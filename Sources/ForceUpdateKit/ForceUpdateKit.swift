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
        Task {
            let request = UpdateRequest(appId: config.appId,
                                        applicationVersion: config.version)
            let response = try await self.update(request: request)
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
}
