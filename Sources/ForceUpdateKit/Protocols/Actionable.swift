//
//  NPSActionable.swift
//  NetPromoterScoreKit
//
//  Created by Maziar Saadatfar on 9/25/25.
//
public protocol Actionable {
    func setAction(_ action: ForceUpdateAction)
}
public extension Actionable where Self: ForceUpdateViewModel {
    func setAction(_ action: ForceUpdateAction) {
        Task {
            let request = ActionRequest(
                forecUpdateId: self.response.data?.id ?? "",
                action: action
            )
            let _ = try await actionService.action(request: request)
        }
    }
}
