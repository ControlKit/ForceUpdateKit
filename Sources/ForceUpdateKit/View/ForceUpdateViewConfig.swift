//
//  File.swift
//  
//
//  Created by Maziar Saadatfar on 10/18/23.
//

import Foundation
import UIKit
import ControlKitBase
open class ForceUpdateViewConfig {
    public init(lang: CKLanguage) {
        self.lang = lang
    }
    public let lang: CKLanguage
    public var style: ForceUpdateViewStyle = .fullscreen1
    public var updateButtonNortmalTitle: String = "Update New Version"
    public var updateButtonSelectedTitle: String = "Update New Version"
    public var updateButtonImage: UIImage = UIImage(named: "") ?? UIImage()
    public var contentViewBackColor: UIColor = .white
    public var popupViewBackColor: UIColor = .black
    public var popupViewCornerRadius: CGFloat = 15.0
    public var contentBackGroundImage = UIImage()
    public var updateImageType: ImageType = .spaceship1
    public var updateImage: UIImage?
    public var updateImageColor: UIColor?
    public var updateButtonFont = UIFont.systemFont(ofSize: 12, weight: .medium)
    public var headerTitleFont = UIFont.systemFont(ofSize: 13, weight: .bold)
    public var headerTitle = "It's time to update"
    public var headerTitleColor: UIColor = .black
    public var descriptionFont = UIFont.systemFont(ofSize: 12, weight: .medium)
    public var descriptionText = "It's time to update The version you are using is old, need to update the latest version in order to experience new features."
    public var descriptionTextColor: UIColor = .gray
    public var versionFont = UIFont.systemFont(ofSize: 10, weight: .bold)
    public var versionText = "Up to 12.349 version Apr 2024."
    public var versionTextColor: UIColor = .gray
    public var updateButtonBackColor: UIColor = .blue
    public var lineColor: UIColor = .lightGray
    public var updateButtonTitleColor: UIColor = .white
    public var updateButtonCornerRadius: CGFloat = 20.0
    public var updateButtonBorderWidth: CGFloat = 0.0
    public var updateButtonBorderColor: UIColor = .clear
    
    // Retry Connection View Properties
    public var retryBackgroundColor: UIColor = UIColor.black.withAlphaComponent(0.7)
    public var retryContainerBackgroundColor: UIColor = .white
    public var retryContainerCornerRadius: CGFloat = 16.0
    public var retryIconColor: UIColor = .systemRed
    public var retryTitleText: String = "Connection Error"
    public var retryTitleFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .bold)
    public var retryTitleColor: UIColor = .black
    public var retryMessageText: String = "Please check your internet connection and try again"
    public var retryMessageFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    public var retryMessageColor: UIColor = .gray
    public var retryButtonTitle: String = "Retry"
    public var retryButtonBackgroundColor: UIColor = .systemBlue
    public var retryButtonTitleColor: UIColor = .white
    public var retryButtonCornerRadius: CGFloat = 8.0
    public var retryButtonFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .medium)
    public var dismissButtonTitle: String = "Dismiss"
    public var dismissButtonTitleColor: UIColor = .systemBlue
    public var dismissButtonFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .medium)
    
    // Retry Connection View Icon Properties
    public var retryIconName: String = "no-wifi1"
    public var retryIconImage: UIImage?
    public var retryIconSize: CGSize = CGSize(width: 64, height: 64)
}

public enum ImageType: String {
    case spaceship1 = "update-icon"
    case spaceship2 = "spaceship"
    case gear = "gear"
}
