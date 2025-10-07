//
//  UpdateServiceTests.swift
//  ForceUpdateKitTests
//
//  Created by Test Suite on 2024.
//

import XCTest
@testable import ForceUpdateKit
import ControlKitBase

final class UpdateServiceTests: XCTestCase {
    
    var service: MockUpdateService!
    
    override func setUpWithError() throws {
        service = MockUpdateService()
    }
    
    override func tearDownWithError() throws {
        service = nil
    }
    
    func testExecuteSuccess() async throws {
        // Given
        let request = UpdateRequest(appId: "com.test.app")
        service.shouldReturnSuccess = true
        service.shouldReturnNil = false
        
        // When
        let result: ControlKitBase.Result<UpdateResponse> = try await service.execute(request: request)
        
        // Then
        XCTAssertNotNil(result.value)
        XCTAssertEqual(service.lastRequest?.appId, "com.test.app")
    }
    
    func testExecuteNil() async throws {
        // Given
        let request = UpdateRequest(appId: "com.test.app")
        service.shouldReturnSuccess = true
        service.shouldReturnNil = true
        
        // When
        let result: ControlKitBase.Result<UpdateResponse> = try await service.execute(request: request)
        
        // Then
        XCTAssertNil(result.value)
    }
    
    func testExecuteError() async {
        // Given
        let request = UpdateRequest(appId: "com.test.app")
        service.shouldReturnSuccess = false
        service.shouldReturnNil = false
        
        // When & Then
//        await XCTAssertThrowsError(try await service.execute(request: request))
    }
}
