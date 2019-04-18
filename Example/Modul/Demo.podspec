

Pod::Spec.new do |s|
  s.name             = 'Demo'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Find.'
  
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com'
  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liucaide' => '565726319@qq.com' }
  s.source           = { :git => '' }
  

  s.ios.deployment_target = '9.0'

  s.source_files = 'Demo/Classes/**/*'
  
  s.resource_bundles = {
    'Demo' => ['Demo/Nib/*.{storyboard}']
    
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'CD/All'
  s.dependency 'Sign'
  s.dependency 'Assets'
  s.dependency 'Config'
  s.dependency 'HUD'
  #s.dependency 'Web'
  #s.dependency 'SnapKit'
  #s.dependency 'RxSwift'
  #s.dependency 'RxCocoa'
  #s.dependency 'RxDataSources'
  #s.dependency 'Kingfisher'
  #s.dependency 'Hero'
  #s.dependency 'Tangram'
  #s.dependency 'coobjc'
  #s.dependency 'CollectionKit'
  #s.dependency 'Charts'
  #s.dependency 'SideMenu'
  #s.dependency 'CryptoSwift'
  #s.dependency 'SwiftDate'
  #s.dependency 'KeychainAccess'
end
