//
//  ZWLinkViewController.m
//  ZWToolKit_Example
//
//  Created by 5i5j on 2023/1/16.
//  Copyright © 2023 sunnyzw. All rights reserved.
//

#import "ZWLinkViewController.h"
#import "AppMacro.h"
#import "ZWLinkView.h"

@interface ZWLinkViewController ()

@end

@implementation ZWLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self createText];
}

- (void)createText {
    ZWLinkView *linkView = [[ZWLinkView alloc] initWithFrame:CGRectMake(20, 120, ScreenWidth - 40, 50)];
    linkView.text = @"登录表示您已同意《用户协议》及《隐私政策》";
    linkView.font = PFRegular(12);
    linkView.textColor = [UIColor grayColor];
    linkView.linkColor = UIColor.blueColor;
    linkView.links = @[@{@"title":@"《用户协议》", @"absolute":@"yonghuxieyi", @"underline":@(true)},
                       @{@"title":@"《隐私政策》", @"absolute":@"yinsizhengce"}];
    linkView.didClickedBlock = ^(NSString * _Nonnull absolute) {
        if ([absolute isEqualToString:@"yonghuxieyi"]) {
            NSLog(@"点击了----用户协议");
        } else if ([absolute isEqualToString:@"yinsizhengce"]) {
            NSLog(@"点击了----隐私政策");
        }
    };
    [self.view addSubview:linkView];
}

@end
