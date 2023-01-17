//
//  ZWCollectionView.h
//  ZWToolKit
//
//  Created by 5i5j on 2023/1/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZWCollectionView : UICollectionView

/// 注册header / footer，xib方式
- (void)registerHeaderOrFooterNibNames:(NSArray<NSDictionary *> *)nibNames;

/// 注册header / footer，class方式
- (void)registerHeaderOrFooterClasses:(NSArray<Class> *)classes;

/// 注册cell，xib方式
- (void)registerCellNibNames:(NSArray<NSString *> *)nibNames;

/// 注册cell，class方式
- (void)registerCellClasses:(NSArray<Class> *)classes;

@end

NS_ASSUME_NONNULL_END
