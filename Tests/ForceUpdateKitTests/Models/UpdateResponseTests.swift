//
//  UpdateResponseTests.swift
//  ForceUpdateKitTests
//
//  Created by Test Suite on 2024.
//

import XCTest
@testable import ForceUpdateKit

final class UpdateResponseTests: XCTestCase {
    
    func testUpdateResponseInitialization() {
        // Given
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
        
        // When
        let response = UpdateResponse(data: updateModel)
        
        // Then
        XCTAssertNotNil(response.data)
        XCTAssertEqual(response.data?.id, "test-id")
        XCTAssertEqual(response.data?.icon, "update-icon")
        XCTAssertEqual(response.data?.link, "https://apps.apple.com/app/test")
        XCTAssertEqual(response.data?.sdk_version, "1.0.0")
        XCTAssertEqual(response.data?.minimum_version, "1.0.0")
        XCTAssertEqual(response.data?.maximum_version, "2.0.0")
    }
    
    func testUpdateResponseWithNilData() {
        // Given & When
        let response = UpdateResponse(data: nil)
        
        // Then
        XCTAssertNil(response.data)
    }
    
    func testUpdateModelLocalizedText() {
        // Given
        let localizedText = LocalizedText(language: CKLanguage.persian.rawValue, content: "به‌روزرسانی موجود است")
        
        // When & Then
        XCTAssertEqual(localizedText.language, CKLanguage.persian.rawValue)
        XCTAssertEqual(localizedText.content, "به‌روزرسانی موجود است")
    }
    
    func testUpdateModelWithMultipleLanguages() {
        // Given
        let title = [
            LocalizedText(language: CKLanguage.english.rawValue, content: "Update Available"),
            LocalizedText(language: CKLanguage.persian.rawValue, content: "به‌روزرسانی موجود است")
        ]
        
        let description = [
            LocalizedText(language: CKLanguage.english.rawValue, content: "Please update your app"),
            LocalizedText(language: CKLanguage.persian.rawValue, content: "لطفاً اپلیکیشن خود را به‌روزرسانی کنید")
        ]
        
        // When
        let updateModel = UpdateModel(
            id: "test-id",
            title: title,
            description: description,
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
        
        // Then
        XCTAssertEqual(updateModel.title?.count, 2)
        XCTAssertEqual(updateModel.description?.count, 2)
        XCTAssertEqual(updateModel.title?.first?.language, CKLanguage.english.rawValue)
        XCTAssertEqual(updateModel.title?.last?.language, CKLanguage.persian.rawValue)
    }
    
    func testUpdateResponseCodable() throws {
        // Given
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
        let response = UpdateResponse(data: updateModel)
        
        // When
        let jsonData = try JSONEncoder().encode(response)
        let decodedResponse = try JSONDecoder().decode(UpdateResponse.self, from: jsonData)
        
        // Then
        XCTAssertEqual(decodedResponse.data?.id, response.data?.id)
        XCTAssertEqual(decodedResponse.data?.icon, response.data?.icon)
        XCTAssertEqual(decodedResponse.data?.link, response.data?.link)
        XCTAssertEqual(decodedResponse.data?.sdk_version, response.data?.sdk_version)
    }
}
