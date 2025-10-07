//
//  NPSActionable.swift
//  NetPromoterScoreKit
//
//  Created by Maziar Saadatfar on 9/25/25.
//
import ControlKitBase
public protocol Actionable {
    func setAction(_ action: ControlKitAction)
}
public extension Actionable where Self: ForceUpdateViewModel {
    func setAction(_ action: ControlKitAction) {
        Task {
            let request = ControlKitBase.ActionRequest(
                route: .force_update,
                appId: serviceConfig.appId,
                sdkVersion: forceUpdateKit_Version,
                action: action,
                itemId: self.response.data?.id ?? "",
            )
            let result: Result<ActionResponse> = try await actionService.execute(request: request)
            
        }
    }
}
