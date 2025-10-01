//
//  UpdateServiceConfigTests.swift
//  ForceUpdateKitTests
//
//  Created by Test Suite on 2024.
//

import XCTest
@testable import ForceUpdateKit

final class UpdateServiceConfigTests: XCTestCase {
    
    func testUpdateServiceConfigInitialization() {
        // Given
        let style = ForceUpdateViewStyle.fullscreen1
        let appId = "com.test.app"
        let language = "en"
        let version = "1.0.0"
        
        // When
        let config = UpdateServiceConfig(style: style, appId: appId, language: language, version: version)
        
        // Then
        XCTAssertEqual(config.appId, appId)
        XCTAssertEqual(config.version, version)
        XCTAssertEqual(config.route, "https://tauri.ir/api/force-updates")
        XCTAssertNotNil(config.viewConfig)
        XCTAssertEqual(config.viewConfig.lang, language)
    }
    
    func testUpdateServiceConfigDefaultValues() {
        // Given
        let style = ForceUpdateViewStyle.fullscreen2
        let appId = "com.test.app"
        let language = "fa"
        let version = "2.0.0"
        
        // When
        let config = UpdateServiceConfig(style: style, appId: appId, language: language, version: version)
        
        // Then
        XCTAssertEqual(config.appId, appId)
        XCTAssertEqual(config.version, version)
        XCTAssertEqual(config.route, "https://tauri.ir/api/force-updates")
        XCTAssertEqual(config.viewConfig.lang, language)
        XCTAssertEqual(config.viewConfig.style, style)
    }
    
    func testUpdateServiceConfigWithDifferentStyles() {
        // Given
        let styles: [ForceUpdateViewStyle] = [.fullscreen1, .fullscreen2, .fullscreen3, .fullscreen4, .popover1, .popover2]
        let appId = "com.test.app"
        let language = "en"
        let version = "1.0.0"
        
        // When & Then
        for style in styles {
            let config = UpdateServiceConfig(style: style, appId: appId, language: language, version: version)
            XCTAssertEqual(config.viewConfig.style, style)
            XCTAssertEqual(config.appId, appId)
            XCTAssertEqual(config.version, version)
            XCTAssertEqual(config.viewConfig.lang, language)
        }
    }
    
    func testUpdateServiceConfigRouteProperty() {
        // Given
        let config = UpdateServiceConfig(style: .fullscreen1, appId: "com.test.app", language: "en", version: "1.0.0")
        
        // When & Then
        XCTAssertEqual(config.route, "https://tauri.ir/api/force-updates")
    }
    
    func testUpdateServiceConfigAppIdProperty() {
        // Given
        let appId = "com.custom.app"
        let config = UpdateServiceConfig(style: .fullscreen1, appId: appId, language: "en", version: "1.0.0")
        
        // When & Then
        XCTAssertEqual(config.appId, appId)
    }
    
    func testUpdateServiceConfigVersionProperty() {
        // Given
        let version = "3.0.0"
        let config = UpdateServiceConfig(style: .fullscreen1, appId: "com.test.app", language: "en", version: version)
        
        // When & Then
        XCTAssertEqual(config.version, version)
    }
    
    func testUpdateServiceConfigViewConfigProperty() {
        // Given
        let language = "fa"
        let style = ForceUpdateViewStyle.popover1
        let config = UpdateServiceConfig(style: style, appId: "com.test.app", language: language, version: "1.0.0")
        
        // When & Then
        XCTAssertNotNil(config.viewConfig)
        XCTAssertEqual(config.viewConfig.lang, language)
        XCTAssertEqual(config.viewConfig.style, style)
    }
}
