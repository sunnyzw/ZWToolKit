//
//  ZWTableView.h
//  ZWToolKit
//
//  Created by 5i5j on 2023/1/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZWTableView : UITableView

/// 注册header / footer，xib方式
- (void)registerHeaderFooterNibNames:(NSArray<NSString *> *)nibNames;

/// 注册header / footer，Class方式
- (void)registerHeaderFooterClasses:(NSArray<Class> *)classes;

/// 注册cell，xib方式
- (void)registerCellNibNames:(NSArray<NSString *> *)nibNames;

/// 注册cell，Class方式
- (void)registerCellClasses:(NSArray<Class> *)classes;

@end

NS_ASSUME_NONNULL_END
