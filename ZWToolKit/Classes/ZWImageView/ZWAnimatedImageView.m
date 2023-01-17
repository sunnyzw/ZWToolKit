//
//  ZWAnimatedImageView.m
//  Sunny
//
//  Created by Sunny on 2022/7/1.
//  Copyright © 2022 Sunny. All rights reserved.
//

#import "ZWAnimatedImageView.h"
#import "SDFLAnimatedImage.h"

@implementation ZWAnimatedImageView

- (void)animatedGIFNamed:(NSString *)name withBundle:(NSBundle *)bundle {
    NSString *filePath = [bundle pathForResource: name ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    self.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageData];
}

@end
