//
//  AllGiftsViewController.h
//  xiongmami
//
//  Created by iMac on 15/3/24.
//  Copyright (c) 2015年 杭州熊管佳电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"
#import "AllGiftsTableViewCell.h"
typedef void (^XGJALLGIFTS_BLOCK)(NSMutableDictionary *);
@interface AllGiftsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_allGiftsTableView;//红包列表
    BOOL cellBtn;//记录CELL上按钮的状态
    NSMutableDictionary *_dic;//全局字典存储选中内容
    UIImageView *imageViewBtn;//全选按钮背景
    
    XGJALLGIFTS_BLOCK user_Block;//
    
    NSArray *_gifts_Array;//红包列表
    NSMutableArray *_gifts_amount;//红包总金额
    NSString * _zjeStr;//总金额
    NSMutableArray *_gifts_card_id;//红包编号
    
    NSMutableDictionary *_dicVal;//记录被选中的index
}
- (id)initWithBlock:(XGJALLGIFTS_BLOCK)dic;
@end
