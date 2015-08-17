//
//  XMMViewController.h
//  xiongmami
//
//  Created by iMac on 14/11/28.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"
#import "LampLightTest.h"
#import "PersonalViewController.h"

@interface XMMViewController : UIViewController
{
    LampLightTest *_lab;
    UIImageView *_imageViews;
    NSTimer *_time;
    
    NSArray *_actArray;
    
    UIView *_topView;//界面上半面
}
@property (nonatomic, strong) NSTimer *time;

- (void)lll;
@end
