
Pod::Spec.new do |s|
  s.name             = 'CD'
  s.version          = '0.1.0'
  s.summary          = 'A iOS development toolbox (iOS 开发工具箱).'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/liucaide/CD'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liucaide' => '565726319@qq.com' }
  s.source           = { :git => 'https://github.com/liucaide/CD.git' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  # s.source_files = 'CD/**/*'
  
  s.default_subspec = 'CD'
  
  s.subspec 'CD' do |cd|
    cd.source_files = 'CD/CD.swift'
    cd.dependency 'CD/Extension'
    cd.dependency 'CD/Form'
    cd.dependency 'CD/Chain'
  end
  
  s.subspec 'All' do |all|
    all.source_files = 'CD/CD.swift'
    all.dependency 'CD/Extension'
    all.dependency 'CD/Form'
    all.dependency 'CD/Chain'
    all.dependency 'CD/IconFont'
    all.dependency 'CD/IBInspectable'
    all.dependency 'CD/MVVM'
    all.dependency 'CD/MJRefresh'
  end
  
  s.subspec 'Extension' do |es|
      es.source_files = 'CD/CD_Extension/*', 'CD/CD.swift'
  end
  
  s.subspec 'IBInspectable' do |ib|
    ib.source_files = 'CD/CD_IBInspectable/*'
  end
  
  s.subspec 'Form' do |fm|
      fm.source_files = 'CD/CD_Form/*'
  end
  
  s.subspec 'Chain' do |cn|
      cn.source_files = 'CD/CD_Chain/*', 'CD/CD.swift'
  end
  
  s.subspec 'IconFont' do |ifont|
      ifont.source_files = 'CD/CD_IconFont/Classes/*', 'CD/CD.swift'
      ifont.resource_bundles = {
          'IconFont' => ['CD/CD_IconFont/Assets/*.{ttf}']
      }
  end
  
  s.subspec 'MVVM' do |vm|
    vm.source_files = 'CD/CD_MVVM/*'
  end
  
  s.subspec 'MJRefresh' do |mj|
    mj.source_files = 'CD/CD_MJRefresh/*'
    mj.dependency 'MJRefresh'
  end
  
  #s.resource_bundles = {
  #  'CD' => ['CD/Storyboards/*.{storyboard}']
  #}

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
