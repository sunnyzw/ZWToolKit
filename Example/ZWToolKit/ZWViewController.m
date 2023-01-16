//
//  ZWViewController.m
//  ZWToolKit
//
//  Created by Sunny on 01/13/2023.
//  Copyright (c) 2023 Sunny. All rights reserved.
//

#import "ZWViewController.h"
//#import "ZWHUDViewController.h"
//#import "ZWLinkViewController.h"

@interface ZWViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ZWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"常用工具类";
    
    self.dataSource = @[
        @{@"key": @"ZWProgressHUD", @"title": @"方便使用的HUD"},
        @{@"key": @"ZWLinkView", @"title": @"部分文字可点击的文本"}
    ];
    [self.tableView reloadData];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kUITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kUITableViewCell"];
    }
    NSDictionary *dict = self.dataSource[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    NSDictionary *dict = self.dataSource[indexPath.row];
    UIViewController *vc;
    if ([dict[@"key"] isEqualToString:@"ZWProgressHUD"]) {
//        vc = [[ZWHUDViewController alloc] init];
    } else if ([dict[@"key"] isEqualToString:@"ZWLinkView"]) {
//        vc = [[ZWLinkViewController alloc] init];
    }
    vc.navigationItem.title = dict[@"title"];
    [self.navigationController pushViewController:vc animated:true];
}

@end
