//
//  BMLTitleNavigationScroll.h
//  BMLSegmentNavigation
//
//  Created by 伯明利 on 16/5/20.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMLTitleCustomLabel.h"

typedef enum : NSUInteger {
    KTitleStyleModeColorSize,   //标题有滚动条，选中后标题的大小和颜色会变化
    KTitleStyleModeMask,    //遮盖效果
} KTitleStyleMode;

@class BMLTitleNavigationScroll;

@protocol BMLTitleNavigationScrollDelegate <NSObject>
/**
 *  点击一个item后的回调
 *
 *  @param titleNavigationScroll
 *  @param titleLabel            点击的label
 *
 *  @return scrollview的offset->x
 */
- (CGFloat)tapTitleNavigationScroll:(BMLTitleNavigationScroll *)titleNavigationScroll withTitleLabel:(BMLTitleCustomLabel *)titleLabel index:(NSInteger)index;

/**
 *  插入一个title 后的回调
 *
 *  @param titleNavigationScroll
 *  @param title
 *  @param index
 *
 *  @return scrollview的offset->x
 */
- (CGFloat)titleNavigationScroll:(BMLTitleNavigationScroll *)titleNavigationScroll insetTitleLabel:(BMLTitleCustomLabel *)titleLabel insetTitle:(NSString *)title withIndex:(NSInteger)index selectedIndex:(NSInteger)selectedIndex;
/**
 *  删除一个title 后的回调
 *
 *  @param titleNavigationScroll
 *  @param index 删除的哪一个
 *
 *  @return scrollview的offset->x
 */
- (CGFloat)titleNavigationScroll:(BMLTitleNavigationScroll *)titleNavigationScroll deleteTitleWithIndex:(NSInteger)index selectedIndex:(NSInteger)selectedIndex;

@end

@interface BMLTitleNavigationScroll : UIScrollView
/**
 *  初始化
 *
 *  @param frame  scrollview的frame
 *  @param titles title数组
 *
 *  @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles style:(KTitleStyleMode)style;
/**
 *  插入一个title
 *
 *  @param title 要插入的文字
 *  @param index 要插入的位置
 */
- (void)insetTitle:(NSString *)title withIndex:(NSInteger)index;
/**
 *  删除一个title
 *
 *  @param index 删除的哪一个
 */
- (void)deleteTitleWithIndex:(NSInteger)index;

/**
 *  遮盖的颜色
 */
@property (strong ,nonatomic) UIColor *maskColor;

/**
 *  选中后字体的颜色
 */
@property (strong ,nonatomic) UIColor *titleColor;
/**
 *  被选中的title的位置
 */
@property (assign ,nonatomic) NSInteger selectedIndex;

@property (weak , nonatomic) id <BMLTitleNavigationScrollDelegate> delegateCustom;

@end
