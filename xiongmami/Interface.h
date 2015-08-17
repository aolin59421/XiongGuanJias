//
//  Interface.h
//  xiongmami
//
//  Created by iMac on 14/11/18.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "Interface.h"
#ifndef xiongmami_Interface_h
#define xiongmami_Interface_h

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>
#import "sys/sysctl.h"
#import <CommonCrypto/CommonDigest.h>
// Need to import for CC_MD5 access

#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>
#import <arpa/inet.h>
#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

#import "NSDictionary+traverse.h"

#import "LeveyTabBarController.h"

#import "MJRefresh.h"

#import "LZWCustomActionSheet.h"
//#import "AFHTTPRequestOperationManager.h"

#import "BoolViewController.h"

#import "NewActivityViewController.h"

#import "HexadecimalConversionUICOLOR.h"

#import "ServiceScopeViewController.h"

#import "MBProgressHUD.h"

#import "YBProgressShow.h"

#import "JSONKit.h"

#import "GTMBase64.h"

#import "PersonalRequest.h"

#import "UMSocialControllerService.h"

#import "UMSocial.h"

#import "AppDelegate.h"

#import "ViewController.h"

#import "OrderViewController.h"

#import "PersonalLanding.h"

#import "UMSocialWechatHandler.h"

#import "UMSocialSinaHandler.h"

#import "CycleScrollView.h"

#import "ActViewController.h"

#import "CPOCycleScrollView.h"

#import "AttributedLabel.h"

#import "UMSocial.h"

#import "UMSocialQQHandler.h"

#import "UIImageView+WebCache.h"

#import "GTMBase64.h"

#import "AFNetworking.h"

#import "SVPullToRefresh.h"

#import "NewPlaceTheOrderViewController.h"

#import "XMTextViewPlaceHolder.h"

#import "PerAFNetBlockRequest.h"

#import "CommentViewController.h"

#import "ToViewCommentViewController.h"
//weixin
#import "WXApi.h"
//网络
#import "Reachability.h"
///ali
/*
#import "DataSigner.h"

#import "DataVerifier.h"

#import "AlixPayOrder.h"

#import "AlixPayResult.h"

#import "AlixLibService.h"
*/
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "PaymentViewController.h"
#import "DataSigner.h"

/////19
#import "PayPlugin.h"
#import "ONPDigest.h"
//#import "ONPQuickPayPlugin.h"
#import "ONPQuickPayPlugin.h"


#define IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 //适配>ios7.0

//判断iphone6
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iphone6+
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define VIEW_FRAME_SIZE_WIDTH  [UIScreen mainScreen].bounds.size.width //获取当前设备屏幕宽度
#define VIEW_FRAME_SIZE_HEIGHT [UIScreen mainScreen].bounds.size.height //获取当前设备屏幕高度
#define NUMBERS @"0123456789\n"

#define WEIXIN_APP_ID @"wxa2b9c6431de230bd"//微信APPID
#define WEIXIN_SECRET @"e66cd9ec4a2abfc38eca977151efbd58"//微信密匙

#define QQ_APP_ID @"1104101001"//QQAPPID
#define QQ_APP_KEY @"v7hENnFULErprw9o"//QQAPP密匙

#define WEIBO_APP_ID @"3756249921"//微博ID
#define WEIBO_APP_KEY @"466b6eaf2947b6f2555dca22acfb8658"//微博key
/***********************************************/
 //////支付宝
//#define PartnerID @"2088711424715774"//支付宝ID/
//支付宝新账号PID
#define PartnerID @"2088812267197656"//支付宝ID

//#define MD5_KEY @"y0etwyyuazqbth25k0eooojxj79ph1gh"//支付宝KEY
//支付宝新账号KEY
#define MD5_KEY @"ayjnrgvtmcjekxnc9n3bur01gqoxzfsw"//支付宝KEY

//#define AlipayPubKey       @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRA FljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQE B/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5Ksi NG9zpgmLCUYuLkxpLQIDAQAB"//支付宝公钥
////支付宝新账号公钥
#define AlipayPubKey       @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"//支付宝公钥

#define SellerID  @"89929355@qq.com"//收款支付宝账号

//支付宝新账号商户私钥
#define PartnerPrivKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAN8Q5H/uOFnJWK25x3Zf/dL8nntOiWo6WmZXICjhAiXkDGdRjApet0p47tYaRBT9QhoDVCkUUF6BerSuTOw2GUCsr5JrF1Naqn6R4n2J7wBu49NNPdy5hop3YSH8E29hEbnL+SG1qk8t+1piJP9HaY83MlDLs3hT2TAjG+0f6VZNAgMBAAECgYBNGY2hGjmn7wwTn+7tX2hgEKjGffLJILo2PU8EUiFn71bKL0l0HCDGQN5sak+14YODcjsYp8jPoXlEEirMSjaXmubTDlkir0I42XO8X1QtUI2ai1aTGscyq8umn7SA5gVBXbcfv2wkgSDJWr43uUjXRLnzSRXvjoP+uYB+mFRYAQJBAO8By+8xBXBqezJToM54SFu2ojh9/Qs0S5en0G9rpJlVYMBjEZwVz5XaT4MgnFJMD3isjpqYIpE/ljHUHogA0M0CQQDu7PNnvFd+g7rphPEKS9tTvhYVJMpfrrhaYtAK1Z+3QaqbprouJmDLd9rHEBy2onFZ4XsYGB4+D9hx8d6tZJuBAkEAn3x/bTk0+/LSCp8raxtwjWKtlSzdMiDPYH+m4vLdf0Qtr7NsCM+1GbX34PRd27zNhiT/c8GZL3tS6iU1ymNg8QJAHU3GlMSO3p99f0Kk5aRkJCM+Rh2bDJ07UyqnZYzJ6AoPyMNsNljSqmHq3VtmiifmSyXSmSPsIaSD4YXOz+l1AQJAbVKe4gtJZpfu2tBUlpkklw0hHsJJ95dPJbj6ePsYx3pij3XZbUPPSLU/WC2Rqm/S9QGu0Sp73tooNZsNhiEvvQ=="//商户私钥，自助生成
//#define PartnerPrivKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAK3WpCUphHbjQx81e3GWjT2NWCU4d1rQoUVpLOzzxWyWqv1UE1Eb9zrbRzomVWxcmwAdEV9SAK9kB4FHYMak4JjRefDHR5LJzEwyx5LlFh1426DxWN9TUd6LKf8u0dy/BXPo1f2GqcPoelG3ZA4AKQdkW+cdyMUV77AvLQQrotGXAgMBAAECgYBopmdoi8bXv1ZgClVG+ygJ3vYqagTIIgKEA53tA49dIJLNMHj0gg5iWzFU21DfjBwvhFA5/ua0r1YpSGwFCaq+tgzksFkvjxrGRVR7mmQwVSfvJ1DT6zHjzXKLh32WhUSfa6GdU3Bjtvy0Kwh8NTMp7XE1XC0o5tz7afQwUuDKWQJBAOEbYiGJXREkYB5T57U4KsjEKpTfdeGQS27uz/x+PoJkrKjO6hBMwoyH9l1Uln+H8nh03mbnl8MYKpBZrC9Wd8MCQQDFsg5RdIY+nsOfOLMT/iPxDHLu/W/G96os7/rnVeiXl7jZlvvCN+vTvS5AFO9sO5PgSWk4A9bfwiptnHDS8DWdAkBmEnmjxVqrDDh9aAR4GtjjonfAe7dDKZ/a1HUBA+mqTKYyAWkHLRdGi9w9o75+Y5Gh5zR1quwY7dtXCyJVcLrrAkAu+gmG945y0N0hN6LuDETUIaYp/hUSjYVlmjzfvb1AUHA/XC5Ez279aIXV+mOOL3YLJMaY5eioUQYt96+joCrNAkEAs5icwzIEw5kqTWHZlwtcA6m2PVesk407It6dOLX2PfXsCXcmMEwKSsurWQLs01he+lp4ZhZSOhxPL61BugKjZA=="//商户私钥，自助生成
/***************************************/
#define QIXINTONG_ID @"ywwl123"//企信通ID
#define QIXINTONG_PASSWORD @"ywwl321"//企信通密码
/****************************************/
/////////////19PAY
#define PAY_MERCHANT_ID @"175093"//19pay网银ID
#define PAY_KEY @"i8mz5bwvw0buw5xxgbw2szzgwilafxv1hf6eep7yyn52ixtcgxrrz803504cegg9jwemktgnw5a8j03xois7t9da8nkmyoshzi0b4bmdpdzwqe31125qzd9wty3hhim5"//19PAY网银KEY
/*******************************************/
#define UMENG_APP_KEY @"547f1955fd98c509a1000007"//友盟KEY

#define personalLanding @"123"

#define SHOW_ALERT(msn) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msn delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];\
[alert show];//提示框

#define QQQQ [NSUserDefaults standardUserDefaults]

#define USER_ID(msn) [msn objectForKey:@"user_id"]//取用户ID
#define USER_TOKEN(msn) [msn objectForKey:@"skey"]//取用户SKEY
#define USER_DEVTOKEN(msn) [msn objectForKey:@"deviceToken"]//取用户设备token值

#define YBMB(msn) [[YBProgressShow defaultProgress] showText:msn InMode:MBProgressHUDModeDeterminate OriginViewEnableTouch:YES HideAfterDelayTime:1];//菊花指示框

#define IsEmptyString(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length]<=0? YES : NO)//判断是否为空

//网络数据封装测试参数
//#define CESHI_NETWORK @"http://mptest.xiongguanjia.cn"
#define CESHI_NETWORK @"http://mp.5k.com/"
//19pay 回掉URL
#define PAYURL @"http://mptest.xiongguanjia.cn/api/OneNinePay/get_data_server"
//支付宝 回掉URL
#define ALIPAY @"http%3A%2F%2Fmptest.xiongguanjia.cn/api/AliPay/get_data_server_recharge"
#endif
