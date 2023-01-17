//
//  ZWAnimatedImageView.h
//  Sunny
//
//  Created by Sunny on 2022/7/1.
//  Copyright © 2022 Sunny. All rights reserved.
//

#import "FLAnimatedImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZWAnimatedImageView : FLAnimatedImageView

/// 设置本地Gif动态图片
/// - Parameter name: gif图片名称
/// - Parameter bundle: git图片资源所在的bundle
- (void)animatedGIFNamed:(NSString *)name withBundle:(NSBundle *)bundle;

@end

NS_ASSUME_NONNULL_END
