//
//  UpdateRequest.swift
//
//
//  Created by Maziar Saadatfar on 10/12/23.
//

import Foundation
public struct UpdateRequest {
    public var appId: String = Bundle.main.bundleIdentifier ?? String()
    public var version: String = Bundle.main.releaseVersionNumber ?? String()
    public var route: String
    public var os: String = "iOs"
    public var language: String = "en"
    public var deviceUUID: String = UUID().uuidString
    
    var dictionary: [String: Any] {
        return ["x-app-id": appId,
                "x-version": version,
                "x-device-uuid": deviceUUID]
    }
    
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }
}
