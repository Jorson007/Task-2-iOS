//
//  ViewController.h
//  NWRTChartDemo
//
//  Created by kwni on 2021/7/21.
//

#import <UIKit/UIKit.h>
#import <MQTTClient/MQTTClient.h>
#import <MQTTClient/MQTTSessionManager.h>
#import "NWRTDemoMainTopView.h"

@interface NWRTMainViewController : UIViewController<MQTTSessionManagerDelegate,dealPillarClickProtocol>


@end

