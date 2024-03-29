#
# Be sure to run `pod lib lint ZWToolKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name            = 'ZWToolKit'
  s.version         = '0.2.0'
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
  s.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 armv7 arm64' }

  # ZWNetworking, 二次封装AFNetworking
  s.subspec 'ZWNetworking' do |cs|
    cs.source_files =
      'ZWToolKit/Classes/ZWNetworking/**/*'
  end
  
  # ZWProgressHUD, 二次封装MBProgressHUD
  s.subspec 'ZWProgressHUD' do |cs|
    cs.source_files = 'ZWToolKit/Classes/ZWProgressHUD/**/*'
    cs.resource_bundles = {
      'ZWToolKit' => ['ZWToolKit/Assets/ZWProgressHUD.xcassets']
    }
    cs.dependency 'MBProgressHUD'
  end
  
  # ZWImageView, 二次封装SDWebImage
  s.subspec 'ZWImageView' do |cs|
    cs.source_files = 'ZWToolKit/Classes/ZWImageView/**/*'
    cs.dependency 'SDWebImage', '~> 5.0'
    cs.dependency 'SDWebImageFLPlugin', '~> 0.6.0'
  end
  
  # ZWTableView, 二次封装UITableView
  s.subspec 'ZWTableView' do |cs|
    cs.source_files =
      'ZWToolKit/Classes/ZWCommon/**/*',
      'ZWToolKit/Classes/Extensions/UIColor/**/*',
      'ZWToolKit/Classes/ZWTableView/**/*'
  end
  
  # ZWCollectionView, 二次封装UICollectionView
  s.subspec 'ZWCollectionView' do |cs|
    cs.source_files =
      'ZWToolKit/Classes/ZWCommon/**/*',
      'ZWToolKit/Classes/Extensions/UIColor/**/*',
      'ZWToolKit/Classes/ZWCollectionView/**/*'
  end
  
  # ZWLinkView, 部分文字可点击的文本
  s.subspec 'ZWLinkView' do |cs|
    cs.source_files =
      'ZWToolKit/Classes/ZWCommon/**/*',
      'ZWToolKit/Classes/Extensions/NSString/**/*',
      'ZWToolKit/Classes/ZWLinkView/**/*'
  end
  
end
