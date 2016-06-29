//
//  BMLContentViewController.h
//  BMLSegmentNavigation
//
//  Created by 伯明利 on 16/5/22.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BMLContentViewController;
@protocol BMLContentViewControllerDelegate <NSObject>

- (void)contentViewController:(BMLContentViewController *)contentViewController dragToIndex:(NSInteger)index;

@optional

- (void)contentViewController:(BMLContentViewController *)contentViewController insertContent:(UIViewController *)viewController AtIndex:(NSInteger)index;

- (void)contentViewController:(BMLContentViewController *)contentViewController deleteContentAtIndex:(NSInteger)index;

@end

@interface BMLContentViewController : UIViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

- (instancetype)initWithFrame:(CGRect)frame contents:(NSArray *)contents;

@property (strong, nonatomic) UIPageViewController *pageController;

@property (strong, nonatomic) NSMutableArray *pageContent;

@property (assign, nonatomic) NSInteger selectedIndex;


- (void)insertContent:(UIViewController *)viewController AtIndex:(NSInteger)index;

- (void)deleteContentAtIndex:(NSInteger)index;

@property (weak , nonatomic) id <BMLContentViewControllerDelegate>
delegate;
@end
