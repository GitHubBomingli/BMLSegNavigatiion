//
//  ViewController.m
//  BMLSegmentNavigation
//
//  Created by 伯明利 on 16/5/20.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import "ViewController.h"
#import "BMLTitleSegmentController.h"
#import "ExampleContentViewController.h"
#import "BMLNavigation.h"
#import "ExampleContentDetailViewController.h"


@interface ViewController ()<BMLTitleSegmentControllerDelegate>

@end

@implementation ViewController
{
    CGSize screenSize;
    
    BMLTitleSegmentController *titleController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    screenSize = [UIScreen mainScreen].bounds.size;
    
    CGRect titleRect = CGRectMake(0, 20, screenSize.width, 40);
    
    titleController = [[BMLTitleSegmentController alloc] initWithFrame:titleRect titles:@[@"爱情",@"婚姻",@"恋爱",@"情感",@"励志与成功",@"家庭事业",@"亲自",@"教育"] titleStyle:KTitleStyleModeMask];
    titleController.titleColor = [UIColor greenColor];
    titleController.maskColor = [UIColor purpleColor];
    titleController.selectedIndex = 2;
    titleController.delegate = self;
    
    [self addChildViewController:titleController];
    UIView *titleView = [[UIView alloc] initWithFrame:titleRect];
    titleView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:titleView];
    [titleView addSubview:titleController.view];
    [titleController didMoveToParentViewController:self];
    
}

- (void)tapTitleSegmentController:(BMLTitleSegmentController *)titleSegmentController titleLabel:(BMLTitleCustomLabel *)titleLabel index:(NSInteger)index {
    NSLog(@"点击了第%ld个",index);
}

- (IBAction)clickBtn:(UIButton *)sender {
    titleController.selectedIndex = titleController.selectedIndex + 1;
    NSLog(@"选中了第%ld个",titleController.selectedIndex);
}
- (IBAction)clickPerBtn:(UIButton *)sender {
    titleController.selectedIndex = titleController.selectedIndex - 1;
    NSLog(@"选中了第%ld个",titleController.selectedIndex);
}
- (IBAction)insertTitle:(UIButton *)sender {
    [titleController insetTitle:@"如果爱" withIndex:2];
}
- (IBAction)deleteTitle:(UIButton *)sender {
    [titleController deleteTitleWithIndex:2];
}


- (IBAction)clickContentBtn:(UIButton *)sender {
    
    
    
    ExampleContentViewController *rootVC = [[ExampleContentViewController alloc] init];
    
    
    UINavigationController *navigationC = [[UINavigationController alloc] initWithRootViewController:rootVC];
    
    
    [self presentViewController:navigationC animated:YES completion:nil];
     

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
