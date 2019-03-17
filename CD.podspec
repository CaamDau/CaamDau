
Pod::Spec.new do |s|
  s.name             = 'CD'
  s.version          = '0.2.423'
  s.summary          = 'A iOS development toolbox (iOS 开发工具箱(模块插件) Swift 版).'
  s.description      = <<-DESC
  TODO: iOS 模块插件 Swift 版：iOS项目开发通用&非通用型模块代码，多功能插件，可快速集成使用以大幅减少基础工作量；附.各种类库使用示例demo.
                       DESC

  s.homepage         = 'https://github.com/liucaide/CD'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liucaide' => '565726319@qq.com' }
  s.source           = { :git => 'https://github.com/liucaide/CD.git', :tag => s.version }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'
  # s.source_files = 'CD/**/*'
  
  s.default_subspec = 'Core'
  
  s.subspec 'Core' do |cd|
    cd.source_files = 'CD/CD.swift'
    cd.dependency 'CD/Extension'
    cd.dependency 'CD/Form'
    cd.dependency 'CD/Chain'
    cd.dependency 'CD/CountDown'
    cd.dependency 'CD/Value'
  end
  
  s.subspec 'All' do |all|
    all.source_files = 'CD/CD.swift'
    all.dependency 'CD/Extension'
    all.dependency 'CD/Form'
    all.dependency 'CD/Chain'
    all.dependency 'CD/CountDown'
    all.dependency 'CD/Value'
    all.dependency 'CD/IconFont'
    all.dependency 'CD/IBInspectable'
    #all.dependency 'CD/MVVM'
    all.dependency 'CD/MJRefresh'
  end
  
  s.subspec 'Extension' do |es|
      es.source_files = 'CD/CD_Extension/*', 'CD/CD.swift'
      es.dependency 'CD/Form'
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
  
  s.subspec 'CountDown' do |down|
    down.source_files = 'CD/CD_CountDown/*'
    down.dependency 'CD/Extension'
  end
  
  s.subspec 'Value' do |v|
    v.source_files = 'CD/CD_Value/*'
  end
  
  s.subspec 'IconFont' do |ifont|
      ifont.source_files = 'CD/CD_IconFont/Classes/*'
      ifont.resource_bundles = {
          'IconFont' => ['CD/CD_IconFont/Assets/*.{ttf}']
      }
      ifont.dependency 'CD/Extension'
  end
  
  #s.subspec 'MVVM' do |vm|
  #  vm.source_files = 'CD/CD_MVVM/*'
  #end
  
  s.subspec 'MJRefresh' do |mj|
    mj.source_files = 'CD/CD_MJRefresh/*', 'CD/CD.swift'
    mj.dependency 'MJRefresh'
  end
  
  #s.resource_bundles = {
  #  'CD' => ['CD/Storyboards/*.{storyboard}']
  #}

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
