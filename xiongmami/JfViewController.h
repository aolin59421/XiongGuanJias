//
//  JfViewController.h
//  xiongmami
//
//  Created by iMac on 14/11/22.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Interface.h"

@interface JfViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *_integralTableView;
    NSMutableArray *_listArray;
    UIAlertView *_alert;
    MBProgressHUD *HUD;
}
@end
