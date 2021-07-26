//
//  NWRTDemoMainCell.h
//
//  Created by kwni on 2021/7/24.
//  Copyright © 2021 kwni. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BAR_cW 15    // 柱状图Cell宽度
#define BAR_cH 300   // 柱状图高度


NS_ASSUME_NONNULL_BEGIN

@interface NWRTDemoMainCell : UICollectionViewCell

@property (nonatomic, weak) UIView *barView;
@property (nonatomic, weak) UILabel *labelView;
@property (nonatomic, strong) UIColor *barColor;

- (void)barHeight:(double)height;

@end

NS_ASSUME_NONNULL_END
