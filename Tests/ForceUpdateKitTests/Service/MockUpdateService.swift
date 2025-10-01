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
            title: [LocalizedText(language: "en", content: "Mock Update Available")],
            description: [LocalizedText(language: "en", content: "Mock update description")],
            icon: "mock-icon",
            link: "https://apps.apple.com/app/mock",
            button_title: [LocalizedText(language: "en", content: "Update")],
            cancel_button_title: [LocalizedText(language: "en", content: "Cancel")],
            version: [LocalizedText(language: "en", content: "1.0.0")],
            sdk_version: 1,
            minimum_version: "1.0.0",
            maximum_version: "2.0.0",
            created_at: "2024-01-01T00:00:00Z"
        )
        return UpdateResponse(data: updateModel)
    }
}
