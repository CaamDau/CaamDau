

Pod::Spec.new do |s|
  s.name             = 'TabbarNavigation'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Find.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
                       
  s.homepage         = 'https://github.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liucaide' => '565726319@qq.com' }
  s.source           = { :git => '' }
  
  s.ios.deployment_target = '10.0'
  s.source_files = 'TabbarNavigation/Classes/**/*'
  s.resource_bundles = {
    'TabbarNavigation' => ['TabbarNavigation/Nib/*.{storyboard}']
    
  }
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'CaamDau'
  s.dependency 'Home'
  s.dependency 'Demo'
  s.dependency 'Publish'
  s.dependency 'Rx'
  s.dependency 'Mine'
  s.dependency 'Sign'
end
