//
//  ManagementAddressTableViewCell.h
//  xiongmami
//
//  Created by iMac on 14/11/19.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"

@interface ManagementAddressTableViewCell : UITableViewCell
/*
 UILabel *nameLabel
 UILabel *numberLabel
 UILabel *addressLabel
 */
@property (nonatomic, strong) UILabel *nameLabel;//收件人名称
@property (nonatomic, strong) UILabel *numberLabel;//收件人手机号码
@property (nonatomic, strong) UILabel *addressLabel;//收件地址
@property (nonatomic, strong) UIButton *defaultButton;//设置默认按钮
@property (nonatomic, strong) UIButton *operationButton;//重新编辑
@property (nonatomic, strong) UIButton *deleteButton;//删除
@end
