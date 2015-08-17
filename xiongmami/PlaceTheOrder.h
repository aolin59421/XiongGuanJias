//
//  PlaceTheOrder.h
//  xiongmami
//
//  Created by iMac on 14/11/20.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import "Interface.h"


@interface PlaceTheOrder : UIViewController<UIAlertViewDelegate>
{
    UIScrollView *_placeTheOrderScrollView;
    UIDatePicker *_dataPicker;//取件picker
    UIDatePicker *_postDataPicker;//送件picker
    UIPickerView *_pickerView;//
    
//    UILabel *_informationLab;//用户明、手机号
//    UILabel *_addressInformationLab;//地址
    UIButton *getTimeButton;//取件时间按钮
    UIButton *_getAddress;//获取用户信息按钮
    
    UIAlertView *_getAlert;
    UIAlertView *_postAlert;
    
    UIButton *_postTimeButton;
    
    UIButton *_notButton;
    
    UIButton *_timeNode;
    
    
    UIButton *_timeButton;
    UIButton *_timeNodeButton;
    
    
    BOOL CallMe;
    BOOL SpecifyTimes;
    BOOL Activation;
    
    
    BOOL BoolSpecifyTimes;//指定送衣时间
    BOOL BoolCallMeBtn;//洗好通知我
    
    BOOL getTimeBool;
    
    UIAlertView *_xiadanAlert;
    UIAlertView *_shoucixiadan;
    /////////////////////////////////////
    NSString *_nameStr;//姓名
    NSString *_cityStr;//城市
    //    NSString *_areaStr;//区域
    NSString *_numeberStr;//手机号码
    NSString *_detailedStr;//详细地址
    NSString *_userId;//用户编号
    NSString *_addrId;//区域id
    NSString *_getDate;//取件日期
    NSString *_getTime;//取件时间
    NSString *_sendDate;//送件日期
    NSString *_sendTime;//送件时间段
    NSString *_flag;//是否加急
    NSString *_mark;//备注
    NSString *_sendType;//送货类型
    
    
    ///////////
    UIImageView *_fgximageView;
    UIButton *_xiadanButton;
    
    UIView *_postTimeView;
    
    MBProgressHUD *HUD;
    
    NSString *_songjianshijianqian;//
    BOOL mange_block_bool;
    
    
    UIButton *_picVCButton;
    
    UIAlertView *_valeAlert;//阀值提示框
}

//取件
@property (nonatomic, strong)NSString *weekStr;//星期
@property (nonatomic, strong)NSString *dayStr;//天
@property (nonatomic, strong)NSString *timeStr;//时间

@property (nonatomic, strong)UILabel *weekLab;//星期
@property (nonatomic, strong)UILabel *dayLab;//天
@property (nonatomic, strong)UILabel *timeLab;//时间


//送件
@property (nonatomic, strong)UIButton *callMeButton;//电话通知我
@property (nonatomic, strong)UIButton *SpecifyTimeButton;//指定时间


@property (nonatomic, strong)NSString *postWeekStr;//星期
@property (nonatomic, strong)NSString *postDayStr;//天
@property (nonatomic, strong)NSString *postTimeStr;//时间

@property (nonatomic, strong)UILabel *postWeekLab;//星期
@property (nonatomic, strong)UILabel *postDayLab;//天
@property (nonatomic, strong)UILabel *postTimeLab;//时间

@property (nonatomic, strong)UILabel *informationLab;//用户明、手机号
@property (nonatomic, strong)UILabel *addressInformationLab;//地址;



///////////////////////////////////////
@property (nonatomic, strong) NSString *nameStr;//用户名
@property (nonatomic, strong) NSString *cityStr;//城市名
//@property (nonatomic, strong) NSString *areaStr;
@property (nonatomic, strong) NSString *numberSte;//手机号
@property (nonatomic, strong) NSString *detailedStr;//详细地址
@property (nonatomic, strong) NSString *userId;//user——id
@property (nonatomic, strong) NSString *addrId;//地址ID
@property (nonatomic, strong) NSString *getDate;
@property (nonatomic, strong) NSString *getTime;
@property (nonatomic, strong) NSString *sendDate;
@property (nonatomic, strong) NSString *sendTime;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *mark;
@property (nonatomic, strong) NSString *sendType;



@property (nonatomic, strong) UIScrollView *placeTheOrderScrollView;
@property (nonatomic, strong) UIImageView *callMeImage;//洗好通知我图片
@property (nonatomic, strong) UIImageView *specifyTimeImage;//指定送衣时间
@end
