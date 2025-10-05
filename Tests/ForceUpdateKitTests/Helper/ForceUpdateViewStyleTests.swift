//
//  ForceUpdateViewStyleTests.swift
//  ForceUpdateKitTests
//
//  Created by Test Suite on 2024.
//

import XCTest
@testable import ForceUpdateKit

final class ForceUpdateViewStyleTests: XCTestCase {
    
    func testForceUpdateViewStyleEnum() {
        // Given & When & Then
        let styles: [ForceUpdateViewStyle] = [.fullscreen1, .fullscreen2, .fullscreen3, .fullscreen4, .popover1, .popover2]
        
        // Verify all styles are defined
        XCTAssertEqual(styles.count, 6)
    }
    
    func testGetViewConfigWithStyleFullscreen1() {
        // Given
        let style = ForceUpdateViewStyle.fullscreen1
        let language = "en"
        
        // When
        let config = ForceUpdateViewStyle.getViewConfigWithStyle(style: style, language: language)
        
        // Then
        XCTAssertNotNil(config)
        XCTAssertEqual(config.lang, language)
        XCTAssertEqual(config.style, style)
    }
    
    func testGetViewConfigWithStyleFullscreen2() {
        // Given
        let style = ForceUpdateViewStyle.fullscreen2
        let language = "fa"
        
        // When
        let config = ForceUpdateViewStyle.getViewConfigWithStyle(style: style, language: language)
        
        // Then
        XCTAssertNotNil(config)
        XCTAssertEqual(config.lang, language)
        XCTAssertEqual(config.style, style)
    }
    
    func testGetViewConfigWithStyleFullscreen3() {
        // Given
        let style = ForceUpdateViewStyle.fullscreen3
        let language = "ar"
        
        // When
        let config = ForceUpdateViewStyle.getViewConfigWithStyle(style: style, language: language)
        
        // Then
        XCTAssertNotNil(config)
        XCTAssertEqual(config.lang, language)
        XCTAssertEqual(config.style, style)
    }
    
    func testGetViewConfigWithStyleFullscreen4() {
        // Given
        let style = ForceUpdateViewStyle.fullscreen4
        let language = "es"
        
        // When
        let config = ForceUpdateViewStyle.getViewConfigWithStyle(style: style, language: language)
        
        // Then
        XCTAssertNotNil(config)
        XCTAssertEqual(config.lang, language)
        XCTAssertEqual(config.style, style)
    }
    
    func testGetViewConfigWithStylePopover1() {
        // Given
        let style = ForceUpdateViewStyle.popover1
        let language = "fr"
        
        // When
        let config = ForceUpdateViewStyle.getViewConfigWithStyle(style: style, language: language)
        
        // Then
        XCTAssertNotNil(config)
        XCTAssertEqual(config.lang, language)
        XCTAssertEqual(config.style, style)
    }
    
    func testGetViewConfigWithStylePopover2() {
        // Given
        let style = ForceUpdateViewStyle.popover2
        let language = "de"
        
        // When
        let config = ForceUpdateViewStyle.getViewConfigWithStyle(style: style, language: language)
        
        // Then
        XCTAssertNotNil(config)
        XCTAssertEqual(config.lang, language)
        XCTAssertEqual(config.style, style)
    }
    
    func testGetViewConfigWithStyleAllStyles() {
        // Given
        let styles: [ForceUpdateViewStyle] = [.fullscreen1, .fullscreen2, .fullscreen3, .fullscreen4, .popover1, .popover2]
        let language = "en"
        
        // When & Then
        for style in styles {
            let config = ForceUpdateViewStyle.getViewConfigWithStyle(style: style, language: language)
            XCTAssertNotNil(config)
            XCTAssertEqual(config.lang, language)
            XCTAssertEqual(config.style, style)
        }
    }
    
    func testGetViewConfigWithStyleDifferentLanguages() {
        // Given
        let style = ForceUpdateViewStyle.fullscreen1
        let languages = ["en", "fa", "ar", "es", "fr", "de", "zh", "ja", "ko"]
        
        // When & Then
        for language in languages {
            let config = ForceUpdateViewStyle.getViewConfigWithStyle(style: style, language: language)
            XCTAssertNotNil(config)
            XCTAssertEqual(config.lang, language)
            XCTAssertEqual(config.style, style)
        }
    }
    
    func testMakeViewWithFullscreen1() {
        // Given
        let viewModel = DefaultForceUpdateViewModel(
            serviceConfig: UpdateServiceConfig(
                appId: "sdsd",
                language: "en"
            ),
            response: UpdateResponse(data: nil)
        )
        let config = ForceUpdateViewConfig(lang: "en")
        config.style = .fullscreen1
        
        // When
        let view = ForceUpdateViewStyle.make(viewModel: viewModel, config: config)
        
        // Then
        XCTAssertNotNil(view)
        XCTAssertTrue(view is ForceUpdateViewProtocol)
    }
    
    func testMakeViewWithFullscreen2() {
        // Given
        let viewModel = DefaultForceUpdateViewModel(
            serviceConfig: UpdateServiceConfig(
                appId: "sdsd",
                language: "en"
            ),
            response: UpdateResponse(data: nil)
        )
        let config = ForceUpdateViewConfig(lang: "en")
        config.style = .fullscreen2
        
        // When
        let view = ForceUpdateViewStyle.make(viewModel: viewModel, config: config)
        
        // Then
        XCTAssertNotNil(view)
        XCTAssertTrue(view is ForceUpdateViewProtocol)
    }
    
    func testMakeViewWithFullscreen3() {
        // Given
        let viewModel = DefaultForceUpdateViewModel(
            serviceConfig: UpdateServiceConfig(
                appId: "sdsd",
                language: "en"
            ),
            response: UpdateResponse(data: nil)
        )
        let config = ForceUpdateViewConfig(lang: "en")
        config.style = .fullscreen3
        
        // When
        let view = ForceUpdateViewStyle.make(viewModel: viewModel, config: config)
        
        // Then
        XCTAssertNotNil(view)
        XCTAssertTrue(view is ForceUpdateViewProtocol)
    }
    
    func testMakeViewWithFullscreen4() {
        // Given
        let viewModel = DefaultForceUpdateViewModel(
            serviceConfig: UpdateServiceConfig(
                appId: "sdsd",
                language: "en"
            ),
            response: UpdateResponse(data: nil)
        )
        let config = ForceUpdateViewConfig(lang: "en")
        config.style = .fullscreen4
        
        // When
        let view = ForceUpdateViewStyle.make(viewModel: viewModel, config: config)
        
        // Then
        XCTAssertNotNil(view)
        XCTAssertTrue(view is ForceUpdateViewProtocol)
    }
    
    func testMakeViewWithPopover1() {
        // Given
        let viewModel = DefaultForceUpdateViewModel(
            serviceConfig: UpdateServiceConfig(
                appId: "sdsd",
                language: "en"
            ),
            response: UpdateResponse(data: nil)
        )
        let config = ForceUpdateViewConfig(lang: "en")
        config.style = .popover1
        
        // When
        let view = ForceUpdateViewStyle.make(viewModel: viewModel, config: config)
        
        // Then
        XCTAssertNotNil(view)
        XCTAssertTrue(view is ForceUpdateViewProtocol)
    }
    
    func testMakeViewWithPopover2() {
        // Given
        let viewModel = DefaultForceUpdateViewModel(
            serviceConfig: UpdateServiceConfig(
                appId: "sdsd",
                language: "en"
            ),
            response: UpdateResponse(data: nil)
        )
        let config = ForceUpdateViewConfig(lang: "en")
        config.style = .popover2
        
        // When
        let view = ForceUpdateViewStyle.make(viewModel: viewModel, config: config)
        
        // Then
        XCTAssertNotNil(view)
        XCTAssertTrue(view is ForceUpdateViewProtocol)
    }
    
    func testMakeViewWithAllStyles() {
        // Given
        let viewModel = DefaultForceUpdateViewModel(
            serviceConfig: UpdateServiceConfig(
                appId: "sdsd",
                language: "en"
            ),
            response: UpdateResponse(data: nil)
        )
        let styles: [ForceUpdateViewStyle] = [.fullscreen1, .fullscreen2, .fullscreen3, .fullscreen4, .popover1, .popover2]
        
        // When & Then
        for style in styles {
            let config = ForceUpdateViewConfig(lang: "en")
            config.style = style
            
            let view = ForceUpdateViewStyle.make(viewModel: viewModel, config: config)
            XCTAssertNotNil(view)
            XCTAssertTrue(view is ForceUpdateViewProtocol)
        }
    }
}
