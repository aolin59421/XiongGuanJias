//
//  NewActivityViewController.h
//  xiongmami
//
//  Created by iMac on 14/12/4.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"
#import "MBProgressHUD.h"

@interface NewActivityViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *_webView;
    MBProgressHUD *_HUD;
}
@end
