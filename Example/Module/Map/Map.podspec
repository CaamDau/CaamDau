

Pod::Spec.new do |s|
  s.name             = 'Map'
  s.version          = '0.1.0'
  s.summary          = 'A short description of .'



  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/liucaide'
  
  #s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liucaide' => '565726319@qq.com' }
  s.source           = { :git => '' }
  

  s.ios.deployment_target = '9.0'

  s.default_subspec = 'Core'
  
  s.subspec 'Core' do |core|
    core.dependency 'Map/Location'
  end

  s.subspec 'Location' do |loc|
    loc.source_files = 'Map/Classes/Location/*'
  end

  s.subspec 'Baidu' do |bd|
    bd.source_files = 'Map/Classes/BaiduMap/*'
    
  end
  s.subspec 'AMap' do |am|
    am.source_files = 'Map/Classes/AMap/*'
  end
  
  s.resource_bundles = {
    'Map' => ['Map/Nib/*.{storyboard}']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'CaamDau'
  s.dependency 'Utility'
end
