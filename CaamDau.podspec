
Pod::Spec.new do |s|
  s.name             = 'CaamDau'
  s.version          = '0.8.42'
  s.summary          = 'A iOS development toolbox (iOS 开发工具箱(模块插件) Swift 版).'
  s.description      = <<-DESC
  TODO: iOS 模块插件 Swift 版：iOS项目开发通用&非通用型模块代码，多功能插件，可快速集成使用以大幅减少基础工作量；附.各种类库使用示例demo.
                       DESC

  s.homepage         = 'https://github.com/liucaide/CaamDau'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liucaide' => '565726319@qq.com' }
  s.source           = { :git => 'https://github.com/liucaide/CaamDau.git', :tag => s.version }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'
  # s.source_files = 'CaamDau/**/*'
  
  s.default_subspec = 'Core'
  
  s.subspec 'Core' do |co|
    co.source_files = 'CaamDau/Core/*.swift',
    'CaamDau/Extension/*.swift',
    'CaamDau/Form/*.{swift}',
    'CaamDau/IBInspectable/*.{swift}',
    'CaamDau/Timer/*.{swift}',
    'CaamDau/Value/*.{swift}', 'CaamDau/RegEx/*.{swift}'
  end
  
  s.subspec 'Module' do |mo|
    mo.dependency 'CaamDau/Core'
    mo.dependency 'CaamDau/InputBox'
    mo.dependency 'CaamDau/IconFont'
    mo.dependency 'CaamDau/Page'
    mo.dependency 'CaamDau/TopBar'
    mo.dependency 'CaamDau/AppDelegate'
    
    mo.dependency 'CaamDau/MVVM'
    mo.dependency 'CaamDau/HUD'
  end
  
  s.subspec 'All' do |all|
    all.dependency 'CaamDau/Core'
    all.dependency 'CaamDau/Module'
    
    all.dependency 'CaamDau/FDFullscreenPopGesture'
    all.dependency 'CaamDau/MJRefresh'
    all.dependency 'CaamDau/Net/All'
    
  end
  
  
  # ---- 核心扩展
  
  # ---- 核心插件 组件
  s.subspec 'AppDelegate' do |app|
    app.source_files = 'CaamDau/AppDelegate/*.{swift}'
  end
  
  s.subspec 'IconFont' do |ifont|
      ifont.source_files = 'CaamDau/IconFont/Classes/*.{swift}'
      ifont.resource_bundles = {
          'IconFont' => ['CaamDau/IconFont/Assets/*.{ttf}']
      }
      ifont.dependency 'CaamDau/Core'
  end
  
  s.subspec 'TopBar' do |topbar|
      topbar.source_files = 'CaamDau/TopBar/*.{swift}'
      topbar.dependency 'CaamDau/Core'
      topbar.dependency 'CaamDau/IconFont'
      topbar.dependency 'CaamDau/FDFullscreenPopGesture'
      topbar.dependency 'SnapKit', '~> 4.2.0'
  end
  
  s.subspec 'Page' do |page|
      page.source_files = 'CaamDau/Page/*.{swift}'
      page.dependency 'CaamDau/Core'
      page.dependency 'CaamDau/FDFullscreenPopGesture'
      page.dependency 'SnapKit', '~> 4.2.0'
  end
  
  s.subspec 'InputBox' do |input|
      input.source_files = 'CaamDau/InputBox/*.{swift}'
      input.dependency 'CaamDau/Core'
      input.dependency 'SnapKit', '4.2.0'
  end
  
  s.subspec 'HUD' do |hud|
    hud.source_files = 'CaamDau/HUD/*.{swift}'
    hud.dependency 'CaamDau/Core'
    hud.dependency 'CaamDau/IconFont'
    hud.dependency 'SnapKit', '4.2.0'
  end
  
  s.subspec 'MVVM' do |vm|
    vm.source_files = 'CaamDau/MVVM/*.{swift}'
    vm.dependency 'CaamDau/Core'
    vm.dependency 'CaamDau/TopBar'
    vm.dependency 'CaamDau/MJRefresh'
    vm.dependency 'SnapKit', '~> 4.2.0'
  end
  
  # ---- 第三方 扩展 或 桥接
  s.subspec 'MJRefresh' do |mj|
    mj.source_files = 'CaamDau/MJRefresh/*.{swift}', 'CaamDau/CD.swift'
    mj.dependency 'MJRefresh', '3.1.15.7'
  end
  
  s.subspec 'FDFullscreenPopGesture' do |fd|
      fd.source_files = 'CaamDau/FDFullscreenPopGesture/*.{swift}', 'CaamDau/CD.swift'
      fd.dependency 'FDFullscreenPopGesture', '1.1'
  end
  
  s.subspec 'Net' do |net|
    
    net.subspec 'Core' do |core|
      core.source_files = 'CaamDau/NetWork/*.{swift}'
      core.dependency 'Alamofire', '4.8.2'
    end
    
    net.subspec 'All' do |all|
      all.dependency 'CaamDau/Net/SwiftyJSON'
      all.dependency 'CaamDau/Net/Cache'
      all.dependency 'CaamDau/Net/Codable'
    end
    
    net.subspec 'SwiftyJSON' do |json|
      json.source_files = 'CaamDau/NetWork/SwiftyJSON/*.{swift}'
      json.dependency 'CaamDau/Net/Core'
      json.dependency 'SwiftyJSON', '4.3.0'
    end
    
    net.subspec 'Cache' do |cache|
      cache.source_files = 'CaamDau/NetWork/Cache/*.{swift}'
      cache.dependency 'CaamDau/Net/Core'
      cache.dependency 'Cache', '5.2.0'
    end
    
    net.subspec 'Codable' do |codable|
      codable.source_files = 'CaamDau/NetWork/Codable/*.{swift}'
      codable.dependency 'CaamDau/Net/Core'
      codable.dependency 'CleanJSON'
    end
    
  end
  
  
  
  
  
  
  
  
  #s.resource_bundles = {
  #  'CD' => ['CaamDau/Storyboards/*.{storyboard}']
  #}

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'Then'
end
