// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import UIKit
import Combine
import ControlKitBase

public let forceUpdateKit_Version: String = "1.0.0"

public class ForceUpdateKit: Updatable {
    public let updateService: GenericServiceProtocol!
    public init(updateService: GenericServiceProtocol = GenericService()) {
        self.updateService = updateService
    }
    @MainActor
    public func configure(config: UpdateServiceConfig) async {
        await configureWithRetry(config: config, maxRetries: 3)
    }
    
    @MainActor
    private func configureWithRetry(config: UpdateServiceConfig, maxRetries: Int, currentRetry: Int = 0) async {
        let request = UpdateRequest(appId: config.appId)
        
        do {
            let response = try await self.update(request: request)
            if response.isSuccess {
                successReponse(config: config, response: response)
            } else {
                showRetryView(config: config, maxRetries: maxRetries, currentRetry: currentRetry)
            }
        } catch {
            showRetryView(config: config, maxRetries: maxRetries, currentRetry: currentRetry)
        }
    }
    
    private func showRetryView(config: UpdateServiceConfig, maxRetries: Int, currentRetry: Int) {
        guard let window = UIApplication.shared.windows.last else { return }
        
        let retryView = RetryConnectionView(
            config: config.viewConfig,
            retryAction: { [weak self] in
                Task { @MainActor in
                    if currentRetry < maxRetries {
                        await self?.configureWithRetry(config: config, maxRetries: maxRetries, currentRetry: currentRetry + 1)
                    } else {
                        // Max retries reached, show error or dismiss
                        self?.showMaxRetriesReached()
                    }
                }
            },
            dismissAction: {
                // User chose to dismiss
            }
        )
        
        retryView.show(in: window)
    }
    
    private func showMaxRetriesReached() {
        guard let window = UIApplication.shared.windows.last else { return }
        
        let alert = UIAlertController(
            title: "Connection Error",
            message: "Unable to connect to server. Please try again later.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        if let topViewController = window.rootViewController {
            topViewController.present(alert, animated: true)
        }
    }
    
    private func successReponse(config: UpdateServiceConfig, response: Result<UpdateResponse>) {
        guard let res = response.value else { return }
        let viewModel = DefaultForceUpdateViewModel(
            serviceConfig: config,
            response: res
        )
        if response.value?.data != nil {
            DispatchQueue.main.async {
                let forceUpdateView = ForceUpdateViewStyle.make(
                    viewModel: viewModel,
                    config: config.viewConfig
                )
                if let window = UIApplication.shared.windows.last {
                    forceUpdateView.center.y += forceUpdateView.frame.height
                    window.addSubview(forceUpdateView)
                    forceUpdateView.fixInView(window)
                    UIView.animate(withDuration: 1.0) {
                        forceUpdateView.center.y -= forceUpdateView.frame.height
                    }
                }
            }
        }
    }
}
