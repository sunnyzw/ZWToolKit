//
//  AppMacro.h
//  Sunny
//
//  Created by Sunny on 2022/7/1.
//  Copyright © 2022 Sunny. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h

#import "UIColor+Category.h"

/// Bundle ID
static NSString *const BundleIDKey          = @"CFBundleIdentifier";
#define BundleID                            NSBundle.mainBundle.infoDictionary[BundleIDKey]
/// 版本号
static NSString *const VersionKey           = @"CFBundleShortVersionString";
#define Version                             NSBundle.mainBundle.infoDictionary[VersionKey]
/// build号
static NSString *const BuildKey             = @"CFBundleVersion";
#define Build                               [NSBundle.mainBundle.infoDictionary[BuildKey] integerValue]
/// App 名称
static NSString *const AppNameKey           = @"CFBundleDisplayName";
#define AppName                             NSBundle.mainBundle.infoDictionary[AppNameKey]
/// weak宏
#define WeakSelf                            __weak __typeof(self) weakSelf = self
/// strong宏
#define StrongSelf                          __strong typeof(weakSelf) strongSelf = weakSelf
/// window
#define KeyWindow                           UIApplication.sharedApplication.keyWindow

/// 输出Log
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#define LOG_ENABLED true
#else
#define NSLog(...) {}
#define LOG_ENABLED false
#endif

/// 屏幕可用尺寸
#define ScreenSize                          UIScreen.mainScreen.bounds.size
/// 屏幕可用宽度
#define ScreenWidth                         UIScreen.mainScreen.bounds.size.width
/// 屏幕可用高度
#define ScreenHeight                        UIScreen.mainScreen.bounds.size.height
/// 以屏幕宽375为标准，计算比例，x为裁剪部分
#define Scale(x)                            (ScreenWidth + x) / (375.0 + x)
/// 状态栏高度
#define StatusBarHeight                     UIApplication.sharedApplication.statusBarFrame.size.height
/// 竖屏底部指示部分高度
#define IndicatorHeight                     (iPhoneX ? 34.0 : 0.0)
/// 导航栏高度
#define NavHeight                           (StatusBarHeight + 44.0)
/// 底部TAB高度
#define TabBarHeight                        (IndicatorHeight + 49.0)
/// 1像素
#define OnePixels                           1.0f / UIScreen.mainScreen.scale
/// 判断是否是iPad
#define iPad                                (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
/// iPhoneX系列
#define iPhoneX                             [Device isIPhoneX]
/// 低分辨率（屏幕宽为320）
#define IsLowDevice                         (ScreenWidth == 320.0)

/// 系统常规字体
#define SystemFont(size)                    [UIFont systemFontOfSize:size]
/// 系统加粗字体
#define BoldFont(size)                      [UIFont boldSystemFontOfSize:size]
/// 苹方字体
#define PFRegular(num)                      [UIFont fontWithName:@"PingFang-SC-Regular" size:num]
#define PFMedium(num)                       [UIFont fontWithName:@"PingFang-SC-Medium" size:num]
#define PFSemibold(num)                     [UIFont fontWithName:@"PingFang-SC-Semibold" size:num]


/// 颜色
#define Color(hex)                          [UIColor colorWithHex:hex alpha:1.0]
#define ColorA(hex, a)                      [UIColor colorWithHex:hex alpha:a]

/// UIImage
#define Image(name)                         [UIImage imageNamed:name]

/// NSString
#define StringRemoveEmpty(a)                ([a stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]])
#define StringAppend(a, b)                  [a stringByAppendingString:b]
#define StringReplacing(o, a, b)            [o stringByReplacingOccurrencesOfString:a withString:b]
#define StringFormat(format, ...)           [NSString stringWithFormat:format, __VA_ARGS__]

/// NSNumber
#define NumberInteger(value)                [NSNumber numberWithInteger:value]

/// NSURL
#define URL(string)                         [NSURL URLWithString:string]

/// NSNotification
#define NotificationPost(name)              [NSNotificationCenter.defaultCenter postNotificationName:name object:nil]
#define NotificationPostObject(name, dict)  [NSNotificationCenter.defaultCenter postNotificationName:name object:nil userInfo:dict]
#define NotificationAdd(kname, action)      [NSNotificationCenter.defaultCenter addObserver:self selector:action name:kname object:nil]
#define NotificationRemove                  [NSNotificationCenter.defaultCenter removeObserver:self]

#endif /* AppMacro_h */
