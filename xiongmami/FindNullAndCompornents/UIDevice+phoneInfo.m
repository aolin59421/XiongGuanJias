//
//  UIDevice+phoneInfo.m
//  33ZS
//
//  Created by MacBookAir on 14-8-4.
//  Copyright (c) 2014年 wangyu. All rights reserved.
//

#import "UIDevice+phoneInfo.h"
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <AdSupport/AdSupport.h>
#import "OpenUDID.h"
#import "UIDevice+Extensions.h"
@implementation UIDevice (phoneInfo)
- (BOOL)sysVersionIsIOS7
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
        return YES;
    }
    return NO;
}
- (NSInteger)devtype
{
    NSString *deviceMd = [self doDeviceModel];
    NSInteger deviceTpyeCode = 0;
    NSRange iphoneRange = [deviceMd rangeOfString:@"iPhone"];
    NSRange ipadRange = [deviceMd rangeOfString:@"iPad"];
    NSRange ipodRange = [deviceMd rangeOfString:@"iPod"];
    
    if (iphoneRange.location != NSNotFound) {
        deviceTpyeCode = 1;
    } else if (ipadRange.location != NSNotFound) {
        deviceTpyeCode = 2;
    } else if (ipodRange.location != NSNotFound) {
        deviceTpyeCode = 3;
    } else {
        deviceTpyeCode = 4;
    }
    return deviceTpyeCode;
}
- (NSString *)doDeviceModel
{
    size_t size;
    int nR = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    nR = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}
- (NSString *)deviceos
{
    return [UIDevice currentDevice].systemVersion;
}
- (BOOL)jailbreak
{
    NSString *cydiaPath = @"/Applications/Cydia.app";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        return YES;
    }
    return NO;
}
- (NSDictionary *)sn
{
    NSMutableDictionary *snDict = [[NSMutableDictionary alloc] init];
    
    NSString *macAddressStr = [self macAddress];
    if (macAddressStr) {
        [snDict setObject:macAddressStr forKey:@"mac"];
    }
    
    NSString *openUDIDStr = [OpenUDID value];
    if (openUDIDStr) {
        [snDict setObject:openUDIDStr forKey:@"openudid"];
    }
    
    NSString *idfaStr = [self idfaString];
    if (idfaStr) {
        [snDict setObject:idfaStr forKey:@"idfa"];
    }

    NSString *idfvStr = [self idfvString];
    if (idfvStr) {
        [snDict setObject:idfvStr forKey:@"idfv"];
    }

    return (NSDictionary *)snDict;
}
- (void)phoneInfo_abcd
{
    
}
@end
