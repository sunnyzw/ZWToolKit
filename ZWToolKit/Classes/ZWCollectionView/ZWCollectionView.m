//
//  ZWCollectionView.m
//  ZWToolKit
//
//  Created by 5i5j on 2023/1/17.
//

#import "ZWCollectionView.h"

@implementation ZWCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = UIColor.whiteColor;
        self.alwaysBounceVertical = true;
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        }
    }
    return self;
}

- (void)registerHeaderOrFooterNibNames:(NSArray<NSDictionary *> *)nibNames {
    for (NSDictionary *dict in nibNames) {
        [self registerNib:[UINib nibWithNibName:dict[@"nibName"] bundle:nil] forSupplementaryViewOfKind:dict[@"kind"] withReuseIdentifier:dict[@"nibName"]];
    }
}

- (void)registerHeaderOrFooterClasses:(NSArray<NSDictionary *> *)classes {
    for (NSDictionary *dict in classes) {
        [self registerClass:dict[@"class"] forSupplementaryViewOfKind:dict[@"kind"] withReuseIdentifier:dict[@"nibName"]];
    }
}

- (void)registerCellNibNames:(NSArray<NSString *> *)nibNames {
    for (NSString *nibName in nibNames) {
        [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellWithReuseIdentifier:nibName];
    }
}

- (void)registerCellClasses:(NSArray<Class> *)classes {
    for (Class cellClass in classes) {
        [self registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
    }
}

@end
