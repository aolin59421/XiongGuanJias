//
//  TopUp.h
//  xiongmami
//
//  Created by iMac on 14/11/20.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"



//@interface Product : NSObject{
//@private
//    float _price;
//    NSString *_subject;
//    NSString *_body;
//    NSString *_orderId;
//}
//
//@property (nonatomic, assign) float price;
//@property (nonatomic, retain) NSString *subject;
//@property (nonatomic, retain) NSString *body;
//@property (nonatomic, retain) NSString *orderId;
//
//@end

@interface TopUp : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,ONPQuickPayPluginDelegate>
{
    UITextField *_moeyTextFiel;
    UIImageView *_imageView;
    BOOL        PAY;
    
    UIAlertView *_unionpayAlert;
    UIAlertView *_zhifubaoAlert;
    
    //
    NSString *_strMerchantID;
    NSString *_strMerchantName;
    NSString *_strMerchantKey;
    NSString *_strNotifyUrl;
    
    NSString *_strIdentityCode;
    
    UIButton *_moneyBtn;
    UIView *_moneyView;
    
    UIButton *_wxButton;//微信按钮
    UIButton *_zfbButton;//支付宝按钮
    
    SEL _result;
}
@property (retain, nonatomic) ONPQuickPayPlugin *quickPayPlugin;

//@property (nonatomic,assign) SEL result;//这里声明为属性方便在于外部传入。
//-(void)paymentResult:(NSString *)result;
@end
