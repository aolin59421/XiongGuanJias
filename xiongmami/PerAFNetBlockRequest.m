//
//  PerAFNetBlockRequest.m
//  xiongmami
//
//  Created by iMac on 15/3/18.
//  Copyright (c) 2015年 杭州熊管佳电子商务有限公司. All rights reserved.
//

#import "PerAFNetBlockRequest.h"

@implementation PerAFNetBlockRequest

+(PerAFNetBlockRequest *)AFNRequest:(NSString *)request
                           dic:(NSMutableDictionary *)dictionary
                      AFNBlock:(RequestAFNetWorkingBlock)AFNetBlock
                       AFNEror:(RequestAFNetWorkingBlockError)AFNError
{
    PerAFNetBlockRequest *personal = [[PerAFNetBlockRequest alloc] init];
    personal.operManager = [AFHTTPRequestOperationManager manager];
    personal.operManager.requestSerializer.timeoutInterval = 30;
    personal.operManager.responseSerializer = [AFJSONResponseSerializer serializer];
    personal.operManager.requestSerializer = [AFJSONRequestSerializer serializer];
    personal.operManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    //CESHI_NETWORK是请求网址
    NSString *URL = [NSString stringWithFormat:@"%@%@",CESHI_NETWORK,request];
    //USER_TOKEN(QQQQ)是加密参数 根据请款可用可不用
    [dictionary setValue:USER_TOKEN(QQQQ) forKey:@"skey"];
    NSLog(@"dicyionary-%@",dictionary);
    [personal.operManager POST:URL parameters:dictionary success:^(AFHTTPRequestOperation *operation,id resopnseJect){
        if (AFNetBlock) {
            AFNetBlock([operation responseObject],[operation responseStringEncoding]);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"operation-%@,error-%@",operation,error);
        if (AFNError) {
            AFNError(error);
        }
    }];
    
    return personal;
}


@end
