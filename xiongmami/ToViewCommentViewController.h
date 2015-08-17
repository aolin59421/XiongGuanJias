//
//  ToViewCommentViewController.h
//  xiongmami
//
//  Created by iMac on 15/5/4.
//  Copyright (c) 2015年 杭州熊管佳电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"

@interface ToViewCommentViewController : UIViewController
{
    IBOutlet UIView *_topView;
    IBOutlet UIView *_downView;
    //完成时间
    IBOutlet UILabel *_over_time;
    
    IBOutlet UIImageView *_chaping_image;
    IBOutlet UIImageView *_zhongping_image;
    IBOutlet UIImageView *_haoping_image;
    //颜色改变，
    IBOutlet UILabel *_pinglun;
    IBOutlet UILabel *_xiyizhiliang;
    IBOutlet UILabel *songyimanyidu;
    IBOutlet UILabel *_quyimanyidu;
    IBOutlet UILabel *_chaping;
    IBOutlet UILabel *_zhongping;
    IBOutlet UILabel *_gaoping;
}
///////订单完成时间
@property (strong, nonatomic) NSString *overOrderTime;
//订单编号
@property (strong, nonatomic) NSString * numberText;
@property (strong, nonatomic) IBOutlet UILabel *orderNum;
//评论内容
@property (strong, nonatomic) IBOutlet UILabel *pinflunneirong;

@end
