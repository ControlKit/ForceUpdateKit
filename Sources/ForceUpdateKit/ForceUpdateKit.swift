// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import UIKit
import Combine
import ControlKitBase

public let forceUpdateKit_Version: String = "1.0.0"

public class ForceUpdateKit:AnyObject, Updatable {
    public let updateService: GenericServiceProtocol!
    public init(updateService: GenericServiceProtocol = GenericService()) {
        self.updateService = updateService
    }
    var retryView: RetryConnectionView?
    @MainActor
    public func configure(config: UpdateServiceConfig, maxRetries: Int = 0) async {
        await configureWithRetry(config: config, maxRetries: maxRetries)
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
        
        // Hide previous retry view if exists
        retryView?.hide()
        
        retryView = RetryConnectionView(
            config: config.viewConfig,
            retryAction: { [weak self] in
                guard let self = self else { return }
                Task { @MainActor in
                    // Hide retry view before making new request
                    self.retryView?.hide()
                    
                    if currentRetry < maxRetries || maxRetries == 0 {
                        await self.configureWithRetry(config: config, maxRetries: maxRetries, currentRetry: currentRetry + 1)
                    } else {
                        // Max retries reached, show error or dismiss
                        self.showMaxRetriesReached()
                    }
                }
            },
            dismissAction: {
                // User chose to dismiss
            }
        )
        
        retryView?.show(in: window)
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
        // Hide retry view if exists
        retryView?.hide()
        
        guard let res = response.value else { return }
        let viewModel = DefaultForceUpdateViewModel(
            serviceConfig: config,
            response: response
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
