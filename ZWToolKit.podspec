#
# Be sure to run `pod lib lint ZWToolKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name            = 'ZWToolKit'
  s.version         = '0.1.3'
  s.summary         = '常用工具集合库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description     = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage        = 'https://github.com/sunnyzw/ZWToolKit'
  s.license         = { :type => 'MIT', :file => 'LICENSE' }
  s.author          = { 'Sunny' => 'sunny_szw@163.com' }
  s.source          = { :git => 'https://github.com/sunnyzw/ZWToolKit.git', :tag => s.version.to_s }
  s.source_files    = 'ZWToolKit/Classes/**/*'

  s.ios.deployment_target = '10.0'

  # 二次封装MBProgressHUD，便于使用
  s.subspec 'ZWProgressHUD' do |cs|
    cs.source_files = 'ZWToolKit/Classes/ZWProgressHUD/**/*'
    cs.resource_bundles = {
      'ZWToolKit' => ['ZWToolKit/Assets/ZWProgressHUD.xcassets']
    }
    cs.dependency 'MBProgressHUD'
  end
  
  # 部分文字可点击的文本
  s.subspec 'ZWLinkView' do |cs|
    cs.source_files = 'ZWToolKit/Classes/ZWCommon/**/*', 'ZWToolKit/Classes/Extensions/NSString/**/*', 'ZWToolKit/Classes/ZWLinkView/**/*'
  end
  
  # 二次封装SDWebImage，便于维护
  s.subspec 'ZWImageView' do |cs|
    cs.source_files = 'ZWToolKit/Classes/ZWImageView/**/*'
    cs.dependency 'SDWebImage', '~> 5.0'
    cs.dependency 'SDWebImageFLPlugin', '~> 0.6.0'
  end
  
end
