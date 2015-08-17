//
//  OrderTracking.h
//  xiongmami
//
//  Created by iMac on 14/11/21.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"
#import "cnvUILabel.h"

@interface OrderTracking : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_orderListTableView;
    UILabel *_numberLabel;
    cnvUILabel *_leixingLabel;
    
    MBProgressHUD *HUD;
}

@property (nonatomic , strong) NSString *orderNumber;//订单编号
@property (nonatomic , strong) NSString *orderType;//订单类型
@property (nonatomic , strong) NSArray  *orderStateList;//订单状态
@property (nonatomic , strong) NSArray  *orderStateTimeList;//订单状态时间
@end
