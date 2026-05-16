# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

target 'CQ-iOS-SDK-Demo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CQ-iOS-SDK-Demo
  pod 'ClearQuoteSDK', :git => 'https://github.com/clearquotetech/cq-ios-sdk.git'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "15.0"
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
    end
  end
end