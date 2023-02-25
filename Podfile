# Uncomment the next line to define a global platform for your project
# platform :ios

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
    end
  end
end

# ignore all warnings from all pods
inhibit_all_warnings!

target 'Watudo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Watudo
pod 'lottie-ios'
pod 'IQKeyboardManagerSwift'
pod 'Charts'
pod 'JTAppleCalendar'
pod 'Alamofire'
pod 'FirebaseAuth'
pod 'FirebaseFirestore'
pod 'FirebaseFirestoreSwift'
pod 'GoogleSignIn'


end
