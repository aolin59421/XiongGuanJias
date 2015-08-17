//
//  TableViewCell.m
//  xiongmami
//
//  Created by iMac on 15/3/20.
//  Copyright (c) 2015年 杭州熊管佳电子商务有限公司. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {

    self.contentView.backgroundColor = [UIColor colorWithRed:245/255.0f green:239/255.0f blue:235/255.0f alpha:1];
    view.layer.borderWidth = 0.5f;
    view.layer.borderColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#dee2e5"].CGColor;
    view.layer.cornerRadius = 5;
    
    
    _money_lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 18, 35, 19)];
    [_money_lab setBackgroundColor:[UIColor clearColor]];
    [_money_lab setTextAlignment:NSTextAlignmentCenter];
    [_money_lab setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#e12e11"]];
    [_money_lab setFont:[UIFont systemFontOfSize:15]];
    [_giftsImage addSubview:_money_lab];
    
    _chai =[[UIImageView alloc] init];
    [view addSubview:_chai];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
