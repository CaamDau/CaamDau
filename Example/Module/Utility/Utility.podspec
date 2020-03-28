
Pod::Spec.new do |s|
  s.name             = 'Utility'
  s.version          = '0.1.0'
  s.summary          = 'A 本地资源.'
  s.description      = <<-DESC
  TODO: A 本地资源，项目配置，通用组件.
                       DESC

  s.homepage         = 'https://github.com'
  # s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liucaide' => '565726319@qq.com' }
  s.source           = { :git => '' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.default_subspec = 'Core'
  
  s.subspec 'Core' do |core|
    core.dependency 'Utility/User'
    core.dependency 'Utility/HUD'
    core.dependency 'Utility/Web'
    core.dependency 'Utility/Config'
    core.dependency 'Utility/App'
    core.dependency 'Utility/Assets'
    core.dependency 'Utility/Extension'
    core.dependency 'Utility/Crypto'
  end

  # 用户信息管理、登录注册响应模型
  s.subspec 'User' do |user|
    user.source_files = 'User/**/*'
    user.dependency 'KeychainAccess', '~> 3.2.0'
    user.dependency 'CaamDau'
  end

  # 提示窗
  s.subspec 'HUD' do |hud|
    hud.source_files = 'HUD/**/*'
    hud.dependency 'CaamDau'
  end

  # 网页
  s.subspec 'Web' do |web|
    web.source_files = 'Web/**/*'
    web.dependency 'CaamDau/TopBar'
  end

  # 全局基本配置
  s.subspec 'Config' do |config|
    config.source_files = 'Config/Classes/**/*'
    config.resource_bundles = {
      'Config' => ['Config/Assets/*.{plist,xcassets}']
    }
    config.dependency 'CaamDau'
  end

  # 网络基本配置
  s.subspec 'App' do |app|
    app.source_files = 'App/**/*'
    app.dependency 'CaamDau/MJRefresh'
    app.dependency 'CaamDau/TopBar'
    app.dependency 'CaamDau/Net/All'
    app.dependency 'IQKeyboardManagerSwift'
  end

  # 通用实施扩展 - ImageView Button ... 
  s.subspec 'Extension' do |ex|
    ex.source_files = 'Extension/**/*'
    ex.dependency 'CaamDau'
  end

  # 加密
  s.subspec 'Crypto' do |crypto|
    crypto.source_files = 'Crypto/**/*'
    #crypto.dependency 'CryptoSwift', '0.15.0'
  end

  # 通用图片资源
  s.subspec 'Assets' do |ass|
    ass.source_files = 'Assets/Classes/**/*'
    ass.resource_bundles = {
      'Assets' => ['Assets/Assets/Images.xcassets']
    }
    ass.dependency 'CaamDau'
  end

  


end
