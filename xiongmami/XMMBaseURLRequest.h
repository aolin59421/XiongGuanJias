//
//  XMMBaseURLRequest.h
//  xiongmami
//
//  Created by iMac on 14/12/31.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Interface.h"

@interface XMMBaseURLRequest : NSObject
@property (readonly ,nonatomic) NSMutableDictionary *params;


//无参数初始化
- (id)initWithNone;

//需要提交的参数
- (NSDictionary *)query;

//封装后的查询请求
- (NSURLRequest *)reqWithUrl:(NSString *)url withDic:(NSString *)cell withParams:(NSDictionary *)params;


//要提交的数据中是否包含图片数据
- (BOOL)imageInclude;

//接口是否需要授权才能调用
- (BOOL)isPrivate;
@end
