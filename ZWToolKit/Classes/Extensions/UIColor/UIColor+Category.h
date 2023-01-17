//
//  UIColor+Category.h
//  Sunny
//
//  Created by Sunny on 2022/7/1.
//  Copyright © 2022 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

/// 十六进制颜色
+ (UIColor *)colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha;

@end
