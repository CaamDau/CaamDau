
Pod::Spec.new do |s|
  s.name             = 'CaamDau'
  s.version          = '1.0.10'
  s.summary          = 'A iOS development toolbox (iOS 开发工具箱(模块组件) Swift 版).'
  s.description      = <<-DESC
  TODO: iOS 开发组件 Swift 版：iOS项目开发通用&非通用型模块代码，多功能组件，可快速集成使用以大幅减少基础工作量；便利性扩展&链式扩展、UI排班组件Form、正则表达式扩展RegEx、计时器管理Timer、简易提示窗HUD、AppDelegate解耦方案、分页控制Page、自定义导航栏TopBar、阿里矢量图标管理IconFonts、MJRefresh扩展、Alamofire扩展......
  附.各种类库使用示例demo.
                       DESC

  s.homepage         = 'https://github.com/liucaide/CaamDau'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liucaide' => '565726319@qq.com' }
  s.source           = { :git => 'https://github.com/liucaide/CaamDau.git', :tag => s.version }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.swift_version = ['4.0', '4.2', '5.0']
  # s.source_files = 'CaamDau/**/*'
  
  s.default_subspec = 'Core'
  
  s.subspec 'Core' do |core|
    core.source_files = 'CaamDau/Core/**/*.swift',
    'CaamDau/Extension/**/*.swift',
    'CaamDau/Value/*.{swift}',
    'CaamDau/Form/**/*.{swift}',
    'CaamDau/RegEx/**/*.{swift}'
  end
  
  s.subspec 'Module' do |mo|
    mo.dependency 'CaamDau/Core'
    
    mo.dependency 'CaamDau/IBInspectable'
    mo.dependency 'CaamDau/Timer'
    mo.dependency 'CaamDau/InputBox'
    mo.dependency 'CaamDau/IconFont'
    mo.dependency 'CaamDau/Page'
    mo.dependency 'CaamDau/TopBar'
    mo.dependency 'CaamDau/AppDelegate'
    mo.dependency 'CaamDau/Router'
    mo.dependency 'CaamDau/HUD'
    mo.dependency 'CaamDau/ViewModel/Core'
    mo.dependency 'CaamDau/Indexes'
    mo.dependency 'CaamDau/Calendar'
    mo.dependency 'CaamDau/Empty'
  end
  
  s.subspec 'All' do |all|
    all.dependency 'CaamDau/Module'
    
    all.dependency 'CaamDau/FDFullscreenPopGesture'
    all.dependency 'CaamDau/MJRefresh'
    all.dependency 'CaamDau/Net/All'
    all.dependency 'CaamDau/ViewModel/BaseUI'
  end
  
  # ---- 核心插件 组件
  s.subspec 'Extension' do |ex|
      ex.source_files = 'CaamDau/Core/**/*.swift',
      'CaamDau/Extension/**/*.swift',
      'CaamDau/Value/*.{swift}',
      'CaamDau/RegEx/**/*.{swift}'
  end
  
  s.subspec 'Form' do |form|
    form.source_files = 'CaamDau/Core/**/*.swift',
    'CaamDau/Extension/**/*.swift',
    'CaamDau/Value/*.{swift}',
    'CaamDau/Form/**/*.{swift}',
    'CaamDau/RegEx/**/*.{swift}'
  end
  
  s.subspec 'Timer' do |t|
    t.source_files = 'CaamDau/Timer/*.{swift}'
    t.dependency 'CaamDau/Core'
  end
  
  s.subspec 'Value' do |v|
    v.source_files = 'CaamDau/Value/*.{swift}'
  end
  
  s.subspec 'IBInspectable' do |ib|
    ib.source_files = 'CaamDau/IBInspectable/*.{swift}'
  end
  
  s.subspec 'AppDelegate' do |app|
    app.source_files = 'CaamDau/AppDelegate/*.{swift}'
  end
  
  s.subspec 'IconFont' do |ifont|
      ifont.source_files = 'CaamDau/IconFont/Classes/*.{swift}'
      ifont.resource_bundles = {
          'CaamDauIconFont' => ['CaamDau/IconFont/Assets/*.{ttf}']
      }
      ifont.dependency 'CaamDau/Core'
  end
  
  s.subspec 'TopBar' do |topbar|
      topbar.source_files = 'CaamDau/TopBar/*.{swift}'
      topbar.dependency 'CaamDau/Core'
      topbar.dependency 'CaamDau/Value'
      topbar.dependency 'CaamDau/IconFont'
      topbar.dependency 'CaamDau/FDFullscreenPopGesture'
      topbar.dependency 'SnapKit'

  end
  
  s.subspec 'Page' do |page|
      page.source_files = 'CaamDau/Page/*.{swift}'
      page.dependency 'CaamDau/Core'
      page.dependency 'CaamDau/FDFullscreenPopGesture'
      page.dependency 'SnapKit'

  end
  
  s.subspec 'InputBox' do |input|
      input.source_files = 'CaamDau/InputBox/Classes/*.{swift}'
      input.dependency 'CaamDau/Core'
      input.dependency 'SnapKit'
      input.resource_bundles = {
        'CaamDauInputBox' => ['CaamDau/InputBox/Nib/*.{xib}']
      }
  end
  
  s.subspec 'HUD' do |hud|
    hud.source_files = 'CaamDau/HUD/*.{swift}'
    hud.dependency 'CaamDau/Core'
    hud.dependency 'CaamDau/Timer'
    hud.dependency 'CaamDau/IconFont'
    hud.dependency 'SnapKit'

  end
  
  s.subspec 'ViewModel' do |vm|
    
    vm.subspec 'Core' do |core|
      core.source_files = 'CaamDau/ViewModel/Core/**/*.{swift}'
      core.dependency 'CaamDau/Core'
    end
    
    vm.subspec 'BaseUI' do |bui|
      bui.source_files = 'CaamDau/ViewModel/BaseUI/**/*.{swift}'
      bui.dependency 'CaamDau/ViewModel/Core'
      bui.dependency 'CaamDau/TopBar'
      bui.dependency 'CaamDau/MJRefresh'
      bui.dependency 'SnapKit'
    end
    
  end
  
  s.subspec 'Router' do |rr|
    rr.source_files = 'CaamDau/Router/*.{swift}'
    rr.dependency 'CaamDau/Core'
  end
  
  s.subspec 'Indexes' do |indx|
      indx.source_files = 'CaamDau/Indexes/*.{swift}'
      indx.dependency 'CaamDau/Core'
      indx.dependency 'SnapKit'

  end
  
  s.subspec 'Calendar' do |date|
      date.source_files = 'CaamDau/Calendar/*.{swift}'
      date.dependency 'CaamDau/Core'
      date.dependency 'SnapKit'
  end
  
  s.subspec 'Empty' do |empty|
    empty.source_files = 'CaamDau/EmptyView/**/*.{swift}'
    empty.dependency 'CaamDau/Core'
  end
  
  # ---- 第三方 扩展 或 桥接
  s.subspec 'MJRefresh' do |mj|
    mj.source_files = 'CaamDau/MJRefresh/*.{swift}'
    mj.dependency 'CaamDau/Core'
    mj.dependency 'MJRefresh', '3.2.0'
  end
  
  s.subspec 'FDFullscreenPopGesture' do |fd|
      fd.source_files = 'CaamDau/FDFullscreenPopGesture/*.{swift}'
      fd.dependency 'CaamDau/Core'
      fd.dependency 'FDFullscreenPopGesture'

  end
  
  s.subspec 'Net' do |net|
    
    net.subspec 'Core' do |core|
      core.source_files = 'CaamDau/NetWork/Core/*'
      core.dependency 'Alamofire'
      core.dependency 'CaamDau/Core'
    end
    
    net.subspec 'All' do |all|
      all.dependency 'CaamDau/Net/Core'
      all.dependency 'CaamDau/Net/SwiftyJSON'
      all.dependency 'CaamDau/Net/Cache'
      all.dependency 'CaamDau/Net/Codable'
    end
    
    net.subspec 'SwiftyJSON' do |json|
      json.source_files = 'CaamDau/NetWork/SwiftyJSON/*.{swift}'
      json.dependency 'CaamDau/Net/Core'
      json.dependency 'SwiftyJSON'
    end
    
    net.subspec 'Cache' do |cache|
      cache.source_files = 'CaamDau/NetWork/Cache/*.{swift}'
      cache.dependency 'CaamDau/Core'
      cache.dependency 'CaamDau/Net/Core'
      cache.dependency 'Cache'

    end
    
    net.subspec 'Codable' do |codable|
      codable.source_files = 'CaamDau/NetWork/Codable/*.{swift}'
      codable.dependency 'CaamDau/Net/Core'
      codable.dependency 'CleanJSON'
    end
    
  end
  
  s.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'Then'
end
