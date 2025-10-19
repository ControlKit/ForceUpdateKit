# ForceUpdateKit

| ForceUpdateKit |
|---|
| <img src='https://github.com/maziar/ReadmeFiles/blob/main/imgpsh_fullsize_anim.jpeg' width='200'>

[![Languages](https://img.shields.io/badge/language-swift%205.0%20|%20objc-FF69B4.svg?style=plastic)](#) <br/>
[![Platform](https://img.shields.io/badge/platform-iOS%20|%20tvOS-blue.svg?style=plastic)](http://cocoadocs.org/docsets/FSPagerView)
[![Version](https://img.shields.io/cocoapods/v/FSPagerView.svg?style=plastic)](http://cocoadocs.org/docsets/FSPagerView) 
[![SPM compatible](https://img.shields.io/badge/SPM-compatible-FF9966.svg?style=plastic)](https://swift.org/package-manager/)

<b>SWIFT</b>

**ForceUpdateKit** This repo is for checking the force update of app and handle the force update flow.

## Cross-Platform Support

ForceUpdateKit is available for both iOS and Android platforms:

- **iOS**: [ForceUpdateKit](https://github.com/ControlKit/ForceUpdateKit) (Swift)
- **Android**: [ForceUpdateKit-Android](https://github.com/ControlKit/ForceUpdateKit-Android) (Kotlin)

## Features
*  ***Force Update*** without implementing server and client
*  ***6 Different Styles*** - FullScreen1, FullScreen2, FullScreen3, FullScreen4, Popover1, Popover2
*  ***Compatible*** with all platforms
*  ***Cross-Platform*** support for iOS and Android
*  ***Retry Mechanism*** with configurable retry attempts
*  ***Customizable UI*** with full control over appearance
*  ***Multi-language*** support (English, Persian, and more)
*  ***Network Error Handling*** with retry connection view
*  ***Built-in Icons*** - Spaceship, Gear, and custom icons
*  ***Smooth Animations*** - Slide-in animations for force update views
*  ***Configurable Colors*** - All UI elements can be customized
*  ***Version Management*** - Automatic version checking and comparison


## Installation
* Manually
* Cocoapods
* SPM (Swift Package Manager)

### Manually
1. ***[Download](https://github.com/maziar/ForceUpdateKit/archive/refs/heads/main.zip)*** the source code.
2. Extract the zip file, simply drag folder ***Sources*** into your project.
3. Make sure ***Copy items if needed*** is checked.

### Cocoapods
```ruby
use_frameworks!
target '<Your Target Name>' do
    pod 'ForceUpdateKit'
end
```
https://cocoapods.org/pods/ForceUpdateKit


### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

To integrate ForceUpdateKit into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/maziar/ForceUpdateKit.git")
]
```


## Tutorial
* [Getting started](#getting_started)
* [Advanced Configuration](#advanced_configuration)
* [Retry Mechanism](#retry_mechanism)
* [Testing](#testing)

### 1. Getting started <a id='getting_started'></a>

* Getting started with code

in Appdelegate or SceneDelegate or wherever you need it you can call:
```swift
import ForceUpdateKit

Task {
    let config = UpdateServiceConfig(
        style: .fullscreen1,
        appId: "com.your.app",
        language: .english
    )
    await ForceUpdateKit().configure(config: config, maxRetries: 5)
}
```

### 2. Advanced Configuration <a id='advanced_configuration'></a>

```swift
let config = UpdateServiceConfig(
    style: .fullscreen1,
    appId: "com.your.app",
    language: .persian
)

// Customize retry connection view
config.viewConfig.retryTitleText = "خطا در اتصال"
config.viewConfig.retryMessageText = "لطفاً اتصال اینترنت خود را بررسی کنید"
config.viewConfig.retryButtonTitle = "تلاش مجدد"
config.viewConfig.maxRetriesAlertTitle = "خطا در اتصال"
config.viewConfig.maxRetriesAlertMessage = "امکان اتصال به سرور وجود ندارد"

await ForceUpdateKit().configure(config: config, maxRetries: 3)
```

### 3. Retry Mechanism <a id='retry_mechanism'></a>

The library includes a built-in retry mechanism for handling network errors:

- **Automatic Retry**: When network request fails, a retry view is shown
- **Configurable Attempts**: Set maximum retry attempts (default: 5)
- **Custom UI**: Fully customizable retry connection view
- **Error Handling**: Graceful handling of max retries reached
- **Full-Screen Retry View**: No dismiss button, user must retry or reach max attempts
- **Configurable Retry UI**: All retry view elements can be customized

#### Retry Connection View Features:
- **Full-screen overlay** with customizable background
- **Configurable icon** (built-in or custom image)
- **Customizable text** for title, message, and button
- **Configurable colors** for all UI elements
- **Smooth animations** for show/hide transitions
- **Automatic retry logic** with attempt counting

### 4. Testing <a id='testing'></a>

ForceUpdateKit includes comprehensive unit tests covering all major functionality:

#### Test Coverage
- **Unit Tests**: Individual component testing
- **Integration Tests**: End-to-end workflow testing
- **Mock Services**: Test with mock network responses
- **UI Testing**: View configuration and display testing

#### Running Tests
```bash
# Run all tests
swift test

# Run specific test file
swift test --filter ForceUpdateKitTests
```

#### Test Structure
```
Tests/
├── ForceUpdateKitTests/
│   ├── Models/
│   │   ├── UpdateResponseTests.swift
│   │   ├── UpdateRequestTests.swift
│   │   └── UpdateServiceConfigTests.swift
│   ├── Services/
│   │   ├── UpdateServiceTests.swift
│   │   └── MockUpdateService.swift
│   ├── ViewModels/
│   │   └── ForceUpdateViewModelTests.swift
│   ├── Views/
│   │   ├── ForceUpdateViewConfigTests.swift
│   │   └── RetryConnectionViewTests.swift
│   ├── Extensions/
│   │   └── BundleExtensionTests.swift
│   └── Integration/
│       └── ForceUpdateKitIntegrationTests.swift
```

## Available Styles

ForceUpdateKit provides 6 different UI styles to match your app's design:

### FullScreen Styles
- **FullScreen1**: Classic full-screen layout with centered content
- **FullScreen2**: Full-screen with version label and separator line
- **FullScreen3**: Full-screen with version label below button
- **FullScreen4**: Full-screen with version label at bottom

### Popover Styles
- **Popover1**: Modal popup with semi-transparent background
- **Popover2**: Modal popup with version label

## Demos
* [Demo1 - FullScreen1](#fullscreen1)
* [Demo2 - FullScreen2](#fullscreen2)
* [Demo3 - FullScreen3](#fullscreen3)
* [Demo4 - FullScreen4](#fullscreen4)
* [Demo5 - Popover1](#popover1)
* [Demo6 - Popover2](#popover2)

### Demo1 - FullScreen1 <a id="fullscreen1"></a>

| FullScreen1 |
|---|
|<img src='https://github.com/maziar/ReadmeFiles/blob/main/fullscreen1.png' width='200'>

**e.g.**

```swift
Task {
    let config = UpdateServiceConfig(
        style: .fullscreen1,
        appId: "com.your.app",
        language: .english
    )
    await ForceUpdateKit().configure(config: config, maxRetries: 5)
}
```


## Demo2 - FullScreen2 <a id="fullscreen2"></a>

| FullScreen2 |
|---|
| <img src='https://github.com/maziar/ReadmeFiles/blob/main/fullscreen2.png' width='200'>

**e.g.**

```swift
Task {
    let config = UpdateServiceConfig(
        style: .fullscreen2,
        appId: "com.your.app",
        language: .english
    )
    await ForceUpdateKit().configure(config: config, maxRetries: 5)
}
```
---

## Demo3 - FullScreen3 <a id="fullscreen3"></a>

| FullScreen3 |
|---|
| <img src='https://github.com/maziar/ReadmeFiles/blob/main/fullscreen3.png' width='200'>

**e.g.**

```swift
Task {
    let config = UpdateServiceConfig(
        style: .fullscreen3,
        appId: "com.your.app",
        language: .english
    )
    await ForceUpdateKit().configure(config: config, maxRetries: 5)
}
```
---

## Demo4 - FullScreen4 <a id="fullscreen4"></a>

| FullScreen4 |
|---|
| <img src='https://github.com/maziar/ReadmeFiles/blob/main/fullscreen4.png' width='200'>

**e.g.**

```swift
Task {
    let config = UpdateServiceConfig(
        style: .fullscreen4,
        appId: "com.your.app",
        language: .english
    )
    await ForceUpdateKit().configure(config: config, maxRetries: 5)
}
```
---

## Demo5 - Popover1 <a id="popover1"></a>

| Popover1 |
|---|
| <img src='https://github.com/maziar/ReadmeFiles/blob/main/popover1.png' width='200'>

**e.g.**

```swift
Task {
    let config = UpdateServiceConfig(
        style: .popover1,
        appId: "com.your.app",
        language: .english
    )
    await ForceUpdateKit().configure(config: config, maxRetries: 5)
}
```
 <img src='https://github.com/maziar/ReadmeFiles/blob/main/popover1-backclear.png' width='200'>

**e.g.**

```swift
Task {
    let config = UpdateServiceConfig(
        style: .popover1,
        appId: "com.your.app",
        language: .english
    )
    config.viewConfig.contentViewBackColor = .clear
    await ForceUpdateKit().configure(config: config, maxRetries: 5)
}
```
---

## Demo6 - Popover2 <a id="popover2"></a>

| Popover2 |
|---|
| <img src='https://github.com/maziar/ReadmeFiles/blob/main/popover2.png' width='200'>

**e.g.**

```swift
Task {
    let config = UpdateServiceConfig(
        style: .popover2,
        appId: "com.your.app",
        language: .english
    )
    await ForceUpdateKit().configure(config: config, maxRetries: 5)
}
```
 <img src='https://github.com/maziar/ReadmeFiles/blob/main/popover2-backclear.png' width='200'>

**e.g.**

```swift
Task {
    let config = UpdateServiceConfig(
        style: .popover2,
        appId: "com.your.app",
        language: .english
    )
    config.viewConfig.contentViewBackColor = .clear
    await ForceUpdateKit().configure(config: config, maxRetries: 5)
}
```


## Force Update Mechanism

ForceUpdateKit implements a comprehensive force update system with the following workflow:

### 1. **Initialization & Configuration**
```swift
let config = UpdateServiceConfig(
    style: .fullscreen1,
    appId: "com.your.app",
    language: .english
)
await ForceUpdateKit().configure(config: config, maxRetries: 5)
```

### 2. **Network Request Flow**
- **API Call**: Makes request to configured endpoint with app ID
- **Response Processing**: Parses server response for update requirements
- **Version Comparison**: Compares current app version with server version
- **Force Update Decision**: Determines if update is mandatory

### 3. **Retry Mechanism**
- **Automatic Retry**: On network failure, shows retry connection view
- **Retry Counter**: Tracks number of retry attempts
- **Max Retries**: Configurable maximum retry attempts (default: 5)
- **Error Handling**: Shows alert when max retries reached

### 4. **UI Display**
- **Force Update View**: Shows appropriate style based on configuration
- **Smooth Animation**: Slide-in animation from bottom
- **User Interaction**: Update button opens App Store/Play Store
- **No Dismiss**: User cannot dismiss force update (if mandatory)

### 5. **Shared Instance Pattern**
- **Memory Management**: Uses shared instance to prevent memory leaks
- **Retry Action**: Ensures retry functionality works correctly
- **State Persistence**: Maintains configuration and retry state

## Service Configuration

The `UpdateServiceConfig` class allows you to configure all aspects of the force update system:

```swift
public struct UpdateServiceConfig {
    public init(style: ForceUpdateViewStyle = .fullscreen1,
                appId: String,
                language: CKLanguage) {
        self.viewConfig = ForceUpdateViewStyle.getViewConfigWithStyle(style: style, language: language)
        self.appId = appId
        self.language = language
    }
    public var appId: String
    public var language: CKLanguage
    public var version: String = Bundle.main.releaseVersionNumber ?? String()
    public var viewConfig: ForceUpdateViewConfig
}
```

**Key Properties:**
- `appId`: Your app's bundle identifier
- `language`: Language for UI text (English, Persian, etc.)
- `version`: Current app version (automatically detected)
- `viewConfig`: UI configuration object

The library uses ControlKitBase for better integration and supports multiple languages through CKLanguage enum.

## Custom Server Configuration

You can configure your own server endpoint for force update checks:

```swift
Task {
    let config = UpdateServiceConfig(
        style: .fullscreen1,
        appId: "com.your.app",
        language: .english
    )
    // Note: Server endpoint is configured in UpdateRequest
    await ForceUpdateKit().configure(config: config, maxRetries: 5)
}
```

### Expected Server Response Format

Your server should return a JSON response in the following format:

```json
{
  "version": "Up to 12.349 version Apr 2024.",
  "forceUpdate": true,
  "title": "It's time to update",
  "description": "It's time to update The version you are using is old, need to update to the latest version in order to experience new features.",
  "iconUrl": "http://dummyimage.com/231x100.png/5fa2dd/ffffff.png",
  "linkUrl": "https://apps.apple.com/us/app/telegram/id747648890",
  "buttonTitle": "Update New Version"
}
```

**Response Fields:**
- `version`: Version information text
- `forceUpdate`: Boolean indicating if update is mandatory
- `title`: Header title for the update view
- `description`: Description text explaining the update
- `iconUrl`: URL for the update icon (optional)
- `linkUrl`: App Store/Play Store link for the update
- `buttonTitle`: Text for the update button


## View and Style Configuration

The `ForceUpdateViewConfig` class provides comprehensive customization options for all UI elements:

```swift
public class ForceUpdateViewConfig {
    // Basic Configuration
    public var style: ForceUpdateViewStyle = .fullscreen1
    public var lang: CKLanguage
    
    // Button Configuration
    public var updateButtonNortmalTitle: String = "Update New Version"
    public var updateButtonSelectedTitle: String = "Update New Version"
    public var updateButtonImage: UIImage = UIImage()
    public var updateButtonFont = UIFont.systemFont(ofSize: 12, weight: .medium)
    public var updateButtonBackColor: UIColor = .blue
    public var updateButtonTitleColor: UIColor = .white
    public var updateButtonCornerRadius: CGFloat = 20.0
    public var updateButtonBorderWidth: CGFloat = 0.0
    public var updateButtonBorderColor: UIColor = .clear
    
    // Content Configuration
    public var contentViewBackColor: UIColor = .white
    public var popupViewBackColor: UIColor = .black
    public var popupViewCornerRadius: CGFloat = 15.0
    public var contentBackGroundImage = UIImage()
    
    // Image Configuration
    public var updateImageType: ImageType = .spaceship1
    public var updateImage: UIImage?
    public var updateImageColor: UIColor?
    
    // Text Configuration
    public var headerTitleFont = UIFont.systemFont(ofSize: 13, weight: .bold)
    public var headerTitle = "It's time to update"
    public var headerTitleColor: UIColor = .black
    public var descriptionFont = UIFont.systemFont(ofSize: 12, weight: .medium)
    public var descriptionText = "It's time to update The version you are using is old, need to update the latest version in order to experience new features."
    public var descriptionTextColor: UIColor = .gray
    public var versionFont = UIFont.systemFont(ofSize: 10, weight: .bold)
    public var versionText = "Up to 12.349 version Apr 2024."
    public var versionTextColor: UIColor = .gray
    
    // Line Configuration
    public var lineColor: UIColor = .lightGray
    
    // Retry Connection View Properties
    public var retryBackgroundColor: UIColor = UIColor.black.withAlphaComponent(0.7)
    public var retryContainerBackgroundColor: UIColor = .white
    public var retryContainerCornerRadius: CGFloat = 16.0
    public var retryIconColor: UIColor = UIColor(r: 83, g: 82, b: 82)
    public var retryTitleText: String = "Connection Error"
    public var retryTitleFont: UIFont = UIFont.systemFont(ofSize: 24, weight: .semibold)
    public var retryTitleColor: UIColor = UIColor(r: 84, g: 84, b: 84)
    public var retryMessageText: String = "Please check your internet connection and try again"
    public var retryMessageFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .regular)
    public var retryMessageColor: UIColor = UIColor(r: 84, g: 84, b: 84)
    public var retryButtonTitle: String = "Retry"
    public var retryButtonBackgroundColor: UIColor = UIColor(r: 145, g: 145, b: 145)
    public var retryButtonTitleColor: UIColor = .white
    public var retryButtonCornerRadius: CGFloat = 10.0
    public var retryButtonFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
    
    // Retry Connection View Icon Properties
    public var retryIconName: String = "no-wifi1"
    public var retryIconImage: UIImage?
    public var retryIconSize: CGSize = CGSize(width: 64, height: 64)
    
    // Max Retries Reached Alert Properties
    public var maxRetriesAlertTitle: String = "Connection Error"
    public var maxRetriesAlertMessage: String = "Unable to connect to server. Please try again later."
    public var maxRetriesAlertButtonTitle: String = "OK"
}
```

### Available Image Types
```swift
public enum ImageType: String {
    case spaceship1 = "update-icon"
    case spaceship2 = "spaceship"
    case gear = "gear"
}
```
### Configuration Example

Here's a comprehensive example of customizing the force update view:

```swift
Task {
    let config = UpdateServiceConfig(
        style: .popover2,
        appId: "com.your.app",
        language: .english
    )
    
    // Customize main view
    config.viewConfig.contentViewBackColor = .clear
    config.viewConfig.popupViewBackColor = .black
    config.viewConfig.headerTitle = "my header title"
    config.viewConfig.updateButtonCornerRadius = 30
    config.viewConfig.updateButtonBorderWidth = 1
    config.viewConfig.updateButtonBorderColor = .yellow
    config.viewConfig.headerTitleColor = .white
    config.viewConfig.updateImageType = .gear
    config.viewConfig.updateImageColor = .orange
    config.viewConfig.updateButtonBackColor = .orange
    config.viewConfig.versionTextColor = .orange
    
    // Customize retry connection view
    config.viewConfig.retryTitleText = "خطا در اتصال"
    config.viewConfig.retryMessageText = "لطفاً اتصال اینترنت خود را بررسی کنید"
    config.viewConfig.retryButtonTitle = "تلاش مجدد"
    config.viewConfig.maxRetriesAlertTitle = "خطا در اتصال"
    config.viewConfig.maxRetriesAlertMessage = "امکان اتصال به سرور وجود ندارد"
    
    await ForceUpdateKit().configure(config: config, maxRetries: 3)
}
```

## Advanced Features

### Multi-Language Support
ForceUpdateKit supports multiple languages through the `CKLanguage` enum:

```swift
// English
let config = UpdateServiceConfig(
    style: .fullscreen1,
    appId: "com.your.app",
    language: .english
)

// Persian
let config = UpdateServiceConfig(
    style: .fullscreen1,
    appId: "com.your.app",
    language: .persian
)
```

### Custom Icons and Images
You can use built-in icons or provide custom images:

```swift
// Built-in icons
config.viewConfig.updateImageType = .spaceship1  // Default spaceship
config.viewConfig.updateImageType = .spaceship2  // Alternative spaceship
config.viewConfig.updateImageType = .gear        // Gear icon

// Custom image
config.viewConfig.updateImage = UIImage(named: "custom-icon")
config.viewConfig.updateImageColor = .blue  // Apply color tint
```

### Retry Connection Customization
Customize the retry connection view appearance:

```swift
// Custom retry icon
config.viewConfig.retryIconName = "custom-retry-icon"
config.viewConfig.retryIconImage = UIImage(named: "custom-icon")
config.viewConfig.retryIconSize = CGSize(width: 80, height: 80)

// Custom colors
config.viewConfig.retryBackgroundColor = UIColor.blue.withAlphaComponent(0.8)
config.viewConfig.retryTitleColor = .white
config.viewConfig.retryMessageColor = .lightGray
config.viewConfig.retryButtonBackgroundColor = .orange
```

## Troubleshooting

### Common Issues

#### 1. **Retry Button Not Working**
**Problem**: Retry button doesn't respond to taps
**Solution**: Ensure you're using the latest version with shared instance pattern

#### 2. **Memory Leaks**
**Problem**: App crashes or memory issues
**Solution**: The library uses shared instance pattern to prevent memory leaks

#### 3. **Network Timeout**
**Problem**: Requests timeout frequently
**Solution**: Increase retry attempts or check network configuration

#### 4. **UI Not Displaying**
**Problem**: Force update view doesn't appear
**Solution**: Check window availability and ensure main thread execution

### Debug Mode
Enable debug logging to troubleshoot issues:

```swift
// Check if configuration is correct
let config = UpdateServiceConfig(
    style: .fullscreen1,
    appId: "com.your.app",
    language: .english
)
print("Config: \(config)")
```

## Requirements

- **iOS**: 12.0+
- **Swift**: 5.0+
- **Xcode**: 12.0+
- **Dependencies**: ControlKitBase

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Support

For support and questions:
- Create an issue on GitHub
- Check existing issues for solutions
- Review the documentation

## Changelog

### Version 1.0.0
- Initial release with 6 UI styles
- Retry mechanism implementation
- Multi-language support
- Comprehensive customization options
- Cross-platform support (iOS/Android)
- Unit test coverage
- Shared instance pattern for memory management

