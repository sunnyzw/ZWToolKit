//
//  ZWTableView.m
//  ZWToolKit
//
//  Created by 5i5j on 2023/1/17.
//

#import "ZWTableView.h"

@implementation ZWTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.backgroundColor = UIColor.whiteColor;
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.rowHeight = UITableViewAutomaticDimension;
        self.tableFooterView = [UIView new];
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        if (@available(iOS 15.0, *)) {
            self.sectionHeaderTopPadding = 0;
        }
    }
    return self;
}

- (void)registerHeaderFooterNibNames:(NSArray<NSString *> *)nibNames {
    for (NSString *nibName in nibNames) {
        [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forHeaderFooterViewReuseIdentifier:nibName];
    }
}

- (void)registerHeaderFooterClasses:(NSArray<Class> *)classes {
    for (Class cellClass in classes) {
        [self registerClass:cellClass forHeaderFooterViewReuseIdentifier:NSStringFromClass(cellClass)];
    }
}

- (void)registerCellNibNames:(NSArray<NSString *> *)nibNames {
    for (NSString *nibName in nibNames) {
        [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
    }
}

- (void)registerCellClasses:(NSArray<Class> *)classes {
    for (Class cellClass in classes) {
        [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
    }
}

@end
