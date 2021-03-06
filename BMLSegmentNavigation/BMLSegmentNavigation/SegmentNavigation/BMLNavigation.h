//
//  BMLNavigation.h
//  BMLSegmentNavigation
//
//  Created by 伯明利 on 16/5/26.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMLTitleSegmentController.h"
#import "BMLContentViewController.h"

@class BMLNavigation;

@protocol BMLNavigationDelegate <NSObject>

@optional
/**
 *  切换子控制器时调用
 *
 *  @param navigation          分段导航的控制器
 *  @param title        子控制器的title
 *  @param index 索引
 *  @return void
 */
- (void)navigation:(BMLNavigation *)navigation title:(NSString *)title index:(NSInteger)index;

@end

@interface BMLNavigation : UIViewController

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
 *  设置代理
 */
@property (weak, nonatomic) id <BMLNavigationDelegate> delegate;

/**
 *  需要导航的子控制器数组
 */
@property (strong ,nonatomic) NSMutableArray *childs;

/**
 *  导航条的风格
 */
@property (assign ,nonatomic ,readonly) KTitleStyleMode titleStyleMode;

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

@end
