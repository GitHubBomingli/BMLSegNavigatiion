//
//  BMLTableView.m
//  BMLSegmentNavigation
//
//  Created by 伯明利 on 16/6/27.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import "BMLTableView.h"

@interface BMLTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BMLTableView
{
    BMLTableView *kTableView;
    
    BOOL isGroup;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
    }
    return self;
}

- (instancetype)creatTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style target:(UIViewController *)target {
    kTableView = [self initWithFrame:frame style:style];
    
    kTableView.dataSource = self;
    
    kTableView.delegate = self;
    
    if (UITableViewStyleGrouped == style) {
        isGroup = YES;
    } else {
        isGroup = NO;
    }
    
    [target.view addSubview:kTableView];
    
    return kTableView;
}

- (void)setKDataSource:(NSMutableArray *)kDataSource {
    _kDataSource = [NSMutableArray arrayWithArray:kDataSource];
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (isGroup) {
        return _kDataSource.count;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isGroup) {
        return [_kDataSource[section] count];
    } else {
        return _kDataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellResuable"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellResuable"];
    }
    if (isGroup) {
        cell.textLabel.text = _kDataSource[indexPath.section][indexPath.row];
    } else {
        cell.textLabel.text = _kDataSource[indexPath.row];
    }
    cell.textLabel.textColor = [UIColor redColor];
    
    return cell;
}

@end
