source "https://github.com/CocoaPods/Specs.git"

platform :ios, '10.0'
inhibit_all_warnings!
use_frameworks!

def common_dependencies
    pod 'SwiftKnife','3.4'
    pod 'SwiftGen', '6.0'
    pod 'SKWorldCurrencies', '1.0'
    pod 'BloodyMary', '1.0.1'
end

target 'AllaRomana' do
    common_dependencies
end

target 'AllaRomanaTests' do
    inherit! :search_paths
    common_dependencies
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
      	    config.build_settings['CLANG_ANALYZER_LOCALIZABILITY_NONLOCALIZED'] = 'YES'
            config.build_settings['SWIFT_VERSION'] = '5'
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
        end
    end
end
