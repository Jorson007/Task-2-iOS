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
    UILabel *label = [UILabel new];
    label.text = @"1";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:label];
    self.barView = barView;
    self.labelView = label;
}

- (void)barHeight:(double)height
{
    self.barView.backgroundColor = self.barColor;
    
    if (height > BAR_cH) {
        height = BAR_cH;
    }
    int height2Int = (int)height/5;
    self.labelView.text = [NSString stringWithFormat:@"%d",height2Int];
    float originY = height2Int > 56 ? BAR_cH - height : BAR_cH - height-20;
    self.barView.frame = CGRectMake(0, BAR_cH - height, BAR_cW, height);
    self.labelView.frame = CGRectMake(BAR_cW/2-8, originY, 16, 20);

}

@end
