//
//  OverOrderCell.m
//  xiongmami
//
//  Created by iMac on 14/11/21.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "OverOrderCell.h"

@implementation OverOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 130)];
        [self.contentView  addSubview:view];
        
        //编号
        UILabel *numberOrederLaber = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/18, 5, view.frame.size.width/5, 20)];
        numberOrederLaber.text = @"订单编号：";
        [numberOrederLaber setFont:[UIFont systemFontOfSize:12]];
        [view addSubview:numberOrederLaber];
        
        _numberOrderLab = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/8+35, 5, view.frame.size.width/5*2.5, 20)];
        [_numberOrderLab setFont:[UIFont systemFontOfSize:12]];
        [view addSubview:_numberOrderLab];
        
        //名称
        UILabel *numberOrederLaber1 = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/18, 35, view.frame.size.width/5, 20)];
        numberOrederLaber1.text = @"商品名称：";
        [numberOrederLaber1 setFont:[UIFont systemFontOfSize:12]];
        [view addSubview:numberOrederLaber1];
        
        _nameOrderLab = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/8+35, 35, view.frame.size.width/5*2.5, 20)];
        [_nameOrderLab setFont:[UIFont systemFontOfSize:12]];
        [view addSubview:_nameOrderLab];
        
        //类型
        UILabel *numberOrederLaber2 = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/18, 65, view.frame.size.width/5, 20)];
        numberOrederLaber2.text = @"订单类型：";
        [numberOrederLaber2 setFont:[UIFont systemFontOfSize:12]];
        [view addSubview:numberOrederLaber2];
        
        _leiXingOrderLab = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/8+35, 65, view.frame.size.width/5*2.5, 20)];
        [_leiXingOrderLab setFont:[UIFont systemFontOfSize:12]];
        [view addSubview:_leiXingOrderLab];
        
        //状态
        UILabel *numberOrederLaber3 = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/18, 95, view.frame.size.width/5, 20)];
        numberOrederLaber3.text = @"订单状态：";
        [numberOrederLaber3 setFont:[UIFont systemFontOfSize:12]];
        [view addSubview:numberOrederLaber3];
        
        _zhuangTaiOrderLab = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/8+35, 95, view.frame.size.width/5*2.5, 20)];
        [_zhuangTaiOrderLab setFont:[UIFont systemFontOfSize:12]];
        [_zhuangTaiOrderLab setTextColor:[UIColor colorWithRed:230/255.0f green:94/255.0f blue:63/255.0f alpha:1]];
        [view addSubview:_zhuangTaiOrderLab];
        
    }
    return self;
}

@end
