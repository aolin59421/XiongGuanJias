//
//  GiftsViewController.h
//  xiongmami
//
//  Created by iMac on 15/3/20.
//  Copyright (c) 2015年 杭州熊管佳电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"
#import "TableViewCell.h"

@interface GiftsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_giftsTableView;//红包列表
    NSArray *_giftsArray;//红包数组
}

@end
