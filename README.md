# BMLSegNavigatiion
分段导航

#######################################################
BMLNavigation.h
#######################################################

/**
 *  初始化一个分段导航的控制器
 *
 *  @param frame          frame约束分段导航控制器的显示坐标和大小
 *  @param childs         需要导航的子控制器数组，子控制器的title必须设置
 *  @param titleStyleMode 导航条的风格：如果是KTitleStyleModeMask，则需要设置maskColor；如果是KTitleStyleModeColorSize，则需要设置titleColor。默认的颜色是红色
 *
 *  @return 分段导航控制器
 */
- (instancetype)initWithFrame:(CGRect)frame childs:(NSArray *)childs titleStyle:(KTitleStyleMode)titleStyleMode;

/**
 *  需要导航的子控制器数组
 */
@property (strong ,nonatomic) NSMutableArray *childs;

/**
 *  导航条的风格
 */
@property (assign ,nonatomic) KTitleStyleMode titleStyleMode;

/**
 *  遮盖的颜色，如果导航条的风格是KTitleStyleModeMask，则需要设置
 */
@property (strong ,nonatomic) UIColor *maskColor;

/**
 *  选中后字体的颜色，如果导航条的风格是KTitleStyleModeColorSize，则需要设置
 */
@property (strong ,nonatomic) UIColor *titleColor;

/**
 *  被选中的子控制器在childs数组中的index
 */
@property (assign ,nonatomic) NSInteger selectedIndex;

/**
 *  导航条右侧是否需要一个按钮,如果是YES，可以通过downButton设置
 */
@property (assign ,nonatomic) BOOL isDown;

/**
 *  导航条右侧的按钮,isDownd等于YES是有效
 */
@property (strong ,nonatomic) UIButton *downButton;
/**
 *  点击导航条右侧按钮的回调事件
 */
@property (strong ,nonatomic) void(^downButtonCallback)(UIButton *);

/**
 *  插入一个子控制器
 *
 *  @param viewController 要插入的子控制器
 *  @param index          要插入的位置
 */
- (void)insertContent:(UIViewController *)viewController AtIndex:(NSInteger)index;
/**
 *  删除一个子控制器
 *
 *  @param index 要删除的位置
 */
- (void)deleteContentAtIndex:(NSInteger)index;



#######################################################
Example
#######################################################
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



- (NSArray *)creatChilds {
    NSMutableArray *contents = [NSMutableArray array];
    for (NSInteger i = 0; i != titles.count; i ++) {
        ExampleContentDetailViewController *contentDetailVC = [[ExampleContentDetailViewController alloc] init];
        contentDetailVC.title = [NSString stringWithFormat:@"%@%ld",titles[i],i];
    
        [contents addObject:contentDetailVC];
    }
    return contents;
}
