//
//  XMMProxy.m
//  xiongmami
//
//  Created by iMac on 14/12/31.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "XMMProxy.h"

@implementation XMMProxy

+ (XMMProxy *)loadWithRequesturl:(NSString *)url
                          api:(NSString *)api
                       params:(NSDictionary *)params
                    completed:(RequestCompletedHandleBlock)completeHandleBlock
                       failed:(RequestFailedHandleBlock)failedHandleBlock
{
    XMMProxy *proxy = [[XMMProxy alloc] init];
    NSURLRequest *urlReq = [proxy.request reqWithUrl:url withDic:api withParams:params];
    proxy.oper = [[AFHTTPRequestOperation alloc] initWithRequest:urlReq];
    [proxy.oper setSuccessCallbackQueue:(dispatch_get_global_queue(0, 0))];
    [proxy.oper setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (completeHandleBlock) {
            completeHandleBlock([operation responseString], [operation responseStringEncoding]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"==================================================");
        NSLog(@"加载数据失败，Error: %@", [error localizedDescription]);
        NSLog(@"Class:::%@", NSStringFromClass([self class]));
        NSLog(@"==================================================");
        
        if (failedHandleBlock) {
            failedHandleBlock(error);
        }
    }];
    
    return proxy;

}

- (void)start
{
    if (_oper && _oper.isReady) {
        [_oper start];
    }
}

- (BOOL)isLoading
{
    _loading = [_oper isExecuting];
    return _loading;
}

- (BOOL)isLoaded
{
    _loaded = [_oper isFinished];
    return _loaded;
}

@end
