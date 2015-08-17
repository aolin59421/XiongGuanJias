//
//  ACTTableViewCell.h
//  xiongmami
//
//  Created by iMac on 14/12/12.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"

@interface ACTTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *image;//图片
@property (nonatomic, strong) UILabel *titleLab;//标题
@property (nonatomic, strong) UILabel *contentLab;//详细信息
@property (nonatomic, strong) UILabel *timeLab;//时间
@end
