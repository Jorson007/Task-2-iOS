//
//  ViewController.m
//  NWRTChartDemo
//
//  Created by kwni on 2021/7/21.
//

#import "NWRTMainViewController.h"
#import "NWRTDemoMainTopView.h"
#import <AFNetworking/AFNetworking.h>
#import "NWRTDemoHeader.h"

@interface NWRTMainViewController ()

@property (nonatomic,strong) MQTTSessionManager *manager;
@property (nonatomic,strong) NSString *rootTopic;
@property (nonatomic) NSInteger qos;


@property (nonatomic,strong) NSMutableArray *heightArr;    //记录每个柱子的高度
@property (nonatomic,strong) NSMutableArray *colorArr;     //记录每个柱子的yanse
@property (nonatomic,strong) UIButton *clearButton;        //清空柱子button
@property (nonatomic,strong) UIButton *addButton;          //添加柱子button
@property (nonatomic, weak) NWRTDemoMainTopView *topView;     //显示柱状图view



@end

@implementation NWRTMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self __initData];
    
    [self __loadConfiguation];

    [self __setupUI];
    
    [self refreshView];
    
}

-(void)__initData{
    self.qos = 0;
    self.rootTopic = @"root";
    self.heightArr = [NSMutableArray array];
    self.colorArr = [[NSMutableArray alloc] initWithObjects:[UIColor redColor],[UIColor blueColor],[UIColor cyanColor],[UIColor greenColor],[UIColor purpleColor],[UIColor redColor],[UIColor blueColor],[UIColor cyanColor],[UIColor greenColor],[UIColor purpleColor], nil];
}

-(void)__setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect f = CGRectMake(10, 120, Screen_Width-20, BAR_cH);
    
    NWRTDemoMainTopView *topView = [[NWRTDemoMainTopView alloc] initWithFrame:f];
    self.topView = topView;
    self.topView.delegate = self;
    [self.view addSubview:topView];
    
    _clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    _clearButton.frame = CGRectMake(160, 500, 100, 30) ;
    [_clearButton setTitle:@"Clear" forState:UIControlStateNormal] ;
    _clearButton.backgroundColor = [UIColor colorWithRed:108/255.0 green:203/255.0 blue:247/255.0 alpha:1] ;
    [_clearButton setTitleColor: [UIColor whiteColor ] forState:UIControlStateNormal] ;
    [_clearButton addTarget:self action:@selector(clearPillar) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_clearButton] ;
    
    _addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    _addButton.frame = CGRectMake(50, 500, 100, 30) ;
    [_addButton setTitle:@"Add" forState:UIControlStateNormal] ;
    _addButton.backgroundColor = [UIColor colorWithRed:108/255.0 green:203/255.0 blue:247/255.0 alpha:1] ;
    [_addButton setTitleColor: [UIColor whiteColor ] forState:UIControlStateNormal] ;
    [_addButton addTarget:self action:@selector(addPillar) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_addButton] ;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 200, 30)];
    label.text = @"MQTT实时图表";
    [self.view addSubview:label];
    
    UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(20, 430, 300, 60)];
    desc.font = [UIFont systemFontOfSize:12];
    desc.numberOfLines = 3;
    desc.text = @"1.点击Add添加柱子,最多可添加10个\n2.点击Clear清空柱状图\n3.点击对应的柱子一次高度加1";
    [self.view addSubview:desc];

}


-(void)__loadConfiguation{
    NSString *deviceID = [UIDevice currentDevice].identifierForVendor.UUIDString;
    NSString *appId = @"djcdf0";
    NSString *clientId = [NSString stringWithFormat:@"%@@%@",deviceID,appId];
    NSString *username = @"user1";
    NSString *password = @"123456";
    BOOL  isSSL = FALSE;
    if(!self.manager){
        self.manager = [[MQTTSessionManager alloc] init];
        self.manager.delegate = self;
        self.manager.subscriptions = @{[NSString stringWithFormat:@"%@/IOS", self.rootTopic]:@(self.qos),[NSString stringWithFormat:@"%@/IOS_TestToic", self.rootTopic]:@(1)};
        [self getTokenWithUsername:username password:password completion:^(NSString *token) {
            NSLog(@"=======token:%@==========",token);
            [self bindWithUserName:username password:token cliendId:clientId isSSL:isSSL];
        }];
    }else{
        [self.manager connectToLast:nil];
    }
    
    // 添加监听状态观察者
    [self.manager addObserver:self
                       forKeyPath:@"state"
                          options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                          context:nil];
}

- (void)getTokenWithUsername:(NSString *)username password:(NSString *)password completion:(void (^)(NSString *token))response {
    NSString *urlString = @"https://a1.easemob.com/1139210715094625/nrtchartdemo/token";
    //初始化一个AFHTTPSessionManager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求体数据为json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置响应体数据为json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSDictionary *parameters = @{@"grant_type":@"password",
                                 @"username":username,
                                 @"password":password
                                 };
   
    __block NSString *token  = @"";
    [manager POST:urlString
             parameters:parameters
             headers:nil
             progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        NSError *error = nil;
                        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&error];
                        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
                        NSLog(@"%s jsonDic:%@",__func__,jsonDic);
                        token = jsonDic[@"access_token"];
                        response(token);}
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        NSLog(@"%s error:%@",__func__,error.debugDescription);
                        response(token);
    }];
}



#pragma mark - 绑定
- (void)bindWithUserName:(NSString *)username password:(NSString *)password cliendId:(NSString *)cliendId isSSL:(BOOL)isSSL{
    [self.manager connectTo:@"djcdf0.cn1.mqtt.chat"
                                port:1883
                                 tls:isSSL
                           keepalive:60
                               clean:YES
                                auth:YES
                                user:username
                                pass:password
                                will:NO
                           willTopic:nil
                             willMsg:nil
                             willQos:0
                      willRetainFlag:NO
                        withClientId:cliendId
                      securityPolicy:[self customSecurityPolicy]
                        certificates:nil
                       protocolLevel:4
                      connectHandler:nil];
    
}

- (MQTTSSLSecurityPolicy *)customSecurityPolicy
{
    MQTTSSLSecurityPolicy *securityPolicy = [MQTTSSLSecurityPolicy policyWithPinningMode:MQTTSSLPinningModeNone];
    
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesCertificateChain = YES;
    securityPolicy.validatesDomainName = NO;
    return securityPolicy;
}
// 监听当前连接状态
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
   switch (self.manager.state) {
       case MQTTSessionManagerStateClosed:
           NSLog(@"连接已经关闭");
           break;
       case MQTTSessionManagerStateClosing:
           NSLog(@"连接正在关闭");

           break;
       case MQTTSessionManagerStateConnected:
           NSLog(@"已经连接");

           break;
       case MQTTSessionManagerStateConnecting:
           NSLog(@"正在连接中");

           break;
       case MQTTSessionManagerStateError: {
           NSString *errorCode = self.manager.lastErrorCode.localizedDescription;
           NSLog(@"连接异常 ----- %@",errorCode);
       }

           break;
       case MQTTSessionManagerStateStarting:
           NSLog(@"开始连接");
          break;
       default:
           break;
   }
}

-(void)addPillar{
    if(self.heightArr.count >= 10){
        return;
    }
    [self sendData:@"add"];
}

-(void)clearPillar{
    [self sendData:@"clear"];
}

- (void)clickPillarAtIndex:(int)index{
    [self sendData:[NSString stringWithFormat:@"%d",index]];
}

- (void)refreshView
{
    [self.topView reloadWith:self.heightArr andColorArr:self.colorArr];
}
// 获取服务器返回数据
- (void)handleMessage:(NSData *)data onTopic:(NSString *)topic retained:(BOOL)retained {
    NSLog(@"------------->>%@",topic);
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",dataString);
    if([dataString isEqualToString:@"add"]){
        [self.heightArr addObject:@1];
//        [self.colorArr addObject:HWRandomColor];
    }else if([dataString isEqualToString:@"clear"])
    {
        [self.heightArr removeAllObjects];
//        [self.colorArr removeAllObjects];
    }else{
        NSInteger index = [dataString integerValue];
        int height = [self.heightArr[index] intValue];
        self.heightArr[index] = @(height + 1);
    }
    [self refreshView];
}

- (void)connect {
    [self.manager connectToLast:nil];
}

- (void)disConnect {
    
    [self.manager disconnectWithDisconnectHandler:nil];
    self.manager.subscriptions = @{};
    
}

//添加柱子
- (void)sendData:(NSString *)data{
    [self.manager sendData:[data dataUsingEncoding:NSUTF8StringEncoding]
                     topic:[NSString stringWithFormat:@"%@/%@",
                            self.rootTopic,
                            @"IOS"]//此处设置多级子topic
                       qos:self.qos
                    retain:FALSE];
}


@end
