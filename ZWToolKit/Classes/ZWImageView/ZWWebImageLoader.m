//
//  ZWWebImageLoader.m
//  Sunny
//
//  Created by Sunny on 2022/7/1.
//  Copyright © 2022 Sunny. All rights reserved.
//

#import "ZWWebImageLoader.h"

@implementation ZWWebImageLoader

+ (id)sharedManager {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (SDWebImageCombinedOperation *)loadImageWithURL:(NSURL *)url
                                          options:(SDWebImageOptions)options
                                         progress:(SDImageLoaderProgressBlock)progressBlock
                                        completed:(SDInternalCompletionBlock)completedBlock {
    return [[SDWebImageManager sharedManager] loadImageWithURL:url options:options progress:progressBlock completed:completedBlock];
}

@end
