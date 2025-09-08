Pod::Spec.new do |s|
  s.name             = 'device_info_ce'
  s.version          = '1.0.0'
  s.summary          = 'A comprehensive Flutter plugin to get detailed device information.'
  s.description      = <<-DESC
A comprehensive Flutter plugin to get detailed device information without external dependencies.
                       DESC
  s.homepage         = 'https://github.com/fussion-integrator/device_info_ce'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Cedeh' => 'cedeh@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end