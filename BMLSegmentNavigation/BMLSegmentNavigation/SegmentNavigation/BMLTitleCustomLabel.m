
 //
//  BMLTitleCustomLabel.m
//  BMLSegmentNavigation
//
//  Created by 伯明利 on 16/5/20.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import "BMLTitleCustomLabel.h"

@implementation BMLTitleCustomLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self mySet];
    }
    return self;
}

- (void)mySet {
    
    self.textAlignment = NSTextAlignmentCenter;
    self.textColor = [UIColor blackColor];
    self.font = [UIFont systemFontOfSize:13];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelf:)];
    [self addGestureRecognizer:tap];
}

- (void)tapSelf:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(tapTitleLabel:titleStyle:)]) {
        [self setTitleStyle:[self.delegate tapTitleLabel:self titleStyle:_titleStyle]];
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.text = _title;
    CGSize size = [self sizeThatFits:CGSizeMake(0, 24)];
    _width = size.width + 16;
}

//- (void)setText:(NSString *)text {
//    self.text = text;
//    _title = text;
//    CGSize size = [self sizeThatFits:CGSizeMake(0, 24)];
//    _width = size.width + 16;
//}

- (void)setTitleStyle:(KTitleStyle)titleStyle {
    _titleStyle = titleStyle;
    if (_titleStyle == KTitleStyleDefault) {
        self.textColor = [UIColor blackColor];
        self.font = [UIFont systemFontOfSize:13 weight:12];
    } else if (_titleStyle == KTitleStyleSelectedColorSize) {
        [UIView animateWithDuration:0.4 animations:^{
            if (self.titleColor) {
                self.textColor = self.titleColor;
            } else {
                self.textColor = [UIColor redColor];
            }
            self.font = [UIFont systemFontOfSize:15 weight:15];
        }];
    }else if (_titleStyle == KTitleStyleMask) {
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:14 weight:14];
    }
}



@end
