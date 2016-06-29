//
//  BMLTitleSegmentController.m
//  BMLSegmentNavigation
//
//  Created by 伯明利 on 16/5/20.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import "BMLTitleSegmentController.h"
#import "BMLTitleNavigationScroll.h"

@implementation BMLTitleSegmentController
{
    CGRect superFrame;
    
    NSArray *superTitles;
    
    KTitleStyleMode superTitleStyle;
    
    BMLTitleNavigationScroll *navigationScroll;
}
/**
 *  初始化
 *
 *  @param frame  导航条的frame
 *  @param titles 导航条的标题数组
 *
 *  @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles titleStyle:(KTitleStyleMode)titleStyle {
    self = [super init];
    if (self) {
        superFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        superTitles = [NSArray arrayWithArray:titles];
        superTitleStyle = titleStyle;
        if (!navigationScroll) {
            navigationScroll = [[BMLTitleNavigationScroll alloc] initWithFrame:superFrame titles:titles style:titleStyle];
        }
        navigationScroll.delegateCustom = self;
    }
    return self;
}

- (void)insetTitle:(NSString *)title withIndex:(NSInteger)index {
    [navigationScroll insetTitle:title withIndex:index];
}

- (void)deleteTitleWithIndex:(NSInteger)index {
    [navigationScroll deleteTitleWithIndex:index];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:navigationScroll];
    
    navigationScroll.delegateCustom = self;
    
    navigationScroll.maskColor = self.maskColor;
    
    navigationScroll.titleColor = self.titleColor;
    
    navigationScroll.selectedIndex = self.selectedIndex;
}
#pragma mark - set
- (void)setMaskColor:(UIColor *)maskColor {
    _maskColor = maskColor;
    
    navigationScroll.maskColor = self.maskColor;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    
    navigationScroll.titleColor = self.titleColor;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    
    navigationScroll.selectedIndex = self.selectedIndex;
    
    [self setTitleNavigationScrollOffsetX];
}
- (void)setTitleNavigationScrollOffsetX {
    BMLTitleCustomLabel *titleLabel = [navigationScroll viewWithTag:_selectedIndex];
    
    CGFloat offsetX = titleLabel.frame.origin.x - (superFrame.size.width - titleLabel.frame.size.width) / 2.f;
    if (offsetX < 0) {
        offsetX = 0;
    } else if (offsetX > navigationScroll.contentSize.width - superFrame.size.width) {
        offsetX = navigationScroll.contentSize.width - superFrame.size.width;
    }

    [navigationScroll setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark - delegate
- (CGFloat)tapTitleNavigationScroll:(BMLTitleNavigationScroll *)titleNavigationScroll withTitleLabel:(BMLTitleCustomLabel *)titleLabel  index:(NSInteger)index {
    _selectedIndex = index;
    
    if ([self.delegate respondsToSelector:@selector(tapTitleSegmentController:titleLabel:index:)]) {
        [self.delegate tapTitleSegmentController:self titleLabel:titleLabel index:index];
    }
    
    CGFloat offsetX = titleLabel.frame.origin.x - (superFrame.size.width - titleLabel.frame.size.width) / 2.f;
    if (offsetX < 0) {
        offsetX = 0;
    } else if (offsetX > titleNavigationScroll.contentSize.width - superFrame.size.width) {
        offsetX = titleNavigationScroll.contentSize.width - superFrame.size.width;
    }
    return offsetX;
}

- (CGFloat)titleNavigationScroll:(BMLTitleNavigationScroll *)titleNavigationScroll insetTitleLabel:(BMLTitleCustomLabel *)titleLabel insetTitle:(NSString *)title withIndex:(NSInteger)index selectedIndex:(NSInteger)selectedIndex {
    
    NSLog(@"插入了%@",title);
    
    _selectedIndex = selectedIndex;
    
    if ([self.delegate respondsToSelector:@selector(TitleSegmentController:insertTitle:withIndex:)]) {
        [self.delegate TitleSegmentController:self insertTitle:title withIndex:index];
    }
    
    CGFloat offsetX = titleLabel.frame.origin.x - (superFrame.size.width - titleLabel.frame.size.width) / 2.f;
    if (offsetX < 0) {
        offsetX = 0;
    } else if (offsetX > titleNavigationScroll.contentSize.width - superFrame.size.width) {
        offsetX = titleNavigationScroll.contentSize.width - superFrame.size.width;
    }
    return offsetX;
}

- (CGFloat)titleNavigationScroll:(BMLTitleNavigationScroll *)titleNavigationScroll deleteTitleWithIndex:(NSInteger)index selectedIndex:(NSInteger)selectedIndex{
    NSLog(@"删除了第%ld个",index);
    _selectedIndex = selectedIndex;
    
    if ([self.delegate respondsToSelector:@selector(TitleSegmentController:deleteTitleWithIndex:)]) {
        [self.delegate TitleSegmentController:self deleteTitleWithIndex:index];
    }
    
    BMLTitleCustomLabel *titleLabel = [navigationScroll viewWithTag:_selectedIndex];
    CGFloat offsetX = titleLabel.frame.origin.x - (superFrame.size.width - titleLabel.frame.size.width) / 2.f;
    if (offsetX < 0) {
        offsetX = 0;
    } else if (offsetX > navigationScroll.contentSize.width - superFrame.size.width) {
        offsetX = navigationScroll.contentSize.width - superFrame.size.width;
    }
    return offsetX;
}

@end
