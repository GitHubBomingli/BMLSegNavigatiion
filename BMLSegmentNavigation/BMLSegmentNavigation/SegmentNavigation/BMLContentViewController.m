//
//  BMLContentViewController.m
//  BMLSegmentNavigation
//
//  Created by 伯明利 on 16/5/22.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import "BMLContentViewController.h"
#import "BMLContentDetailViewController.h"


@interface BMLContentViewController ()

@property (assign , nonatomic) CGRect superFrame;

@property (strong , nonatomic) NSMutableArray *contents;

@property (assign , nonatomic) NSInteger willIndex;

@end

@implementation BMLContentViewController

@synthesize pageController = _pageController;

@synthesize pageContent = _pageContent;

- (instancetype)initWithFrame:(CGRect)frame contents:(NSArray *)contents {
    self = [super init];
    if (self) {
        _superFrame = frame;
        if (!_pageContent) {
            _pageContent = [NSMutableArray array];
        }
        [_pageContent addObjectsFromArray:contents];
        
        if (!_contents) {
            _contents = [NSMutableArray array];
        }
        //初始化数据
        [self createContentPages];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 设置UIPageViewController的配置项
    
    NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationNone] forKey: UIPageViewControllerOptionSpineLocationKey];
    
    // 实例化UIPageViewController对象，根据给定的属性
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options: options];
    
    // 设置UIPageViewController对象的代理
    
    _pageController.dataSource = self;
    
    _pageController.delegate = self;
    
    // 定义“这本书”的尺寸
    
    [[_pageController view] setFrame:_superFrame];
    
    
    // 让UIPageViewController对象，显示相应的页数据。
    
    // UIPageViewController对象要显示的页数据封装成为一个NSArray。
    
    // 因为我们定义UIPageViewController对象显示样式为显示一页（options参数指定）。
    
    // 如果要显示2页，NSArray中，应该有2个相应页数据。
    
    BMLContentDetailViewController *initialViewController =[self viewControllerAtIndex:_selectedIndex];// 得到第一页
    
    NSArray *viewControllers =[NSArray arrayWithObject:initialViewController];
    
    [_pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // 在页面上，显示UIPageViewController对象的View
    
    [self addChildViewController:_pageController];
    
    [[self view] addSubview:[_pageController view]];
}
- (void) createContentPages {
    for (int i = 0; i != _pageContent.count; i++){
        UIViewController *childViewController = (UIViewController *)[_pageContent objectAtIndex:i];
        
        BMLContentDetailViewController *contentDetailViewController = [[BMLContentDetailViewController alloc] initWithChildViewController:childViewController size:_superFrame.size];
        
        [_contents addObject:contentDetailViewController];
    }
}
// 得到相应的VC对象

- (BMLContentDetailViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    if (([self.pageContent count] == 0) || (index >= [self.pageContent count])) {
        return nil;
    }
    // 创建一个新的控制器类，并且分配给相应的数据
    BMLContentDetailViewController *contentDetailViewController = _contents[index];
    if (!contentDetailViewController.childViewController) {
        contentDetailViewController.childViewController = _pageContent[index];
    }
    return contentDetailViewController;
    
}


// 根据数组元素值，得到下标值

- (NSUInteger)indexOfViewController:(BMLContentDetailViewController *)viewController {
    
    return [self.contents indexOfObject:viewController];
    
}

#pragma mark- UIPageViewControllerDataSource


// 返回上一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSUInteger index = [self indexOfViewController:(BMLContentDetailViewController *)viewController];
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    // 返回的ViewController，将被添加到相应的UIPageViewController对象上。
    
    // UIPageViewController对象会根据UIPageViewControllerDataSource协议方法，自动来维护次序。
    
    // 不用我们去操心每个ViewController的顺序问题。
    
    return [self viewControllerAtIndex:index];
}


// 返回下一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSUInteger index = [self indexOfViewController:(BMLContentDetailViewController *)viewController];
    
    if (index == NSNotFound || index + 1 == [self.pageContent count]) {
        return nil;
    }
    
    index++;
    
    return [self viewControllerAtIndex:index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
    NSInteger index = [self indexOfViewController:(BMLContentDetailViewController *)pendingViewControllers[0]];
    self.willIndex = index;
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if(completed){
        
        _selectedIndex = self.willIndex;
        
        if ([self.delegate respondsToSelector:@selector(contentViewController:dragToIndex:)]) {
            [self.delegate contentViewController:self dragToIndex:_selectedIndex];
        }
    }
}
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    
    if (_selectedIndex == 0) {
        [self.pageController setViewControllers:@[[self viewControllerAtIndex:selectedIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
            
        }];
    }else if (_selectedIndex < selectedIndex){
        [self.pageController setViewControllers:@[[self viewControllerAtIndex:selectedIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
            
        }];
    }else{
        [self.pageController setViewControllers:@[[self viewControllerAtIndex:selectedIndex]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
            
        }];
    }
    
    _selectedIndex = selectedIndex;
}


#pragma mark - insert

- (void)insertContent:(UIViewController *)viewController AtIndex:(NSInteger)index {
    
    [_pageContent insertObject:viewController atIndex:index];
    
    BMLContentDetailViewController *contentDetailViewController = [[BMLContentDetailViewController alloc] initWithChildViewController:viewController size:_superFrame.size];
    [_contents insertObject:contentDetailViewController atIndex:index];
    
    if (_selectedIndex >= index) {
        _selectedIndex ++;
    }
    
    if ([self.delegate respondsToSelector:@selector(contentViewController:insertContent:AtIndex:)]) {
        [self.delegate contentViewController:self insertContent:viewController AtIndex:index];
    }
}

#pragma mark - delete

- (void)deleteContentAtIndex:(NSInteger)index {
    if (index != _selectedIndex) {
        [_pageContent removeObjectAtIndex:index];
        [_contents removeObjectAtIndex:index];
        
        if (_selectedIndex > index) {
            _selectedIndex --;
        }
    } else {
        if (_selectedIndex == 0) {
            [self setSelectedIndex:1];
            
            [_pageContent removeObjectAtIndex:index];
            [_contents removeObjectAtIndex:index];
            
            _selectedIndex = 0;
        } else if (_selectedIndex == _pageContent.count - 1) {
            [self setSelectedIndex:_pageContent.count - 2];
            
            [_pageContent removeObjectAtIndex:index];
            [_contents removeObjectAtIndex:index];
            
            _selectedIndex = _pageContent.count - 1;
        } else {
            [self setSelectedIndex:index + 1];
            
            [_pageContent removeObjectAtIndex:index];
            [_contents removeObjectAtIndex:index];
            
            _selectedIndex = index;
        }
        
    }
    
    if ([self.delegate respondsToSelector:@selector(contentViewController:deleteContentAtIndex:)]) {
        [self.delegate contentViewController:self deleteContentAtIndex:index];
    }
    
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
