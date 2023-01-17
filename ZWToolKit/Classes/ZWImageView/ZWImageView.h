//
//  ZWImageView.h
//  Sunny
//
//  Created by Sunny on 2022/7/1.
//  Copyright © 2022 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 图片view
@interface ZWImageView : UIImageView

/// 保存到默认路径
- (void)setImageWithURLString:(NSString *)url;

/// 设置网络图片
- (void)setImageWithURLString:(NSString *)url placeholderImage:(UIImage *)placeholder;

/// 设置网络图片，带进度展示
- (void)setImageProgressiveWithURLString:(NSString *)url placeholderImage:(UIImage *)placeholder;

/// 设置网络图片，失败后显示占位图
- (void)setImageWithURLString:(NSString *)url placeholderImage:(UIImage *)placeholder errorImage:(UIImage*)errorImage;

@end

NS_ASSUME_NONNULL_END
