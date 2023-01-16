//
//  UIColor+Category.h
//  ZiShu
//
//  Created by ZiShu on 2021/4/26.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

/// 十六进制颜色
+ (UIColor *)colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha;

@end
