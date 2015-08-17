//
//  FwzOrderCell.m
//  xiongmami
//
//  Created by iMac on 14/11/21.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "FwzOrderCell.h"

@implementation FwzOrderCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 170)];
        [self.contentView  addSubview:view];
        
        //编号
        UILabel *numberOrederLaber = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/18, 5, view.frame.size.width/4, 20)];
        numberOrederLaber.text = @"订单编号：";
        [numberOrederLaber setFont:[UIFont systemFontOfSize:15]];
        [view addSubview:numberOrederLaber];
        
        _numberOrderLab = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/8+45, 5, view.frame.size.width/5*3, 20)];
        [_numberOrderLab setFont:[UIFont systemFontOfSize:15]];
        [view addSubview:_numberOrderLab];
        
        //名称
        UILabel *numberOrederLaber1 = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/18, 35, view.frame.size.width/4, 20)];
        numberOrederLaber1.text = @"商品名称：";
        [numberOrederLaber1 setFont:[UIFont systemFontOfSize:15]];
        [view addSubview:numberOrederLaber1];
        
        _nameOrderLab = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/8+45, 35, view.frame.size.width/5*3, 20)];
        [_nameOrderLab setFont:[UIFont systemFontOfSize:15]];
        [view addSubview:_nameOrderLab];
        
        //类型
        UILabel *numberOrederLaber2 = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/18, 65, view.frame.size.width/4, 20)];
        numberOrederLaber2.text = @"订单类型：";
        [numberOrederLaber2 setFont:[UIFont systemFontOfSize:15]];
        [view addSubview:numberOrederLaber2];
        
        _leiXingOrderLab = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/8+45, 65, view.frame.size.width/5*3, 20)];
        [_leiXingOrderLab setFont:[UIFont systemFontOfSize:15]];
        [view addSubview:_leiXingOrderLab];
        
        //状态
        UILabel *numberOrederLaber3 = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/18, 95, view.frame.size.width/4, 20)];
        numberOrederLaber3.text = @"订单状态：";
        [numberOrederLaber3 setFont:[UIFont systemFontOfSize:15]];
        [view addSubview:numberOrederLaber3];
        
        _zhuangTaiOrderLab = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/8+45, 95, view.frame.size.width/5*3, 20)];
        [_zhuangTaiOrderLab setFont:[UIFont systemFontOfSize:15]];
        [view addSubview:_zhuangTaiOrderLab];
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(view.frame.size.width/18, 121, VIEW_FRAME_SIZE_WIDTH*0.9, 0.5)];
        image.backgroundColor = [UIColor colorWithRed:190/255.0f green:190/255.0f blue:190/255.0f alpha:1];
        [view addSubview:image];
        
        _dingDanZhuiZongButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dingDanZhuiZongButton setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH - 100, 130, 80, 30)];
        [_dingDanZhuiZongButton setTitle:@"订单追踪" forState:UIControlStateNormal];
        [_dingDanZhuiZongButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        _dingDanZhuiZongButton.layer.cornerRadius = 5.0f;
        [_dingDanZhuiZongButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
        [_dingDanZhuiZongButton setTitleColor:[UIColor colorWithRed:59/255.0f green:55/255.f blue:51/255.f alpha:1] forState:UIControlStateNormal];
        [view addSubview:_dingDanZhuiZongButton];
        
        
        _quXiaoOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _quXiaoOrderButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100, 130, 80, 30);
        [_quXiaoOrderButton setTitle:@"取消订单" forState:UIControlStateNormal];
        [_quXiaoOrderButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_quXiaoOrderButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_quXiaoOrderButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:_quXiaoOrderButton];
        
        
        _fuKuanOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _fuKuanOrderButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH - 100, 130, 80, 30);
        [_fuKuanOrderButton setBackgroundImage:[UIImage imageNamed:@"btnHover.png"] forState:UIControlStateNormal];
        [_fuKuanOrderButton setTitleColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#ed6c44"] forState:UIControlStateNormal];
        [_fuKuanOrderButton setTitle:@"付款" forState:UIControlStateNormal];
        [_fuKuanOrderButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.contentView addSubview:_fuKuanOrderButton];
        
    }
    return self;
}

@end
