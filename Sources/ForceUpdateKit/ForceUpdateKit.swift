// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import UIKit
import Combine
import ControlKitBase

public let forceUpdateKit_Version: String = "1.0.0"

/**
 * ForceUpdateKit - A comprehensive force update solution for iOS apps
 * 
 * This class implements a complete force update mechanism with the following features:
 * - Automatic version checking via network requests
 * - Configurable retry mechanism for network failures
 * - Multiple UI styles (FullScreen1-4, Popover1-2)
 * - Customizable appearance and behavior
 * - Multi-language support
 * - Memory-safe shared instance pattern
 * 
 * Usage:
 * ```swift
 * Task {
 *     let config = UpdateServiceConfig(
 *         style: .fullscreen1,
 *         appId: "com.your.app",
 *         language: .english
 *     )
 *     await ForceUpdateKit().configure(config: config, maxRetries: 5)
 * }
 * ```
 */
public class ForceUpdateKit: AnyObject, Updatable {
    // MARK: - Properties
    
    /// Service for making network requests to check for updates
    public let updateService: GenericServiceProtocol!
    
    /// Current retry connection view (shown on network failures)
    private var retryView: RetryConnectionView?
    
    /// Current configuration for the force update system
    private var currentConfig: UpdateServiceConfig?
    
    /// Maximum number of retry attempts (default: 5)
    private var currentMaxRetries: Int = 5
    
    /// Current retry attempt counter
    private var currentRetryCount: Int = 0
    
    /// Shared instance to prevent memory leaks and ensure retry functionality works
    private static var sharedInstance: ForceUpdateKit?
    
    // MARK: - Initialization
    
    /**
     * Initialize ForceUpdateKit with a service for network requests
     * 
     * - Parameter updateService: Service for making network requests (defaults to GenericService)
     * 
     * The shared instance is set during initialization to ensure proper memory management
     * and to allow retry actions to work correctly even when the original instance
     * might be deallocated.
     */
    public init(updateService: GenericServiceProtocol = GenericService()) {
        self.updateService = updateService
        ForceUpdateKit.sharedInstance = self
    }
    
    // MARK: - Public Configuration
    
    /**
     * Configure the force update system with the specified parameters
     * 
     * - Parameter config: Configuration object containing style, app ID, language, etc.
     * - Parameter maxRetries: Maximum number of retry attempts for network failures (default: 5)
     * 
     * This method:
     * 1. Stores the configuration and retry settings
     * 2. Resets the retry counter
     * 3. Initiates the force update check process
     * 
     * The method is marked as @MainActor to ensure UI updates happen on the main thread.
     */
    @MainActor
    public func configure(config: UpdateServiceConfig, maxRetries: Int = 5) async {
        self.currentConfig = config
        self.currentMaxRetries = maxRetries
        self.currentRetryCount = 0
        
        await configureWithRetry()
    }
    
    // MARK: - Private Force Update Logic
    
    /**
     * Internal method that handles the force update check with retry logic
     * 
     * This method:
     * 1. Creates an UpdateRequest with the app ID
     * 2. Makes a network request to check for updates
     * 3. Processes the response:
     *    - If successful and update required: Shows force update view
     *    - If successful but no update needed: Does nothing
     *    - If network error: Shows retry connection view
     * 
     * The retry mechanism ensures users can retry failed network requests
     * up to the configured maximum number of attempts.
     */
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
    
    /**
     * Display the retry connection view when network requests fail
     * 
     * This method:
     * 1. Hides any existing retry view
     * 2. Creates a new RetryConnectionView with current configuration
     * 3. Sets up the retry action closure that:
     *    - Hides the retry view
     *    - Increments the retry counter
     *    - Either retries the request or shows max retries alert
     * 4. Shows the retry view with animation
     * 
     * The retry action uses the shared instance to ensure it works correctly
     * even if the original ForceUpdateKit instance is deallocated.
     */
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
                // User chose to dismiss (not used in current implementation)
            }
        )
        
        retryView?.show(in: window)
    }
    
    /**
     * Show alert when maximum retry attempts have been reached
     * 
     * This method displays a system alert with configurable title, message, and button text.
     * The alert text is customizable through the ForceUpdateViewConfig.
     * 
     * After showing the alert, the user can either:
     * - Try again later (by restarting the app)
     * - Check their network connection
     * - Contact support if the issue persists
     */
    private func showMaxRetriesReached() {
        guard let window = UIApplication.shared.windows.last,
              let config = currentConfig else { return }
        
        let alert = UIAlertController(
            title: config.viewConfig.maxRetriesAlertTitle,
            message: config.viewConfig.maxRetriesAlertMessage,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: config.viewConfig.maxRetriesAlertButtonTitle, style: .default))
        
        if let topViewController = window.rootViewController {
            topViewController.present(alert, animated: true)
        }
    }
    
    /**
     * Handle successful response from the update service
     * 
     * - Parameter config: Current configuration
     * - Parameter response: Response from the update service
     * 
     * This method:
     * 1. Hides any existing retry view
     * 2. Creates a view model with the response data
     * 3. If update is required (data exists), shows the appropriate force update view
     * 4. Uses the configured style to create the correct view type
     * 5. Animates the view sliding in from the bottom
     * 
     * The animation provides a smooth user experience when the force update
     * view appears, making it feel integrated with the app's UI.
     */
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
