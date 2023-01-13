#
# Be sure to run `pod lib lint ZWToolKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZWToolKit'
  s.version          = '0.1.0'
  s.summary          = '常用工具集合库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/sunnyzw/ZWToolKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sunny' => 'sunny_szw@163.com' }
  s.source           = { :git => 'https://github.com/sunnyzw/ZWToolKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

# 基于MBProgressHUD二次封装的HUD
  s.subspec 'ZWProgressHUD' do |cs|
    cs.source_files = 'ZWToolKit/Classes/ZWProgressHUD/**/*'
    cs.resource = ['ZWToolKit/Assets/ZWProgressHUD/*']
    cs.dependency 'MBProgressHUD'
  end
  
end
