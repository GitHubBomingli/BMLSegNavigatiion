//
//  BMLNavigation.m
//  BMLSegmentNavigation
//
//  Created by 伯明利 on 16/5/26.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import "BMLNavigation.h"


@interface BMLNavigation ()<BMLTitleSegmentControllerDelegate,BMLContentViewControllerDelegate>
{
    CGRect superFrame;
    
    CGSize screenSize;
    
    BMLTitleSegmentController *titleController;
    
    BMLContentViewController *contentVC;
    
    NSMutableArray *titles;
    
    UIScrollView *superScroll;
    
}

@end

@implementation BMLNavigation

- (instancetype)initWithFrame:(CGRect)frame childs:(NSArray *)childs titleStyle:(KTitleStyleMode)titleStyleMode {
    self = [super init];
    if (self) {
        _childs = [NSMutableArray arrayWithArray:childs];
        superFrame = frame;
        _titleStyleMode = titleStyleMode;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    superScroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:superScroll];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //获得屏幕大小
    screenSize = [UIScreen mainScreen].bounds.size;
    
    //创建标题导航栏
    [self creatTitleController];
    
    //创建内容controller
    [self creatContentController];
    
}
#pragma mark - creat
- (void)creatTitleController {
    //根据childs获取titles数组
    [self creatTitles];
    
    //根据是否添加向下的按钮来确定titleScrollview的frame
    CGRect titleRect = CGRectMake(0, 0, 0, 0);
    if (_isDown) {
        titleRect = CGRectMake(CGRectGetMinX(superFrame), CGRectGetMinY(superFrame), CGRectGetWidth(superFrame) - 40, 40);
        
        [self creatDownButton];
    } else {
        titleRect = CGRectMake(CGRectGetMinX(superFrame), CGRectGetMinY(superFrame), CGRectGetWidth(superFrame), 40);
    }
    
    titleController = [[BMLTitleSegmentController alloc] initWithFrame:titleRect titles:titles titleStyle:_titleStyleMode];
    titleController.titleColor = _titleColor;
    titleController.maskColor = _maskColor;
    if (!_titleColor) {
        titleController.titleColor = [UIColor redColor];
    }
    if (!_maskColor) {
        titleController.maskColor = [UIColor redColor];
    }
    titleController.selectedIndex = _selectedIndex;
    titleController.delegate = self;
    
    [self addChildViewController:titleController];
    UIView *titleView = [[UIView alloc] initWithFrame:titleRect];
    [superScroll addSubview:titleView];
    [titleView addSubview:titleController.view];
    [titleController didMoveToParentViewController:self];
}

- (void)creatDownButton {
    if (!_downButton) {
        _downButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _downButton.frame = CGRectMake(CGRectGetMaxX(superFrame) - 38, CGRectGetMinY(superFrame), 38, 40);
        _downButton.layer.shadowColor = [UIColor blackColor].CGColor;
        _downButton.layer.shadowOpacity = 0.8;
        _downButton.layer.shadowOffset = CGSizeMake(-2, 0);
        _downButton.backgroundColor = [UIColor whiteColor];
        
        [_downButton addTarget:self action:@selector(clickDownButton:) forControlEvents:UIControlEventTouchUpInside];
        [superScroll addSubview:_downButton];
    }
}
- (void)clickDownButton:(UIButton *)sender {
    if (self.downButtonCallback) {
        self.downButtonCallback(sender);
    }
}
- (void)creatTitles {
    if (!titles) {
        titles = [NSMutableArray array];
    }
    for (NSInteger i = 0; i != _childs.count; i ++) {
        UIViewController *child = _childs[i];
        [titles addObject:child.title];
    }
}

- (void)creatContentController {
    
    contentVC = [[BMLContentViewController alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(superFrame), CGRectGetHeight(superFrame) - 40) contents:_childs];
    contentVC.selectedIndex = _selectedIndex;
    contentVC.delegate = self;
    UIView *superView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(superFrame), CGRectGetMinY(superFrame) + 40, CGRectGetWidth(superFrame), CGRectGetHeight(superFrame) - 40)];
    [superScroll addSubview:superView];
    [self addChildViewController:contentVC];
    
    [superView addSubview:contentVC.view];
    
    [contentVC didMoveToParentViewController:self];
}

#pragma mark - set

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    
}

- (void)setIsDown:(BOOL)isDown {
    _isDown = isDown;
    
    _downButton.hidden = !_isDown;
}

#pragma mark - BMLTitleSegmentControllerDelegate
- (void)tapTitleSegmentController:(BMLTitleSegmentController *)titleSegmentController titleLabel:(BMLTitleCustomLabel *)titleLabel index:(NSInteger)index {
    NSLog(@"########点击了第%ld个########",index);
    contentVC.selectedIndex = index;
}

- (void)TitleSegmentController:(BMLTitleSegmentController *)titleSegmentController insertTitle:(NSString *)title withIndex:(NSInteger)index {
    
}

- (void)TitleSegmentController:(BMLTitleSegmentController *)titleSegmentController deleteTitleWithIndex:(NSInteger)index {
    
}

#pragma mark - BMLContentViewControllerDelegate

- (void)contentViewController:(BMLContentViewController *)contentViewController dragToIndex:(NSInteger)index {
    NSLog(@"***********%s,%ld**********",__FUNCTION__,index);
    titleController.selectedIndex = index;
}

- (void)contentViewController:(BMLContentViewController *)contentViewController insertContent:(UIViewController *)viewController AtIndex:(NSInteger)index {
    
}

- (void)contentViewController:(BMLContentViewController *)contentViewController deleteContentAtIndex:(NSInteger)index {
    
}


#pragma mark - insert

- (void)insertContent:(UIViewController *)viewController AtIndex:(NSInteger)index {
    [contentVC insertContent:viewController AtIndex:index];
    
    [titleController insetTitle:viewController.title withIndex:index];
}

#pragma mark - delete

- (void)deleteContentAtIndex:(NSInteger)index {
    
    [contentVC deleteContentAtIndex:index];
    
    [titleController deleteTitleWithIndex:index];
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
