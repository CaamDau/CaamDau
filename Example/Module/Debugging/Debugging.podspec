
Pod::Spec.new do |s|
  s.name             = 'Debugging'
  s.version          = '0.1.0'
  s.summary          = 'A 本地资源.'
  s.description      = <<-DESC
  TODO: A 本地资源，项目配置，通用组件.
                       DESC

  s.homepage         = 'https://github.com/liucaide'
  #s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liucaide' => '565726319@qq.com' }
  s.source           = { :git => '' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'App+Debugging.swift'
  s.dependency 'DoraemonKit/Core'
  s.dependency 'DoraemonKit/WithLogger'
  s.dependency 'CaamDau/AppDelegate'
  s.dependency 'CaamDau/Core'

end
