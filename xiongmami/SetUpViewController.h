//
//  SetUpViewController.h
//  xiongmami
//
//  Created by iMac on 14/11/24.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"
#import "UMSocialControllerService.h"

@interface SetUpViewController : UIViewController<UMSocialUIDelegate,UITextFieldDelegate>

@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;

@end
