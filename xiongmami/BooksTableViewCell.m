//
//  BooksTableViewCell.m
//  xiongmami
//
//  Created by iMac on 14/11/22.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "BooksTableViewCell.h"

@implementation BooksTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 250, 30)];
    _nameLab.text = @"支付宝充值";
    [self.contentView addSubview:_nameLab];
    
    _numberLab = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100, 0, 90, 40)];
//    _numberLab.text = @"+50";
    [_numberLab setTextAlignment:NSTextAlignmentRight];
    [_numberLab setFont:[UIFont systemFontOfSize:20]];
    [self.contentView addSubview:_numberLab];
        
        if (iPhone6Plus) {
            _nameLab.frame = CGRectMake(10, 13, 250, 30);
            _numberLab.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100, 10, 90, 40);

        }
    }
    return self;
}

@end
