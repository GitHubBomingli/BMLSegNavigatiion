//
//  BMLTitleNavigationScroll.m
//  BMLSegmentNavigation
//
//  Created by 伯明利 on 16/5/20.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import "BMLTitleNavigationScroll.h"


@interface BMLTitleNavigationScroll ()<BMLTitleCustomLabelDelegate>

@end

@implementation BMLTitleNavigationScroll

{
    KTitleStyleMode mStyle;
    
    NSMutableArray *mTitles;
    
    NSMutableArray *titleLabels;
    
    UIView *maskView;
    
    UIView *scrollMark;//滚动标签
    
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles style:(KTitleStyleMode)style {
    self = [super initWithFrame:frame];
    if (self) {
        if (!mTitles) {
            mTitles = [NSMutableArray array];
        }
        [mTitles removeAllObjects];
        [mTitles addObjectsFromArray:titles];
        if (!titleLabels) {
            titleLabels = [NSMutableArray array];
        }
        mStyle = style;
        
        [self mySet];
    }
    return self;
}

- (void)mySet {
    self.showsHorizontalScrollIndicator = NO;
    
    maskView = [[UIView alloc] init];
    maskView.layer.cornerRadius = 15.f;
    maskView.layer.masksToBounds = YES;
    maskView.alpha = 0.5;
    maskView.backgroundColor = [UIColor clearColor];
    [self addSubview:maskView];
    
    scrollMark = [[UIView alloc] init];
    scrollMark.backgroundColor = [UIColor redColor];
    [self addSubview:scrollMark];
    
    for (NSInteger index = 0; index != mTitles.count; index ++) {
        BMLTitleCustomLabel *titleLabel = [[BMLTitleCustomLabel alloc] init];
        titleLabel.tag = index;
        titleLabel.title = mTitles[index];
        titleLabel.titleColor = self.titleColor;
        titleLabel.titleStyle = KTitleStyleDefault;
        titleLabel.delegate = self;
        if (index == 0) {
            titleLabel.frame = CGRectMake(0, 0, titleLabel.width, self.frame.size.height - 1);
        } else {
            BMLTitleCustomLabel *perTitleLabel = titleLabels[index - 1];
            titleLabel.frame = CGRectMake(CGRectGetMaxX(perTitleLabel.frame), 0, titleLabel.width, self.frame.size.height - 1);
        }
        
        [self addSubview:titleLabel];
        [titleLabels addObject:titleLabel];
    }
    
    
    BMLTitleCustomLabel *lastTitleLabel = [titleLabels lastObject];
    self.contentSize = CGSizeMake(CGRectGetMaxX(lastTitleLabel.frame), self.frame.size.height);
}

- (KTitleStyle)tapTitleLabel:(BMLTitleCustomLabel *)titleLabel titleStyle:(KTitleStyle)titleStyle {
    
    if ([self.delegateCustom respondsToSelector:@selector(tapTitleNavigationScroll:withTitleLabel:index:)]) {
        CGFloat offsetX = [self.delegateCustom tapTitleNavigationScroll:self withTitleLabel:titleLabel index:titleLabel.tag];
        [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    for (BMLTitleCustomLabel *label in titleLabels) {
        label.titleStyle = KTitleStyleDefault;
    }
    [self setSelectedIndex:titleLabel.tag];
    
    if (mStyle == KTitleStyleModeColorSize) {
        return KTitleStyleSelectedColorSize;
    } else {
        return KTitleStyleMask;
    }
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    scrollMark.backgroundColor = _titleColor;
    for (BMLTitleCustomLabel *titleLabel in titleLabels) {
        titleLabel.titleColor = _titleColor;
    }
}

- (void)setMaskColor:(UIColor *)maskColor {
    _maskColor = maskColor;
    maskView.backgroundColor = _maskColor;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    
    for (BMLTitleCustomLabel *label in titleLabels) {
        label.titleStyle = KTitleStyleDefault;
    }
    
    BMLTitleCustomLabel *titleLabel = titleLabels[_selectedIndex];
    if (KTitleStyleModeColorSize == mStyle) {
        titleLabel.titleStyle = KTitleStyleSelectedColorSize;
        [UIView animateWithDuration:0.4 animations:^{
            scrollMark.frame = CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetMaxY(titleLabel.frame) - 1, CGRectGetWidth(titleLabel.frame), 1);
        }];
    } else {
        titleLabel.titleStyle = KTitleStyleMask;
        [UIView animateWithDuration:0.4 animations:^{
            CGRect maskFrame = CGRectMake(CGRectGetMinX(titleLabel.frame), (CGRectGetHeight(titleLabel.frame) - 30) / 2.f, CGRectGetWidth(titleLabel.frame), 30);
            maskView.frame = maskFrame;
        }];
    }
    
}

- (void)insetTitle:(NSString *)title withIndex:(NSInteger)index {
    [mTitles insertObject:title atIndex:index];
    
    BMLTitleCustomLabel *newTitleLabel = [[BMLTitleCustomLabel alloc] init];
    newTitleLabel.title = title;
    newTitleLabel.titleColor = self.titleColor;
    newTitleLabel.titleStyle = KTitleStyleDefault;
    newTitleLabel.delegate = self;
    [titleLabels insertObject:newTitleLabel atIndex:index];
    [self addSubview:newTitleLabel];
    
    for (NSInteger i = 0; i != titleLabels.count; i ++ ) {
        BMLTitleCustomLabel *titleLabel = titleLabels[i];
        titleLabel.tag = i;
        
        if (i == 0) {
            titleLabel.frame = CGRectMake(0, 0, titleLabel.width, self.frame.size.height - 1);
        } else {
            BMLTitleCustomLabel *perTitleLabel = titleLabels[i - 1];
            titleLabel.frame = CGRectMake(CGRectGetMaxX(perTitleLabel.frame), 0, titleLabel.width, self.frame.size.height - 1);
        }
    }
    
    BMLTitleCustomLabel *lastTitleLabel = [titleLabels lastObject];
    self.contentSize = CGSizeMake(CGRectGetMaxX(lastTitleLabel.frame), self.frame.size.height);
    
    if (_selectedIndex >= index) {
        [self setSelectedIndex:_selectedIndex + 1];
    }
    
    if ([self.delegateCustom respondsToSelector:@selector(titleNavigationScroll:insetTitleLabel:insetTitle:withIndex:selectedIndex:)]) {
        CGFloat offsetX = [self.delegateCustom titleNavigationScroll:self insetTitleLabel:newTitleLabel insetTitle:title withIndex:index  selectedIndex:_selectedIndex];
        [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
}

- (void)deleteTitleWithIndex:(NSInteger)index {
    [mTitles removeObjectAtIndex:index];
    BMLTitleCustomLabel *deleteTitleLabel = titleLabels[index];
    [deleteTitleLabel removeFromSuperview];
    [titleLabels removeObjectAtIndex:index];
    
    for (NSInteger i = 0; i != titleLabels.count; i ++ ) {
        BMLTitleCustomLabel *titleLabel = titleLabels[i];
        titleLabel.tag = i;
        
        if (i == 0) {
            titleLabel.frame = CGRectMake(0, 0, titleLabel.width, self.frame.size.height - 1);
        } else {
            BMLTitleCustomLabel *perTitleLabel = titleLabels[i - 1];
            titleLabel.frame = CGRectMake(CGRectGetMaxX(perTitleLabel.frame), 0, titleLabel.width, self.frame.size.height - 1);
        }
    }
    
    BMLTitleCustomLabel *lastTitleLabel = [titleLabels lastObject];
    self.contentSize = CGSizeMake(CGRectGetMaxX(lastTitleLabel.frame), self.frame.size.height);
    
    if (_selectedIndex == index) {
        if (index == 0) {
            [self setSelectedIndex:0];
        } else if (index == titleLabels.count) {
            [self setSelectedIndex:titleLabels.count - 1];
        } else {
            [self setSelectedIndex:index];
        }
    } else if (_selectedIndex > index) {
        [self setSelectedIndex:_selectedIndex - 1];
    } else {
        [self setSelectedIndex:_selectedIndex];
    }
    
    if ([self.delegateCustom respondsToSelector:@selector(titleNavigationScroll:deleteTitleWithIndex:selectedIndex:)]) {
        CGFloat offsetX = [self.delegateCustom titleNavigationScroll:self deleteTitleWithIndex:index selectedIndex:_selectedIndex];
        [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
}

@end
