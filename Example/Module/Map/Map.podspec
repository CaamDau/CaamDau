

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
    loc.resource_bundles = {
      'Map' => ['Map/Nib/*.{storyboard}']
    }
    loc.dependency 'CaamDau'
    loc.dependency 'Utility'
  end

  s.subspec 'Baidu' do |bd|
    bd.source_files = 'Map/Classes/BaiduMap/*'
    bd.resource_bundles = {
      'Map' => ['Map/Nib/*.{storyboard}']
    }
#    bd.dependency 'BaiduMapKit'
#    bd.dependency 'BMKLocationKit'
#    bd.dependency 'BaiduTraceKit-Lite'
    bd.dependency 'CaamDau'
    bd.dependency 'Utility'
  end
  s.subspec 'AMap' do |am|
    am.source_files = 'Map/Classes/AMap/*'
    am.resource_bundles = {
      'Map' => ['Map/Nib/*.{storyboard}']
    }
    am.dependency 'CaamDau'
    am.dependency 'Utility'
  end
end
