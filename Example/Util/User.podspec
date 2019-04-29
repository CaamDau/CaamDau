

Pod::Spec.new do |s|
  s.name             = 'User'
  s.version          = '0.1.0'
  s.summary          = 'A '



  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com'
  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liucaide' => '565726319@qq.com' }
  s.source           = { :git => '' }
  

  s.ios.deployment_target = '9.0'

  s.source_files = 'User/**/*'
  
 
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'KeychainAccess', '~> 3.2.0'
  # s.dependency 'CryptoSwift', '~> 0.15.0'
  s.dependency 'CD/Extension'
end
