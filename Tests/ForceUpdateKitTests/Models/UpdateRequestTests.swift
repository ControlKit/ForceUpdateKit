//
//  UpdateRequestTests.swift
//  ForceUpdateKitTests
//
//  Created by Test Suite on 2024.
//

import XCTest
@testable import ForceUpdateKit

final class UpdateRequestTests: XCTestCase {
    
    func testUpdateRequestInitialization() {
        // Given
        let appId = "com.test.app"
        let version = "1.0.0"
        let route = "https://api.example.com/update"
        
        // When
        let request = UpdateRequest(appId: appId, applicationVersion: version, route: route)
        
        // Then
        XCTAssertEqual(request.appId, appId)
        XCTAssertEqual(request.applicationVersion, version)
        XCTAssertEqual(request.route, route)
        XCTAssertFalse(request.deviceUUID.isEmpty)
        XCTAssertEqual(request.sdkVersion, forceUpdateKit_Version)
    }
    
    func testUpdateRequestDictionary() {
        // Given
        let appId = "com.test.app"
        let version = "1.0.0"
        let route = "https://api.example.com/update"
        let request = UpdateRequest(appId: appId, applicationVersion: version, route: route)
        
        // When
        let dictionary = request.dictionary
        
        // Then
        XCTAssertEqual(dictionary["x-app-id"], appId)
        XCTAssertEqual(dictionary["x-version"], version)
        XCTAssertEqual(dictionary["x-sdk-version"], forceUpdateKit_Version)
        XCTAssertEqual(dictionary["x-device-uuid"], request.deviceUUID)
    }
    
    func testUpdateRequestNSDictionary() {
        // Given
        let appId = "com.test.app"
        let version = "1.0.0"
        let route = "https://api.example.com/update"
        let request = UpdateRequest(appId: appId, applicationVersion: version, route: route)
        
        // When
        let nsDictionary = request.nsDictionary
        
        // Then
        XCTAssertEqual(nsDictionary["x-app-id"] as? String, appId)
        XCTAssertEqual(nsDictionary["x-version"] as? String, version)
        XCTAssertEqual(nsDictionary["x-sdk-version"] as? String, forceUpdateKit_Version)
        XCTAssertEqual(nsDictionary["x-device-uuid"] as? String, request.deviceUUID)
    }
    
    func testUpdateRequestDefaultValues() {
        // Given
        let appId = "com.test.app"
        let route = "https://api.example.com/update"
        
        // When
        let request = UpdateRequest(appId: appId, route: route)
        
        // Then
        XCTAssertEqual(request.appId, appId)
        XCTAssertEqual(request.route, route)
        XCTAssertEqual(request.applicationVersion, Bundle.main.releaseVersionNumber ?? String())
        XCTAssertFalse(request.deviceUUID.isEmpty)
        XCTAssertEqual(request.sdkVersion, forceUpdateKit_Version)
    }
}
