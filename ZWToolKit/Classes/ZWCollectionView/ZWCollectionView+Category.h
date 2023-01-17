//
//  ZWCollectionView+Category.h
//  Sunny
//
//  Created by Sunny on 2022/7/1.
//  Copyright © 2022 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZWCollectionView (Category)

/// headerView
@property (nonatomic, strong) UIView *collectionHeaderView;

/// footerView
@property (nonatomic, strong) UIView *collectionFooterView;

/// 自定义占位图，设置该属性后，无数据占位属性则无效
@property (nonatomic, strong) UIView *placeholderView;

/// 无数据占位 - 设置占位图偏
@property (nonatomic, strong) UIImage *placeholderImage;

/// 无数据占位 - 设置显示文字
@property (nonatomic, copy) NSString *placeholderString;

/// 无数据占位 - 设置显示文字颜色
@property (nonatomic, strong) UIColor *placeholderColor;

/// 无数据占位 - 设置 CenterY 向下的偏移量
@property (nonatomic, assign) CGFloat placeholderCenterYOffset;

@end

NS_ASSUME_NONNULL_END
