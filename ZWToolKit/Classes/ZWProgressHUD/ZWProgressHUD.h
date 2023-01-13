//
//  ZWProgressHUD.h
//  Sunny
//
//  Created by Sunny on 2022/7/1.
//  Copyright © 2022 Sunny. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

/// 基于 MBProgressHUD 二次封装的加载器
@interface ZWProgressHUD : UIView

/// 显示菊花
/// @param view     添加到view上
+ (void)showIndeterminate:(UIView *)view;

/// 显示默认gif动画
/// @param view     添加到view上
+ (void)showAnimation:(UIView *)view;

/// 显示默认gif动画，可设置偏移量
/// @param view     添加到view上
/// @param offsetY  向下偏移量
+ (void)showAnimation:(UIView *)view offsetY:(CGFloat)offsetY;

/// 显示自定义gif动画
/// @param images   图片数组
/// @param view     添加到view上
+ (void)showCustomAnimation:(NSArray<UIImage *> *)images view:(UIView *)view;

/// 显示自定义gif动画，可设置偏移量
/// @param images   图片数组
/// @param view     添加到view上
/// @param offsetY  向下偏移量
+ (void)showCustomAnimation:(NSArray<UIImage *> *)images view:(UIView *)view offsetY:(CGFloat)offsetY;

/// 显示文字提示，2s后自动隐藏
/// @param message  文字
/// @param view     添加到view上
+ (void)showMessage:(NSString *)message view:(UIView *)view;

/// 显示自定义图片提示，2s后自动隐藏
/// @param image    图片
/// @param message  文字
/// @param view     添加到view上
+ (void)showCustomImage:(UIImage *)image message:(NSString *)message view:(UIView *)view;

/// 显示成功提示，2s后自动隐藏
/// @param message  文字
/// @param view     添加到view上
+ (void)showSuccess:(NSString *)message view:(UIView *)view;

/// 显示失败提示，2s后自动隐藏
/// @param message  文字
/// @param view     添加到view上
+ (void)showFailure:(NSString *)message view:(UIView *)view;

/// 显示警告提示，2s后自动隐藏
/// @param message  文字
/// @param view     添加到view上
+ (void)showWarning:(NSString *)message view:(UIView *)view;

/// 显示进度条
/// @param progress 进度
/// @param view     添加到view上
+ (void)showProgress:(float)progress view:(UIView *)view;

/// 隐藏HUD
/// @param view     隐藏view上HUD
+ (void)hide:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
