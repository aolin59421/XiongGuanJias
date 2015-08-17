//
//  PayPlugin.h
//  xiongmami
//
//  Created by iMac on 14/12/18.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayPlugin : NSObject


//用户ID
@property (nonatomic, retain) NSString *strUserID;
//产品商家
@property (nonatomic, retain) NSString *strShopName;
//产品名称
@property (nonatomic, retain) NSString *strProductName;
//产品描述
@property (nonatomic, retain) NSString *strProductDesc;
//产品价格
@property (nonatomic, retain) NSString *strAmount;

- (id) initWithUserID:(NSString *)userID ShopName:(NSString *)shopName ProductName:(NSString *)productName ProductDesc:(NSString *)productDesc Amount:(NSString *)amount;


@end
