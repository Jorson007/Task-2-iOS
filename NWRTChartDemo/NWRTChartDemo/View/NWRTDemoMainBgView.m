//
//  DemoFMainBgView.m
//
//  Created by kwni on 2021/7/24.
//  Copyright © 2021 kwni. All rights reserved.
//

#import "NWRTDemoMainBgView.h"

@implementation NWRTDemoMainBgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark - 初始化View
- (void)setupView
{
    // 其实绘制线，有很多方法，这里就简单使用CALayer代替了
    
    CGFloat w = self.frame.size.width - 30 - 30;
    CGFloat gap = self.frame.size.height / 4.0;
    
    for (int i = 0; i < 5; i++)
    {
        CALayer *spLayer = [CALayer new];
        spLayer.backgroundColor = [UIColor redColor].CGColor;
        spLayer.frame = CGRectMake(30, gap * (i), w, 0.5);
        [self.layer addSublayer:spLayer];


        CGFloat y = gap * (i) - 10;

        UILabel *label = [UILabel new];
        label.text = [NSString stringWithFormat:@"%d",(60 - ((i) * 15))];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor purpleColor];
        label.frame = CGRectMake(0, y, 30, 20);
        [self addSubview:label];
    }
}

@end
