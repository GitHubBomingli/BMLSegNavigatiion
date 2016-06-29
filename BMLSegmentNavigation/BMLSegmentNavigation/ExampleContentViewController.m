//
//  ExampleContentViewController.m
//  BMLSegmentNavigation
//
//  Created by 伯明利 on 16/5/23.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import "ExampleContentViewController.h"
#import "BMLContentViewController.h"
#import "ExampleContentDetailViewController.h"
#import "BMLNavigation.h"


@interface ExampleContentViewController ()

@end

@implementation ExampleContentViewController

{
    CGSize screenSize;
    
    BMLNavigation *exampleVC;
    
    NSArray *titles;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenSize = [UIScreen mainScreen].bounds.size;
    
    titles = @[@"爱情",@"婚姻",@"恋爱",@"情感",@"励志与成功",@"家庭事业",@"亲自",@"教育"];
    
}

- (void)insertNewViewController {
    ExampleContentDetailViewController *contentDetailVC = [[ExampleContentDetailViewController alloc] init];
    contentDetailVC.title = @"新插入的页";
    contentDetailVC.contentLabel.text = @"新插入的页";
    contentDetailVC.contentString = @"新插入的页";
    
    [exampleVC insertContent:contentDetailVC AtIndex:1];
}

- (void)deleteViewController {
    
    
    [exampleVC deleteContentAtIndex:1];
}

- (IBAction)previousButton:(UIButton *)sender {
}
- (IBAction)nextButton:(UIButton *)sender {
    
    
    exampleVC = [[BMLNavigation alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height - 64) childs:[self creatChilds] titleStyle:KTitleStyleModeMask];
    exampleVC.maskColor = [UIColor colorWithRed:0.173 green:1.000 blue:0.128 alpha:1.000];
    exampleVC.titleColor = [UIColor blueColor];
    exampleVC.selectedIndex = 1;
    exampleVC.isDown = NO;
    
    __weak typeof(self) blockSelf = self;
    exampleVC.downButtonCallback = ^(UIButton *sender) {
        [blockSelf insertNewViewController];
    };
    
    [self.navigationController pushViewController:exampleVC animated:YES];
}

- (NSArray *)creatChilds {
    NSMutableArray *contents = [NSMutableArray array];
    for (NSInteger i = 0; i != titles.count; i ++) {
        ExampleContentDetailViewController *contentDetailVC = [[ExampleContentDetailViewController alloc] init];
        contentDetailVC.title = [NSString stringWithFormat:@"%@%ld",titles[i],i];
    
        [contents addObject:contentDetailVC];
    }
    return contents;
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
