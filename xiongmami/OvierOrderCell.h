//
//  OvierOrderCell.h
//  xiongmami
//
//  Created by iMac on 14/11/21.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"

@interface OvierOrderCell : UITableViewCell

@property (nonatomic, strong)UILabel *numberOrderLab;//订单编号

@property (nonatomic, strong)UILabel *nameOrderLab;//商品名称

@property (nonatomic, strong)UILabel *leiXingOrderLab;//订单类型

@property (nonatomic, strong)UILabel *zhuangTaiOrderLab;//订单状态

@property (nonatomic, strong)UILabel *fuKuanFangShiLab;//付款方式

@property (nonatomic, strong)UILabel *fuKuanJinELab;//付款金额

@property (nonatomic, strong)UIButton *pingjia;//评价按钮

@property (nonatomic, strong)UIButton *commentBtn;//查看评论
@end
