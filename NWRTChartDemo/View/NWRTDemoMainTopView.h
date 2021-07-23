//
//  DemoFMainTopView.h
//
//  Created by kwni on 2021/7/24.
//  Copyright © 2021 kwni. All rights reserved.
//

#import <UIKit/UIKit.h>

// --------------------------View--------------------------
#import "NWRTDemoMainCell.h"
#import "NWRTDemoMainBgView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol dealPillarClickProtocol <NSObject>

@optional
-(void)clickPillarAtIndex:(int)index;

@end

@interface NWRTDemoMainTopView : UIView

// --------------------------UI--------------------------

@property (nonatomic, weak) NWRTDemoMainBgView *bgView;

@property (nonatomic, weak) UICollectionViewFlowLayout *fw;

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) id<dealPillarClickProtocol> delegate;


// --------------------------Data--------------------------
/// 数据
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *colorArray;



// --------------------------Medhod--------------------------

- (void)reloadWith:(NSArray *)dataArray andColorArr:(NSArray *)colorArray;


@end

NS_ASSUME_NONNULL_END
