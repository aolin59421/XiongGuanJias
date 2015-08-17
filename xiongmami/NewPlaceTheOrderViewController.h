//
//  NewPlaceTheOrderViewController.h
//  xiongmami
//
//  Created by iMac on 15/3/16.
//  Copyright (c) 2015年 杭州熊管佳电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"

@interface NewPlaceTheOrderViewController : UIViewController<UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,doneSelect,UIAlertViewDelegate>
{
    UIPickerView *_ymd_pickerView;//选择器
    UIPickerView *_time_pickerView;//
    NSArray *_TIME_array;//时间段数组
    NSArray *_YMD_Array;//年月日数组
    
    BOOL YMD;//年月日选择器判断
    BOOL TIME;//时间选择器判断
    
    BOOL mange_block_bool;//跳转判断
    
    BOOL getTimeBool;//判断是否获取了时间
    
    UIButton *_addressBtn;//添加地址按钮
    UILabel *_addressBtnLab;//添加地址按钮Lab
    
    UIAlertView *_valeAlert;//阀值提示框
    UIAlertView *_xiadanAlert;//下单提示框
}

@property (nonatomic, strong)UILabel *userLab;//用户明、手机号
@property (nonatomic, strong)UILabel *address;//地址;

////////////////////
@property (nonatomic, strong) NSString *nameStr;//用户名
@property (nonatomic, strong) NSString *cityStr;//城市名
//@property (nonatomic, strong) NSString *areaStr;
@property (nonatomic, strong) NSString *numberSte;//手机号
@property (nonatomic, strong) NSString *detailedStr;//详细地址
@property (nonatomic, strong) NSString *userId;//user——id
@property (nonatomic, strong) NSString *addrId;//地址ID
@property (nonatomic, strong) NSString *getDate;//取件日期
@property (nonatomic, strong) NSString *getTime;//取件时间
@property (nonatomic, strong) NSString *mark;//备注
@property (nonatomic, strong) NSString *sendType;
@end
