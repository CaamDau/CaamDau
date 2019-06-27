
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
  s.static_framework = true

  s.default_subspec = 'Core'
  
#  s.source_files  = 'Module/*'
#  s.preserve_path = 'Module/module.modulemap'
#  s.xcconfig = {
#    'SWIFT_INCLUDE_PATHS' => '$(PODS_ROOT)/ThirdSDK/Module'
#  }

  s.subspec 'Core' do |core|
    core.dependency 'ThirdSDK/BaiduUp'
    core.dependency 'ThirdSDK/Alipay'
    #core.dependency 'ThirdSDK/Wechat'
    core.dependency 'ThirdSDK/UnionPay'
    #core.dependency 'ThirdSDK/UM'
    #core.dependency 'ThirdSDK/JPush'
    #core.dependency 'ThirdSDK/Bugly'
    #core.dependency 'ThirdSDK/Baidu'
    #core.dependency 'ThirdSDK/BaiduMap'
  end
  
  s.subspec 'BaiduUp' do |bdu|
    bdu.source_files = 'ThirdSDK/BaiduUploader/Classes/**/*'
    bdu.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '"-ObjC"' }
    bdu.ios.vendored_frameworks = 'ThirdSDK/BaiduUploader/Frameworks/*.framework'
    bdu.preserve_paths = 'ThirdSDK/BaiduUploader/Frameworks/module.modulemap'
  end
  
  # 阿里-支付宝
  s.subspec 'Alipay' do |ali|
    ali.source_files = 'ThirdSDK/Alipay/Classes/**/*'
    ali.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '"-ObjC"' }
    ali.ios.vendored_frameworks = 'ThirdSDK/Alipay/Frameworks/*.framework'
    ali.preserve_paths = 'ThirdSDK/Alipay/Frameworks/module.modulemap'
    ali.dependency 'CD/AppDelegate'
  end

  # 微信
  s.subspec 'Wechat' do |wx|
    wx.source_files = 'ThirdSDK/Wechat/**/*'
    wx.dependency 'WechatOpenSDK', '1.8.4'
    wx.dependency 'CD/AppDelegate'
  end
  
  # 银联
  s.subspec 'UnionPay' do |unionpay|
    unionpay.source_files = 'ThirdSDK/UnionPay/Classes/**/*', 'ThirdSDK/UnionPay/lib/*.h'
    unionpay.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }
    unionpay.frameworks = 'SystemConfiguration', 'CFNetwork'
    unionpay.ios.library = 'c++', 'z'
    unionpay.vendored_libraries = 'ThirdSDK/UnionPay/lib/*.a'
    unionpay.public_header_files = 'ThirdSDK/UnionPay/lib/*.h'
    unionpay.preserve_paths = 'ThirdSDK/UnionPay/lib/module.modulemap'
    unionpay.dependency 'CD/AppDelegate'
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
    bd.dependency 'BaiduMobStatCodeless', '5.0.2'
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
    bugly.dependency 'Bugly', '2.5.0'
    bugly.dependency 'CD/AppDelegate'
  end


end
