Pod::Spec.new do |s|
  s.name             = 'SwiftExtensions'
  s.version          = '1.0.0'
  s.summary          = 'Essential Swift extensions for Foundation and UIKit.'
  s.description      = 'SwiftExtensions provides essential extensions for Foundation, UIKit, and SwiftUI.'
  s.homepage         = 'https://github.com/muhittincamdali/SwiftExtensions'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Muhittin Camdali' => 'contact@muhittincamdali.com' }
  s.source           = { :git => 'https://github.com/muhittincamdali/SwiftExtensions.git', :tag => s.version.to_s }
  s.ios.deployment_target = '15.0'
  s.swift_versions = ['5.9', '5.10', '6.0']
  s.source_files = 'Sources/**/*.swift'
  s.frameworks = 'Foundation', 'UIKit'
end
