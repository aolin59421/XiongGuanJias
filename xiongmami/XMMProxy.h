//
//  XMMProxy.h
//  xiongmami
//
//  Created by iMac on 14/12/31.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "XMMBaseURLRequest.h"

typedef void (^RequestCompletedHandleBlock)(NSString * resp, NSStringEncoding encoding);
typedef void (^RequestFailedHandleBlock)(NSError * error);

@interface XMMProxy : NSObject

@property (readonly ,nonatomic) BOOL loading;
@property (readonly , nonatomic) BOOL loaded;
@property (strong, nonatomic) AFHTTPRequestOperation *oper;
@property (strong, nonatomic) XMMBaseURLRequest *request;

- (void)start;
- (BOOL)isLoading;
- (BOOL)isLoaded;

+ (XMMProxy *)loadWithRequesturl:(NSString *)url
                          api:(NSString *)api
                       params:(NSDictionary *)params
                    completed:(RequestCompletedHandleBlock)completeHandleBlock
                       failed:(RequestFailedHandleBlock)failedHandleBlock;

@end
