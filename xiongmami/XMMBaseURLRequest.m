//
//  XMMBaseURLRequest.m
//  xiongmami
//
//  Created by iMac on 14/12/31.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "XMMBaseURLRequest.h"
#import "NSString+category.h"
#import "UIDevice+phoneInfo.h"

#import "JSONKit.h"
#import "GTMBase64.h"
#import "AFNetworking.h"

@implementation XMMBaseURLRequest

- (NSDictionary *)query
{
//    NSString *pStr = [_params JSONString];
    NSDictionary *dic = [[NSDictionary alloc] init];

    return dic;
}

- (id)initWithNone
{
    if (self = [super init]) {
        
    }
    
    return self;
}

- (NSURLRequest *)reqWithUrl:(NSString *)urls withDic:(NSString *)cell withParams:(NSDictionary *)params
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",urls,cell];
    NSURL *url = [NSURL URLWithString:urlStr];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSMutableURLRequest *afRequest;
    
    afRequest = [httpClient requestWithMethod:@"POST" path:nil parameters:params];
    [afRequest setTimeoutInterval:10];
    
    return afRequest;
}


//要提交的数据中是否包含图片数据
- (BOOL)imageInclude{return YES;}

//接口是否需要授权才能调用
- (BOOL)isPrivate{return YES;}
@end
