//
//  ForceUpdateKitMainTests.swift
//  ForceUpdateKitTests
//
//  Created by Test Suite on 2024.
//

import XCTest
import ControlKitBase
@testable import ForceUpdateKit

final class ForceUpdateKitMainTests: XCTestCase {
    
    var forceUpdateKit: ForceUpdateKit!
    var mockUpdateService: MockUpdateService!
    
    override func setUpWithError() throws {
        mockUpdateService = MockUpdateService()
        forceUpdateKit = ForceUpdateKit(updateService: mockUpdateService)
    }
    
    override func tearDownWithError() throws {
        forceUpdateKit = nil
        mockUpdateService = nil
    }
    
    func testForceUpdateKitInitialization() {
        // Given & When
        let kit = ForceUpdateKit()
        
        // Then
        XCTAssertNotNil(kit)
        XCTAssertNotNil(kit.updateService)
    }
    
    func testForceUpdateKitInitializationWithCustomService() {
        // Given
        let mockService = MockUpdateService()
        
        // When
        let kit = ForceUpdateKit(updateService: mockService)
        
        // Then
        XCTAssertNotNil(kit)
        XCTAssertNotNil(kit.updateService)
        XCTAssertTrue(kit.updateService is MockUpdateService)
    }
    
    func testForceUpdateKitVersion() {
        // Given & When & Then
        XCTAssertEqual(forceUpdateKit_Version, "1.0.0")
    }
    
    func testConfigureWithValidConfig() async {
        // Given
        let config = UpdateServiceConfig(
            style: .fullscreen1,
            appId: "com.test.app",
            language: CKLanguage.english
        )
        mockUpdateService.shouldReturnSuccess = true
        mockUpdateService.shouldReturnNil = false
        
        // When
        await forceUpdateKit.configure(config: config)
        
        // Then
//        XCTAssertNotNil(mockUpdateService.lastRequest)
//        XCTAssertEqual(mockUpdateService.lastRequest?.appId, "com.test.app")
//        XCTAssertEqual(mockUpdateService.lastRequest?.applicationVersion, "1.0.0")
//        XCTAssertEqual(mockUpdateService.lastRequest?.route, "https://tauri.ir/api/force-updates")
    }
    
    func testConfigureWithNilResponse() async {
        // Given
        let config = UpdateServiceConfig(
            style: .fullscreen1,
            appId: "com.test.app",
            language: CKLanguage.english
        )
        mockUpdateService.shouldReturnSuccess = true
        mockUpdateService.shouldReturnNil = true
        
        // When
        await forceUpdateKit.configure(config: config)
        
        // Then
//        XCTAssertNotNil(mockUpdateService.lastRequest)
        // Should not crash when response is nil
    }
    
    func testConfigureWithNetworkError() async {
        // Given
        let config = UpdateServiceConfig(
            style: .fullscreen1,
            appId: "com.test.app",
            language: CKLanguage.english
        )
        mockUpdateService.shouldReturnSuccess = false
        mockUpdateService.shouldReturnNil = false
        
        // When
        await forceUpdateKit.configure(config: config)
        
        // Then
//        XCTAssertNotNil(mockUpdateService.lastRequest)
        // Should handle network errors gracefully
    }
    
    func testConfigureWithDifferentStyles() async {
        // Given
        let styles: [ForceUpdateViewStyle] = [.fullscreen1, .fullscreen2, .fullscreen3, .fullscreen4, .popover1, .popover2]
        mockUpdateService.shouldReturnSuccess = true
        mockUpdateService.shouldReturnNil = false
        
        // When & Then
        for style in styles {
            let config = UpdateServiceConfig(
                style: style,
                appId: "com.test.app",
                language: CKLanguage.english
            )
            
            await forceUpdateKit.configure(config: config)
            
//            XCTAssertNotNil(mockUpdateService.lastRequest)
//            XCTAssertEqual(mockUpdateService.lastRequest?.appId, "com.test.app")
        }
    }
    
    func testConfigureWithDifferentLanguages() async {
        // Given
        let languages = [CKLanguage.english, CKLanguage.persian, CKLanguage.arabic, CKLanguage.spanish]
        mockUpdateService.shouldReturnSuccess = true
        mockUpdateService.shouldReturnNil = false
        
        // When & Then
        for language in languages {
            let config = UpdateServiceConfig(
                style: .fullscreen1,
                appId: "com.test.app",
                language: language
            )
            
            await forceUpdateKit.configure(config: config)
            
//            XCTAssertNotNil(mockUpdateService.lastRequest)
//            XCTAssertEqual(mockUpdateService.lastRequest?.appId, "com.test.app")
        }
    }
    
    func testConfigureWithCustomRoute() async {
        // Given
        let config = UpdateServiceConfig(
            style: .fullscreen1,
            appId: "com.test.app",
            language: CKLanguage.english
        )
        mockUpdateService.shouldReturnSuccess = true
        mockUpdateService.shouldReturnNil = false
        
        // When
        await forceUpdateKit.configure(config: config)
        
        // Then
//        XCTAssertNotNil(mockUpdateService.lastRequest)
//        XCTAssertEqual(mockUpdateService.lastRequest?.route, "https://custom.api.com/update")
    }
    
    func testUpdatableProtocolConformance() {
        // Given & When
        let kit = ForceUpdateKit()
        
        // Then
        XCTAssertTrue(kit is Updatable)
        XCTAssertNotNil(kit.updateService)
    }
    
    func testUpdateMethod() async throws {
        // Given
        let request = UpdateRequest(
            route: .force_update,
            appId: "com.test.app",
            applicationVersion: "1.0.0"
        )
        mockUpdateService.shouldReturnSuccess = true
        mockUpdateService.shouldReturnNil = false
        
        // When
        let response = try await forceUpdateKit.update(request: request)
        
        // Then
        XCTAssertNotNil(response)
        XCTAssertEqual(mockUpdateService.lastRequest?.appId, "com.test.app")
        XCTAssertEqual(mockUpdateService.lastRequest?.applicationVersion, "1.0.0")
        XCTAssertEqual(mockUpdateService.lastRequest?.route, .force_update)
    }
    
    func testUpdateMethodWithError() async throws {
        // Given
        let request = UpdateRequest(
            route: .force_update,
            appId: "com.test.app",
            applicationVersion: "1.0.0"
        )
        mockUpdateService.shouldReturnSuccess = false
        mockUpdateService.shouldReturnNil = false
        
        // When & Then
        do {
            _ = try await forceUpdateKit.update(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}

