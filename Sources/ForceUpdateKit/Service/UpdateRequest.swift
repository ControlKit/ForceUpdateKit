//
//  UpdateRequest.swift
//
//
//  Created by Maziar Saadatfar on 10/12/23.
//

import Foundation
public struct UpdateRequest {
    public var appId: String
    public var applicationVersion: String = Bundle.main.releaseVersionNumber ?? String()
    public var route: String
    public var deviceUUID: String = UUID().uuidString
    public var sdkVersion: String = forceUpdateKit_Version
    
    var dictionary: [String: String] {
        return ["x-app-id": appId,
                "x-version": applicationVersion,
                "x-sdk-version": sdkVersion,
                "x-device-uuid": deviceUUID]
    }
    
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }
}
