

Pod::Spec.new do |s|
  s.name             = 'FileManager'
  s.version          = '0.1.0'
  s.summary          = 'A short description of .'



  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/liucaide'
  
  #s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liucaide' => '565726319@qq.com' }
  s.source           = { :git => '' }
  

  s.ios.deployment_target = '10.0'

  s.source_files = 'FileManager/Classes/**/*'
  s.resource_bundles = {
    'FileManager' => ['FileManager/Nib/*.{xib,storyboard}'],
    'AssetsFile' => ['FileManager/Assets/*.{xcassets}']
  }

  s.dependency 'CaamDau'
  s.dependency 'Utility'
  s.dependency 'Router'
end
