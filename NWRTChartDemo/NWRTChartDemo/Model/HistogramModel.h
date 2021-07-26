//
//  HistogramModel.h
//
//  Created by kwni on 2021/7/24.
//  Copyright © 2021 kwni. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistogramModel : NSObject

/// 是否选中此数据
@property (nonatomic, assign, getter=isSelected) BOOL selected;

@property (nonatomic, assign) NSInteger value;

@property (nonatomic, copy) NSString *date;



@end

NS_ASSUME_NONNULL_END
