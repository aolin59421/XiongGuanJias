//
//  PaymentViewController.h
//  xiongmami
//
//  Created by iMac on 14/11/21.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//
/*
#import <UIKit/UIKit.h>
#import "Interface.h"
#import "ONPQuickPayPlugin.h"
/////////////////////已弃用///////////////////
/////////////////////已弃用///////////////////
/////////////////////已弃用///////////////////
/////////////////////已弃用///////////////////
/////////////////////已弃用///////////////////
@interface PaymentViewController : UIViewController<UIAlertViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,doneSelect>
{
    UIButton * _ClickButton;
    
    UIAlertView *_payAlert;
    UIAlertView *_payAndremainAlert;
    UIAlertView *_aliAlert;
    
    BOOL _remainPay;//余额支付
    BOOL _otherPay;//其他支付方式
    BOOL _zhifufangshi;//支付方式
    BOOL _panduan;//判断是否1+1
    
    ////////////19pay
    NSString *_strMerchantID;
    NSString *_strMerchantName;
    NSString *_strMerchantKey;
    NSString *_strNotifyUrl;
    
    NSString *_strIdentityCode;
    ////////////alipay
    UIImageView *_image;
    
    SEL _result;
    
    NSInteger key_OK;
    
    //////////////选择器
    UIPickerView *_pickView;//支付方式选择器
    NSArray *_array_pay;//支付方式数组
    
}
@property (nonatomic, strong)UILabel *lab;

@property (nonatomic , strong)NSString *orderNumber;//订单编号
@property (nonatomic, strong) NSString *orderAmount;//订单金额

@property (nonatomic, strong) UILabel *dingdanJ;
@property (nonatomic, strong) UILabel *dingdanY;
@property (nonatomic, strong) UILabel *yueJ;//需要再支付余额


@property (nonatomic,assign) SEL result;//这里声明为属性方便在于外部传入。

//- (void)parse:(NSURL *)url application:(UIApplication *)application;

@end
 */
