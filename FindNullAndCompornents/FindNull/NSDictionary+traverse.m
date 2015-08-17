//
//  NSDictionary+traverse.m
//  33ZS
//
//  Created by MacBookAir on 14-8-4.
//  Copyright (c) 2014年 wangyu. All rights reserved.
//

#import "NSDictionary+traverse.h"
#import "NSArray+traverse.h"
@implementation NSDictionary (traverse)
- (BOOL)isDictionaryHaveNull
{
    __block BOOL isNull = NO;
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        //如果字典中的某一个key对应value的类型是字典
        if ([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSMutableDictionary class]]) {
            if ([(NSDictionary *)obj isDictionaryHaveNull]) {
                isNull = YES;
            }
        }
        //如果字典中的某一个key对应value的类型是数组
        if ([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSMutableArray class]]) {
            //遍历数组，查找其中是否有空(<null>)
            if ([(NSArray *)obj isArrayHaveNull]) {
                isNull = YES;
            }
        }
        //如果字典中的某一个key对应value是空(<null>)
        if (nil == obj || [obj isEqual:[NSNull null]]) {
            NSLog(@"key = %@ and obj = %@", key, obj);
            isNull = YES;
        }
    }];
    return isNull;
}

@end
