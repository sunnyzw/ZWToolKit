//
//  ZWImageCache.m
//  Sunny
//
//  Created by Sunny on 2022/7/1.
//  Copyright © 2022 Sunny. All rights reserved.
//

#import "ZWImageCache.h"
#import "SDWebImage.h"

@implementation ZWImageCache

+ (id)sharedImageCache {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (nullable UIImage *)imageFromCacheForKey:(nullable NSString *)key {
    return [[SDImageCache sharedImageCache] imageFromCacheForKey:key];
}

@end
