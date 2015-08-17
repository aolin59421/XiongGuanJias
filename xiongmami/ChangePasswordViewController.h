//
//  ChangePasswordViewController.h
//  xiongmami
//
//  Created by iMac on 14/11/24.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"
#import "XMMViewController.h"

@interface ChangePasswordViewController : UIViewController

{
    UITextField *_ymmTextField;
    UITextField *_xmmTextField;
    UITextField *_qrxmmTextField;
    UIBarButtonItem *_rightButton;
    
    UILabel *_zhLabel;
    
    MBProgressHUD *HUD;
    
    UIAlertView *_messagealert;
}
@end
