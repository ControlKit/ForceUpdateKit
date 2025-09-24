// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import UIKit
import Combine

public let forceUpdateKit_Version: String = "1.0.0"

public class ForceUpdateKit: Updatable {
    public let updateService: UpdateServiceProtocol!
    public init(updateService: UpdateServiceProtocol = UpdateService()) {
        self.updateService = updateService
    }
    @MainActor
    public func configure(config: UpdateServiceConfig) async {
        Task {
            let request = UpdateRequest(appId: config.appId,
                                        applicationVersion: config.version,
                                        route: config.route)
            if let response = try await self.update(request: request) {
                let viewModel = DefaultForceUpdateViewModel(response: response)
                if response.data != nil {
                    DispatchQueue.main.async {
                        let forceUpdateView = ForceUpdateViewStyle.make(
                            viewModel: viewModel,
                            config: config.viewConfig
                        )
                        let window = UIApplication.shared.windows.last!
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
}
