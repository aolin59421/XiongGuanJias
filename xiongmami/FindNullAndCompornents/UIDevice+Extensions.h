//
//  UIDevice+Extensions.h
//  zheyingyong
//
//  Created by jack on 14-6-25.
//  Copyright (c) 2014年 yuzhuangbao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Extensions)

// mac
- (NSString *)macAddress;

// idfa
- (NSString *)idfaString;

// idfv
- (NSString *)idfvString;

// disk space
- (NSNumber *) totalDiskSpace;
- (NSNumber *) freeDiskSpace;

// running process
- (NSArray *)runningProcesses;

@end