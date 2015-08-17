//
//  PerAFNetBlockRequest.h
//  xiongmami
//
//  Created by iMac on 15/3/18.
//  Copyright (c) 2015年 杭州熊管佳电子商务有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Interface.h"
typedef void (^RequestAFNetWorkingBlock)(NSDictionary *resp,NSStringEncoding encoding);
typedef void (^RequestAFNetWorkingBlockError)(NSError * error);

@interface PerAFNetBlockRequest : NSObject
@property (strong, nonatomic)AFHTTPRequestOperationManager *operManager;

+(PerAFNetBlockRequest *)AFNRequest:(NSString *)request
                           dic:(NSDictionary *)dictionary
                      AFNBlock:(RequestAFNetWorkingBlock)AFNetBlock
                       AFNEror:(RequestAFNetWorkingBlockError)AFNError;

@end
