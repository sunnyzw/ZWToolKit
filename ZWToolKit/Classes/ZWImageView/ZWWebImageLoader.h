//
//  ZWWebImageLoader.h
//  Sunny
//
//  Created by Sunny on 2022/7/1.
//  Copyright © 2022 Sunny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDWebImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZWWebImageLoader : NSObject

+ (id)sharedManager;

- (SDWebImageCombinedOperation *)loadImageWithURL:(NSURL *)url
                                          options:(SDWebImageOptions)options
                                         progress:(SDImageLoaderProgressBlock)progressBlock
                                        completed:(SDInternalCompletionBlock)completedBlock;

@end

NS_ASSUME_NONNULL_END
