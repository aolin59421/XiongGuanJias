//
//  ManagementAddressTableViewCell.m
//  xiongmami
//
//  Created by iMac on 14/11/19.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "ManagementAddressTableViewCell.h"

@implementation ManagementAddressTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        //收件人名称
        UIView *nameView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, VIEW_FRAME_SIZE_WIDTH, 30)];
        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, nameView.frame.size.width/4, nameView.frame.size.height)];
        nameLab.text = @"收  货  人:";
        nameLab.textAlignment = NSTextAlignmentRight;
        [nameLab setTextColor:[UIColor blackColor]];
        [nameView addSubview:nameLab];
        
        _defaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_defaultButton setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH - 80, 10, 135/2, 40/2)];
        
        [_defaultButton setBackgroundImage:[UIImage imageNamed:@"默认.png"] forState:UIControlStateNormal];
        [_defaultButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_defaultButton.titleLabel setTextAlignment:NSTextAlignmentRight];   
        [nameView addSubview:_defaultButton];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+nameLab.frame.size.width, 0, nameView.frame.size.width, nameView.frame.size.height)];
        _nameLabel.text = @"naruto";
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setTextColor:[UIColor blackColor]];
        [nameView addSubview:_nameLabel];
        
        [self.contentView addSubview:nameView];
        
        //收件人手机号码
        UIView *numberView = [[UIView alloc] initWithFrame:CGRectMake(0, 120/4+5, VIEW_FRAME_SIZE_WIDTH, 30)];
        
        UILabel *numberLab = [[UILabel alloc] initWithFrame:CGRectMake(15 , 0, nameView.frame.size.width/4, nameView.frame.size.height)];
        numberLab.text = @"联系电话:";
        numberLab.textAlignment = NSTextAlignmentRight;
        [numberLab setTextColor:[UIColor blackColor]];
        [numberView addSubview:numberLab];
        
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+numberLab.frame.size.width, 0, nameView.frame.size.width, nameView.frame.size.height)];
        _numberLabel.text = @"12345678901";
        _numberLabel.textAlignment = NSTextAlignmentLeft;
        [_numberLabel setTextColor:[UIColor blackColor]];
        [numberView addSubview:_numberLabel];
        
        [self.contentView addSubview:numberView];
        
        //收件人地址
        UIView *addressView = [[UIView alloc] initWithFrame:CGRectMake(0, 120/2+5, VIEW_FRAME_SIZE_WIDTH, 60)];
        
        UILabel *addressLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, nameView.frame.size.width/4, nameView.frame.size.height)];
        addressLab.text = @"收件地址:";
        addressLab.textAlignment = NSTextAlignmentRight;
        [addressLab setTextColor:[UIColor blackColor]];
        [addressView addSubview:addressLab];
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+addressLab.frame.size.width, 0, VIEW_FRAME_SIZE_WIDTH/4*2+40, 30)];
        _addressLabel.text = @"大宇宙银河系太阳系地球亚洲中国杭州余杭区";
//        _addressLabel.textAlignment = NSTextAlignmentLeft;
        [_addressLabel setTextColor:[UIColor blackColor]];
        [_addressLabel setFont:[UIFont systemFontOfSize:17]];
        _addressLabel.numberOfLines = 1;
        [addressView addSubview:_addressLabel];
        
        [self.contentView addSubview:addressView];
        
        UILabel *fengexian = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 35, VIEW_FRAME_SIZE_WIDTH*0.9, 0.5)];
        [fengexian setBackgroundColor:[UIColor colorWithRed:214/255.0f green:219/255.0f blue:223/255.0f alpha:1]];
        [addressView addSubview:fengexian];
        //操作
        UIView *operationView = [[UIView alloc] initWithFrame:CGRectMake(0, 105, VIEW_FRAME_SIZE_WIDTH, 30)];
        
        _operationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _operationButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH -190, 5, 80, 30);
        [_operationButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
        [_operationButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_operationButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [_operationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [operationView addSubview:_operationButton];
        
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH - 100, 5, 80, 30);
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"btnHover.png"] forState:UIControlStateNormal];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor colorWithRed:255/255.0f green:80/255.0f blue:43/255.0f alpha:1] forState:UIControlStateNormal];
        [_deleteButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [operationView addSubview:_deleteButton];
        
        [self.contentView addSubview:operationView];
        
        if (iPhone6Plus) {
            nameLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20 - 20, 0, nameView.frame.size.width/4, nameView.frame.size.height);
            
            [_defaultButton setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH - 80, 10, 135/2, 40/2)];
            
            _nameLabel.frame = CGRectMake(nameView.frame.size.width/4+VIEW_FRAME_SIZE_WIDTH/20 -10, 0, nameView.frame.size.width, nameView.frame.size.height);
            
            numberLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20 - 20, 0, nameView.frame.size.width/4, nameView.frame.size.height);
            
            _numberLabel.frame = CGRectMake(nameView.frame.size.width/4+VIEW_FRAME_SIZE_WIDTH/20-10, 0, nameView.frame.size.width, nameView.frame.size.height);
            
            addressLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20 - 20, 0, nameView.frame.size.width/4, nameView.frame.size.height);
            
            _addressLabel.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20 - 15 +nameView.frame.size.width/4, 0, VIEW_FRAME_SIZE_WIDTH/4*2+80, nameView.frame.size.height);
            
            _operationButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH -190, 5, 80, 30);
            
            _deleteButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH - 100, 5, 80, 30);
        }
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
