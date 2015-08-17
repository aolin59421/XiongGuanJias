//
//  AllGiftsTableViewCell.h
//  xiongmami
//
//  Created by iMac on 15/3/24.
//  Copyright (c) 2015年 杭州熊管佳电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"

@interface AllGiftsTableViewCell : UITableViewCell
{
    __weak IBOutlet UIView *_view;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;//红包图片
@property (weak, nonatomic) IBOutlet UILabel *pjGiftsBtn;//红包来源
@property (weak, nonatomic) IBOutlet UILabel *giftsTimeLab;//有效期
@property (weak, nonatomic) IBOutlet UILabel *giftsNumLab;//红包编号
@property (strong, nonatomic) IBOutlet UIImageView *xzImgae;//选择背景框
@property (strong, nonatomic) IBOutlet UIImageView *chai;
@property (strong, nonatomic) UILabel *money_lab;//红包金额
@property (strong, nonatomic) NSString *str;//
@property (strong, nonatomic) NSMutableAttributedString*mabs;//
@end
