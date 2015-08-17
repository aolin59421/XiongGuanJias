//
//  PersonalRequest.h
//  xiongmami
//
//  Created by iMac on 14/12/2.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Interface.h"
#import "AFNetworking.h"

@interface PersonalRequest : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate,NSURLConnectionDownloadDelegate>


+ (NSArray *)withRunAndRun;

+ (NSDictionary *)withURLStr:(NSString *)URLStr
                withSetValue:(NSString *)a
                withSetValue:(NSString *)b
                withSetValue:(NSString *)c
                withSetValue:(NSString *)d
                  withForKey:(NSString *)aa
                  withForKey:(NSString *)bb
                  withForKey:(NSString *)cc
                  withForKey:(NSString *)dd;

+ (NSDictionary *)withAllUrll:(NSString *)url
                      WithDic:(NSMutableDictionary *)dic;
+ (NSDictionary *)NOTokenWithAllUrll:(NSString *)url
                             WithDic:(NSMutableDictionary *)dic;

@end
