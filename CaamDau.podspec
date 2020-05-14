
Pod::Spec.new do |s|
  s.name             = 'CaamDau'
  s.version          = '2.0.0'
  s.summary          = 'CaamDau 系列产品组合，iOS 开发工具箱(模块组件) Swift 版.'
  s.description      = <<-DESC
  TODO: CaamDau 系列产品：iOS 便捷开发套件 Swift 版：iOS项目开发通用&非通用型模块代码，多功能组件，可快速集成使用以大幅减少基础工作量；便利性扩展&链式扩展、UI排班组件Form、正则表达式扩展RegEx、计时器管理Timer、简易提示窗HUD、AppDelegate解耦方案、分页控制Page、自定义导航栏TopBar、阿里矢量图标管理IconFonts、MJRefresh扩展、Alamofire扩展......
  附.各种类库使用示例demo.
                       DESC

  s.homepage         = 'https://github.com/CaamDau/CaamDau'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liucaide' => '565726319@qq.com' }
  s.source           = { :git => 'https://github.com/CaamDau/CaamDau.git', :tag => s.version }

  s.ios.deployment_target = '9.0'
  s.swift_version = ['4.0', '4.2', '5.0', '5.1']
  s.default_subspec = 'Core'
  s.source_files = 'CaamDau/*.swift'

  s.subspec 'Core' do |ss|
    ss.dependency 'CaamDau/Extension'
    ss.dependency 'CaamDau/Form'
    ss.dependency 'CaamDau/AppDelegate'
    ss.dependency 'CaamDau/Router'
  end
  
  s.subspec 'Module' do |ss|
    ss.dependency 'CaamDau/Core'

    ss.dependency 'CaamDau/Timer'
    ss.dependency 'CaamDau/InputBox'
    ss.dependency 'CaamDau/IconFont'
    ss.dependency 'CaamDau/Page'
    ss.dependency 'CaamDau/TopBar'
    ss.dependency 'CaamDau/HUD'
    ss.dependency 'CaamDau/ViewModel/Core'
    ss.dependency 'CaamDau/Indexes'
    ss.dependency 'CaamDau/Calendar'
    ss.dependency 'CaamDau/Pencil'
    #ss.dependency 'CaamDau/Empty'
  end
  
  s.subspec 'All' do |ss|
    ss.dependency 'CaamDau/Module'
    
    ss.dependency 'CaamDau/PopGesture'
    ss.dependency 'CaamDau/Refresh'
    ss.dependency 'CaamDau/Net/All'
    ss.dependency 'CaamDau/ViewModel/BaseUI'
    
  end

  # ---- 核心插件 组件
  s.subspec 'Extension' do |ss|
    ss.source_files = 'CaamDau/Extension.h'
    ss.dependency 'CaamDauExtension'
end

s.subspec 'Form' do |ss|
  ss.source_files = 'CaamDau/Form.h'
  ss.dependency 'CaamDauForm'
end

s.subspec 'Timer' do |ss|
  ss.source_files = 'CaamDau/Timer.h'
  ss.dependency 'CaamDauTimer'
end

s.subspec 'Value' do |ss|
  ss.source_files = 'CaamDau/Value.h'
  ss.dependency 'CaamDauValue'
end

s.subspec 'AppDelegate' do |ss|
  ss.source_files = 'CaamDau/AppDelegate.h'
  ss.dependency 'CaamDauAppDelegate'
end

s.subspec 'IconFont' do |ss|
  ss.source_files = 'CaamDau/IconFont.h'
  ss.dependency 'CaamDauIconFont'
end

s.subspec 'TopBar' do |ss|
  ss.source_files = 'CaamDau/TopBar.h'
  ss.dependency 'CaamDauTopBar'
end

s.subspec 'Page' do |ss|
  ss.source_files = 'CaamDau/Page.h'
  ss.dependency 'CaamDauPage'
end

s.subspec 'InputBox' do |ss|
  ss.source_files = 'CaamDau/InputBox.h'
  ss.dependency 'CaamDauInputBox'
end

s.subspec 'HUD' do |ss|
  ss.source_files = 'CaamDau/HUD.h'
  ss.dependency 'CaamDauHUD'
end

s.subspec 'ViewModel' do |vm|
  
  vm.subspec 'Core' do |ss|
    ss.source_files = 'CaamDau/ViewModel.h'
    ss.dependency 'CaamDauViewModel/Core'
  end
  
  vm.subspec 'BaseUI' do |ss|
    ss.source_files = 'CaamDau/ViewModel.h'
    ss.dependency 'CaamDauViewModel/BaseUI'
  end
  
end

s.subspec 'Router' do |ss|
  ss.source_files = 'CaamDau/Router.h'
  ss.dependency 'CaamDauRouter'
end

s.subspec 'Indexes' do |ss|
  ss.source_files = 'CaamDau/Indexes.h'
  ss.dependency 'CaamDauIndexes'
end

s.subspec 'Calendar' do |ss|
  ss.source_files = 'CaamDau/Calendar.h'
  ss.dependency 'CaamDauCalendar'
end

s.subspec 'Empty' do |ss|
  ss.source_files = 'CaamDau/Empty.h'
  ss.dependency 'CaamDauEmpty'
end

s.subspec 'Pencil' do |ss|
  ss.source_files = 'CaamDau/Pencil.h'
  ss.dependency 'CaamDauPencil'
end

# ---- 第三方 扩展 或 桥接
s.subspec 'Refresh' do |ss|
  ss.source_files = 'CaamDau/Refresh.h'
  ss.dependency 'CaamDauRefresh'
end

s.subspec 'PopGesture' do |ss|
  ss.source_files = 'CaamDau/PopGesture.h'
  ss.dependency 'CaamDauPopGesture'
end

s.subspec 'Net' do |net|
  
  net.subspec 'Core' do |ss|
    ss.source_files = 'CaamDau/Net.h'
    ss.dependency 'CaamDauNet/Core'
  end
  
  net.subspec 'All' do |ss|
    
    ss.dependency 'CaamDau/Net/SwiftyJSON'
    ss.dependency 'CaamDau/Net/Cache'
    ss.dependency 'CaamDau/Net/Codable'
  end
  
  net.subspec 'SwiftyJSON' do |ss|
    ss.dependency 'CaamDau/Net/Core'
    ss.dependency 'CaamDauNet/SwiftyJSON'
  end
  
  net.subspec 'Cache' do |ss|
    ss.dependency 'CaamDau/Net/Core'
    ss.dependency 'CaamDauNet/Cache'
  end
  
  net.subspec 'Codable' do |ss|
    ss.dependency 'CaamDau/Net/Core'
    ss.dependency 'CaamDauNet/Codable'
  end
  
end

  s.frameworks = 'UIKit', 'Foundation'
end
