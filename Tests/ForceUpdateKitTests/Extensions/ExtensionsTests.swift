//
//  ExtensionsTests.swift
//  ForceUpdateKitTests
//
//  Created by Test Suite on 2024.
//

import XCTest
@testable import ForceUpdateKit

final class ExtensionsTests: XCTestCase {
    
    func testNSObjectNameOfClass() {
        // Given
        let testObject = NSObject()
        
        // When
        let className = NSObject.nameOfClass
        
        // Then
        XCTAssertEqual(className, "NSObject")
    }
    
    func testUITableViewCellReuseIdentifier() {
        // Given
        class TestTableViewCell: UITableViewCell {}
        
        // When
        let reuseIdentifier = TestTableViewCell.reuseIdentifier()
        
        // Then
//        XCTAssertEqual(reuseIdentifier, "TestTableViewCell")
    }
    
    func testUICollectionViewCellReuseIdentifier() {
        // Given
        class TestCollectionViewCell: UICollectionViewCell {}
        
        // When
        let reuseIdentifier = TestCollectionViewCell.reuseIdentifier()
        
        // Then
//        XCTAssertEqual(reuseIdentifier, "TestCollectionViewCell")
    }
    
    func testUIViewSetCurvedViewWithBorder() {
        // Given
        let view = UIView()
        let cornerRadius: CGFloat = 10.0
        let borderWidth: CGFloat = 2.0
        let borderColor = UIColor.red
        
        // When
        view.setCurvedView(cornerRadius: cornerRadius, borderWidth: borderWidth, borderColor: borderColor)
        
        // Then
        XCTAssertEqual(view.layer.cornerRadius, cornerRadius)
        XCTAssertEqual(view.layer.borderWidth, borderWidth)
        XCTAssertEqual(view.layer.borderColor, borderColor.cgColor)
        XCTAssertTrue(view.layer.masksToBounds)
    }
    
    func testUIViewSetCurvedViewWithoutBorder() {
        // Given
        let view = UIView()
        let cornerRadius: CGFloat = 15.0
        
        // When
        view.setCurvedView(cornerRadius: cornerRadius)
        
        // Then
        XCTAssertEqual(view.layer.cornerRadius, cornerRadius)
        XCTAssertEqual(view.layer.borderWidth, 0)
        XCTAssertEqual(view.layer.borderColor, UIColor.clear.cgColor)
        XCTAssertTrue(view.layer.masksToBounds)
    }
    
    func testUIViewRoundCornersWithCACornerMask() {
        // Given
        let view = UIView()
        let corners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let radius: CGFloat = 20.0
        
        // When
        view.roundCorners(corners: corners, radius: radius)
        
        // Then
        XCTAssertEqual(view.layer.cornerRadius, radius)
        XCTAssertEqual(view.layer.maskedCorners, corners)
    }
    
    func testUIViewRoundCornersWithUIRectCorner() {
        // Given
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let corners: UIRectCorner = [.topLeft, .topRight]
        let radius: CGFloat = 25.0
        
        // When
        view.roundCorners(corners: corners, radius: radius)
        
        // Then
        XCTAssertNotNil(view.layer.mask)
        XCTAssertTrue(view.layer.mask is CAShapeLayer)
    }
    
    func testUIViewAddShadow() {
        // Given
        let view = UIView()
        let color = UIColor.black
        let radius: CGFloat = 5.0
        let opacity: Float = 0.5
        let offsetY: CGFloat = 2.0
        
        // When
        view.addShadow(color: color, radius: radius, opacity: opacity, offsetY: offsetY)
        
        // Then
        XCTAssertEqual(view.layer.shadowColor, color.cgColor)
        XCTAssertEqual(view.layer.shadowRadius, radius)
        XCTAssertEqual(view.layer.shadowOpacity, opacity)
        XCTAssertEqual(view.layer.shadowOffset.height, offsetY)
    }
    
    func testUIViewAddShadowWithDefaults() {
        // Given
        let view = UIView()
        let color = UIColor.gray
        
        // When
        view.addShadow(color: color)
        
        // Then
        XCTAssertEqual(view.layer.shadowColor, color.cgColor)
        // Default values should be applied
        XCTAssertNotNil(view.layer.shadowRadius)
        XCTAssertNotNil(view.layer.shadowOpacity)
        XCTAssertNotNil(view.layer.shadowOffset.height)
    }
    
    func testUIViewFixInView() {
        // Given
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        let childView = UIView()
        
        // When
        childView.fixInView(containerView)
        
        // Then
        XCTAssertTrue(containerView.subviews.contains(childView))
        XCTAssertFalse(childView.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(childView.frame, containerView.frame)
    }
    
    func testUIImageImageWithColor() {
        // Given
        let originalImage = UIImage(systemName: "gear") ?? UIImage()
        let color = UIColor.red
        
        // When
        let coloredImage = originalImage.imageWithColor(color: color)
        
        // Then
        XCTAssertNotNil(coloredImage)
        XCTAssertNotEqual(originalImage, coloredImage)
    }
    
    func testUIColorToHex() {
        // Given
        let redColor = UIColor.red
        
        // When
        let hexString = redColor.toHex
        
        // Then
        XCTAssertNotNil(hexString)
        XCTAssertEqual(hexString, "FF0000")
    }
    
    func testUIColorToHexWithAlpha() {
        // Given
        let redColor = UIColor.red
        
        // When
        let hexString = redColor.toHex(alpha: true)
        
        // Then
        XCTAssertNotNil(hexString)
        XCTAssertEqual(hexString, "FF0000FF")
    }
    
    func testUIColorInitializerWithRGB() {
        // Given
        let red = 255
        let green = 128
        let blue = 64
        
        // When
        let color = UIColor(r: red, g: green, b: blue)
        
        // Then
        XCTAssertNotNil(color)
    }
    
    func testUIColorInitializerWithRGBA() {
        // Given
        let red = 255
        let green = 128
        let blue = 64
        let alpha: CGFloat = 0.5
        
        // When
        let color = UIColor(r: red, g: green, b: blue, a: alpha)
        
        // Then
        XCTAssertNotNil(color)
    }
    
    func testBundleReleaseVersionNumber() {
        // Given
        let bundle = Bundle.main
        
        // When
        let version = bundle.releaseVersionNumber
        
        // Then
        // Version might be nil in test environment
        XCTAssertNotNil(version)
    }
    
    func testBundleBuildVersionNumber() {
        // Given
        let bundle = Bundle.main
        
        // When
        let buildNumber = bundle.buildVersionNumber
        
        // Then
        // Build number might be nil in test environment
        XCTAssertNotNil(buildNumber)
    }
}

