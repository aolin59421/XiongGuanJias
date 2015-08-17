//
//  ONPQuickPayPlugin.h
//  ONPQuickPayPlugin
//
//  Created by xiaopeng on 14-4-27.
//  Copyright (c) 2014年 com.19pay. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ONPQuickPayPluginDelegate;

@interface ONPQuickPayPlugin : NSObject

@property (nonatomic, unsafe_unretained) id<ONPQuickPayPluginDelegate> delegate;

- (id)init;

- (BOOL)createInfoWithMerchantID: (NSString *) merchant_id             //商家id
                    MerchantName: (NSString *) merchant_name           //商家名字
                  MerchantUserID: (NSString *) merchant_user_id        //商家下的商户id
                         OrderID: (NSString *) order_id                //订单号
                       OrderDate: (NSString *) order_date              //下单时间
                          Amount: (NSString *) amount                  //金额
                    IdentityCode: (NSString *) identity_code           //签名
                     MerchantKey: (NSString *) merchantKey             //商家的key
                       NotifyURL: (NSString *) notify_url              //后台通知地址
                     ProductName: (NSString *) product_name            //商品名
                     ProductDesc: (NSString *) product_desc            //商品描述
                     ProductType: (NSString *) product_type            //商品类型（1.实物商品，2虚拟商品，3虚拟账户）
                        ShopName: (NSString *) shop_name               //商店名
                 BankChannelType: (int) bankChannelType                //银行通道类型是否指定（0 不指定 1 指定）
                        BankName: (NSString *) bank_name               //银行名字       0可空  1非空
                          BankId: (NSString *) bank_id                 //银行id         0可空  1非空
                    BankCardType: (NSString *) bankCard_type;          //借记卡和信用卡   0可空   1非空

- (void)showPluginInViewController:(UIViewController *)viewController;

@end

@protocol ONPQuickPayPluginDelegate <NSObject>

- (void)finishQuickPayPluginWithController:(ONPQuickPayPlugin *)controller
                                    Result:(NSDictionary *)result;

@end
