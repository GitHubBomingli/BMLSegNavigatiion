//
//  BMLTableView.h
//  BMLSegmentNavigation
//
//  Created by 伯明利 on 16/6/27.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMLTableView : UITableView

- (instancetype)creatTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style target:(UIViewController *)target;

@property (nonatomic ,strong) NSMutableArray *kDataSource;

@end
