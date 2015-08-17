//
//  ManagementAddress.h
//  xiongmami
//
//  Created by iMac on 14/11/19.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"

typedef void (^XGJBlock)(NSMutableDictionary *);

@interface ManagementAddress : UIViewController
{
    NSString *bianjidizhi ;
    NSArray *_listArray;
    MBProgressHUD *HUD;
    
    XGJBlock user_Block;
}

@property (nonatomic, strong) NSString *order_manage;

- (id)initWithBlock:(XGJBlock)dic;
@end
