//
//  TableViewCell.h
//  xiongmami
//
//  Created by iMac on 15/3/20.
//  Copyright (c) 2015年 杭州熊管佳电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"

@interface TableViewCell : UITableViewCell
{
    __weak IBOutlet UIView *view;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *giftsImage;//红包图片
@property (weak, nonatomic) IBOutlet UILabel *numberLab;//红包编号
@property (weak, nonatomic) IBOutlet UILabel *giftsLab;//红包来源
@property (weak, nonatomic) IBOutlet UILabel *timeLab;//红包有效期
@property (strong, nonatomic) NSString *str;//
@property (strong, nonatomic) IBOutlet UIImageView *chai;
@property (strong, nonatomic) UILabel *money_lab;//红包金额
@end
