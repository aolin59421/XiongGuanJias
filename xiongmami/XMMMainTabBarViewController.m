//
//  XMMMainTabBarViewController.m
//  xiongmami
//
//  Created by iMac on 14/12/1.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "XMMMainTabBarViewController.h"

@implementation XMMMainTabBarViewController


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *VC = [[ViewController alloc] init];
    OrderViewController *orderVC = [[OrderViewController alloc] init];
    PersonalLanding *personal = [[PersonalLanding alloc] init];
    UINavigationController *VCNav = [[UINavigationController alloc] initWithRootViewController:VC];
    UINavigationController *orderNav = [[UINavigationController alloc] initWithRootViewController:orderVC];
    UINavigationController *personalNav = [[UINavigationController alloc] initWithRootViewController:personal];
    NSArray *navArray = [[NSArray alloc] initWithObjects:VCNav,orderNav,personalNav, nil];
    NSMutableDictionary *imageHomes = [NSMutableDictionary dictionaryWithCapacity:3];
    [imageHomes setObject:[UIImage imageNamed:@"home.png"] forKey:@"Default"];
    [imageHomes setObject:[UIImage imageNamed:@"homehover.png"] forKey:@"Highlighted"];
    [imageHomes setObject:[UIImage imageNamed:@"homehover.png"] forKey:@"Seleted"];
    NSMutableDictionary *imageOrders = [NSMutableDictionary dictionaryWithCapacity:3];
    [imageOrders setObject:[UIImage imageNamed:@"订单.png"] forKey:@"Default"];
    [imageOrders setObject:[UIImage imageNamed:@"订单hover.png"] forKey:@"Highlighted"];
    [imageOrders setObject:[UIImage imageNamed:@"订单hover.png"] forKey:@"Seleted"];
    NSMutableDictionary *imageMys = [NSMutableDictionary dictionaryWithCapacity:3];
    [imageMys setObject:[UIImage imageNamed:@"my.png"] forKey:@"Default"];
    [imageMys setObject:[UIImage imageNamed:@"myhover.png"] forKey:@"Highlighted"];
    [imageMys setObject:[UIImage imageNamed:@"myhover.png"] forKey:@"Seleted"];
    NSArray *imageArray = [NSArray arrayWithObjects:imageHomes,imageOrders,imageMys, nil];
    _leveyTabBarController = [[LeveyTabBarController alloc] initWithViewControllers:navArray imageArray:imageArray];
    [_leveyTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"mainBg.png"]];
    [_leveyTabBarController.tabBar setBackgroundColor:[UIColor whiteColor]];
    [_leveyTabBarController setTabBarTransparent:YES];
    [self.window setRootViewController:_leveyTabBarController];
    return YES;
}
@end
