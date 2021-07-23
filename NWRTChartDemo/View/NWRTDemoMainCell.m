//
//  NWRTDemoMainCell.m
//
//  Created by kwni on 2021/7/24.
//  Copyright © 2021 kwni. All rights reserved.
//

#import "NWRTDemoMainCell.h"


@implementation NWRTDemoMainCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark - 初始化View
- (void)setupView
{
    self.contentView.backgroundColor = [UIColor clearColor];
    
    UIView *barView = [UIView new];
    [self.contentView addSubview:barView];
    self.barView = barView;
}

- (void)barHeight:(double)height
{
    self.barView.backgroundColor = self.barColor;
    if (height < 10) {
        height = 10;
    }
    
    if (height > BAR_cH) {
        height = BAR_cH;
    }
    
    self.barView.frame = CGRectMake(0, BAR_cH - height, BAR_cW, height);
}

@end
