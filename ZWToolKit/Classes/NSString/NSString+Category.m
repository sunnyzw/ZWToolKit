//
//  NSString+Category.m
//  ZiShu
//
//  Created by ZiShu on 2021/4/26.
//

#import "NSString+Category.h"
#import "AppMacro.h"
#import "CommonCrypto/CommonDigest.h"

/// NSString 分类
@implementation NSString (Category)

/// 判空
- (BOOL)isEmpty {
    NSString *res = StringRemoveEmpty(self);
    return res.length == 0;
}

/// 是否是邮箱
- (BOOL)isEmail {
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/// MD5加密
- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    unsigned int length = (unsigned int)strlen(cStr);
    CC_MD5(cStr, length, result);
    
    NSString *resultText = StringFormat(@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                                        result[0], result[1], result[2], result[3],
                                        result[4], result[5], result[6], result[7],
                                        result[8], result[9], result[10], result[11],
                                        result[12], result[13], result[14], result[15]);
    return resultText;
}

/// 参数签名
+ (NSString *)sign:(NSDictionary *)params sercet:(NSString *)sercet {
    if (!params) return @"";
    NSArray *keys = params.allKeys;
    keys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result == NSOrderedDescending;
    }];
    NSString *result = @"";
    for (int i = 0; i < keys.count; i++) {
        NSString *key = [keys objectAtIndex:i];
        if (!([key isEqualToString:@"sign"] || [key isEqualToString:@"token"])) {
            NSString *value = [params objectForKey:key];
            result = StringAppend(result, StringFormat(@"%@%@", key.lowercaseString, value));
        }
    }
    if (params[@"token"]) {
        result = StringAppend(result, params[@"token"]);
    }
    if (sercet) {
        result = StringAppend(sercet, result);
    }
    result = [result md5].uppercaseString;
    return result;
}

/// 计算单行文字宽度
- (CGFloat)getSingleWidth:(UIFont *)font {
    NSDictionary *attr = @{NSFontAttributeName: font};
    CGSize size = [self sizeWithAttributes:attr];
    return ceilf(size.width);
}

/// 计算文字高度
- (CGFloat)getHeightByWidth:(CGFloat)width font:(UIFont *)font {
    NSDictionary *attr = @{NSFontAttributeName: font};
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:options attributes:attr context:nil].size;
    return ceilf(size.height);
}

/// 字符串乘法
- (NSString *)multiplyingBy:(NSString *)other {
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:other];
    if ([self isNaN:num1] || [self isNaN:num2]) return @"--";
    return [num1 decimalNumberByMultiplyingBy:num2].stringValue;
}

/// 字符串除法
- (NSString *)dividingBy:(NSString *)other {
    if (other.floatValue == 0) return @"--";
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:other];
    if ([self isNaN:num1] || [self isNaN:num2]) return @"--";
    return [num1 decimalNumberByDividingBy:num2].stringValue;
}

/// 是否是数字字符串
- (BOOL)isNaN:(NSDecimalNumber *)decimalNumber {
    return [decimalNumber.stringValue isEqualToString:@"NaN"];
}

/// 格式化浮点型数字为字符串，保留2位
+ (NSString *)formatNumber:(double)value {
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:false raiseOnOverflow:false raiseOnUnderflow:false raiseOnDivideByZero:false];
    NSDecimalNumber *ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:value];
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return StringFormat(@"%@", roundedOunces);
}

/// 获取 NSAttributedString
+ (NSMutableAttributedString *)getAttributedString:(NSArray<NSDictionary *> *)params style:(NSDictionary *)dict {
    NSMutableAttributedString *result = [NSMutableAttributedString new];
    for (NSDictionary *dict in params) {
        if ([dict[@"attachment"] boolValue]) {
            NSTextAttachment *attachment = [NSTextAttachment new];
            attachment.bounds = [dict[@"bounds"] CGRectValue];
            attachment.image = dict[@"image"];
            NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attachment];
            [result appendAttributedString:imageStr];
        } else {
            if (!dict[@"string"]) continue;
            NSMutableDictionary *attributes = [NSMutableDictionary new];
            if (dict[@"color"]) {
                [attributes setValue:dict[@"color"] forKey:NSForegroundColorAttributeName];
            }
            if (dict[@"font"]) {
                [attributes setValue:dict[@"font"] forKey:NSFontAttributeName];
            }
            if ([dict[@"line"] boolValue]) {
                [attributes setValue:@(NSUnderlineStyleSingle) forKey:NSStrikethroughStyleAttributeName];
            }
            if ([dict[@"underLine"] boolValue]) {
                [attributes setValue:@(NSUnderlineStyleSingle) forKey:NSUnderlineStyleAttributeName];
            }
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:dict[@"string"] attributes:attributes];
            [result appendAttributedString:attrStr];
        }
    }
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    if (dict[@"lineSpace"]) {
        style.lineSpacing = [dict[@"lineSpace"] floatValue];
    }
    if (dict[@"paragraphSpace"]) {
        style.paragraphSpacing = [dict[@"paragraphSpace"] floatValue];
    }
    if (dict[@"alignment"]) {
        style.alignment = (NSTextAlignment)[dict[@"alignment"] integerValue];
    } else {
        style.alignment = NSTextAlignmentJustified;
    }
    [result addAttributes:@{NSParagraphStyleAttributeName:style} range:NSMakeRange(0, result.length)];
    return result;
}

@end


/// NSAttributedString 分类
@implementation NSAttributedString (Height)

/// 计算文字高度
- (CGFloat)getHeightByWidth:(CGFloat)width {
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:options context:nil].size;
    return ceilf(size.height);
}

@end
