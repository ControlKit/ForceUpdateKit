//
//  ForceUpdateViewConfigTests.swift
//  ForceUpdateKitTests
//
//  Created by Test Suite on 2024.
//

import XCTest
@testable import ForceUpdateKit

final class ForceUpdateViewConfigTests: XCTestCase {
    
    func testForceUpdateViewConfigInitialization() {
        // Given
        let language = CKLanguage.english
        
        // When
        let config = ForceUpdateViewConfig(lang: language)
        
        // Then
        XCTAssertEqual(config.lang, language)
        XCTAssertEqual(config.style, .fullscreen1)
        XCTAssertEqual(config.updateButtonNortmalTitle, "Update New Version")
        XCTAssertEqual(config.updateButtonSelectedTitle, "Update New Version")
        XCTAssertEqual(config.contentViewBackColor, .white)
        XCTAssertEqual(config.popupViewBackColor, .black)
        XCTAssertEqual(config.popupViewCornerRadius, 15.0)
        XCTAssertEqual(config.updateImageType, .spaceship1)
        XCTAssertEqual(config.updateButtonFont, UIFont.systemFont(ofSize: 12, weight: .medium))
        XCTAssertEqual(config.headerTitleFont, UIFont.systemFont(ofSize: 13, weight: .bold))
        XCTAssertEqual(config.headerTitle, "It's time to update")
        XCTAssertEqual(config.headerTitleColor, .black)
        XCTAssertEqual(config.descriptionFont, UIFont.systemFont(ofSize: 12, weight: .medium))
        XCTAssertEqual(config.descriptionText, "It's time to update The version you are using is old, need to update the latest version in order to experience new features.")
        XCTAssertEqual(config.descriptionTextColor, .gray)
        XCTAssertEqual(config.versionFont, UIFont.systemFont(ofSize: 10, weight: .bold))
        XCTAssertEqual(config.versionText, "Up to 12.349 version Apr 2024.")
        XCTAssertEqual(config.versionTextColor, .gray)
        XCTAssertEqual(config.updateButtonBackColor, .blue)
        XCTAssertEqual(config.lineColor, .lightGray)
        XCTAssertEqual(config.updateButtonTitleColor, .white)
        XCTAssertEqual(config.updateButtonCornerRadius, 20.0)
        XCTAssertEqual(config.updateButtonBorderWidth, 0.0)
        XCTAssertEqual(config.updateButtonBorderColor, .clear)
    }
    
    func testForceUpdateViewConfigWithDifferentLanguage() {
        // Given
        let language = CKLanguage.persian
        
        // When
        let config = ForceUpdateViewConfig(lang: language)
        
        // Then
        XCTAssertEqual(config.lang, language)
    }
    
    func testForceUpdateViewConfigStyleProperty() {
        // Given
        let config = ForceUpdateViewConfig(lang: CKLanguage.english)
        
        // When
        config.style = .popover2
        
        // Then
        XCTAssertEqual(config.style, .popover2)
    }
    
    func testForceUpdateViewConfigButtonTitles() {
        // Given
        let config = ForceUpdateViewConfig(lang: CKLanguage.english)
        
        // When
        config.updateButtonNortmalTitle = "Custom Update"
        config.updateButtonSelectedTitle = "Custom Update Selected"
        
        // Then
        XCTAssertEqual(config.updateButtonNortmalTitle, "Custom Update")
        XCTAssertEqual(config.updateButtonSelectedTitle, "Custom Update Selected")
    }
    
    func testForceUpdateViewConfigColors() {
        // Given
        let config = ForceUpdateViewConfig(lang: CKLanguage.english)
        
        // When
        config.contentViewBackColor = .red
        config.popupViewBackColor = .blue
        config.headerTitleColor = .green
        config.descriptionTextColor = .orange
        config.versionTextColor = .purple
        config.updateButtonBackColor = .yellow
        config.lineColor = .brown
        config.updateButtonTitleColor = .cyan
        config.updateButtonBorderColor = .magenta
        
        // Then
        XCTAssertEqual(config.contentViewBackColor, .red)
        XCTAssertEqual(config.popupViewBackColor, .blue)
        XCTAssertEqual(config.headerTitleColor, .green)
        XCTAssertEqual(config.descriptionTextColor, .orange)
        XCTAssertEqual(config.versionTextColor, .purple)
        XCTAssertEqual(config.updateButtonBackColor, .yellow)
        XCTAssertEqual(config.lineColor, .brown)
        XCTAssertEqual(config.updateButtonTitleColor, .cyan)
        XCTAssertEqual(config.updateButtonBorderColor, .magenta)
    }
    
    func testForceUpdateViewConfigFonts() {
        // Given
        let config = ForceUpdateViewConfig(lang: CKLanguage.english)
        
        // When
        config.updateButtonFont = UIFont.systemFont(ofSize: 16, weight: .bold)
        config.headerTitleFont = UIFont.systemFont(ofSize: 18, weight: .heavy)
        config.descriptionFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        config.versionFont = UIFont.systemFont(ofSize: 12, weight: .semibold)
        
        // Then
        XCTAssertEqual(config.updateButtonFont, UIFont.systemFont(ofSize: 16, weight: .bold))
        XCTAssertEqual(config.headerTitleFont, UIFont.systemFont(ofSize: 18, weight: .heavy))
        XCTAssertEqual(config.descriptionFont, UIFont.systemFont(ofSize: 14, weight: .regular))
        XCTAssertEqual(config.versionFont, UIFont.systemFont(ofSize: 12, weight: .semibold))
    }
    
    func testForceUpdateViewConfigTexts() {
        // Given
        let config = ForceUpdateViewConfig(lang: CKLanguage.english)
        
        // When
        config.headerTitle = "Custom Header"
        config.descriptionText = "Custom description text"
        config.versionText = "Custom version text"
        
        // Then
        XCTAssertEqual(config.headerTitle, "Custom Header")
        XCTAssertEqual(config.descriptionText, "Custom description text")
        XCTAssertEqual(config.versionText, "Custom version text")
    }
    
    func testForceUpdateViewConfigCornerRadius() {
        // Given
        let config = ForceUpdateViewConfig(lang: CKLanguage.english)
        
        // When
        config.popupViewCornerRadius = 25.0
        config.updateButtonCornerRadius = 30.0
        
        // Then
        XCTAssertEqual(config.popupViewCornerRadius, 25.0)
        XCTAssertEqual(config.updateButtonCornerRadius, 30.0)
    }
    
    func testForceUpdateViewConfigBorder() {
        // Given
        let config = ForceUpdateViewConfig(lang: CKLanguage.english)
        
        // When
        config.updateButtonBorderWidth = 2.0
        config.updateButtonBorderColor = .red
        
        // Then
        XCTAssertEqual(config.updateButtonBorderWidth, 2.0)
        XCTAssertEqual(config.updateButtonBorderColor, .red)
    }
    
    func testForceUpdateViewConfigImageType() {
        // Given
        let config = ForceUpdateViewConfig(lang: CKLanguage.english)
        
        // When
        config.updateImageType = .gear
        
        // Then
        XCTAssertEqual(config.updateImageType, .gear)
    }
    
    func testImageTypeEnum() {
        // Given & When & Then
        XCTAssertEqual(ImageType.spaceship1.rawValue, "update-icon")
        XCTAssertEqual(ImageType.spaceship2.rawValue, "spaceship")
        XCTAssertEqual(ImageType.gear.rawValue, "gear")
    }
}
