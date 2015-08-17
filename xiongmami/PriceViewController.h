//
//  PriceViewController.h
//  xiongmami
//
//  Created by iMac on 14/11/20.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"

@interface PriceViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *_webView;
    MBProgressHUD *HUD;
}
@end
