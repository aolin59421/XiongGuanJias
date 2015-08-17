//
//  NewPayViewController.h
//  xiongmami
//
//  Created by iMac on 15/3/23.
//  Copyright (c) 2015年 杭州熊管佳电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"
#import "OtherPay.h"

@interface NewPayViewController : UIViewController<UIAlertViewDelegate,ONPQuickPayPluginDelegate>
{
    //订单金额
    UILabel *_moneyNumb;
    //红包数量
    UILabel *_giftsLab;
    //红包金额
    UILabel *_gifts_money;
    //箭头
    UIImageView *_hongbaoSLImage;
    //抵用红包按钮
    UIButton *_giftsBtn;
    //抵用红包状态变化
    UILabel *_hongbaoSL;
    ////////////////////
    //支付金额（移动）
    UILabel *_gifts_mob;
    //订单编号
    UILabel *_Numb;
    //实付金额
    UILabel *_sfMoney;
    
    //余额image
    UIImageView *_ye_image;
    //现金image
    UIImageView *_money_image;
    //支付宝image
    UIImageView *_aLiPay_image;
    //网银image
    UIImageView *_19Pay_image;
    
    //余额bool
    BOOL _ye_bool;
    //现金bool
    BOOL _money_bool;
    //支付宝bool
    BOOL _aLiPay_bool;
    //网银bool
    BOOL _19pay_bool;
    
    //确定按钮
    UIButton *_OK_Button;
    
    //down view
    UIView *_downView;
    
    //余额
    NSString *_outMoney;
    
    //余额付款提示框
    UIAlertView *_outMoney_Alert;
    //红包付款提示框
    UIAlertView *_giftsMoney_Alert;
    //现金付款提示框
    UIAlertView *_money_Alert;
    //网银付款提示框
    UIAlertView *_payMoney_Alert;
    //支付宝支付
    UIAlertView *_aliMoney_Alert;
    //返回上一页
    UIAlertView *_back_Alert;
    //回调记录所选红包编号
    NSArray *_gifts_Array;
    ////////////////////
    /*
     *19Pay
     */
    NSString *_strMerchantID;//商家ID
    NSString *_strMerchantName;//商家名
    NSString *_strMerchantKey;//19Pay商家密钥
    NSString *_strNotifyUrl;//回调URL
    NSString *_strIdentityCode;//生成商家权限验证码
}
//////订单编号
@property (nonatomic, strong)NSString *numbMoney;
//////订单金额
@property (nonatomic, strong)NSString *orderAmount;
//////快捷支付插件
@property (retain, nonatomic) ONPQuickPayPlugin *quickPayPlugin;
@end
