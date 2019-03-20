source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/CoCoKit/CoCoRepo.git'


platform :ios, '9.0'
inhibit_all_warnings!
install! 'cocoapods', :deterministic_uuids => false
#use_frameworks!

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
        end
    end
end




workspace 'Demo.xcworkspace'

target 'Demo' do
    project 'Demo/Demo.xcodeproj'
    pod 'CoCoRx',  :path => './CoCoRx.podspec'
end

