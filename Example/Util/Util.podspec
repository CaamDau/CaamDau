
Pod::Spec.new do |s|
  s.name             = 'Util'
  s.version          = '0.1.0'
  s.summary          = 'A 本地资源.'
  s.description      = <<-DESC
  TODO: A 本地资源，项目配置，通用组件.
                       DESC

  s.homepage         = 'https://github.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liucaide' => '565726319@qq.com' }
  s.source           = { :git => '' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'

  s.default_subspec = 'Core'
  
  s.subspec 'Core' do |core|
    core.dependency 'Util/User'
    core.dependency 'Util/HUD'
    core.dependency 'Util/Config'
    core.dependency 'Util/Net'
    core.dependency 'Util/Assets'
    core.dependency 'Util/Extension'
    core.dependency 'Util/Crypto'
  end

  # 用户信息管理、登录注册响应模型
  s.subspec 'User' do |user|
    user.source_files = 'Util/User/**/*'
    user.dependency 'KeychainAccess', '~> 3.2.0'
    user.dependency 'CaamDau'
  end

  # 提示窗
  s.subspec 'HUD' do |hud|
    hud.source_files = 'Util/HUD/**/*'
    hud.dependency 'CaamDau/HUD'
  end

  # 全局基本配置
  s.subspec 'Config' do |config|
    config.source_files = 'Util/Config/Classes/**/*'
    config.resource_bundles = {
      'Config' => ['Util/Config/Assets/*.{plist,xcassets}']
    }
    config.dependency 'CaamDau'
  end

  # 网络基本配置
  s.subspec 'Net' do |net|
    net.source_files = 'Util/Net/**/*'
    net.dependency 'CaamDau/Net/All'
  end

  # 通用实施扩展 - ImageView Button ... 
  s.subspec 'Extension' do |ex|
    ex.source_files = 'Util/Extension/**/*'
    ex.dependency 'CaamDau'
  end

  # 加密
  s.subspec 'Crypto' do |crypto|
    crypto.source_files = 'Util/Crypto/**/*'
    #crypto.dependency 'CryptoSwift', '0.15.0'
  end

  # 通用图片资源
  s.subspec 'Assets' do |ass|
    ass.source_files = 'Util/Assets/Classes/**/*'
    ass.resource_bundles = {
      'Assets' => ['Util/Assets/Assets/*.{xcassets}']
    }
    ass.dependency 'CaamDau'
  end

  # 导航、Tab 图片资源
  # s.subspec 'TabAssets' do |tabass|
  #   tabass.source_files = 'Util/TabAssets/Classes/**/*'
  #   tabass.resource_bundles = {
  #     'TabAssets' => ['Util/TabAssets/Assets/*.{xcassets}']
  #   }
  #   tabass.dependency 'CaamDau/Extension'
  # end

  # 购物车、商品详情、订单、图片资源
  # s.subspec 'CartAssets' do |carass|
  #   carass.source_files = 'Util/CartAssets/Classes/**/*'
  #   carass.resource_bundles = {
  #     'CartAssets' => ['Util/CartAssets/Assets/*.{xcassets}']
  #   }
  #   carass.dependency 'CaamDau/Extension'
  # end

  # 个人中心资源
  # s.subspec 'MineAssets' do |mineass|
  #   carass.source_files = 'Util/MineAssets/Classes/**/*'
  #   carass.resource_bundles = {
  #     'MineAssets' => ['Util/MineAssets/Assets/*.{xcassets}']
  #   }
  #   carass.dependency 'CaamDau/Extension'
  # end


end
