//
//  XMMMainTabBarViewController.h
//  xiongmami
//
//  Created by iMac on 14/12/1.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "OrderViewController.h"
#import "PersonalViewController.h"
#import "PersonalLanding.h"
#import "LeveyTabBarController.h"

@interface XMMMainTabBarViewController : UIResponder
{
    LeveyTabBarController *_leveyTabBarController;
}

@property (strong, nonatomic) IBOutlet UIWindow *window;

@property (strong, nonatomic) IBOutlet LeveyTabBarController*leveyTabBarController;

@end
