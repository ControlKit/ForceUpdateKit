//
//  MockUpdateService.swift
//  ForceUpdateKitTests
//
//  Created by Test Suite on 2024.
//

import Foundation
@testable import ForceUpdateKit

class MockUpdateService: UpdateServiceProtocol {
    var shouldReturnSuccess = true
    var shouldReturnNil = false
    var mockResponse: UpdateResponse?
    var lastRequest: UpdateRequest?
    
    func update(request: UpdateRequest) async throws -> UpdateResponse? {
        lastRequest = request
        
        if shouldReturnNil {
            return nil
        }
        
        if shouldReturnSuccess {
            return mockResponse ?? createMockResponse()
        } else {
            throw NSError(domain: "MockError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Mock network error"])
        }
    }
    
    private func createMockResponse() -> UpdateResponse {
        let updateModel = UpdateModel(
            id: "mock-id",
            title: [LocalizedText(language: CKLanguage.english.rawValue, content: "Mock Update Available")],
            description: [LocalizedText(language: CKLanguage.english.rawValue, content: "Mock update description")],
            force: true,
            icon: "mock-icon",
            link: "https://apps.apple.com/app/mock",
            button_title: [LocalizedText(language: CKLanguage.english.rawValue, content: "Update")],
            cancel_button_title: [LocalizedText(language: CKLanguage.english.rawValue, content: "Cancel")],
            version: [LocalizedText(language: CKLanguage.english.rawValue, content: "1.0.0")],
            sdk_version: "1.0.0",
            minimum_version: "1.0.0",
            maximum_version: "2.0.0",
            created_at: "2024-01-01T00:00:00Z"
        )
        return UpdateResponse(data: updateModel)
    }
}
