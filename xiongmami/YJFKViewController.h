//
//  YJFKViewController.h
//  xiongmami
//
//  Created by iMac on 14/11/24.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"

@interface YJFKViewController : UIViewController<UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,doneSelect>
{
    UIPickerView *_pickerView;//反馈类型选择器
    NSArray *_yjfkArray;//反馈类型数组
}
@end
