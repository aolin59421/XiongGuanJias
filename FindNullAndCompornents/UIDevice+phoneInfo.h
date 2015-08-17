//
//  UIDevice+phoneInfo.h
//  33ZS
//
//  Created by MacBookAir on 14-8-4.
//  Copyright (c) 2014年 wangyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (phoneInfo)
- (NSInteger)devtype;
- (NSString *)deviceos;
- (BOOL)jailbreak;
- (NSDictionary *)sn;
- (BOOL)sysVersionIsIOS7;
@end
