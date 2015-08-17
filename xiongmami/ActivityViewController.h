//
//  ActivityViewController.h
//  xiongmami
//
//  Created by iMac on 14/11/20.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"
/////////////////////已弃用///////////////////
/////////////////////已弃用///////////////////
/////////////////////已弃用///////////////////
/////////////////////已弃用///////////////////
#define kTagShareEdit 101
#define kTagSharePost 102

@interface ActivityViewController : UIViewController<UIWebViewDelegate,UIActionSheetDelegate,UMSocialUIDelegate>
{
    UIWebView *_webView;
}

@property (nonatomic, strong)NSString *act_id;
@property (nonatomic, strong)NSString *webUrl;
@property (nonatomic, strong)MBProgressHUD *HUD;
@end
