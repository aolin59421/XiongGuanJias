//
//  NSArray+traverse.m
//  LoopView
//
//  Created by MacBookAir on 14-8-6.
//  Copyright (c) 2014年 wangyu. All rights reserved.
//

#import "NSArray+traverse.h"
#import "NSDictionary+traverse.h"
@implementation NSArray (traverse)
- (BOOL)isArrayHaveNull
{
    BOOL isNull = NO;
    for (id obj in self) {
        //如果数组中的某一个value的类型是字典
        if ([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSMutableDictionary class]]) {
            if ([(NSDictionary *)obj isDictionaryHaveNull]) {
                isNull = YES;
            }
        }
        //如果数组中的某一个value的类型是数组
        if ([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSArray class]]) {
            if ([(NSArray *)obj isArrayHaveNull]) {
                isNull = YES;
            }
        }
        //如果数组中的某一个value是空(<null>)
        if (nil == obj || [obj isEqual:[NSNull null]]) {
            NSLog(@"obj is %@",obj);
            isNull = YES;
        }
    }
    return isNull;
}
@end
