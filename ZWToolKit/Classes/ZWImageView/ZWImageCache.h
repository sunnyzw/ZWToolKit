//
//  ZWImageCache.h
//  Sunny
//
//  Created by Sunny on 2022/7/1.
//  Copyright © 2022 Sunny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZWImageCache : NSObject

+ (id)sharedImageCache;

- (nullable UIImage *)imageFromCacheForKey:(nullable NSString *)key;

@end

NS_ASSUME_NONNULL_END
