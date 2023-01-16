//
//  NSString+Category.h
//  ZiShu
//
//  Created by ZiShu on 2021/4/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// NSString 分类
@interface NSString (Category)

/// 判空
- (BOOL)isEmpty;

/// 是否是邮箱
- (BOOL)isEmail;

/// MD5 加密
- (NSString *)md5;

/// 参数签名
+ (NSString *)sign:(NSDictionary *)params sercet:(NSString *)sercet;

/// 计算单行文字宽度
- (CGFloat)getSingleWidth:(UIFont *)font;

/// 计算文字高度
- (CGFloat)getHeightByWidth:(CGFloat)width font:(UIFont *)font;

/// 字符串乘法
- (NSString *)multiplyingBy:(NSString *)other;

/// 字符串除法
- (NSString *)dividingBy:(NSString *)other;

/// 格式化浮点型数字为字符串，保留2位
+ (NSString *)formatNumber:(double)value;

/// 获取 NSAttributedString
+ (NSMutableAttributedString *)getAttributedString:(NSArray<NSDictionary *> *)params style:(NSDictionary * _Nullable)dict;

@end


/// NSAttributedString 分类
@interface NSAttributedString (Height)

/// 计算文字高度
- (CGFloat)getHeightByWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
