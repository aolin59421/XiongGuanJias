//
//  OrderList.m
//  xiongmami
//
//  Created by iMac on 14/11/21.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "OrderList.h"

@implementation OrderList
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         _image = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/10, 0, 20, 80)];
        [_image setImage:[UIImage imageNamed:@"wuliu@3x.png"]];
        [self.contentView addSubview:_image];
        
        _orderTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/10 + 25, -10, 300, 60)];
        _orderTimeLab.numberOfLines = 0;
        _orderTimeLab.text = @"已完成\n2014-11-19 12：09：35";
        [_orderTimeLab setFont:[UIFont systemFontOfSize:17]];
        [_orderTimeLab setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_orderTimeLab];
    }
    return self;
}
@end
