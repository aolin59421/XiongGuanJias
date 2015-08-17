//
//  ActivityViewController.m
//  xiongmami
//
//  Created by iMac on 14/11/20.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "ActivityViewController.h"
#import "HexadecimalConversionUICOLOR.h"
/////////////////////已弃用///////////////////
/////////////////////已弃用///////////////////
/////////////////////已弃用///////////////////
/////////////////////已弃用///////////////////
@implementation ActivityViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"活动详情";
    
    //    [self addTabBarView];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(fenxiang)];
    
    
    self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"share.png"];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    self.navigationItem.backBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT - 64)];
    _webView.delegate = self;
    _webView.scrollView.bounces = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:_webView];
    
    [NSThread detachNewThreadSelector:@selector(addWebView) toTarget:self withObject:nil];
//    [self addWebView];
    
    //未登录
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *userID = [userDefault objectForKey:@"user_id"];
    if (userID == nil || userID == NULL) {
        UILabel *navLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 64)];
        navLab.backgroundColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];
        [navLab setNumberOfLines:0];
        navLab.text = @"\n活动详情";
        navLab.textAlignment = NSTextAlignmentCenter;
        navLab.font = [UIFont systemFontOfSize:20];
        navLab.textColor = [UIColor whiteColor];
        [self.view addSubview:navLab];
        
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        back.frame = CGRectMake(5, 20, 44, 44);
        [back setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        [back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [back.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:back];
        
        UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
        share.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 30, 30, 37/2, 32/2);
        [share setBackgroundImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
        [share.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [share addTarget:self action:@selector(fenxiang) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:share];
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(bback)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)bback
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)share
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)addWebView
{
    
//    NSLog(@"act_id%@---url%@",_act_id,[NSString stringWithFormat:@"%@",_webUrl]);
    
    
    if (_act_id) {
        NSLog(@"ACT");
        [self getWebUrl];
        if (_act_id == nil || _act_id == NULL) {
            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.hao123.com"]]];
        }else{
            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_webUrl]]]];
        }
    }else if (_webUrl){
        NSLog(@"web");
        if (_webUrl == nil || _webUrl == NULL) {
            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.hao123.com"]]];
        }else{
            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_webUrl]]]];
        }
    }else{
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.hao123.com"]]];
    }
}


#pragma  mark - 分享
- (void)fenxiang
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *content = [userDefault objectForKey:@"content"];
    NSString *link = [userDefault objectForKey:@"link"];
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:UMENG_APP_KEY shareText:[NSString stringWithFormat:@"%@ %@",content,link] shareImage:[UIImage imageNamed:@"icon.png"] shareToSnsNames:nil delegate:self];
    /*
    UIActionSheet * editActionSheet = [[UIActionSheet alloc] initWithTitle:@"直接分享到微博" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    for (NSString *snsName in [UMSocialSnsPlatformManager sharedInstance].allSnsValuesArray) {
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:snsName];
        [editActionSheet addButtonWithTitle:snsPlatform.displayName];
        NSLog(@"displayName=%@",snsPlatform.displayName);
    }
    
    [editActionSheet addButtonWithTitle:@"取消"];
    editActionSheet.tag = kTagSharePost;
    editActionSheet.cancelButtonIndex = editActionSheet.numberOfButtons - 1;
    [editActionSheet showFromTabBar:self.tabBarController.tabBar];
    editActionSheet.delegate = self;
     */
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
//    NSLog(@"click button index is %ld",(long)buttonIndex);
    //分享编辑页面的接口,snsName可以换成你想要的任意平台，例如UMShareToSina,UMShareToWechatTimeline
    NSString *snsName = [[UMSocialSnsPlatformManager sharedInstance].allSnsValuesArray objectAtIndex:buttonIndex];
    NSString *shareText = @"熊管佳分享测试。 http://www.baidu.com";
    UIImage *shareImage = [UIImage imageNamed:@"icon"];
    
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

- (void)getWebUrl
{
    [[BoolViewController alloc] testOut];
    NSMutableDictionary * diccct = [[NSMutableDictionary alloc] init];
    [diccct setValue:_act_id forKey:@"act_id"];
//    NSLog(@"------%@-------",diccct);
//    NSDictionary *dic = [PersonalRequest withAllUrll:@"/index.php?s=/Api/Act/getinfo" WithDic:diccct];
    NSDictionary *dic =[PersonalRequest NOTokenWithAllUrll:@"/index.php?s=/Api/Act/getinfo" WithDic:diccct];
//    NSLog(@"活动详情内容-%@",dic);
    
    int status = [[dic valueForKey:@"status"] intValue];
    
    if (status == 0) {
        
        _webUrl = [[dic valueForKey:@"data"] valueForKey:@"url"];
//        NSLog(@"_____url-%@",_webUrl);
        
    }else if (status == 1){
        YBMB([dic valueForKey:@"data"])
    }
}

#pragma  mark - UIWebViewDelegate
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_HUD removeFromSuperview];
    YBMB(@"加载失败，请检查网络！")
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_HUD removeFromSuperview];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.mode = MBProgressHUDModeText;
    _HUD.labelText = @"加载中";
    [_HUD show:YES];
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



@end
