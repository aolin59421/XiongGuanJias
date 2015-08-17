//
//  RegisteredViewController.h
//  xiongmami
//
//  Created by iMac on 14/11/18.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeveyTabBarController.h"

@interface RegisteredViewController : UIViewController<UITabBarDelegate,UIScrollViewDelegate>
{
    LeveyTabBarController *_leveyTabBarController;
    
    BOOL FWTK;
}

@property (strong, nonatomic) IBOutlet UIWindow *window;

@property (strong, nonatomic) IBOutlet LeveyTabBarController*leveyTabBarController;
@property (strong, nonatomic) UINavigationController *nav;
@end
