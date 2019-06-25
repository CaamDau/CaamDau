
Pod::Spec.new do |s|
  s.name             = 'Popois'
  s.version          = '0.8.42'
  s.summary          = 'A iOS development toolbox (iOS 开发工具箱(模块插件) Swift 版).'
  s.description      = <<-DESC
  TODO: iOS 模块插件 Swift 版：iOS项目开发通用&非通用型模块代码，多功能插件，可快速集成使用以大幅减少基础工作量；附.各种类库使用示例demo.
                       DESC

  s.homepage         = 'https://github.com/liucaide/Popois'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liucaide' => '565726319@qq.com' }
  s.source           = { :git => 'https://github.com/liucaide/Popois.git', :tag => s.version }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'
  # s.source_files = 'Popois/**/*'
  
  s.default_subspec = 'Core'
  
  s.subspec 'Core' do |po|
    po.source_files = 'Popois/CD.swift'
    po.dependency 'Popois/Extension'
    po.dependency 'Popois/Form'
    po.dependency 'Popois/Chain'
    po.dependency 'Popois/CountDown'
    po.dependency 'Popois/Value'
    po.dependency 'Popois/RegEx'
  end
  
  s.subspec 'Module' do |mo|
    mo.dependency 'Popois/Core'
    mo.dependency 'Popois/IBInspectable'
    mo.dependency 'Popois/InputBox'
    mo.dependency 'Popois/IconFont'
    mo.dependency 'Popois/Page'
    mo.dependency 'Popois/TopBar'
    mo.dependency 'Popois/AppDelegate'
    
    mo.dependency 'Popois/MVVM'
    mo.dependency 'Popois/HUD'
  end
  
  s.subspec 'All' do |all|
    all.dependency 'Popois/Core'
    all.dependency 'Popois/Module'
    
    all.dependency 'Popois/FDFullscreenPopGesture'
    all.dependency 'Popois/MJRefresh'
    all.dependency 'Popois/Net/All'
    
  end
  
  
  # ---- 核心扩展
  s.subspec 'Extension' do |es|
      es.source_files = 'Popois/Extension/*.{swift}', 'Popois/CD.swift'
      es.dependency 'Popois/Form'
  end
  
  s.subspec 'IBInspectable' do |ib|
    ib.source_files = 'Popois/IBInspectable/*.{swift}'
  end
  
  s.subspec 'Form' do |fm|
      fm.source_files = 'Popois/Form/*.{swift}'
  end
  
  s.subspec 'Chain' do |cn|
      cn.source_files = 'Popois/Chain/*.{swift}', 'Popois/CD.swift'
      cn.dependency 'Popois/Extension'
  end
  
  s.subspec 'CountDown' do |down|
    down.source_files = 'Popois/CountDown/*.{swift}'
    down.dependency 'Popois/Extension'
  end
  
  s.subspec 'Value' do |v|
    v.source_files = 'Popois/Value/*.{swift}'
  end
  
  s.subspec 'RegEx' do |regex|
    regex.source_files = 'Popois/RegEx/*.{swift}', 'Popois/CD.swift'
    regex.dependency 'Popois/Extension'
    regex.dependency 'Popois/Value'
  end
  
  # ---- 核心插件 组件
  s.subspec 'AppDelegate' do |app|
    app.source_files = 'Popois/AppDelegate/*.{swift}'
  end
  
  s.subspec 'IconFont' do |ifont|
      ifont.source_files = 'Popois/IconFont/Classes/*.{swift}'
      ifont.resource_bundles = {
          'IconFont' => ['Popois/IconFont/Assets/*.{ttf}']
      }
      ifont.dependency 'Popois/Extension'
  end
  
  s.subspec 'TopBar' do |topbar|
      topbar.source_files = 'Popois/TopBar/*.{swift}'
      topbar.dependency 'Popois/Core'
      topbar.dependency 'Popois/IconFont'
      topbar.dependency 'Popois/FDFullscreenPopGesture'
      topbar.dependency 'SnapKit', '~> 4.2.0'
  end
  
  s.subspec 'Page' do |page|
      page.source_files = 'Popois/Page/*.{swift}'
      page.dependency 'Popois/Core'
      page.dependency 'Popois/FDFullscreenPopGesture'
      page.dependency 'SnapKit', '~> 4.2.0'
  end
  
  s.subspec 'InputBox' do |input|
      input.source_files = 'Popois/InputBox/*.{swift}'
      input.dependency 'Popois/Core'
      input.dependency 'SnapKit', '4.2.0'
  end
  
  s.subspec 'HUD' do |hud|
    hud.source_files = 'Popois/HUD/*.{swift}'
    hud.dependency 'Popois/Core'
    hud.dependency 'Popois/IconFont'
    hud.dependency 'SnapKit', '4.2.0'
  end
  
  s.subspec 'MVVM' do |vm|
    vm.source_files = 'Popois/MVVM/*.{swift}'
    vm.dependency 'Popois/Core'
    vm.dependency 'Popois/TopBar'
    vm.dependency 'Popois/MJRefresh'
    vm.dependency 'SnapKit', '~> 4.2.0'
  end
  
  # ---- 第三方 扩展 或 桥接
  s.subspec 'MJRefresh' do |mj|
    mj.source_files = 'Popois/MJRefresh/*.{swift}', 'Popois/CD.swift'
    mj.dependency 'MJRefresh', '3.1.15.7'
  end
  
  s.subspec 'FDFullscreenPopGesture' do |fd|
      fd.source_files = 'Popois/FDFullscreenPopGesture/*.{swift}', 'Popois/CD.swift'
      fd.dependency 'FDFullscreenPopGesture', '1.1'
  end
  
  s.subspec 'Net' do |net|
    
    net.subspec 'Core' do |core|
      core.source_files = 'Popois/NetWork/*.{swift}'
      core.dependency 'Popois/Extension'
      core.dependency 'Alamofire', '4.8.2'
    end
    
    net.subspec 'All' do |all|
      all.dependency 'Popois/Net/SwiftyJSON'
      all.dependency 'Popois/Net/Cache'
      all.dependency 'Popois/Net/Codable'
    end
    
    net.subspec 'SwiftyJSON' do |json|
      json.source_files = 'Popois/NetWork/SwiftyJSON/*.{swift}'
      json.dependency 'Popois/Net/Core'
      json.dependency 'SwiftyJSON', '4.3.0'
    end
    
    net.subspec 'Cache' do |cache|
      cache.source_files = 'Popois/NetWork/Cache/*.{swift}'
      cache.dependency 'Popois/Net/Core'
      cache.dependency 'Cache', '5.2.0'
    end
    
    net.subspec 'Codable' do |codable|
      codable.source_files = 'Popois/NetWork/Codable/*.{swift}'
      codable.dependency 'Popois/Net/Core'
      codable.dependency 'CleanJSON'
    end
    
  end
  
  
  
  
  
  
  
  
  #s.resource_bundles = {
  #  'CD' => ['Popois/Storyboards/*.{storyboard}']
  #}

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'Then'
end
