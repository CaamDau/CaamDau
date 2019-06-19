
Pod::Spec.new do |s|
  s.name             = 'ThirdSDK'
  s.version          = '0.1.0'
  s.summary          = 'A 第三方资源.'
  s.description      = <<-DESC
  TODO: A 第三方资源，项目配置组件.
                       DESC

  s.homepage         = 'https://github.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liucaide' => '565726319@qq.com' }
  s.source           = { :git => '' }
  

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'

  s.default_subspec = 'Core'
  
  s.subspec 'Core' do |core|
    core.dependency 'CD/Ali'
    core.dependency 'CD/Wechat'
  end

  # 阿里-支付宝
  s.subspec 'Ali' do |ali|
    ali.source_files = 'ThirdSDK/Ali/**/*'
    ali.dependency 'AlipaySDK-iOS'
    ali.dependency 'CD/AppDelegate'
  end

  # 微信
  s.subspec 'Wechat' do |wx|
    wx.source_files = 'ThirdSDK/Wechat/**/*'
    wx.dependency 'WechatOpenSDK'
    wx.dependency 'CD/AppDelegate'
  end

  # 友盟分享、登录能力
  s.subspec 'UM' do |um|
    um.source_files = 'ThirdSDK/UMeng/**/*'
    um.dependency 'UMCCommon'
    um.dependency 'UMCSecurityPlugins'
    um.dependency 'UMCShare/Social/ReducedWeChat'
    um.dependency 'UMCShare/Social/ReducedQQ'
    um.dependency 'UMCShare/Social/ReducedSina'
    um.dependency 'CD/AppDelegate'
  end

  # 极光推送能力
  s.subspec 'JPush' do |jpush|
    jpush.source_files = 'ThirdSDK/JPush/**/*'
    jpush.dependency 'JPush'
    jpush.dependency 'CD/AppDelegate'
  end

  # 百度统计能力
  s.subspec 'Baidu' do |bd|
    bd.source_files = 'ThirdSDK/Baidu/**/*'
    bd.dependency 'BaiduMobStatCodeless'
    bd.dependency 'CD/AppDelegate'
  end

  # 百度地图能力
  s.subspec 'BaiduMap' do |bdmap|
    bdmap.source_files = 'ThirdSDK/BaiduMap/**/*'
    bdmap.dependency 'BaiduMapKit'
    bdmap.dependency 'BMKLocationKit'
    bdmap.dependency 'CD/AppDelegate'
  end

  # Bugly
  s.subspec 'Bugly' do |bugly|
    bugly.source_files = 'ThirdSDK/Bugly/**/*'
    bugly.dependency 'Bugly'
    bugly.dependency 'CD/AppDelegate'
  end


end
