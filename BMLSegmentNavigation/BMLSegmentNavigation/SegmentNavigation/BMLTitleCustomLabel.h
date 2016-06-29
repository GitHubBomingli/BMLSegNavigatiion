//
//  BMLTitleCustomLabel.h
//  BMLSegmentNavigation
//
//  Created by 伯明利 on 16/5/20.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    KTitleStyleDefault,
    KTitleStyleSelectedColorSize,
    KTitleStyleMask,
} KTitleStyle;

@class BMLTitleCustomLabel;
@protocol BMLTitleCustomLabelDelegate <NSObject>

- (KTitleStyle)tapTitleLabel:(BMLTitleCustomLabel *)titleLabel titleStyle:(KTitleStyle)titleStyle;

@end

@interface BMLTitleCustomLabel : UILabel

/**
 *  要显示的文字
 */
@property (strong, nonatomic) NSString *title;
/**
 *  选中文字的颜色
 */
@property (strong ,nonatomic) UIColor *titleColor;

/**
 *  风格
 */
@property (assign , nonatomic) KTitleStyle titleStyle;

/**
 *  宽度
 */
@property (assign , nonatomic , readonly) CGFloat width;

@property (weak , nonatomic) id <BMLTitleCustomLabelDelegate> delegate;



@end
