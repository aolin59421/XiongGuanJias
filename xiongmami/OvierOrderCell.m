//
//  OvierOrderCell.m
//  xiongmami
//
//  Created by iMac on 14/11/21.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "OvierOrderCell.h"

@implementation OvierOrderCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 235)];
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
        
        //付款方式
        UILabel *fukuanfangshiLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/18, 125, view.frame.size.width/4, 20)];
        fukuanfangshiLabel.text = @"付款方式：";
        [fukuanfangshiLabel setFont:[UIFont systemFontOfSize:15]];
        [view addSubview:fukuanfangshiLabel];
        
        _fuKuanFangShiLab = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/8+45, 125,  view.frame.size.width/5*3, 20)];
        [_fuKuanFangShiLab setFont:[UIFont systemFontOfSize:15]];
        [view addSubview:_fuKuanFangShiLab];
        
        //付款金额
        UILabel *fuKuanJinELabel = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/18, 155, view.frame.size.width/4, 20)];
        fuKuanJinELabel.text = @"付款金额：";
        [fuKuanJinELabel setFont:[UIFont systemFontOfSize:15]];
        [view addSubview:fuKuanJinELabel];
        
        _fuKuanJinELab = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/8+45, 155,  view.frame.size.width/5*3, 20)];
        [_fuKuanJinELab setFont:[UIFont systemFontOfSize:15]];
        [_fuKuanJinELab setTextColor:[UIColor colorWithRed:236/255.0f green:129/255.0f blue:104/255.0f alpha:1]];
        [view addSubview:_fuKuanJinELab];
        
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(15, view.frame.size.height-55, VIEW_FRAME_SIZE_WIDTH*0.9, 0.5)];
        image.backgroundColor = [UIColor colorWithRed:190/255.0f green:190/255.0f blue:190/255.0f alpha:1];
        [view addSubview:image];
        
        _pingjia = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pingjia setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH-100, view.frame.size.height-45, 80, 30)];
        [_pingjia setTitleColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#ed6c44"] forState:UIControlStateNormal];
        [_pingjia setTitle:@"评价" forState:UIControlStateNormal];
        [_pingjia.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [view addSubview:_pingjia];
        
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH-100, view.frame.size.height-45, 80, 30)];
        [_commentBtn setTitleColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#ed6c44"] forState:UIControlStateNormal];
        [_commentBtn setTitle:@"查看评价" forState:UIControlStateNormal];
        [_commentBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [view addSubview:_commentBtn];
    }
    return self;
}
@end
