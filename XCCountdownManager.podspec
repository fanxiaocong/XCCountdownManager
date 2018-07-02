

Pod::Spec.new do |s|
  s.name             = 'XCCountdownManager'
  s.version          = '0.0.1'
  s.summary          = 'XCCountdownManager，倒计时定时器，支持多组倒计时'

  s.description      = <<-DESC
TODO：XCCountdownManager，倒计时定时器，支持多组倒计时
                       DESC

  s.homepage         = 'https://github.com/fanxiaocong/XCCountdownManager'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fanxiaocong' => '1016697223@qq.com' }
  s.source           = { :git => 'https://github.com/fanxiaocong/XCCountdownManager.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'XCCountdownManager/Classes/**/*'
  
end
