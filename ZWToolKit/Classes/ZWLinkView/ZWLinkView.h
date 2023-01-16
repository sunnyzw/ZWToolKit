//
//  ZWLinkView.h
//  Sunny
//
//  Created by Sunny on 2022/7/1.
//  Copyright © 2022 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZWLinkView : UITextView

@property (nonatomic, strong) UIColor *linkColor;
@property (nonatomic, nullable, strong) NSArray<NSDictionary *> *links;
@property (nonatomic, copy) void (^didClickedBlock)(NSString *absolute);

@end

NS_ASSUME_NONNULL_END
