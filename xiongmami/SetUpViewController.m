//
//  SetUpViewController.m
//  xiongmami
//
//  Created by iMac on 14/11/24.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "SetUpViewController.h"
#import "ChangePasswordViewController.h"
#import "KLSwitch.h"
#import "YJFKViewController.h"
#import "AboutViewController.h"
#import "HexadecimalConversionUICOLOR.h"
#import "XMMViewController.h"

#define kTagShareEdit 101
#define kTagSharePost 102

@interface SetUpViewController ()<UIAlertViewDelegate,UIActionSheetDelegate,UMSocialUIDelegate>

@end

@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustom];
    self.view.backgroundColor = [UIColor colorWithRed:246/255.0f green:240/255.0f blue:236/255.0f alpha:1];
    self.title = @"设置";
    [self addZaXiangView];
    [self aboutView];
    [self getUp];
    self.synthesizer = [[AVSpeechSynthesizer alloc] init];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(bback)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)bback
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];

}
#pragma  mark - 修改密码
- (void)addCustom
{
    UIView *setUpView =[[UIView alloc] initWithFrame:CGRectMake(0, 75, VIEW_FRAME_SIZE_WIDTH, 44)];
    setUpView.backgroundColor = [UIColor whiteColor];
    setUpView.layer.borderWidth = 1;
    setUpView.layer.borderColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#edecec"].CGColor;
    
    UILabel * setUpab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 0, 100, 44)];
    setUpab.text = @"修改密码";
    [setUpab setTextAlignment:NSTextAlignmentLeft];
    [setUpView addSubview:setUpab];
    
    UIImageView * setUpButtonImage = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 14, 10, 20)];
    [setUpButtonImage setImage:[UIImage imageNamed:@"箭头@3x.png"]];
    [setUpView addSubview:setUpButtonImage];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 44);
//    [button setBackgroundColor:[UIColor clearColor]];
    [button setAlpha:0.6];
    [button setBackgroundImage:[UIImage imageNamed:@"dianji.png"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(zaxiangButton) forControlEvents:UIControlEventTouchUpInside];
    [setUpView addSubview:button];
    
    //判断是否第三方登录隐藏修改密码
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults valueForKey:@"_Flag"] == nil) {
        [self.view addSubview:setUpView];
    }
    //6plus 适配
    if (iPhone6Plus) {
        
        setUpView.frame = CGRectMake(0, 75, VIEW_FRAME_SIZE_WIDTH, 55);
        setUpab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 10, 100, 40);
        setUpButtonImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 20, 10, 20);
        
        button.frame = CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 55);
    }else if (iPhone6) {
        
        setUpView.frame = CGRectMake(0, 75, VIEW_FRAME_SIZE_WIDTH, 50);
        
        setUpab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 6, 100, 40);
        
        setUpButtonImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 18, 10, 20);
        
        button.frame = CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 50);
    }
}

#pragma  mark - 杂项
- (void)addZaXiangView
{
    UIView *setUpView =[[UIView alloc] initWithFrame:CGRectMake(0, 130, VIEW_FRAME_SIZE_WIDTH, 132)];
    setUpView.backgroundColor = [UIColor whiteColor];
    setUpView.layer.borderWidth = 1;
    setUpView.layer.borderColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#edecec"].CGColor;
    [self.view addSubview:setUpView];
    
    //判断是否第三方登录隐藏修改密码
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults valueForKey:@"_Flag"] != nil) {
        setUpView.frame = CGRectMake(0, 75, VIEW_FRAME_SIZE_WIDTH, 132);
    }else{
        
    }
    
    UILabel *lalab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/40, 88, VIEW_FRAME_SIZE_WIDTH*0.95, 0.5)];
    lalab.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#f0f3f5"];
    [setUpView addSubview:lalab];
    
    UILabel *lalab1 = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/40, 44, VIEW_FRAME_SIZE_WIDTH*0.95, 0.5)];
    lalab1.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#f0f3f5"];
    [setUpView addSubview:lalab1];
    
//    消息推送
    UILabel * xxts = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 10, 100, 30)];
    xxts.text = @"消息推送";
    [xxts setTextAlignment:NSTextAlignmentLeft];
    [setUpView addSubview:xxts];
    
    KLSwitch *switchButton = [[KLSwitch alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 10, 50, 25)];
    [switchButton setOn:YES];
    [switchButton setOnTintColor:[UIColor orangeColor]];
    [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [setUpView addSubview:switchButton];
    
    //分享
    UILabel * xgmm = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 44, 100, 44)];//45
    xgmm.text = @"分享";
    [xgmm setTextAlignment:NSTextAlignmentLeft];
    [setUpView addSubview:xgmm];
    
    UIImageView * xgmmImage = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 58, 10, 20)];//50
    [xgmmImage setImage:[UIImage imageNamed:@"箭头@3x.png"]];
    [setUpView addSubview:xgmmImage];
    
    UIButton *xgmmbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    xgmmbutton.frame = CGRectMake(0, 44, VIEW_FRAME_SIZE_WIDTH, 44);//45
//    [xgmmbutton setBackgroundColor:[UIColor clearColor]];
    [xgmmbutton setAlpha:0.6];
    [xgmmbutton setBackgroundImage:[UIImage imageNamed:@"dianji.png"] forState:UIControlStateHighlighted];
    [xgmmbutton addTarget:self action:@selector(fenxiang) forControlEvents:UIControlEventTouchUpInside];
    [setUpView addSubview:xgmmbutton];
    
    //意见反馈
    UILabel * yjfk = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 88, 100, 44)];//85
    yjfk.text = @"意见反馈";
    [yjfk setTextAlignment:NSTextAlignmentLeft];
    [setUpView addSubview:yjfk];
    
    UIImageView * yjfkImage = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 100, 10, 20)];//90
    [yjfkImage setImage:[UIImage imageNamed:@"箭头@3x.png"]];
    [setUpView addSubview:yjfkImage];
    
    UIButton *yjfkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    yjfkButton.frame = CGRectMake(0, 88, VIEW_FRAME_SIZE_WIDTH, 44);//85
//    [yjfkButton setBackgroundColor:[UIColor clearColor]];
    [yjfkButton setAlpha:0.6];
    [yjfkButton setBackgroundImage:[UIImage imageNamed:@"dianji.png"] forState:UIControlStateHighlighted];
    [yjfkButton addTarget:self action:@selector(pushYJFK) forControlEvents:UIControlEventTouchUpInside];
    [setUpView addSubview:yjfkButton];
    
    if (iPhone6Plus) {
        setUpView.frame =CGRectMake(0, 145, VIEW_FRAME_SIZE_WIDTH, 55*3);
        //判断是否第三方登录隐藏修改密码
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([userDefaults valueForKey:@"_Flag"] != nil) {
            setUpView.frame =CGRectMake(0, 75, VIEW_FRAME_SIZE_WIDTH, 55*3);
        }else{
            
        }
        
        lalab1.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/40, 110, VIEW_FRAME_SIZE_WIDTH*0.95, 0.5);
        xxts.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 10, 100, 40);
        switchButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 15, 50, 25);
        
        lalab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/40, 55, VIEW_FRAME_SIZE_WIDTH*0.95, 0.5);
        
        xgmm.frame =CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 65, 100, 40);
        xgmmImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 75, 10, 20);
        xgmmbutton.frame = CGRectMake(0, 55, VIEW_FRAME_SIZE_WIDTH, 55);
        
        yjfk.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 118, 100, 40);
        yjfkImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 130, 10, 20);
        yjfkButton.frame = CGRectMake(0, 110, VIEW_FRAME_SIZE_WIDTH, 55);
    }else if (iPhone6){
        
        setUpView.frame =CGRectMake(0, 133, VIEW_FRAME_SIZE_WIDTH, 50*3);
        //判断是否第三方登录隐藏修改密码
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([userDefaults valueForKey:@"_Flag"] != nil) {
            setUpView.frame =CGRectMake(0, 75, VIEW_FRAME_SIZE_WIDTH, 50*3);
        }else{
            
        }
        
        lalab1.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/40, 100, VIEW_FRAME_SIZE_WIDTH*0.95, 0.5);
        xxts.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 8, 100, 40);
        switchButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 13, 50, 25);
        
        lalab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/40, 48, VIEW_FRAME_SIZE_WIDTH*0.95, 0.5);
        
        xgmm.frame =CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 58, 100, 40);
        xgmmImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 68, 10, 20);
        xgmmbutton.frame = CGRectMake(0, 50, VIEW_FRAME_SIZE_WIDTH, 50);
        
        yjfk.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 100, 100, 40);
        yjfkImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 116, 10, 20);
        yjfkButton.frame = CGRectMake(0, 100, VIEW_FRAME_SIZE_WIDTH, 50);
    }
}

#pragma mark - 消息推送
- (void)switchAction:(UISwitch *)sender
{
    BOOL isButtonOn = [sender isOn];
    if (isButtonOn) {
//        NSLog(@"yes");
        [self pushswitch:@"1"];
    }else {
//        NSLog(@"no");
        [self pushswitch:@"0"];
    }
}

#pragma  mark - 关于
- (void)aboutView
{
    UIView *setUpView =[[UIView alloc] initWithFrame:CGRectMake(0, 274, VIEW_FRAME_SIZE_WIDTH, 44)];//300
    setUpView.backgroundColor = [UIColor whiteColor];
    setUpView.layer.borderWidth = 1;
    setUpView.layer.borderColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#edecec"].CGColor;
    [self.view addSubview:setUpView];
    
    //判断是否第三方登录隐藏修改密码
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults valueForKey:@"_Flag"] != nil) {
        setUpView.frame =CGRectMake(0, 219, VIEW_FRAME_SIZE_WIDTH, 44);
    }else{
        
    }
    
    UILabel * setUpab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 0, 100, 44)];
    setUpab.text = @"关于";
    [setUpab setTextAlignment:NSTextAlignmentLeft];
    [setUpView addSubview:setUpab];
    
    UIImageView * setUpButtonImage = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 14, 10, 20)];
    [setUpButtonImage setImage:[UIImage imageNamed:@"箭头@3x.png"]];
    [setUpView addSubview:setUpButtonImage];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 44);
//    [button setBackgroundColor:[UIColor clearColor]];
    [button setAlpha:0.5];
    [button setBackgroundImage:[UIImage imageNamed:@"dianji.png"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(pushGY) forControlEvents:UIControlEventTouchUpInside];
    [setUpView addSubview:button];
    
    if (iPhone6Plus) {
        setUpView.frame = CGRectMake(0, 325, VIEW_FRAME_SIZE_WIDTH, 55);
        
        //判断是否第三方登录隐藏修改密码
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([userDefaults valueForKey:@"_Flag"] != nil) {
            setUpView.frame =CGRectMake(0, 250, VIEW_FRAME_SIZE_WIDTH, 55);
        }
        
        setUpab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 10, 100, 40);
        
        setUpButtonImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 30, 20, 10, 20);
        
        button.frame = CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 55);
    }else if (iPhone6) {
        
        setUpView.frame = CGRectMake(0, 294, VIEW_FRAME_SIZE_WIDTH, 50);
        
        //判断是否第三方登录隐藏修改密码
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([userDefaults valueForKey:@"_Flag"] != nil) {
            setUpView.frame =CGRectMake(0, 234, VIEW_FRAME_SIZE_WIDTH, 50);
        }
        
        setUpab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 6, 100, 40);
        
        setUpButtonImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 30, 18, 10, 20);
        
        button.frame = CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 50);
    }
}

#pragma  mark - Push修改密码
- (void)zaxiangButton
{
    ChangePasswordViewController *changePassWord = [[ChangePasswordViewController alloc] init];
    [self.navigationController pushViewController:changePassWord animated:YES];
}

#pragma  mark - push意见反馈
- (void)pushYJFK
{
    YJFKViewController *yjfk = [[YJFKViewController alloc] init];
    [self.navigationController pushViewController:yjfk animated:YES];
}

#pragma  mark - push关于
- (void)pushGY
{
    AboutViewController *about = [[AboutViewController alloc] init];
    [self.navigationController pushViewController:about animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mrak - 退出登录
- (void)getUp
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 350, VIEW_FRAME_SIZE_WIDTH, 44);//360
    
    //判断是否第三方登录隐藏修改密码
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults valueForKey:@"_Flag"] != nil) {
        button.frame = CGRectMake(0, 295, VIEW_FRAME_SIZE_WIDTH, 44);    }
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setBackgroundImage:[UIImage imageNamed:@"dianji.png"] forState:UIControlStateHighlighted];
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:20]];
    button.layer.borderWidth = 1;
    button.layer.borderColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#edecec"].CGColor;
    [button addTarget:self action:@selector(tuichu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    if (iPhone6Plus) {
        
        button.frame = CGRectMake(0, 400, VIEW_FRAME_SIZE_WIDTH, 55);
        //判断是否第三方登录隐藏修改密码
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([userDefaults valueForKey:@"_Flag"] != nil) {
            button.frame = CGRectMake(0, 355, VIEW_FRAME_SIZE_WIDTH, 55);
        }
    }else if (iPhone6){
        button.frame = CGRectMake(0, 374, VIEW_FRAME_SIZE_WIDTH, 50);
        //判断是否第三方登录隐藏修改密码
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([userDefaults valueForKey:@"_Flag"] != nil) {
            button.frame = CGRectMake(0, 335, VIEW_FRAME_SIZE_WIDTH, 50);
        }
    }
}

- (void)tuichu
{
    NSString *message = @"真的要退出么？";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    
    [alert show];
}

#pragma  mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        
        [ud removeObjectForKey:@"name"];
        [ud removeObjectForKey:@"user_id"];
        [ud removeObjectForKey:@"skey"];
        [ud removeObjectForKey:@"_Flag"];
        [ud removeObjectForKey:@"link"];
        [ud removeObjectForKey:@"content"];
        [ud synchronize];
        XMMViewController *xmmVC = [[XMMViewController alloc] init];

        [self presentViewController:xmmVC animated:YES completion:nil];
    }else if(buttonIndex == 1){
//        NSLog(@"取消");
    }
}

#pragma  mark - 分享
- (void)fenxiang
{
//    UIActionSheet * editActionSheet = [[UIActionSheet alloc] initWithTitle:@"直接分享到微博" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
//    for (NSString *snsName in [UMSocialSnsPlatformManager sharedInstance].allSnsValuesArray) {
//        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:snsName];
//        [editActionSheet addButtonWithTitle:snsPlatform.displayName];
//        NSLog(@"displayName=%@",snsPlatform.displayName);
//    }
//    
//    [editActionSheet addButtonWithTitle:@"取消"];
//    editActionSheet.tag = kTagSharePost;
//    editActionSheet.cancelButtonIndex = editActionSheet.numberOfButtons - 1;
//    [editActionSheet showFromTabBar:self.tabBarController.tabBar];
//    editActionSheet.delegate = self;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *content = [userDefault objectForKey:@"content"];
    NSString *link = [userDefault objectForKey:@"link"];
    NSLog(@"%@%@",content,link);
    [UMSocialSnsService presentSnsIconSheetView:self appKey:UMENG_APP_KEY shareText:[NSString stringWithFormat:@"%@ %@",content,link] shareImage:[UIImage imageNamed:@"icon.png"] shareToSnsNames:nil delegate:self];
}

#pragma  mark - UIActionSheetDelegate协议的方法

/*
 在自定义分享样式中，根据点击不同的点击来处理不同的的动作
 
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex + 1 >= actionSheet.numberOfButtons ) {
        return;
    }
    //分享编辑页面的接口,snsName可以换成你想要的任意平台，例如UMShareToSina,UMShareToWechatTimeline
    NSString *snsName = [[UMSocialSnsPlatformManager sharedInstance].allSnsValuesArray objectAtIndex:buttonIndex];
    NSString *shareText = @"熊管佳分享测试。 http://www.baidu.com";
    UIImage *shareImage = [UIImage imageNamed:@"icon.png"];
    
//    [UMSocialConfig setSnsPlatformNames:@[UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline]];
    
    if (actionSheet.tag == kTagShareEdit) {
        //设置分享内容，和回调对象
        [[UMSocialControllerService defaultControllerService] setShareText:shareText shareImage:shareImage socialUIDelegate:self];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:snsName];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
    } else if (actionSheet.tag == kTagSharePost){
        
        [[UMSocialDataService defaultDataService] postSNSWithTypes:@[snsName] content:shareText image:shareImage location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity * response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"成功" message:@"分享成功" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
                [alertView show];
            } else if(response.responseCode != UMSResponseCodeCancel) {
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"分享失败" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
                [alertView show];
            }
        }];
    }
}


-(void)didFinishShareInShakeView:(UMSocialResponseEntity *)response
{
//    NSLog(@"finish share with response is %@",response);
}

-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType
{
//    NSLog(@"didClose is %d",fromViewControllerType);
}

//下面得到分享完成的回调
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
//    NSLog(@"didFinishGetUMSocialDataInViewController with response is %@",response);
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"成功" message:@"分享成功" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
        [alertView show];
        
    }else{
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"分享失败" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
        [alertView show];
    }
}

////下面可以设置根据点击不同的分享平台，设置不同的分享文字
//-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
//{
//    if ([platformName isEqualToString:UMShareToSina]) {
//        socialData.shareText = @"分享到新浪微博";
//    }
//    else{
//        socialData.shareText = @"分享内嵌文字";
//    }
//}
#pragma  mark - 设置是否推送
- (void)pushswitch:(NSString *)sw
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:sw forKey:@"status"];
    [dic setValue:USER_ID(QQQQ) forKey:@"user_id"];
    
    [PerAFNetBlockRequest AFNRequest:@"/index.php?s=/Api/Apns/setinfo" dic:dic AFNBlock:^(NSDictionary *resp, NSStringEncoding encoding) {
//        NSLog(@"开关推送\n-%@",resp);
    } AFNEror:^(NSError *error) {
        NSLog(@"error");
    }];
}

@end
