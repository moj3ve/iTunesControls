Pod::Spec.new do |s|
  s.name             = 'iTunesControls'
  s.version          = '0.1.0'
  s.summary          = 'A wrapper to control iTunes app.'
 
  s.description      = <<-DESC
A wrapper to control iTunes app on macOS 10.14 and older.
                       DESC
 
  s.homepage         = 'https://github.com/Minh-Ton/iTunesControls'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MinhTon' => 'ford.tonthat@icloud.com' }
  s.source           = { :git => 'https://github.com/Minh-Ton/iTunesControls.git', :tag => s.version.to_s }
 
  s.osx.deployment_target = '10.12'
  s.source_files = 'iTunesControls/*.swift'
  s.swift_version = '4.0'
 
end