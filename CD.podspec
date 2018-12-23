
Pod::Spec.new do |s|
  s.name             = 'CD'
  s.version          = '0.1.0'
  s.summary          = 'A iOS development toolbox (iOS 开发工具箱).'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/liucaide/CD'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liucaide' => '565726319@qq.com' }
  s.source           = { :git => 'https://github.com/liucaide/CD.git' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  # s.source_files = 'CD/**/*'
  
  s.default_subspec = 'CD'
  
  s.subspec 'CD' do |cd|
      cd.source_files = 'CD/**/*'
  end
  
  s.subspec 'Config' do |cf|
      cf.source_files = 'CD/CD_Config/*'
  end
  
  s.subspec 'Extension' do |es|
      es.source_files = 'CD/CD_Extension/*', 'CD/CD.swift'
  end
  
  s.subspec 'Form' do |fm|
      fm.source_files = 'CD/CD_Form/*'
  end
  
  s.subspec 'Chain' do |cn|
      cn.source_files = 'CD/CD_Form/*', 'CD/CD.swift'
  end
  
  #s.resource_bundles = {
  #  'CD' => ['CD/Storyboards/*.{storyboard}']
  #}

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
