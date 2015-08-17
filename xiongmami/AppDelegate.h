//
//  AppDelegate.h
//  xiongmami
//
//  Created by iMac on 14/11/18.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"



@class LeveyTabBarController;


@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,UINavigationControllerDelegate,UINavigationBarDelegate,UIActionSheetDelegate,UIScrollViewDelegate,UIAlertViewDelegate>
{
    LeveyTabBarController *_leveyTabBarController;

    UIPageControl *pageC;
    UIScrollView *dyScrollView;
    UIAlertView *_alert_Push;//通知提示框
}

@property (strong, nonatomic) IBOutlet UIWindow *window;

@property (strong, nonatomic) IBOutlet LeveyTabBarController*leveyTabBarController;
@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;//语音
//程序初始化，注：这里也可以覆盖默认推送参数
- (void)onInit;
//获取到设备token回调
- (void)onReturnDeviceToken:(NSString *)deviceToken errorMessage:(id)errorMessage;
//收到推送消息处理回调
- (void)onMessage:(NSString *)channelId userId:(NSString *)userId inmeId:(NSString *)inmeId dataMap:(NSDictionary *)dataMap;
@end
