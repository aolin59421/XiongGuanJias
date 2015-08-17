//
//  BoolViewController.h
//  xiongmami
//
//  Created by iMac on 14/12/9.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"
@interface BoolViewController : UIViewController<UIAlertViewDelegate>

//判断是否有网络
- (void)testOut;
- (BOOL)connectedToNetwork;

//判断字符串是否为空
+(BOOL)jugementStringIsNil:(NSString *)str;

+(BOOL)isNOTNull:(id)object;
+(BOOL)isARRAYNOTNull:(id)object;
+(NSString*) doDevicePlatform;

@end
