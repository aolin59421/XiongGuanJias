//
//  ActViewController.h
//  xiongmami
//
//  Created by iMac on 14/12/12.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"

@interface ActViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_actTableView;
    
    NSArray *_listArray;
    NSArray *_imageListArray;
    
    MBProgressHUD *HUD;
    
    BOOL actBool;
    
    UILabel *errenLab;
    
    UILabel *_actLab_Null;
}

@property (nonatomic, strong) NSString *cellTitleStr;
@end
