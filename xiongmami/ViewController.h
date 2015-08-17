//
//  ViewController.h
//  xiongmami
//
//  Created by iMac on 14/11/18.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LampLightTest.h"
#import "PersonalViewController.h"

@interface ViewController : UIViewController
{
    LampLightTest *_lab;
    UIImageView *_imageViews;
    NSTimer *_time;
    
    NSArray *_actArray;
    
    UIView *_topView;//首页上半界面
}
@property (nonatomic, strong) NSTimer *time;

- (void)lll;
- (void)pushCom:(NSString *)num with:(NSString *)time;
@end
