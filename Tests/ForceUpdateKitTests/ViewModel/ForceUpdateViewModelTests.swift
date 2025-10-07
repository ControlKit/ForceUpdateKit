//
//  ForceUpdateViewModelTests.swift
//  ForceUpdateKitTests
//
//  Created by Test Suite on 2024.
//

import XCTest
import ControlKitBase
@testable import ForceUpdateKit

final class ForceUpdateViewModelTests: XCTestCase {
    
    var viewModel: DefaultForceUpdateViewModel!
    var mockResponse: UpdateResponse!
    
    override func setUpWithError() throws {
        let updateModel = UpdateModel(
            id: "test-id",
            title: [LocalizedText(language: CKLanguage.english.rawValue, content: "Update Available")],
            description: [LocalizedText(language: CKLanguage.english.rawValue, content: "Please update your app")],
            force: true,
            icon: "update-icon",
            link: "https://apps.apple.com/app/test",
            button_title: [LocalizedText(language: CKLanguage.english.rawValue, content: "Update")],
            cancel_button_title: [LocalizedText(language: CKLanguage.english.rawValue, content: "Cancel")],
            version: [LocalizedText(language: CKLanguage.english.rawValue, content: "1.0.0")],
            sdk_version: "1.0.0",
            minimum_version: "1.0.0",
            maximum_version: "2.0.0",
            created_at: "2024-01-01T00:00:00Z"
        )
        mockResponse = UpdateResponse(data: updateModel)
        viewModel = DefaultForceUpdateViewModel(
            serviceConfig: UpdateServiceConfig(
                appId: "sdsd",
                language: CKLanguage.english
            ),
            response: mockResponse
        )
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockResponse = nil
    }
    
    func testViewModelInitialization() {
        // Given & When
        let viewModel = DefaultForceUpdateViewModel(
            serviceConfig: UpdateServiceConfig(
                appId: "sdsd",
                language: CKLanguage.english
            ),
            response: mockResponse
        )
        
        // Then
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.response.data?.id, "test-id")
        XCTAssertEqual(viewModel.response.data?.link, "https://apps.apple.com/app/test")
    }
    
    func testViewModelResponseProperty() {
        // Given
        let newUpdateModel = UpdateModel(
            id: "new-id",
            title: [LocalizedText(language: CKLanguage.english.rawValue, content: "New Update")],
            description: [LocalizedText(language: CKLanguage.english.rawValue, content: "New description")],
            force: true,
            icon: "new-icon",
            link: "https://apps.apple.com/app/new",
            button_title: [LocalizedText(language: CKLanguage.english.rawValue, content: "Update")],
            cancel_button_title: [LocalizedText(language: CKLanguage.english.rawValue, content: "Cancel")],
            version: [LocalizedText(language: CKLanguage.english.rawValue, content: "2.0.0")],
            sdk_version: "1.0.0",
            minimum_version: "2.0.0",
            maximum_version: "3.0.0",
            created_at: "2024-02-01T00:00:00Z"
        )
        let newResponse = UpdateResponse(data: newUpdateModel)
        
        // When
        viewModel.response = newResponse
        
        // Then
        XCTAssertEqual(viewModel.response.data?.id, "new-id")
        XCTAssertEqual(viewModel.response.data?.link, "https://apps.apple.com/app/new")
        XCTAssertEqual(viewModel.response.data?.sdk_version, "1.0.0")
    }
    
    func testOpenLinkWithValidURL() {
        // Given
        let expectation = XCTestExpectation(description: "Open link")
        
        // When
        viewModel.openLink()
        
        // Then
        // Note: In a real test environment, you would mock UIApplication.shared.open
        // For now, we just verify the method doesn't crash
        XCTAssertNotNil(viewModel.response.data?.link)
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testOpenLinkWithNilURL() {
        // Given
        let updateModel = UpdateModel(
            id: "test-id",
            title: [LocalizedText(language: CKLanguage.english.rawValue, content: "Update Available")],
            description: [LocalizedText(language: CKLanguage.english.rawValue, content: "Please update your app")],
            force: true,
            icon: "update-icon",
            link: nil,
            button_title: [LocalizedText(language: CKLanguage.english.rawValue, content: "Update")],
            cancel_button_title: [LocalizedText(language: CKLanguage.english.rawValue, content: "Cancel")],
            version: [LocalizedText(language: CKLanguage.english.rawValue, content: "1.0.0")],
            sdk_version: "1.0.0",
            minimum_version: "1.0.0",
            maximum_version: "2.0.0",
            created_at: "2024-01-01T00:00:00Z"
        )
        let response = UpdateResponse(data: updateModel)
        let viewModel = DefaultForceUpdateViewModel(
            serviceConfig: UpdateServiceConfig(
                appId: "sdsd",
                language: CKLanguage.english
            ),
            response: response
        )
        
        // When
        viewModel.openLink()
        
        // Then
        // Should not crash when link is nil
        XCTAssertNil(viewModel.response.data?.link)
    }
    
    func testOpenLinkWithInvalidURL() {
        // Given
        let updateModel = UpdateModel(
            id: "test-id",
            title: [LocalizedText(language: CKLanguage.english.rawValue, content: "Update Available")],
            description: [LocalizedText(language: CKLanguage.english.rawValue, content: "Please update your app")],
            force: true,
            icon: "update-icon",
            link: "invalid-url",
            button_title: [LocalizedText(language: CKLanguage.english.rawValue, content: "Update")],
            cancel_button_title: [LocalizedText(language: CKLanguage.english.rawValue, content: "Cancel")],
            version: [LocalizedText(language: CKLanguage.english.rawValue, content: "1.0.0")],
            sdk_version: "1.0.0",
            minimum_version: "1.0.0",
            maximum_version: "2.0.0",
            created_at: "2024-01-01T00:00:00Z"
        )
        let response = UpdateResponse(data: updateModel)
        let viewModel = DefaultForceUpdateViewModel(
            serviceConfig: UpdateServiceConfig(
                appId: "sdsd",
                language: CKLanguage.english
            ),
            response: response
        )
        
        // When
        viewModel.openLink()
        
        // Then
        // Should not crash when URL is invalid
        XCTAssertEqual(viewModel.response.data?.link, "invalid-url")
    }
    
    func testViewModelProtocolConformance() {
        // Given & When
        let viewModel = DefaultForceUpdateViewModel(
            serviceConfig: UpdateServiceConfig(
                appId: "sdsd",
                language: CKLanguage.english
            ),
            response: mockResponse
        )
        
        // Then
        XCTAssertTrue(viewModel is ForceUpdateViewModel)
        XCTAssertNotNil(viewModel.response)
    }
}

