//
//  JfTableViewCell.m
//  xiongmami
//
//  Created by iMac on 14/11/22.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "JfTableViewCell.h"

@implementation JfTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 25)];
    _nameLab.text = @"每日登录";
    [self.contentView addSubview:_nameLab];
    
    _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 150, 25)];
    _timeLab.text = @"2014-11-15 9:00:05";
    [_timeLab setTextAlignment:NSTextAlignmentLeft];
    [_timeLab setFont:[UIFont systemFontOfSize:12]];
    [_timeLab setTextColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:_timeLab];
    
    _numberLab = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width -115, 15, 100, 30)];
    _numberLab.text = @"+10";
    [_numberLab setTextAlignment:NSTextAlignmentRight];
    [_numberLab setFont:[UIFont systemFontOfSize:20]];
    [self.contentView addSubview:_numberLab];
    }
    return self;
}

@end
