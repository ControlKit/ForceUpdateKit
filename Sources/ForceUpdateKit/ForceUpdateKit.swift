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
    private var currentMaxRetries: Int = 5
    private var currentRetryCount: Int = 0
    private static var sharedInstance: ForceUpdateKit?
    
    public init(updateService: GenericServiceProtocol = GenericService()) {
        self.updateService = updateService
        ForceUpdateKit.sharedInstance = self
    }
    @MainActor
    public func configure(config: UpdateServiceConfig, maxRetries: Int = 5) async {
        self.currentConfig = config
        self.currentMaxRetries = maxRetries
        self.currentRetryCount = 0
        
        await configureWithRetry()
    }
    
    @MainActor
    private func configureWithRetry() async {
        guard let config = currentConfig else { 
            return 
        }
        
        let request = UpdateRequest(appId: config.appId)
        
        do {
            let response = try await self.update(request: request)
            if response.isSuccess {
                successResponse(config: config, response: response)
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
        retryView?.hide()
        retryView = RetryConnectionView(
            config: config.viewConfig,
            retryAction: {
                guard let sharedInstance = ForceUpdateKit.sharedInstance else {
                    return
                }
                
                Task { @MainActor in
                    sharedInstance.retryView?.hide()
                    sharedInstance.currentRetryCount += 1
                    if sharedInstance.currentRetryCount <= sharedInstance.currentMaxRetries {
                        await sharedInstance.configureWithRetry()
                    } else {
                        sharedInstance.showMaxRetriesReached()
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
    
    private func successResponse(config: UpdateServiceConfig, response: Result<UpdateResponse>) {
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
