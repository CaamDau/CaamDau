
Pod::Spec.new do |s|
  s.name             = 'LocalModul'
  s.version          = '0.1.0'
  s.summary          = '本地模块组件.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/liucaide'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lcd' => '' }
  s.source           = { :git => '' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'LocalModul/**/*'
  
  s.resource_bundles = {
     'LocalModul' => ['LocalModul/Storyboards/*.{storyboard}']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit'
  s.dependency 'CD'
end
