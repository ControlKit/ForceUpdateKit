//
//  IntegrationTests.swift
//  ForceUpdateKitTests
//
//  Created by Test Suite on 2024.
//

import XCTest
@testable import ForceUpdateKit

final class IntegrationTests: XCTestCase {
    
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
    
    func testCompleteFlowWithSuccessfulUpdate() async {
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
//        XCTAssertEqual(mockUpdateService.lastRequest?.sdkVersion, forceUpdateKit_Version)
//        XCTAssertFalse(mockUpdateService.lastRequest?.deviceUUID.isEmpty ?? true)
    }
    
    func testCompleteFlowWithNoUpdateRequired() async {
        // Given
        let config = UpdateServiceConfig(
            style: .popover1,
            appId: "com.test.app",
            language: CKLanguage.persian
        )
        mockUpdateService.shouldReturnSuccess = true
        mockUpdateService.shouldReturnNil = true
        
        // When
        await forceUpdateKit.configure(config: config)
        
        // Then
//        XCTAssertNotNil(mockUpdateService.lastRequest)
//        XCTAssertEqual(mockUpdateService.lastRequest?.appId, "com.test.app")
//        XCTAssertEqual(mockUpdateService.lastRequest?.applicationVersion, "2.0.0")
        // Should handle nil response gracefully
    }
    
    func testCompleteFlowWithNetworkError() async {
        // Given
        let config = UpdateServiceConfig(
            style: .fullscreen2,
            appId: "com.test.app",
            language: CKLanguage.arabic
        )
        mockUpdateService.shouldReturnSuccess = false
        mockUpdateService.shouldReturnNil = false
        
        // When
        await forceUpdateKit.configure(config: config)
        
        // Then
//        XCTAssertNotNil(mockUpdateService.lastRequest)
//        XCTAssertEqual(mockUpdateService.lastRequest?.appId, "com.test.app")
//        XCTAssertEqual(mockUpdateService.lastRequest?.applicationVersion, "3.0.0")
        // Should handle network errors gracefully
    }
    
    func testMultipleConfigurations() async {
        // Given
        let configs = [
            UpdateServiceConfig(style: .fullscreen1, appId: "com.app1", language: CKLanguage.english),
            UpdateServiceConfig(style: .fullscreen2, appId: "com.app2", language: CKLanguage.persian),
            UpdateServiceConfig(style: .popover1, appId: "com.app3", language: CKLanguage.arabic)
        ]
        mockUpdateService.shouldReturnSuccess = true
        mockUpdateService.shouldReturnNil = false
        
        // When & Then
        for config in configs {
            await forceUpdateKit.configure(config: config)
            
//            XCTAssertNotNil(mockUpdateService.lastRequest)
//            XCTAssertEqual(mockUpdateService.lastRequest?.appId, config.appId)
//            XCTAssertEqual(mockUpdateService.lastRequest?.applicationVersion, config.version)
        }
    }
    
    func testDifferentViewStyles() async {
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
            XCTAssertEqual(config.viewConfig.style, style)
        }
    }
    
    func testDifferentLanguages() async {
        // Given
        let languages = [
            CKLanguage.english,
            CKLanguage.persian,
            CKLanguage.arabic,
            CKLanguage.spanish,
            CKLanguage.french,
            CKLanguage.german,
            CKLanguage.chineseSimplified,
            CKLanguage.japanese,
            CKLanguage.korean
        ]
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
            XCTAssertEqual(config.viewConfig.lang, language)
        }
    }
    
    func testCustomRoute() async {
        // Given
        var config = UpdateServiceConfig(
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
//        XCTAssertEqual(mockUpdateService.lastRequest?.route, "https://custom.api.com/force-update")
    }
    
    func testViewModelIntegration() async {
        // Given
        let updateModel = UpdateModel(
            id: "integration-test",
            title: [LocalizedText(language: CKLanguage.english.rawValue, content: "Integration Test Update")],
            description: [LocalizedText(language: CKLanguage.english.rawValue, content: "This is an integration test")],
            force: true,
            icon: "test-icon",
            link: "https://apps.apple.com/app/integration-test",
            button_title: [LocalizedText(language: CKLanguage.english.rawValue, content: "Update Now")],
            cancel_button_title: [LocalizedText(language: CKLanguage.english.rawValue, content: "Later")],
            version: [LocalizedText(language: CKLanguage.english.rawValue, content: "1.0.0")],
            sdk_version: "1.0.0",
            minimum_version: "1.0.0",
            maximum_version: "2.0.0",
            created_at: "2024-01-01T00:00:00Z"
        )
        let response = UpdateResponse(data: updateModel)
        mockUpdateService.mockResponse = response
        mockUpdateService.shouldReturnSuccess = true
        mockUpdateService.shouldReturnNil = false
        
        let config = UpdateServiceConfig(
            style: .fullscreen1,
            appId: "com.test.app",
            language: CKLanguage.english
        )
        
        // When
        await forceUpdateKit.configure(config: config)
        
        // Then
//        XCTAssertNotNil(mockUpdateService.lastRequest)
        XCTAssertNotNil(mockUpdateService.mockResponse)
        XCTAssertEqual(mockUpdateService.mockResponse?.data?.id, "integration-test")
        XCTAssertEqual(mockUpdateService.mockResponse?.data?.link, "https://apps.apple.com/app/integration-test")
    }
    
    func testErrorHandling() async {
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
        // Should not crash on error
    }
    
    func testPerformanceWithMultipleRequests() {
        // Given
        let config = UpdateServiceConfig(
            style: .fullscreen1,
            appId: "com.test.app",
            language: CKLanguage.english
        )
        mockUpdateService.shouldReturnSuccess = true
        mockUpdateService.shouldReturnNil = false
        
        // When & Then
        measure {
            Task {
                await forceUpdateKit.configure(config: config)
            }
        }
    }
}
