//
//  AboutViewController.h
//  xiongmami
//
//  Created by iMac on 14/11/24.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"

@interface AboutViewController : UIViewController<UIAlertViewDelegate>
{
    UIAlertView *_alert;
}
@property (nonatomic ,strong) NSMutableData * receiveData;
@property (nonatomic ,strong) NSString *downUrl;
@end
