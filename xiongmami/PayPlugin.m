//
//  PayPlugin.m
//  xiongmami
//
//  Created by iMac on 14/12/18.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "PayPlugin.h"

@implementation PayPlugin
@synthesize strUserID,strShopName,strProductName,strProductDesc,strAmount;

- (id) init
{
    self = [super init];
    if (self != nil) {
        strUserID = @"";
        strShopName = @"";
        strProductName = @"";
        strProductDesc = @"";
        strAmount = @"";
    }
    return self;
}

- (id) initWithUserID:(NSString *)userID ShopName:(NSString *)shopName ProductName:(NSString *)productName ProductDesc:(NSString *)productDesc Amount:(NSString *)amount {
    strUserID = userID;
    strShopName = shopName;
    strProductName = productName;
    strProductDesc = productDesc;
    strAmount = amount;
    
    return self;
}

- (void)dealloc
{
    [self setStrUserID:nil];
    [self setStrShopName:nil];
    [self setStrProductName:nil];
    [self setStrProductDesc:nil];
    [self setStrAmount:nil];
}
@end
