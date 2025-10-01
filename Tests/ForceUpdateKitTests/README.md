# ForceUpdateKit Tests

این مجموعه تست‌های کامل برای کتابخانه ForceUpdateKit است که شامل تست‌های unit، integration و performance می‌باشد.

## ساختار تست‌ها

### 📁 Models/
- **UpdateRequestTests.swift**: تست‌های مدل درخواست به‌روزرسانی
- **UpdateResponseTests.swift**: تست‌های مدل پاسخ به‌روزرسانی

### 📁 Service/
- **UpdateServiceTests.swift**: تست‌های سرویس به‌روزرسانی
- **MockUpdateService.swift**: Mock service برای تست‌ها

### 📁 ViewModel/
- **ForceUpdateViewModelTests.swift**: تست‌های ViewModel

### 📁 Config/
- **UpdateServiceConfigTests.swift**: تست‌های تنظیمات سرویس
- **ForceUpdateViewConfigTests.swift**: تست‌های تنظیمات View

### 📁 Helper/
- **ForceUpdateViewStyleTests.swift**: تست‌های استایل‌های View

### 📁 Extensions/
- **ExtensionsTests.swift**: تست‌های extension‌ها

### 📁 Integration/
- **IntegrationTests.swift**: تست‌های integration و performance

## انواع تست‌ها

### 🔧 Unit Tests
- تست‌های جداگانه برای هر کلاس و متد
- تست‌های initialization و property‌ها
- تست‌های validation و error handling

### 🔗 Integration Tests
- تست‌های جریان کامل از configure تا نمایش View
- تست‌های interaction بین کامپوننت‌ها
- تست‌های performance

### 🎯 Mock Tests
- استفاده از MockUpdateService برای تست‌های network
- تست‌های error scenarios
- تست‌های success scenarios

## ویژگی‌های تست‌ها

### ✅ پوشش کامل
- تمام کلاس‌ها و متدهای public
- تمام سناریوهای success و error
- تمام style‌ها و language‌ها

### 🚀 Performance Tests
- تست‌های سرعت اجرا
- تست‌های memory usage
- تست‌های concurrent access

### 🌍 Internationalization
- تست‌های زبان‌های مختلف (انگلیسی، فارسی، عربی، اسپانیایی، فرانسوی، آلمانی، چینی، ژاپنی، کره‌ای)
- تست‌های RTL و LTR

### 🎨 UI Styles
- تست‌های تمام style‌های View (fullscreen1-4, popover1-2)
- تست‌های customization
- تست‌های responsive design

## نحوه اجرای تست‌ها

```bash
# اجرای تمام تست‌ها
xcodebuild test -scheme ForceUpdateKit -destination 'platform=iOS Simulator,name=iPhone 15'

# اجرای تست‌های خاص
xcodebuild test -scheme ForceUpdateKit -destination 'platform=iOS Simulator,name=iPhone 15' -only-testing:ForceUpdateKitTests/ForceUpdateKitMainTests
```

## Coverage Report

برای مشاهده coverage report:

```bash
xcodebuild test -scheme ForceUpdateKit -destination 'platform=iOS Simulator,name=iPhone 15' -enableCodeCoverage YES
```

## تست‌های اضافی

### 🔒 Security Tests
- تست‌های validation input
- تست‌های secure communication
- تست‌های data protection

### 📱 Device Tests
- تست‌های iPhone و iPad
- تست‌های iOS versions مختلف
- تست‌های orientation changes

### 🌐 Network Tests
- تست‌های offline scenarios
- تست‌های slow network
- تست‌های timeout handling

## Best Practices

1. **Naming Convention**: استفاده از نام‌های واضح و توصیفی
2. **Arrange-Act-Assert**: ساختار استاندارد تست‌ها
3. **Mock Objects**: استفاده از mock برای isolation
4. **Error Testing**: تست‌های comprehensive error handling
5. **Performance**: تست‌های performance برای critical paths

## Contributing

برای اضافه کردن تست‌های جدید:

1. فایل تست را در پوشه مناسب ایجاد کنید
2. از naming convention موجود پیروی کنید
3. تست‌های unit و integration را جدا کنید
4. Mock objects را برای network calls استفاده کنید
5. Documentation را به‌روزرسانی کنید
