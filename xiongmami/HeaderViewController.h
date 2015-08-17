//
//  HeaderViewController.h
//  xiongmami
//
//  Created by iMac on 14/11/24.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import "Interface.h"

@interface HeaderViewController : UIViewController<NIDropDownDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,doneSelect>
{
    NIDropDown *niDrop;
    UITextField *_NickNameTextField;
    
    UIPickerView *_pickerView;//选择器
    NSArray *_sex_Array;//性别数组
}
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) NSString *NickName;//昵称传值
@property (nonatomic, strong) NSString *Sex;//性别传值
@end
