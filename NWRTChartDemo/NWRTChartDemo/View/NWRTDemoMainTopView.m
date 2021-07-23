//
//  NWRTDemoMainTopView.m
//
//  Created by kwni on 2021/7/24.
//  Copyright © 2021 kwni. All rights reserved.
//

#import "NWRTDemoMainTopView.h"

#import "NWRTDemoHeader.h"

@interface NWRTDemoMainTopView () <UICollectionViewDelegate, UICollectionViewDataSource>

@end


@implementation NWRTDemoMainTopView

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
    self.backgroundColor = App_bgGrey;
    
    CGRect f = CGRectMake(0,0, Screen_Width, BAR_cH);
    
    NWRTDemoMainBgView *bgView = [[NWRTDemoMainBgView alloc] initWithFrame:f];
    [self addSubview:bgView];
    self.bgView = bgView;
    
    UICollectionViewFlowLayout *fw = [[UICollectionViewFlowLayout alloc] init];
    fw.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置行与行之间的间距最小距离
    fw.minimumLineSpacing = 10;
    // 设置列与列之间的间距最小距离
    fw.minimumInteritemSpacing = 0;
    fw.itemSize = CGSizeMake(BAR_cW, BAR_cH);
    
    self.fw = fw;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:f collectionViewLayout:fw];
    collectionView.clipsToBounds = YES;
    collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.alwaysBounceHorizontal = YES;
    collectionView.backgroundColor = [UIColor clearColor];
    if (@available(iOS 11.0, *)) {
        collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[NWRTDemoMainCell class] forCellWithReuseIdentifier:@"BTC"];
    
    [self addSubview:collectionView];
    self.collectionView = collectionView;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataArray) return self.dataArray.count;
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NWRTDemoMainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BTC" forIndexPath:indexPath];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NWRTDemoMainCell *c = (NWRTDemoMainCell *)cell;
    c.barColor = self.colorArray[indexPath.item];
    double t = [self.dataArray[indexPath.item] doubleValue]*5;
    
    [c barHeight:t];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    int index = (int)indexPath.item;
    [self.delegate clickPillarAtIndex:index];

}


#pragma mark - 刷新数据

- (void)reloadWith:(NSArray *)dataArray andColorArr:(NSArray *)colorArray
{
    CGFloat w = (dataArray.count * BAR_cW) + (dataArray.count - 1) * self.fw.minimumLineSpacing;
    
    if (w > Screen_Width) {
        self.fw.headerReferenceSize = CGSizeMake(self.fw.minimumLineSpacing, BAR_cH);
        self.fw.footerReferenceSize = CGSizeMake(self.fw.minimumLineSpacing, BAR_cH);
    } else {
        self.fw.headerReferenceSize = CGSizeMake((Screen_Width - w) * 0.5, BAR_cH);
        self.fw.footerReferenceSize = CGSizeMake((Screen_Width - w) * 0.5, BAR_cH);
    }
    
    self.dataArray = dataArray;
    self.colorArray = colorArray;
    [self.collectionView reloadData];
}





@end
