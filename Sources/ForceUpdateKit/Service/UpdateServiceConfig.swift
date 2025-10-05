//
//  UpdateServiceConfig.swift
//
//
//  Created by Maziar Saadatfar on 10/12/23.
//

import Foundation
public struct UpdateServiceConfig {
    public init(style: ForceUpdateViewStyle = .fullscreen1,
                appId: String,
                language: String) {
        self.viewConfig = ForceUpdateViewStyle.getViewConfigWithStyle(style: style, language: language)
        self.appId = appId
    }
    public var appId: String = Bundle.main.bundleIdentifier ?? String()
    public var version: String = Bundle.main.releaseVersionNumber ?? String()
    public var viewConfig: ForceUpdateViewConfig
}
