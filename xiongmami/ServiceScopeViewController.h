//
//  ServiceScopeViewController.h
//  xiongmami
//
//  Created by iMac on 15/1/13.
//  Copyright (c) 2015年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"
#import "MBProgressHUD.h"

@interface ServiceScopeViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *_webView;
    MBProgressHUD *_HUD;
}

@end
