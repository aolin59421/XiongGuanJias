//
//  TermsOfServiceViewController.h
//  xiongmami
//
//  Created by iMac on 15/3/19.
//  Copyright (c) 2015年 杭州熊管佳电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"
#import "MBProgressHUD.h"

@interface TermsOfServiceViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *_webView;
    MBProgressHUD *_HUD;
}
@end
