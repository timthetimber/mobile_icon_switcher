Pod::Spec.new do |s|
  s.name             = 'mobile_icon_switcher'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin for switching the app icon.'
  s.description      = <<-DESC
A Flutter plugin for switching the app icon dynamically from Dart code. Works on both iOS and Android.
                       DESC
  s.homepage         = 'https://github.com/timthetimber/mobile_icon_switcher'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Tim H' => 'tim@hoenlinger.dev' }
  s.source           = { :path => '.' }
  s.source_files     = 'Runner/**/*'
  s.public_header_files = 'Runner/**/*.h'
  s.dependency 'Flutter'

  s.ios.deployment_target = '11.0'
end
