//
//  BMLContentDetailViewController.h
//  BMLSegmentNavigation
//
//  Created by 伯明利 on 16/5/22.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMLContentDetailViewController : UIViewController

- (instancetype)initWithChildViewController:(UIViewController *)childViewController size:(CGSize)size;

@property (strong , nonatomic) UIViewController *childViewController;

@end
