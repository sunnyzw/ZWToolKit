//
//  ZWCollectionView+Category.m
//  Sunny
//
//  Created by Sunny on 2022/7/1.
//  Copyright © 2022 Sunny. All rights reserved.
//

#import "ZWCollectionView+Category.h"
#import <objc/runtime.h>
#import "AppMacro.h"
#import "UIColor+Category.h"

NSString *const kCollectionNoDataViewObserveKeyPath = @"frame";
static const NSString *kCollectionHeaderViewKey     = @"collectionHeaderView";
static const NSString *kCollectionFooterViewKey     = @"collectionFooterView";
static const NSString *kPlaceholderViewKey          = @"placeholderView";
static const NSString *kPlaceholderImageKey         = @"placeholderImage";
static const NSString *kPlaceholderStringKey        = @"placeholderString";
static const NSString *kPlaceholderColorKey         = @"placeholderColor";
static const NSString *kPlaceholderCenterYOffsetKey = @"placeholderCenterYOffset";

@implementation ZWCollectionView (Category)

@dynamic collectionHeaderView;
- (void)setCollectionHeaderView:(UIView *)collectionHeaderView {
    UIView *headerView = self.collectionHeaderView;
    if (headerView != collectionHeaderView) {
        // 获取内边距
        UIEdgeInsets contentInset = self.contentInset;
        
        // 移除之前的collectionHeaderView
        contentInset.top -= headerView.frame.size.height;
        [headerView removeFromSuperview];
        
        // 设置内边距
        contentInset.top += collectionHeaderView.frame.size.height;
        self.contentInset = contentInset;
        
        // 添加collectionHeaderView
        [self addSubview:collectionHeaderView];
        
        objc_setAssociatedObject(self, &(kCollectionHeaderViewKey), collectionHeaderView, OBJC_ASSOCIATION_ASSIGN);
    }
}
- (UIView *)collectionHeaderView {
    return objc_getAssociatedObject(self, &(kCollectionHeaderViewKey));
}

@dynamic collectionFooterView;
- (void)setCollectionFooterView:(UIView *)collectionFooterView {
    UIView *footerView = self.collectionFooterView;
    
    if (footerView != collectionFooterView) {
        // 获取内边距
        UIEdgeInsets contentInset = self.contentInset;
        
        // 移除之前的
        contentInset.bottom -= footerView.frame.size.height;
        [footerView removeFromSuperview];
        
        // 设置内边距
        contentInset.bottom += collectionFooterView.frame.size.height;
        self.contentInset= contentInset;
        
        // 添加页脚
        [self addSubview:collectionFooterView];
        
        objc_setAssociatedObject(self, &(kCollectionFooterViewKey), collectionFooterView, OBJC_ASSOCIATION_ASSIGN);
    }
}
- (UIView *)collectionFooterView {
    return objc_getAssociatedObject(self, &(kCollectionFooterViewKey));
}

- (void)setPlaceholderView:(UIView *)placeholderView {
    objc_setAssociatedObject(self, &(kPlaceholderViewKey), placeholderView, OBJC_ASSOCIATION_ASSIGN);
}
- (UIView *)placeholderView {
    return objc_getAssociatedObject(self, &(kPlaceholderViewKey));
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage {
    objc_setAssociatedObject(self, &(kPlaceholderImageKey), placeholderImage, OBJC_ASSOCIATION_ASSIGN);
}
- (UIImage *)placeholderImage {
    return objc_getAssociatedObject(self, &(kPlaceholderImageKey));
}

- (void)setPlaceholderString:(NSString *)placeholderString {
    objc_setAssociatedObject(self, &(kPlaceholderStringKey), placeholderString, OBJC_ASSOCIATION_ASSIGN);
}
- (NSString *)placeholderString {
    return objc_getAssociatedObject(self, &(kPlaceholderStringKey));
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    objc_setAssociatedObject(self, &(kPlaceholderColorKey), placeholderColor, OBJC_ASSOCIATION_ASSIGN);
}
- (UIColor *)placeholderColor {
    return objc_getAssociatedObject(self, &(kPlaceholderColorKey));
}

- (void)setPlaceholderCenterYOffset:(CGFloat)placeholderCenterYOffset {
    objc_setAssociatedObject(self, &(kPlaceholderCenterYOffsetKey), @(placeholderCenterYOffset), OBJC_ASSOCIATION_ASSIGN);
}
- (CGFloat)placeholderCenterYOffset {
    return [objc_getAssociatedObject(self, &(kPlaceholderCenterYOffsetKey)) floatValue];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method old_reloadData = class_getInstanceMethod(self, @selector(reloadData));
        Method new_reloadData = class_getInstanceMethod(self, @selector(zw_reloadData));
        method_exchangeImplementations(old_reloadData, new_reloadData);
        
        Method old_layoutSubviews = class_getInstanceMethod(self, @selector(layoutSubviews));
        Method new_layoutSubviews = class_getInstanceMethod(self, @selector(zw_layoutSubviews));
           method_exchangeImplementations(old_layoutSubviews, new_layoutSubviews);
    });
}

- (void)zw_layoutSubviews {
    [self zw_layoutSubviews];
    CGRect headerFrame = self.collectionHeaderView.frame;
    CGRect footerFrame = self.collectionFooterView.frame;
    headerFrame.origin.y = -headerFrame.size.height;
    footerFrame.origin.y = self.contentSize.height;
    self.collectionHeaderView.frame = headerFrame;
    self.collectionFooterView.frame = footerFrame;
}

- (void)zw_reloadData {
    [self zw_reloadData];
        
    // 忽略第一次加载
    if (![self isInitFinish]) {
        [self havingData:true];
        [self setIsInitFinish:true];
        return;
    }
    // 刷新完成之后检测数据量
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger numberOfSections = [self numberOfSections];
        BOOL havingData = false;
        for (NSInteger i = 0; i < numberOfSections; i++) {
            if ([self numberOfItemsInSection:i] > 0) {
                havingData = true;
                break;
            }
        }
        [self havingData:havingData];
    });
}

/// 设置已经加载完成数据
/// @param finish 是否完成
- (void)setIsInitFinish:(BOOL)finish {
    objc_setAssociatedObject(self, @selector(isInitFinish), @(finish), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// 是否已经加载完成数据
- (BOOL)isInitFinish {
    id obj = objc_getAssociatedObject(self, _cmd);
    return [obj boolValue];
}

- (void)havingData:(BOOL)havingData {
    // 不需要显示占位图
    if (havingData) {
        [self removeNoDataObserver];
        self.backgroundView = nil;
        return;
    }
    // 不需要重复创建
    if (self.backgroundView) return;
    
    // 自定义占位图
    if (self.placeholderView) {
        self.backgroundView = self.placeholderView;
        return;
    }
    
    // 使用自带的
    UIImage *img = self.placeholderImage;
    NSString *msg = self.placeholderString;
    UIColor *color = self.placeholderColor ? self.placeholderColor : Color(0x888888);
    CGFloat offset = self.placeholderCenterYOffset;
    
    if (!img && msg.length == 0) return;
    
    // 创建占位图
    self.backgroundView = [self collectionViewDefaultNoDataViewWithImage:img message:msg color:color offsetY:offset];
}


/// 默认的占位图
/// @param image    图片
/// @param message  文字
/// @param color    颜色
/// @param offset   偏移量
- (UIView *)collectionViewDefaultNoDataViewWithImage:(UIImage *)image message:(NSString *)message color:(UIColor *)color offsetY:(CGFloat)offset {
    
    // 计算位置, 垂直居中, 图片默认中心偏上.
    CGFloat sW = self.bounds.size.width;
    CGFloat cX = sW / 2;
    CGFloat cY = self.bounds.size.height * (1 - 0.618) + offset;
    CGFloat iW = image.size.width * self.frame.size.width / 375.0;
    CGFloat iH = iW * 0.71;
    
    // 图片
    UIImageView *imgView = [UIImageView new];
    CGRect frame = CGRectMake(cX - iW / 2, cY - iH / 2, iW, iH);
    imgView.frame = frame;
    imgView.image = image;
    
    // 文字
    UILabel *label = [UILabel new];
    label.font = PFRegular(14);
    label.textColor = color;
    label.text = message;
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, CGRectGetMaxY(imgView.frame), sW, label.font.lineHeight);
    
    // 视图
    UIView *view = [UIView new];
    view.tag = 88888;
    [view addSubview:imgView];
    [view addSubview:label];
    
    // 实现跟随 collectionView 滚动
    [view addObserver:self forKeyPath:kCollectionNoDataViewObserveKeyPath options:NSKeyValueObservingOptionNew context:nil];
    return view;
}

/// 监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kCollectionNoDataViewObserveKeyPath]) {
        CGRect frame = [[change objectForKey:NSKeyValueChangeNewKey] CGRectValue];
        if (frame.origin.y != 0) {
            frame.origin.y  = 0;
            self.backgroundView.frame = frame;
        }
    }
}

/// 移除监听
- (void)removeNoDataObserver {
    if ([self.backgroundView isKindOfClass:UIView.class] && self.backgroundView.tag == 88888) {
        @try {
            [self.backgroundView removeObserver:self forKeyPath:kCollectionNoDataViewObserveKeyPath context:nil];
        }
        @catch(NSException *exception) {
            NSLog(@"%@", exception);
        }
    }
}

- (void)dealloc {
    [self removeNoDataObserver];
}

@end
