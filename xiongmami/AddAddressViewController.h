//
//  AddAddressViewController.h
//  xiongmami
//
//  Created by iMac on 14/11/19.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"
#import "DropListview.h"
#import "XMTextViewPlaceHolder.h"
#import "PlaceValueEntity.h"
#import "NIDropDown.h"
#import "HexadecimalConversionUICOLOR.h"
#import "LZWCustomActionSheet.h"

@interface AddAddressViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,doneSelect>
{
    UITextField *_nameTextField;//用户名
    UITextField *_numberTextField;//用户手机号
    UILabel *_cityDrop;//用户城市
    UILabel *_areaDrop;//用户区域
    NIDropDown *cityDrop;
    NIDropDown *areaDrop;
    
    
    UIButton *_xzqyButton;
    UIButton *_xzcsButton;
    
    MBProgressHUD *HUD;

    NSArray *_city_Array;//城市数组
    NSArray *_area_Array;//区域数组
    
    BOOL _city_area_Bool;//判断是城市选择器还是区域选择器
    
    UIPickerView *_city_Picker;//城市选择器
    UIPickerView *_area_Picker;//区域选择器
}
@property (nonatomic, strong)UITextField *textView;//用户详情
@property (nonatomic, strong)UITextField *nameTextField;
@property (nonatomic, strong)UITextField *numberTextField;

@property (nonatomic, strong)NSString *textViewView;//用户详情
@property (nonatomic, strong)NSString *nameTextFieldField;
@property (nonatomic, strong)NSString *numberTextFieldField;
@property (nonatomic, strong)NSString *city;
@property (nonatomic, strong)NSString *area;

@property (nonatomic, strong)NSString *bianjidizhi;


@end
