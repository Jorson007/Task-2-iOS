//
//  NWRTDemoHeader.h
//  
//
//  Created by kwni on 2021/7/24.
//  Copyright © 2021 kwni. All rights reserved.
//

#ifndef NWRTDemoHeader_h
#define NWRTDemoHeader_h


#import "HistogramModel.h"


/// 屏幕 宽度、高度
#define Screen_Width ([UIScreen mainScreen].bounds.size.width)
#define Screen_Height ([UIScreen mainScreen].bounds.size.height)

// 随机色
#define HWRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

#define App_bgGrey [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.f]


#define HWRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]




#endif /* NWRTDemoHeader_h */
