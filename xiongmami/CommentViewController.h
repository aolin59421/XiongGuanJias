//
//  CommentViewController.h
//  xiongmami
//
//  Created by iMac on 15/5/4.
//  Copyright (c) 2015年 杭州熊管佳电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"
#import "XMTextViewPlaceHolder.h"
#import "cnvUILabel.h"
/////block
typedef void (^XGJCommertBlock)(NSMutableDictionary *);

@interface CommentViewController : UIViewController<UITextViewDelegate,UIAlertViewDelegate>
{
    
    XGJCommertBlock user_Block;
    ///取衣图片
    IBOutlet UIImageView *_quyi_chaping;
    IBOutlet UIImageView *_quyi_zhongping;
    IBOutlet UIImageView *_quyi_haoping;
    ///送衣图片
    IBOutlet UIImageView *_songyi_chaping;
    IBOutlet UIImageView *_songyi_zhongping;
    IBOutlet UIImageView *_songyi_haoping;
    ///洗衣图片
    IBOutlet UIImageView *_xiyi_chaping;
    IBOutlet UIImageView *_xiyi_zhongping;
    IBOutlet UIImageView *_xiyi_haoping;
    ///上半部视图
    IBOutlet UIView *_topView;
    ///下半部视图
    IBOutlet UIView *_downView;
    ///////无关紧要只为修改文字颜色
    IBOutlet UILabel *youorderover;
    IBOutlet UILabel *orderstate;
    IBOutlet UILabel *quyimanyidu;
    IBOutlet UILabel *chaping1;
    IBOutlet UILabel *zhongping1;
    IBOutlet UILabel *haoping1;
    IBOutlet UILabel *songyimanyidu;
    IBOutlet UILabel *chaping2;
    IBOutlet UILabel *zhongping2;
    IBOutlet UILabel *haoping2;
    IBOutlet UILabel *xiyizhiliangmanyidu;
    IBOutlet UILabel *chaping3;
    IBOutlet UILabel *haoping3;
    IBOutlet UILabel *zhongping3;
    IBOutlet UILabel *_fengexian;
    IBOutlet UIButton *_fabiaopinglun;
    
    /////////记录取衣满意度
    NSString *_quyi_manyidu;
    /////////记录送衣满意度
    NSString *_songyi_manyidu;
    /////////记录洗衣质量满意度
    NSString *_xiyizhiliang_manyidu;
    
    ///////////确认评论提示框
    UIAlertView *_ok_Alert;
    
}
@property (strong, nonatomic) IBOutlet UITextView *textField_wenben;
//评论文本
@property (strong, nonatomic) IBOutlet UILabel *_textLab;

///////订单状态
@property (strong, nonatomic) IBOutlet UILabel *stateLab;
//////订单编号lab
@property (strong, nonatomic) IBOutlet UILabel *orderNum;
///////订单结束时间
@property (strong, nonatomic) IBOutlet UILabel *overTime;
////////取衣满意度
- (IBAction)quyimanyidu:(UIButton *)sender;
////////送衣满意度
- (IBAction)songyi:(UIButton *)sender;
////////洗衣质量满意度
- (IBAction)xiyi:(UIButton *)sender;
///////评论内容

///////发表评论
- (IBAction)submit:(UIButton *)sender;
/////////block回调方法
- (id)initWithBlock:(XGJCommertBlock)dic;

//评论文本输入框
@property (strong, nonatomic) XMTextViewPlaceHolder *textPlace;
///////订单编号
@property (strong, nonatomic) NSString *numberText;
///////订单完成时间
@property (strong, nonatomic) NSString *overOrderTime;
@property (strong, nonatomic) NSString *orderOverTime;
@end
