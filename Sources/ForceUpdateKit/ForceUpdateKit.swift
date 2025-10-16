// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import UIKit
import Combine
import ControlKitBase

public let forceUpdateKit_Version: String = "1.0.0"

public class ForceUpdateKit: AnyObject, Updatable {
    public let updateService: GenericServiceProtocol!
    private var retryView: RetryConnectionView?
    private var currentConfig: UpdateServiceConfig?
    private var currentMaxRetries: Int = 0
    private var currentRetryCount: Int = 0
    
    public init(updateService: GenericServiceProtocol = GenericService()) {
        self.updateService = updateService
    }
    @MainActor
    public func configure(config: UpdateServiceConfig, maxRetries: Int = 0) async {
        // Store configuration for retry mechanism
        self.currentConfig = config
        self.currentMaxRetries = maxRetries
        self.currentRetryCount = 0
        
        await configureWithRetry()
    }
    
    @MainActor
    private func configureWithRetry() async {
        guard let config = currentConfig else { return }
        
        let request = UpdateRequest(appId: config.appId)
        
        do {
            let response = try await self.update(request: request)
            if response.isSuccess {
                successReponse(config: config, response: response)
            } else {
                showRetryView()
            }
        } catch {
            showRetryView()
        }
    }
    
    private func showRetryView() {
        guard let window = UIApplication.shared.windows.last,
              let config = currentConfig else { return }
        
        // Hide previous retry view if exists
        retryView?.hide()
        
        retryView = RetryConnectionView(
            config: config.viewConfig,
            retryAction: { [weak self] in
                guard let self = self else { return }
                Task { @MainActor in
                    // Hide retry view before making new request
                    self.retryView?.hide()
                    
                    // Increment retry count
                    self.currentRetryCount += 1
                    
                    if self.currentRetryCount <= self.currentMaxRetries || self.currentMaxRetries == 0 {
                        await self.configureWithRetry()
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
        retryView?.config = config.viewConfig
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
