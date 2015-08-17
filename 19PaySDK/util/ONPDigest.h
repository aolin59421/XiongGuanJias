//
//  ONPDigest.h
//  ONPQuickPayTest
//
//  Created by xiaopeng on 14-5-4.
//  Copyright (c) 2014年 com.19pay. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark
#pragma mark Get MD5
#pragma mark
// Get MD5 Code
NSString *GetMd5withKey(void *Key, int keyLen, void *Data, int length, unsigned char *Md5);
