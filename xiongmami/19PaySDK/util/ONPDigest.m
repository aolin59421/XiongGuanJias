//
//  ONPDigest.m
//  ONPQuickPayTest
//
//  Created by xiaopeng on 14-5-4.
//  Copyright (c) 2014年 com.19pay. All rights reserved.
//

#import "ONPDigest.h"
#import <CommonCrypto/CommonDigest.h>

#pragma mark
#pragma mark Get MD5
#pragma mark
NSString *GetMd5withKey(void *Key, int keyLen, void *Data, int length, unsigned char *Md5)
{
    unsigned char finaldigest[CC_MD5_DIGEST_LENGTH + 1] = {0, };
    CC_MD5_CTX    tempContext;
    CC_MD5_Init( &tempContext );
    CC_MD5_Update( &tempContext, Data, length );
    CC_MD5_Update( &tempContext, Key, keyLen );
    CC_MD5_Final( finaldigest, &tempContext );
    
    NSString *hex = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                     finaldigest[0], finaldigest[1],
                     finaldigest[2], finaldigest[3],
                     finaldigest[4], finaldigest[5],
                     finaldigest[6], finaldigest[7],
                     finaldigest[8], finaldigest[9],
                     finaldigest[10], finaldigest[11],
                     finaldigest[12], finaldigest[13],
                     finaldigest[14], finaldigest[15]];
    
    if (Md5 != nil) {
        for ( int i = 0; i<CC_MD5_DIGEST_LENGTH*2; i++ ){
            unsigned char aChar =[hex characterAtIndex:i];
            Md5[i] = aChar;
        }
    }
    
    return hex;
}
