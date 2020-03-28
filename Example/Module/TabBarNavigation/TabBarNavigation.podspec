

Pod::Spec.new do |s|
  s.name             = 'TabBarNavigation'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Find.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
                       
  s.homepage         = 'https://github.com/liucaide'
  # s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liucaide' => '565726319@qq.com' }
  s.source           = { :git => '' }
  
  s.ios.deployment_target = '10.0'
  s.source_files = 'Classes/**/*'
  s.resource_bundles = {
    'TabBarNavigation' => ['Nib/*.{storyboard}'],
    'AssetsTabBar' => ['Assets/*.{xcassets}']
    
  }
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'CaamDau'
  s.dependency 'Utility'
end
