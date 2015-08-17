//
//  OrderViewController.h
//  xiongmami
//
//  Created by iMac on 14/11/18.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"

@interface OrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UIButton * _button;//服务中
    UIButton * _overButton;//已完成
    UIButton * _cancelButton;//已取消
    
    UITableView *_fwzTableView;//服务中列表
    UITableView *_ywcTableView;//已完成列表
    UITableView *_yqxTableView;//已取消列表
    
    UIImageView *_fwzImage;
    UIImageView *_ywcImage;
    UIImageView *_yqxImage;
    
    NSArray *_listArray;//服务中列表
    NSArray *_listOverArray;//已完成列表
    
    //取消订单
    UIAlertView *_qxddAlertView;
    //确认评论
    UIAlertView *_querenpinglun;
    
    MBProgressHUD *HUD;
    
    //////无订单lab
    UILabel *_no_order;
    UILabel *_no_ywcOrder;
    
    BOOL  per;
}

@end
