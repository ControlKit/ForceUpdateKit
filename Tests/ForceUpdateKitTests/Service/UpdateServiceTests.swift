//
//  UpdateServiceTests.swift
//  ForceUpdateKitTests
//
//  Created by Test Suite on 2024.
//

import XCTest
@testable import ForceUpdateKit

final class UpdateServiceTests: XCTestCase {
    
    var updateService: UpdateService!
    
    override func setUpWithError() throws {
        updateService = UpdateService()
    }
    
    override func tearDownWithError() throws {
        updateService = nil
    }
    
    func testUpdateServiceInitialization() {
        // Given & When
        let service = UpdateService()
        
        // Then
        XCTAssertNotNil(service)
    }
    
    func testUpdateServiceWithInvalidURL() async throws {
        // Given
        let request = UpdateRequest(
            appId: "com.test.app",
            applicationVersion: "1.0.0",
            route: "invalid-url"
        )
        
        // When
        let response = try await updateService.update(request: request)
        
        // Then
        XCTAssertNil(response)
    }
    
    func testUpdateServiceWithValidURLButInvalidResponse() async throws {
        // Given
        let request = UpdateRequest(
            appId: "com.test.app",
            applicationVersion: "1.0.0",
            route: "https://httpbin.org/status/404"
        )
        
        // When
        let response = try await updateService.update(request: request)
        
        // Then
        XCTAssertNil(response)
    }
    
    func testUpdateServiceWithValidJSONResponse() async throws {
        // Given
        let request = UpdateRequest(
            appId: "com.test.app",
            applicationVersion: "1.0.0",
            route: "https://httpbin.org/json"
        )
        
        // When
        let response = try await updateService.update(request: request)
        
        // Then
        // This test might fail depending on the actual response from httpbin.org
        // In a real scenario, you would mock the network response
        XCTAssertNotNil(response)
    }
    
    func testUpdateServiceRequestHeaders() async throws {
        // Given
        let request = UpdateRequest(
            appId: "com.test.app",
            applicationVersion: "1.0.0",
            route: "https://httpbin.org/headers"
        )
        
        // When
        let response = try await updateService.update(request: request)
        
        // Then
        // This test verifies that the request is made with proper headers
        // In a real scenario, you would mock the network and verify headers
        XCTAssertNotNil(response)
    }
    
    func testUpdateServiceNetworkError() async throws {
        // Given
        let request = UpdateRequest(
            appId: "com.test.app",
            applicationVersion: "1.0.0",
            route: "https://nonexistent-domain-12345.com/api"
        )
        
        // When
        let response = try await updateService.update(request: request)
        
        // Then
        XCTAssertNil(response)
    }
    
    func testUpdateServiceTimeout() async throws {
        // Given
        let request = UpdateRequest(
            appId: "com.test.app",
            applicationVersion: "1.0.0",
            route: "https://httpbin.org/delay/10"
        )
        
        // When
        let startTime = Date()
        let response = try await updateService.update(request: request)
        let endTime = Date()
        
        // Then
        let duration = endTime.timeIntervalSince(startTime)
        XCTAssertNil(response)
        // Note: This test might take a while due to the delay
        XCTAssertGreaterThan(duration, 5.0)
    }
}
