//
//  FwzOrderCell.h
//  xiongmami
//
//  Created by iMac on 14/11/21.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"

@interface FwzOrderCell : UITableViewCell

@property (nonatomic, strong)UILabel *numberOrderLab;//订单编号

@property (nonatomic, strong)UILabel *nameOrderLab;//商品名称

@property (nonatomic, strong)UILabel *leiXingOrderLab;//订单类型

@property (nonatomic, strong)UILabel *zhuangTaiOrderLab;//订单状态

@property (nonatomic, strong)UIButton *quXiaoOrderButton;//取消订单

@property (nonatomic, strong)UIButton *fuKuanOrderButton;//付款

@property (nonatomic, strong)UIButton *dingDanZhuiZongButton;//订单追踪



@end
