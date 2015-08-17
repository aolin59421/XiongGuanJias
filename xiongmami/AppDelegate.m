//
//  AppDelegate.m
//  xiongmami
//
//  Created by iMac on 14/11/18.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "OrderViewController.h"
#import "PersonalViewController.h"
#import "PersonalLanding.h"
#import "LeveyTabBarController.h"
#import "HexadecimalConversionUICOLOR.h"
#import "XMMViewController.h"
#import "XMMCustomSegmentedButton.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [NSThread sleepForTimeInterval:1];
    [self PUSH:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.synthesizer = [[AVSpeechSynthesizer alloc] init];
//    dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //添加任务到队列中，就可以执行任务
    //异步函数：具备开启新线程的能力
//    dispatch_async(queue, ^{
//        [self xiongmamiFenXiangURL];
//    });
    
    //判断是否有网络
    [[BoolViewController alloc] testOut];
    NSUserDefaults *userFirst = [NSUserDefaults standardUserDefaults];
    NSString *first = [userFirst  valueForKey:@"First"];
//    NSLog(@"first-%@",first);
    if (first == nil || first == NULL ) {
        NSLog(@"无");
        NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
        [userdefault setValue:@"1" forKey:@"First"];
        [self xgjWidow];
        [self loadGuideView];
        return YES;
    }else{
        NSLog(@"有");
        [self xgjWidow];
        return YES;
    }
}
- (void)xgjWidow
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSString *name = [userDefault objectForKey:@"name"];
    NSString *userID = [userDefault objectForKey:@"user_id"];
//    NSLog(@"进入__user_id-%@___user_token--%@",userID,USER_TOKEN(QQQQ));
    if (userID == nil ||userID == NULL) {
        [NSThread detachNewThreadSelector:@selector(umeng) toTarget:self withObject:nil];
        
        XMMViewController *xmm = [[XMMViewController alloc] init];
        self.window.rootViewController = xmm;
        [self.window makeKeyAndVisible];
    }
    else if (userID != nil && [BoolViewController alloc].connectedToNetwork)
    {
//        NSLog(@"name%@--userid%@___user_token--%@",name,userID,USER_TOKEN(QQQQ));

        ViewController *VC = [[ViewController alloc] init];

        OrderViewController *orderVC = [[OrderViewController alloc] init];
        
        PersonalLanding *personal = [[PersonalLanding alloc] init];
        
        [NSThread detachNewThreadSelector:@selector(umeng) toTarget:self withObject:nil];
        
        UINavigationController *VCNav = [[UINavigationController alloc] initWithRootViewController:VC];
        UINavigationController *orderNav = [[UINavigationController alloc] initWithRootViewController:orderVC];
        UINavigationController *personalNav = [[UINavigationController alloc] initWithRootViewController:personal];
        NSArray *navArray = [[NSArray alloc] initWithObjects:VCNav,orderNav,personalNav, nil];
        
        NSMutableDictionary *imageHomes = [NSMutableDictionary dictionaryWithCapacity:3];
        NSMutableDictionary *imageOrders = [NSMutableDictionary dictionaryWithCapacity:3];
        NSMutableDictionary *imageMys = [NSMutableDictionary dictionaryWithCapacity:3];
        
        if (iPhone6Plus) {
            //6+
            [imageHomes setObject:[UIImage imageNamed:@"home_icon.png"] forKey:@"Default"];
            [imageHomes setObject:[UIImage imageNamed:@"home_iconhover.png"] forKey:@"Highlighted"];
            [imageHomes setObject:[UIImage imageNamed:@"home_iconhover.png"] forKey:@"Seleted"];
           
            [imageOrders setObject:[UIImage imageNamed:@"order_icon.png"] forKey:@"Default"];
            [imageOrders setObject:[UIImage imageNamed:@"order_iconhover.png"] forKey:@"Highlighted"];
            [imageOrders setObject:[UIImage imageNamed:@"order_iconhover.png"] forKey:@"Seleted"];
            
            [imageMys setObject:[UIImage imageNamed:@"my_icon.png"] forKey:@"Default"];
            [imageMys setObject:[UIImage imageNamed:@"my_iconhover.png"] forKey:@"Highlighted"];
            [imageMys setObject:[UIImage imageNamed:@"my_iconhover.png"] forKey:@"Seleted"];
        }else{
            
            [imageHomes setObject:[UIImage imageNamed:@"home.png"] forKey:@"Default"];
            [imageHomes setObject:[UIImage imageNamed:@"homehover.png"] forKey:@"Highlighted"];
            [imageHomes setObject:[UIImage imageNamed:@"homehover.png"] forKey:@"Seleted"];
            
            [imageOrders setObject:[UIImage imageNamed:@"订单.png"] forKey:@"Default"];
            [imageOrders setObject:[UIImage imageNamed:@"订单hover.png"] forKey:@"Highlighted"];
            [imageOrders setObject:[UIImage imageNamed:@"订单hover.png"] forKey:@"Seleted"];
            
            [imageMys setObject:[UIImage imageNamed:@"my.png"] forKey:@"Default"];
            [imageMys setObject:[UIImage imageNamed:@"myhover.png"] forKey:@"Highlighted"];
            [imageMys setObject:[UIImage imageNamed:@"myhover.png"] forKey:@"Seleted"];
        }
        
        NSArray *imageArray = [NSArray arrayWithObjects:imageHomes,imageOrders,imageMys, nil];
        
        _leveyTabBarController = [[LeveyTabBarController alloc] initWithViewControllers:navArray imageArray:imageArray];
        [_leveyTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"navBg.png"]];
        [_leveyTabBarController setTabBarTransparent:YES];
        
        [self.window setRootViewController:_leveyTabBarController];
        [self.window makeKeyAndVisible];
        
    }else {
        
        [NSThread detachNewThreadSelector:@selector(umeng) toTarget:self withObject:nil];
        XMMViewController *xmm = [[XMMViewController alloc] init];
        self.window.rootViewController = xmm;
        [self.window makeKeyAndVisible];
    }
}

#pragma  mark - 友盟
- (void)umeng
{

    //设置友盟社会化组件APPKEY
    [UMSocialData setAppKey:UMENG_APP_KEY];
    
    //打开调试log的开关
    //        [UMSocialData openLog:YES];
    //设置分享平台
    [UMSocialConfig setSnsPlatformNames:@[UMShareToSina,UMShareToQzone,UMShareToTencent]];
    
    //    //设置支持没有客户端情况下使用SSO授权
    
    [UMSocialQQHandler setQQWithAppId:QQ_APP_ID appKey:QQ_APP_KEY url:@"http://www.xiongguanjia.cn/download/"];
    [UMSocialQQHandler setSupportWebView:YES];
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:WEIXIN_APP_ID appSecret:WEIXIN_SECRET url:[self xiongmamiFenXiangURL]];
    //打开新浪微博的SSO开关
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://open.weibo.com/apps/"];//[NSString
}

#pragma -mark tabBar
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[ViewController class]])
    {
        [_leveyTabBarController hidesTabBar:NO animated:YES];
    }
    NSLog(@"-----");
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    // 支付宝支付
//    NSLog(@"scheme = %@", [url scheme]);
    if ([[url scheme] isEqualToString:@"xiongmami"] == YES)
    {
        if ([url.host isEqualToString:@"safepay"]) {
            [[AlipaySDK defaultService]
             processOrderWithPaymentResult:url
             standbyCallback:^(NSDictionary *resultDic) {
             }];
        }
        NSLog(@"支付宝-0");
        [self.leveyTabBarController hidesTabBar:YES animated:NO];
        [[[[UIApplication sharedApplication] windows] objectAtIndex:0] setHidden:YES];
    }
    return [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}
- (NSString *)xiongmamiFenXiangURL
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *user_id = [userDefault objectForKey:@"user_id"];
    NSLog(@"user_id==%@",user_id);
    if (user_id == nil || user_id == NULL || [BoolViewController isNOTNull:user_id] == NO) {
        user_id = @"0";
    }
    NSMutableDictionary *diccct = [[NSMutableDictionary alloc] init];
    [diccct setValue:user_id forKey:@"user_id"];
    [diccct setValue:@"3" forKey:@"platform"];

    NSDictionary *dic =[PersonalRequest NOTokenWithAllUrll:@"/index.php?s=/Api/Other/getshare" WithDic:diccct];
    
    NSDictionary *array = [dic valueForKey:@"data"];
    NSLog(@"share=%@",dic);
    if ([[dic valueForKey:@"data"] isKindOfClass:[NSNull class]] ==YES) {
        NSLog(@"\n\n\n\no.o");
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:@"熊管家，在线洗衣，免费取送！下载戳→" forKey:@"content"];
        [userDefault setObject:@"http://www.xiongguanjia.cn/download/" forKey:@"link"];
        return @"http://www.xiongguanjia.cn/download/";
    }else{
        NSString *dicData = [array valueForKey:@"content"];
        NSString *str = [array valueForKey:@"link"];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:@"熊管家，在线洗衣，免费取送！下载戳→" forKey:@"content"];
        [userDefault setObject:@"http://www.xiongguanjia.cn/download/" forKey:@"link"];
        NSLog(@"===%@---%@",dicData,str);
        return str;
    }
}

#pragma  mark - 支付宝支付
//独立客户端回调函数
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {  //***123 1
    // 支付宝支付
//    NSLog(@"scheme = %@", [url scheme]);
    if ([[url scheme] isEqualToString:@"xiongmami"] == YES)
    {
//        [[PaymentViewController alloc] parse:url application:application];
        if ([url.host isEqualToString:@"safepay"]) {
            
            [[AlipaySDK defaultService] processAuth_V2Result:url
                                             standbyCallback:^(NSDictionary *resultDic) {
//                                                 NSLog(@"resultqweewq = %@",resultDic);
//                                                 NSString *resultStr = resultDic[@"result"];
//                                                 NSLog(@"---%@",resultStr);
                                             }];
        }
        NSLog(@"支付宝-1-");
        [[[[UIApplication sharedApplication] windows] objectAtIndex:0] setHidden:YES];
    }
    return [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

#pragma  mark - 引导页

-(void)loadGuideView
{
    pageC=[[UIPageControl alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 60, VIEW_FRAME_SIZE_WIDTH, 20)];
    pageC.numberOfPages=3.;
    pageC.currentPage=0.;
    pageC.backgroundColor=[UIColor clearColor];
    
//    NSLog(@"当前屏幕大小-%f-%f---%f",VIEW_FRAME_SIZE_WIDTH,VIEW_FRAME_SIZE_HEIGHT,[[[UIDevice currentDevice] systemVersion] floatValue]);
    
    dyScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT)];
    dyScrollView.delegate=self;
    dyScrollView.backgroundColor=[UIColor greenColor];
    dyScrollView.contentSize=CGSizeMake(VIEW_FRAME_SIZE_WIDTH*4, VIEW_FRAME_SIZE_HEIGHT);
    dyScrollView.showsVerticalScrollIndicator=NO;
    dyScrollView.pagingEnabled=YES;
    dyScrollView.bounces=NO;       //取消弹性
    NSArray *array=@[@"引导页1.png",@"引导页2.png",@"引导页3.png",@"引导页4.png"];
    dyScrollView.showsHorizontalScrollIndicator=NO;
    [self.window addSubview:dyScrollView ];
    [self.window addSubview:pageC];
    for (NSInteger i=0; i<4; i++)
    {
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(i*VIEW_FRAME_SIZE_WIDTH, 0, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT)];
        imgView.image=[UIImage imageNamed:[array objectAtIndex:i]];
        
        [dyScrollView addSubview:imgView];
        
        if (i==3)
        {
            [imgView setUserInteractionEnabled:YES];
            UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame=CGRectMake((VIEW_FRAME_SIZE_WIDTH-382/2)/2, [UIScreen mainScreen].bounds.size.height - 60, 382/2, 72/2);
//            [button setTitle:@"立即体验" forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"tybtn.png"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
            [imgView addSubview:button];
            if (iPhone6Plus){
//                640 90
                button.frame=CGRectMake((VIEW_FRAME_SIZE_WIDTH - 320)/2, [UIScreen mainScreen].bounds.size.height - 75, 640/2, 90/2);
            }
        }
    }
}

- (void)hideView
{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    dyScrollView.alpha = 0;
    pageC.alpha = 0;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(stopAnimation)];
    [UIView commitAnimations];
  
}

- (void)stopAnimation
{
    [dyScrollView removeFromSuperview];
    [pageC removeFromSuperview];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [pageC setCurrentPage:offset.x / bounds.size.width];
    if (offset.x / bounds.size.width == 3.000000) {
        pageC.alpha = 0;
    }else{
        pageC.alpha = 1;
    }
}

#pragma  mark - PUSH
- (void)PUSH:(NSDictionary *)launchOptions
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    if ([launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]!=nil) {
        //获取应用程序消息通知标记数（即小红圈中的数字）
        int badge =(int) [UIApplication sharedApplication].applicationIconBadgeNumber;
        if (badge>0) {
            //如果应用程序消息通知标记数（即小红圈中的数字）大于0，清除标记。
            badge --;
            //清除标记。清除小红圈中数字，小红圈中数字为0，小红圈才会消除。
            [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
        }
    }
    ///应用程序不处在后台，并且是通过推送打开应用的时候
    if (launchOptions) {
        ///获取到推送相关的信息
        NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        //        [self performSelector:@selector(handleRemoteNotification:) withObject:userInfo];
        NSLog(@"---------------------------------%@",userInfo);
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //注册推送通知
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                             settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                             categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }else{
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeAlert|
          UIRemoteNotificationTypeBadge|
          UIRemoteNotificationTypeSound)];
    }
    
    [self performSelector:@selector(onInit)];
}
//tuisong
///Token值成功获取的时候走的是这个方法（Token值不能带空格）
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *des = [deviceToken description];
    des = [des stringByReplacingOccurrencesOfString:@"<" withString:@""];
    des = [des stringByReplacingOccurrencesOfString:@">" withString:@""];
    des = [des stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    [CommonTools setDeviceToken:des];
    
    [self performSelector:@selector(onReturnDeviceToken:errorMessage:) withObject:des withObject:nil];
//    NSLog(@"des:  %@",des);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
//    NSLog(@"userInfo == %@",userInfo);
    NSString *message = [[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
//    NSString *string_Push = [message substringWithRange:NSMakeRange(0, 3)];
//    NSLog(@"message-\n%@",message);
//    //语音提示
//    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:message];
//    //设置语言类别（不能被识别，返回值为nil）
//    AVSpeechSynthesisVoice *voiceType = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-TW"];
//    utterance.voice = voiceType;
//    //设置语速快慢
//    utterance.rate *= 0.3;
//    //语音合成器会生成音频
//    [self.synthesizer speakUtterance:utterance];
    NSString *_c = [message substringWithRange:NSMakeRange(0, 3)];
    NSString *_d = [message substringWithRange:NSMakeRange(0, 2)];
//    NSLog(@"\n1________%@",_c);
    if ([_c rangeOfString:@"闪电熊"].location != NSNotFound) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
//        [alert show];
//        NSLog(@"\n2________%@",_c);
    }else if([_d rangeOfString:@"熊宝"].location != NSNotFound){
        NSString *_a = [message substringWithRange:NSMakeRange(7, 21)];
        NSString *_b = [message substringWithRange:NSMakeRange(29, 19)];
//        NSLog(@"\n3________%@\n________%@\n________%@",_a,_b,_c);
//        _alert_Push = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"去评价" otherButtonTitles:@"取消", nil];
//        [_alert_Push show];
        CommentViewController *com = [[CommentViewController alloc] init];
        com.numberText = _a;
        com.orderOverTime = _b;
        [self.window.rootViewController presentViewController:com animated:NO completion:nil];
    }
}
- (void)onInit{
}
///Token值获取失败的时候走的是这个方法
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [self performSelector:@selector(onReturnDeviceToken:errorMessage:) withObject:nil withObject:error];
    NSLog(@"%@",error);
}

- (void)onMessage:(NSString *)channelId userId:(NSString *)userId inmeId:(NSString *)inmeId dataMap:(NSDictionary *)dataMap
{
//    NSLog(@"channelID-%@,userID-%@,inmeID-%@,dataMap-%@",channelId,userId,inmeId,dataMap);
}
//获取到设备token回调
- (void)onReturnDeviceToken:(NSString *)deviceToken errorMessage:(id)errorMessage
{
//    NSLog(@"deviceToken-%@,errorMessage-%@",deviceToken,errorMessage);
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *devtoken = [NSString stringWithFormat:@"%@",deviceToken];
    [userdefault setValue:devtoken forKey:@"deviceToken"];
}
#pragma  mark- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _alert_Push) {
        if (buttonIndex == 0) {
        }
    }
}
@end