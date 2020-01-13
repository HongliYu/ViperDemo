platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

def shared_pods
  pod 'SwiftLint', "~> 0.38.2"
  pod 'SwiftGen', '~> 6.1.0'
end

target 'ViperDemo' do
  shared_pods

  post_install do |installer_representation|
      installer_representation.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
          end
      end
  end
end

target 'ViperDemoTests' do
  inherit! :search_paths
  shared_pods
end

target 'ViperDemoUITests' do
  inherit! :search_paths
  shared_pods
  pod 'XCTest-Gherkin', "~> 0.19.1"
  pod 'XCTest-Gherkin/Native'

end
