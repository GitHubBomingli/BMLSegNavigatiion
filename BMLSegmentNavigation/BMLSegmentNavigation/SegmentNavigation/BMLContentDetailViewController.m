//
//  BMLContentDetailViewController.m
//  BMLSegmentNavigation
//
//  Created by 伯明利 on 16/5/22.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import "BMLContentDetailViewController.h"

@interface BMLContentDetailViewController ()


@end

@implementation BMLContentDetailViewController
{
    CGRect childFrame;
    
    CGSize childSize;
}

- (instancetype)initWithChildViewController:(UIViewController *)childViewController size:(CGSize)size {
    self = [super init];
    if (self) {
        childSize = size;
        _childViewController = childViewController;
    }
    return self;
}
- (void)viewDidLayoutSubviews {
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (id subView in _childViewController.view.subviews) {
        if ( [subView isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)subView;
            childFrame = tableView.frame;
            
            childFrame.size = childSize;
            tableView.frame = childFrame;
        }
    }
    [self.view addSubview:_childViewController.view];
    
    [self addChildViewController:_childViewController];
    
    [_childViewController didMoveToParentViewController:self];
}

- (void)setChildViewController:(UIViewController *)childViewController {
    _childViewController = childViewController;
    
    [self.view addSubview:_childViewController.view];
    
    [self addChildViewController:_childViewController];
    
    [_childViewController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
