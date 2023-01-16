//
//  ZWProgressHUD.m
//  Sunny
//
//  Created by Sunny on 2022/7/1.
//  Copyright © 2022 Sunny. All rights reserved.
//

#import "ZWProgressHUD.h"
#import "MBProgressHUD.h"

@implementation ZWProgressHUD

// MARK: - 公开方法
/// 显示菊花
+ (void)showIndeterminate:(UIView *)view {
    MBProgressHUD *hud = [self createHUD:view message:nil mode:MBProgressHUDModeIndeterminate isLoading:true];
    hud.margin = 10;
}

/// 显示默认gif动画
+ (void)showAnimation:(UIView *)view {
    MBProgressHUD *hud = [self createHUD:view message:nil mode:MBProgressHUDModeCustomView isLoading:true];
    hud.bezelView.backgroundColor = UIColor.clearColor;
    hud.customView = [self createGifAnimation:nil];
}

/// 显示默认gif动画，可设置偏移量
+ (void)showAnimation:(UIView *)view offsetY:(CGFloat)offsetY {
    MBProgressHUD *hud = [self createHUD:view message:nil mode:MBProgressHUDModeCustomView isLoading:true];
    hud.bezelView.backgroundColor = UIColor.clearColor;
    hud.customView = [self createGifAnimation:nil];
    CGRect frame = hud.frame;
    frame.origin.y = offsetY;
    frame.size.height = frame.size.height - offsetY;
    hud.frame = frame;
}

/// 显示自定义gif动画
+ (void)showCustomAnimation:(NSArray<UIImage *> *)images view:(UIView *)view {
    MBProgressHUD *hud = [self createHUD:view message:nil mode:MBProgressHUDModeCustomView isLoading:true];
    hud.bezelView.backgroundColor = UIColor.clearColor;
    hud.customView = [self createGifAnimation:images];
}

/// 显示自定义gif动画，可设置偏移量
+ (void)showCustomAnimation:(NSArray<UIImage *> *)images view:(UIView *)view offsetY:(CGFloat)offsetY {
    MBProgressHUD *hud = [self createHUD:view message:nil mode:MBProgressHUDModeCustomView isLoading:true];
    hud.bezelView.backgroundColor = UIColor.clearColor;
    hud.customView = [self createGifAnimation:images];
    CGRect frame = hud.frame;
    frame.origin.y = offsetY;
    frame.size.height = frame.size.height - offsetY;
    hud.frame = frame;
}

/// 显示文字提示，2s后自动隐藏
+ (void)showMessage:(NSString *)message view:(UIView *)view {
    MBProgressHUD *hud = [self createHUD:view message:message mode:MBProgressHUDModeText isLoading:false];
    [hud hideAnimated:true afterDelay:2];
}

/// 显示自定义图片提示，2s后自动隐藏
+ (void)showCustomImage:(UIImage *)image message:(NSString *)message view:(UIView *)view {
    MBProgressHUD *hud = [self createCustomViewHUD:view image:image message:message];
    [hud hideAnimated:true afterDelay:2];
}

/// 显示成功提示，2s后自动隐藏
+ (void)showSuccess:(NSString *)message view:(UIView *)view {
    MBProgressHUD *hud = [self createCustomViewHUD:view image:[self loadBundleImage:@"hud_success"] message:message];
    [hud hideAnimated:true afterDelay:2];
}

/// 显示失败提示，2s后自动隐藏
+ (void)showFailure:(NSString *)message view:(UIView *)view {
    MBProgressHUD *hud = [self createCustomViewHUD:view image:[self loadBundleImage:@"hud_failure"] message:message];
    [hud hideAnimated:true afterDelay:2];
}

/// 显示警告提示，2s后自动隐藏
+ (void)showWarning:(NSString *)message view:(UIView *)view {
    MBProgressHUD *hud = [self createCustomViewHUD:view image:[self loadBundleImage:@"hud_warning"] message:message];
    [hud hideAnimated:true afterDelay:2];
}

/// 显示进度条
+ (void)showProgress:(float)progress view:(UIView *)view {
    MBProgressHUD *hud = [self createHUD:view message:nil mode:MBProgressHUDModeAnnularDeterminate isLoading:true];
    hud.progress = progress;
}

/// 隐藏
+ (void)hide:(UIView *)view {
    for (UIView *hud in view.subviews) {
        if ([hud isKindOfClass:MBProgressHUD.class]) {
            [(MBProgressHUD *)hud hideAnimated:true];
            [hud removeFromSuperview];
        }
    }
}

// MARK: - 私有方法
/// 创建 HUD
+ (MBProgressHUD *)createHUD:(UIView *)view message:(NSString *)message mode:(MBProgressHUDMode)mode isLoading:(BOOL)isLoading {
    if (!view) { return nil; }
    if (mode != MBProgressHUDModeAnnularDeterminate) {
        [self hide:view];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:true];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    BOOL isBlack = mode == MBProgressHUDModeIndeterminate || mode == MBProgressHUDModeText || mode == MBProgressHUDModeAnnularDeterminate || (mode == MBProgressHUDModeCustomView && message && message.length > 0);
    hud.bezelView.backgroundColor = isBlack ? [UIColor.blackColor colorWithAlphaComponent:0.8] : UIColor.clearColor;
    hud.contentColor = UIColor.whiteColor;
    hud.margin = 18;
    hud.userInteractionEnabled = isLoading;
    hud.removeFromSuperViewOnHide = true;
    hud.label.text = message;
    hud.label.numberOfLines = 0;
    hud.mode = mode;
    return hud;
}

/// 创建自定义视图 HUD
+ (MBProgressHUD *)createCustomViewHUD:(UIView *)view image:(UIImage *)image message:(NSString *)message {
    MBProgressHUD *hud = [self createHUD:view message:message mode:MBProgressHUDModeCustomView isLoading:false];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    return hud;
}

/// 创建自定义Gif动画
+ (UIImageView *)createGifAnimation:(NSArray<UIImage *> *)images {
    NSMutableArray<UIImage *> *animationImages = [NSMutableArray arrayWithArray:images];
    if (animationImages.count == 0) {
        for (int i = 1; i <= 16; i++) {
            UIImage *img = [self loadBundleImage:[NSString stringWithFormat:@"loading_%d", i]];
            if (img) {
                [animationImages addObject:img];
            }
        }
    }
    UIImageView *customImgView = [[UIImageView alloc] init];
    customImgView.animationImages = animationImages;
    customImgView.animationRepeatCount = 0;
    customImgView.animationDuration = (animationImages.count + 1) * 0.06;
    [customImgView startAnimating];
    return customImgView;
}

/// 加载组件中图片
+ (UIImage *)loadBundleImage:(NSString *)imageName {
    NSString *bundleNameWithExtension = @"ZWToolKit.bundle";
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]].resourcePath stringByAppendingPathComponent:bundleNameWithExtension];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    UIImage *image = [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
    if (image) {
        return image;
    }
    return [UIImage imageNamed:imageName];
}

@end
