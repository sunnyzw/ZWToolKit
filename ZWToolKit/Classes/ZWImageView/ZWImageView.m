//
//  ZWImageView.m
//  Sunny
//
//  Created by Sunny on 2022/7/1.
//  Copyright © 2022 Sunny. All rights reserved.
//

#import "ZWImageView.h"
#import "UIImageView+WebCache.h"

@interface ZWImageView ()

@end

@implementation ZWImageView

- (void)setImageWithURLString:(NSString *)url {
    [self sd_setImageWithURL:[NSURL URLWithString:url]];
}

- (void)setImageWithURLString:(NSString *)url placeholderImage:(UIImage *)placeholder {
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
}

/// 设置网络图片，带进度展示
- (void)setImageProgressiveWithURLString:(NSString *)url placeholderImage:(UIImage *)placeholder {
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder options:SDWebImageProgressiveLoad];
}

/// 设置网络图片，失败后显示占位图
- (void)setImageWithURLString:(NSString *)url placeholderImage:(UIImage *)placeholder errorImage:(UIImage *)errorImage {
    __weak typeof(self) weakSelf = self;
    SDWebImageOptions options = SDWebImageRetryFailed | SDWebImageLowPriority;
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder options:options progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) {
            weakSelf.image = errorImage;
        }
    }];
}

@end
