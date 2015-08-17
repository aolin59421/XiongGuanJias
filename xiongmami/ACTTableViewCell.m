//
//  ACTTableViewCell.m
//  xiongmami
//
//  Created by iMac on 14/12/12.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "ACTTableViewCell.h"

@implementation ACTTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 105, 72.5)];
        _image.image = [UIImage imageNamed:@"活动商城.png"];
        [self.contentView addSubview:_image];
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(125, 10, VIEW_FRAME_SIZE_WIDTH - 135, 20)];
        [_titleLab setText:@"卡农洗衣，首次下单免2件"];
        [_titleLab setFont:[UIFont systemFontOfSize:15]];
        [_titleLab setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"]];
        [self.contentView addSubview:_titleLab];
        
        _contentLab = [[UILabel alloc] initWithFrame:CGRectMake(125, 30, VIEW_FRAME_SIZE_WIDTH - 135, 40)];
        [_contentLab setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#9f9f9f"]];
        [_contentLab setText:@"使用条件：首次关注卡农西一刻微信公众号即可。"];
        [_contentLab setNumberOfLines:0];
        [_contentLab setFont:[UIFont systemFontOfSize:12.5f]];
        [self.contentView addSubview:_contentLab];
        
        _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(125, 70, VIEW_FRAME_SIZE_WIDTH - 135, 20)];
        [_timeLab setText:@"截止时间： 2014-10-31"];
        [_timeLab setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#c50404"]];
        [_timeLab setFont:[UIFont systemFontOfSize:10]];
        [self.contentView addSubview:_timeLab];
        
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
