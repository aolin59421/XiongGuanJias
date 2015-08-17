//
//  VerificationViewController.h
//  xiongmami
//
//  Created by iMac on 14/11/18.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"
#import "HexadecimalConversionUICOLOR.h"
#import "LeveyTabBarController.h"
typedef void (^XGJVerificationBlock)(NSMutableDictionary *);

@interface VerificationViewController : UIViewController<UITabBarDelegate>
{
    LeveyTabBarController *_leveyTabBarController;

    XGJVerificationBlock ver_block;
    
    BOOL FWTK;
}
@property (nonatomic, strong)NSString *open_id;
@property (nonatomic, strong)NSString *flag;


@property (strong, nonatomic) IBOutlet UIWindow *window;

@property (strong, nonatomic) IBOutlet LeveyTabBarController*leveyTabBarController;
@property (strong, nonatomic) UINavigationController *nav;
- (id)initWithBlock:(XGJVerificationBlock)dic;
@end
