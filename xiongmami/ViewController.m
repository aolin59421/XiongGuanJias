//
//  ViewController.m
//  xiongmami
//
//  Created by iMac on 14/11/18.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "Interface.h"
#import "ViewController.h"
#import "OrderViewController.h"
#import "PersonalViewController.h"
#import "ManagementAddress.h"
#import "PlaceTheOrder.h"
#import "PriceViewController.h"
#import "ActivityViewController.h"
#import "TopUp.h"
#import "OrderTracking.h"
#import "HexadecimalConversionUICOLOR.h"
#import "LeveyTabBarController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString * dengluStr = @"登录成功";
    [[YBProgressShow defaultProgress] showText:dengluStr InMode:MBProgressHUDModeDeterminate OriginViewEnableTouch:YES HideAfterDelayTime:1];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTabBarView];
    [self addCustomView];
    [self postDEVToken];
    [[BoolViewController alloc] testOut];
}

#pragma  mark - button
- (void)addCustomView
{
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT/2)];
    [_topView setBackgroundColor:[UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9]];
    [self.view addSubview:_topView];
    
    UIButton *serviceScopeViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [serviceScopeViewButton setFrame:CGRectMake(_topView.bounds.size.width - 115/1.5 - 15, 37, 115/1.5, 40/1.5)];
    [serviceScopeViewButton setBackgroundImage:[UIImage imageNamed:@"service@3x.png"] forState:UIControlStateNormal];
    [serviceScopeViewButton addTarget:self action:@selector(service) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:serviceScopeViewButton];
    //我要洗衣动画
    if (iPhone6Plus) {
        UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/2-(VIEW_FRAME_SIZE_WIDTH/1.5)/2, VIEW_FRAME_SIZE_HEIGHT/12-10, VIEW_FRAME_SIZE_WIDTH/1.5, VIEW_FRAME_SIZE_WIDTH/1.5)];
        NSArray *gifArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"button2760001.png"],
                             [UIImage imageNamed:@"button2760002.png"],
                             [UIImage imageNamed:@"button2760003.png"],
                             [UIImage imageNamed:@"button2760004.png"],
                             [UIImage imageNamed:@"button2760005.png"],
                             [UIImage imageNamed:@"button2760006.png"],
                             [UIImage imageNamed:@"button2760007.png"],
                             [UIImage imageNamed:@"button2760008.png"],
                             [UIImage imageNamed:@"button2760009.png"],
                             [UIImage imageNamed:@"button2760010.png"],
                             [UIImage imageNamed:@"button2760011.png"],
                             [UIImage imageNamed:@"button2760012.png"],
                             [UIImage imageNamed:@"button2760013.png"],
                             [UIImage imageNamed:@"button2760014.png"],
                             [UIImage imageNamed:@"button2760015.png"],
                             [UIImage imageNamed:@"button2760016.png"],
                             [UIImage imageNamed:@"button2760017.png"],
                             [UIImage imageNamed:@"button2760018.png"],
                             [UIImage imageNamed:@"button2760019.png"],
                             [UIImage imageNamed:@"button2760020.png"],
                             [UIImage imageNamed:@"button2760021.png"],
                             [UIImage imageNamed:@"button2760022.png"],
                             [UIImage imageNamed:@"button2760023.png"],nil];
        gifImageView.animationImages = gifArray; //动画图片数组
        gifImageView.animationDuration = 2.5f; //执行一次完整动画所需的时长
        gifImageView.animationRepeatCount = 0;  //动画重复次数
        [gifImageView startAnimating];
        [_topView addSubview:gifImageView];
    }else{
        UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/2-(VIEW_FRAME_SIZE_WIDTH/1.7)/2, VIEW_FRAME_SIZE_HEIGHT/8-15, VIEW_FRAME_SIZE_WIDTH/1.7, VIEW_FRAME_SIZE_WIDTH/1.7)];
        NSArray *gifArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"button1900001.png"],
                             [UIImage imageNamed:@"button1900002.png"],
                             [UIImage imageNamed:@"button1900003.png"],
                             [UIImage imageNamed:@"button1900004.png"],
                             [UIImage imageNamed:@"button1900005.png"],
                             [UIImage imageNamed:@"button1900006.png"],
                             [UIImage imageNamed:@"button1900007.png"],
                             [UIImage imageNamed:@"button1900008.png"],
                             [UIImage imageNamed:@"button1900009.png"],
                             [UIImage imageNamed:@"button1900010.png"],
                             [UIImage imageNamed:@"button1900011.png"],
                             [UIImage imageNamed:@"button1900012.png"],
                             [UIImage imageNamed:@"button1900013.png"],
                             [UIImage imageNamed:@"button1900014.png"],
                             [UIImage imageNamed:@"button1900015.png"],
                             [UIImage imageNamed:@"button1900016.png"],
                             [UIImage imageNamed:@"button1900017.png"],
                             [UIImage imageNamed:@"button1900018.png"],
                             [UIImage imageNamed:@"button1900019.png"],
                             [UIImage imageNamed:@"button1900020.png"],
                             [UIImage imageNamed:@"button1900021.png"],
                             [UIImage imageNamed:@"button1900022.png"],
                             [UIImage imageNamed:@"button1900023.png"],nil];
        gifImageView.animationImages = gifArray; //动画图片数组
        gifImageView.animationDuration = 2.5f; //执行一次完整动画所需的时长
        gifImageView.animationRepeatCount = 0;  //动画重复次数
        [gifImageView startAnimating];
        [_topView addSubview:gifImageView];
    }
    //我要洗衣按钮
    UIButton *maiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    maiButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/2-(VIEW_FRAME_SIZE_WIDTH/1.7)/2, VIEW_FRAME_SIZE_HEIGHT/8-15, VIEW_FRAME_SIZE_WIDTH/1.7, VIEW_FRAME_SIZE_WIDTH/1.7);
    [maiButton setBackgroundColor:[UIColor clearColor]];
    maiButton.layer.masksToBounds = YES;
    maiButton.layer.cornerRadius = VIEW_FRAME_SIZE_WIDTH/4;
    if (iPhone6Plus) {
        maiButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/2-(VIEW_FRAME_SIZE_WIDTH/1.5)/2, VIEW_FRAME_SIZE_HEIGHT/12-10, VIEW_FRAME_SIZE_WIDTH/1.5, VIEW_FRAME_SIZE_WIDTH/1.5);
        maiButton.layer.cornerRadius = VIEW_FRAME_SIZE_WIDTH/3;
    }
    [maiButton addTarget:self action:@selector(lll) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:maiButton];
    
    //动画字幕
    _lab = [[LampLightTest alloc] initWithFrame:CGRectMake(30,VIEW_FRAME_SIZE_HEIGHT/2 - 18-15, VIEW_FRAME_SIZE_WIDTH - 30, 30)];
    
    _lab.numberOfLines = 1;
    [_lab setFont:[UIFont systemFontOfSize:15]];
    //获取活动信息
     _actArray = [PersonalRequest withRunAndRun];
    
    if ([_actArray count] == 0) {
        _lab.text =@" 欢迎小主,新活动敬请期待～";
    }else{
        _lab.text = [[_actArray objectAtIndex:0] valueForKey:@"title"];
    }
    
    [_lab setTextColor:[UIColor whiteColor]];
    [_topView addSubview:_lab];

    _imageViews = [[UIImageView alloc] initWithFrame:CGRectMake(10, (VIEW_FRAME_SIZE_HEIGHT/2)-28, 20, 20)];
    [_imageViews setImage:[UIImage imageNamed:@"news.png"]];
    [_topView addSubview:_imageViews];

    if ([_actArray count] > 1) {
        //动画定时器
        _lab.frame = CGRectMake(30,VIEW_FRAME_SIZE_HEIGHT/2 - 18, VIEW_FRAME_SIZE_WIDTH - 30, 30);
        _time =  [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timeAnimation:) userInfo:nil repeats:YES];
    }
    
    //字幕链接按钮
    UIButton *labButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [labButton setFrame:CGRectMake(0,VIEW_FRAME_SIZE_HEIGHT/2 - 28, VIEW_FRAME_SIZE_WIDTH, 30)];
    labButton.backgroundColor = [UIColor clearColor];
    [labButton addTarget:self action:@selector(pushActivity) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:labButton];

    if (iPhone6Plus) {
        [serviceScopeViewButton setFrame:CGRectMake(_topView.bounds.size.width - 115/1.5 - 15, 37, 115/1.5, 40/1.5)];
    }
}
#pragma  mark - 动画
- (void)timeAnimation:(BOOL)animation
{
    //动画
    [_lab sizeToFit];
    CGRect frame = _lab.frame;
    
    frame.origin.y =(VIEW_FRAME_SIZE_HEIGHT/2);
    
    frame.origin.x =30;
    static int i = 0;
    
    _lab.frame = frame;
    _lab.alpha =0;
    _lab.alpha =0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:1];
    i++;

    if ([_actArray count] == 0) {
        _lab.text =@"欢迎小主～";
    }else{
        if (i == [_actArray count]) {
            i=0;
        }
        _lab.text = [[_actArray objectAtIndex:i] valueForKey:@"title"];
//        NSLog(@"lab--%@",[[_actArray objectAtIndex:i] valueForKey:@"title"]);
    }
    
    frame = _lab.frame;
    frame.size.width = VIEW_FRAME_SIZE_WIDTH - 30;
    frame.origin.x = 30;

    frame.origin.y = (VIEW_FRAME_SIZE_HEIGHT/2) - _lab.frame.size.height -10;
    _lab.frame = frame;
    
    _lab.alpha = 1;
    [UIView commitAnimations];
    [self animationFrame];
}

- (void)animationFrame
{
    CGRect frame = _lab.frame;
    frame.origin.y = (VIEW_FRAME_SIZE_HEIGHT/2) - _lab.frame.size.height -10;
    
    _lab.frame = frame;
    _imageViews.alpha =1;
    _lab.alpha =1;
}

- (void)lll
{
    NewPlaceTheOrderViewController *place = [[NewPlaceTheOrderViewController alloc] init];
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
    [self.navigationController pushViewController:place animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [NSThread detachNewThreadSelector:@selector(paomadeng) toTarget:self withObject:nil];
    [self.leveyTabBarController hidesTabBar:NO animated:NO];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)paomadeng
{
    _actArray = [PersonalRequest withRunAndRun];
}
- (void)viewDidAppear:(BOOL)animated
{
    //开启定时器
    [_time setFireDate:[NSDate distantPast]];
}

#pragma  mark - tabBar
- (void)addTabBarView
{
    UIView *underView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_FRAME_SIZE_HEIGHT/2, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT/2)];
    underView.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < 4; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.frame = CGRectMake(19+i%2*(VIEW_FRAME_SIZE_WIDTH*0.9/2+5), 15+i/2*(VIEW_FRAME_SIZE_HEIGHT/2*0.8/2-5), VIEW_FRAME_SIZE_WIDTH*0.9/2-10, VIEW_FRAME_SIZE_HEIGHT/2*0.8/2-20);
        if (iPhone6Plus) {
            button.frame = CGRectMake(25+i%2*(VIEW_FRAME_SIZE_WIDTH*0.9/2+5), 15+i/2*(VIEW_FRAME_SIZE_HEIGHT/2*0.8/2-5), VIEW_FRAME_SIZE_WIDTH*0.9/2-10, VIEW_FRAME_SIZE_HEIGHT/2*0.8/2-20);
        }
        switch (i) {
                
            case 0:{
                [button setImage:[UIImage imageNamed:@"价格表.png"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(pushPrice) forControlEvents:UIControlEventTouchUpInside];
                break;
            }
            case 1:
            {
                [button setImage:[UIImage imageNamed:@"订单跟踪.png"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(pushOrderView) forControlEvents:UIControlEventTouchUpInside];
                break;
            }
            case 2:
            {
                [button setImage:[UIImage imageNamed:@"活动商城.png"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(pushActivity) forControlEvents:UIControlEventTouchUpInside];
                break;
            }
            case 3:
            {
                [button setImage:[UIImage imageNamed:@"快速充值.png"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(pushRechargeButton) forControlEvents:UIControlEventTouchUpInside];
                break;
            }
            default:
                break;
        }
        [underView addSubview:button];
    }
    [self.view addSubview:underView];
}

#pragma  mark - 提交设备token值
- (void)postDEVToken
{
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    [mDic setValue:USER_ID(QQQQ) forKey:@"user_id"];
    [mDic setValue:USER_DEVTOKEN(QQQQ) forKey:@"token"];
    
    [PerAFNetBlockRequest AFNRequest:@"/index.php?s=/Api/Apns/setinfo" dic:mDic AFNBlock:^(NSDictionary *resp, NSStringEncoding encoding) {
//        NSLog(@"Token-resp-\n%@",resp);
//        NSString *asd = [resp valueForKey:@"data"];
//        NSLog(@"asd\n\n%@\n\n\n\n\n\n%@",USER_DEVTOKEN(QQQQ),asd);
    } AFNEror:^(NSError *error) {
        NSLog(@"error");
    }];
    //版本
    NSString *version = [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
    //设备型号
    NSString * strModel  = [HexadecimalConversionUICOLOR deviceVersion];
    //系统版本
    NSString * iosxt = [[UIDevice currentDevice] systemVersion];
    NSLog(@"-版本-%@-设备型号-%@-系统版本-%@",version,strModel,iosxt);
}

#pragma mark - 订单追踪
- (void)pushOrderView
{
    [self.leveyTabBarController setSelectedIndex:1];
//    NSLog(@"订单追踪");
}

#pragma  mark - 快速充值
- (void)pushRechargeButton
{
//    NSLog(@"快速充值");
    TopUp *topUp = [[TopUp alloc] init];
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
    [self.navigationController pushViewController:topUp animated:YES];
}

#pragma  mark - 价目
- (void)pushPrice
{
    PriceViewController *priceVC =[[PriceViewController alloc] init];
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
    [self.navigationController pushViewController:priceVC animated:YES];
//    NSLog(@"价目");
}

#pragma  mark - 活动链接
- (void)pushNewActivity
{
    NewActivityViewController *newActivity = [[NewActivityViewController alloc] init];
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
    [self.navigationController pushViewController:newActivity animated:YES];
}

#pragma  mark - 活动商城
- (void)pushActivity
{
    ActViewController *act = [[ActViewController alloc] init];
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
    [self.navigationController pushViewController:act animated:YES];
}

#pragma  mark - 服务范围
- (void)service
{
    ServiceScopeViewController *service = [[ServiceScopeViewController alloc] init];
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
    [self.navigationController pushViewController:service animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
//    NSLog(@"viewDiDisAppear");
    //关闭定时器
    [_time setFireDate:[NSDate distantFuture]];
}
- (void)pushCom:(NSString *)num with:(NSString *)time
{
    CommentViewController *com = [[CommentViewController alloc] init];
    com.numberText = num;
    com.orderOverTime = time;
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
    [self.navigationController presentViewController:com animated:NO completion:nil];
}
@end
