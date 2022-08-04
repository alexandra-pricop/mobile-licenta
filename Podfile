# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'iOS-MVVM' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iOS-MVVM
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Moya/RxSwift'
  pod 'Reusable'
  pod 'RxNuke'
  pod 'RxOptional'
  pod 'Defaults'
  pod 'SnapKit'
  pod 'Hero'
  pod 'IQKeyboardManagerSwift'
  pod 'SwiftDate'
  pod 'NVActivityIndicatorView', '~> 4.8.0'
  pod 'NotificationBannerSwift'
  pod 'PopupDialog'
  pod 'SwiftLint'
  pod 'CleanroomLogger'
  pod 'Wormholy', :configurations => ['Stage']
  pod 'SwiftGen'
  pod 'TweeTextField'
  pod 'DropDown', '2.3.2'
  pod "MonthYearPicker", '~> 4.0.2'
  pod 'Kingfisher', '~> 7.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['CleanroomLogger'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.2'
      end
    end
  end
end
