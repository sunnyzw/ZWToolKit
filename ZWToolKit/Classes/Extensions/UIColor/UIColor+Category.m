//
//  UIColor+Category.m
//  ZiShu
//
//  Created by ZiShu on 2021/4/26.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)

/// 16进制颜色
+ (UIColor *)colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha {
    NSUInteger r = (hex & 0xFF0000) >> 16;
    NSUInteger g = (hex & 0x00FF00) >> 8;
    NSUInteger b = (hex & 0x0000FF);
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

@end
