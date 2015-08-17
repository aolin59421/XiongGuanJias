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

- (id) init;

- (BOOL) createInfoWithMerchantID: (NSString *) merchant_id MerchantName: (NSString *) merchant_name MerchantUserID: (NSString *) merchant_user_id OrderID: (NSString *)order_id OrderDate: (NSString *)order_date Amount: (NSString *) amount IdentityCode:(NSString *)identity_code NotifyURL: (NSString *)notify_url ProductName: (NSString *)product_name ProductDesc: (NSString *)product_desc ShopName: (NSString *)shop_name;

- (void) showPluginInViewController:(UIViewController *)viewController;

@end

@protocol ONPQuickPayPluginDelegate <NSObject>

- (void) finishQuickPayPluginWithController:(NSObject *)controller Result:(NSDictionary *)result;

@end
