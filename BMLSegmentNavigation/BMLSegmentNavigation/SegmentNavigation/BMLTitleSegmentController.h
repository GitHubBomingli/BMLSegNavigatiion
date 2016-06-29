//
//  BMLTitleSegmentController.h
//  BMLSegmentNavigation
//
//  Created by 伯明利 on 16/5/20.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMLTitleNavigationScroll.h"
#import "BMLTitleCustomLabel.h"

@class BMLTitleSegmentController ;

@protocol BMLTitleSegmentControllerDelegate <NSObject>

- (void)tapTitleSegmentController:(BMLTitleSegmentController *)titleSegmentController titleLabel:(BMLTitleCustomLabel *)titleLabel index:(NSInteger)index;

@optional

- (void)TitleSegmentController:(BMLTitleSegmentController *)titleSegmentController insertTitle:(NSString *)title withIndex:(NSInteger)index;

- (void)TitleSegmentController:(BMLTitleSegmentController *)titleSegmentController deleteTitleWithIndex:(NSInteger)index;

@end


@interface BMLTitleSegmentController : UIViewController<BMLTitleNavigationScrollDelegate>

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles titleStyle:(KTitleStyleMode)titleStyle;

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

@property (weak ,nonatomic) id <BMLTitleSegmentControllerDelegate> delegate;
@end
