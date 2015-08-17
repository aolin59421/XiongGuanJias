//
//  NewPlaceTheOrderViewController.m
//  xiongmami
//
//  Created by iMac on 15/3/16.
//  Copyright (c) 2015年 杭州熊管佳电子商务有限公司. All rights reserved.
//

#import "NewPlaceTheOrderViewController.h"
#import "AddAddressViewController.h"
#import "ManagementAddress.h"

@interface NewPlaceTheOrderViewController ()
{
    XMTextViewPlaceHolder*_textView;
    UILabel *_TIMELab;//时间段
    UILabel *_YMDLab;//年月日
}
@end

@implementation NewPlaceTheOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"下单";
    self.view.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#f8f3f0"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(bback)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    mange_block_bool = YES;
    getTimeBool= NO;
    // Do any additional setup after loading the view.
    [self chooseTime];
    [self chooseAddress];
    [self clickOk];
    [self getTimes];
//    [self getUser];
}

- (void)bback
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark - 选择取件时间
- (void)chooseTime
{
    UIView *chooseView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, 215/2)];
    [chooseView setBackgroundColor:[UIColor whiteColor]];
    chooseView.layer.borderColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#dee2e5"].CGColor;
    chooseView.layer.borderWidth = 0.5;
    [self.view addSubview:chooseView];
    
    UILabel *fengexian = [[UILabel alloc] initWithFrame:CGRectMake(0, 75/2, VIEW_FRAME_SIZE_WIDTH, 0.5)];
    [fengexian setBackgroundColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#dee2e5"]];
    [chooseView addSubview:fengexian];
    
    UIImageView *timeImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 15, 15)];
    [timeImage setImage:[UIImage imageNamed:@"time.png"]];
    [chooseView addSubview:timeImage];
    
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(35, 15, 100, 15)];
    [timeLab setText:@"选择取件时间"];
    [timeLab setFont:[UIFont systemFontOfSize:15]];
    [chooseView addSubview:timeLab];
    
    _YMDLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 52.5f, 140, 35)];
    _YMDLab.text = [self getNowTime];
    [_YMDLab setFont:[UIFont systemFontOfSize:17]];
    [_YMDLab setTextAlignment:NSTextAlignmentCenter];
    [_YMDLab setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#3b3631"]];
    _YMDLab.layer.cornerRadius = 5;
    _YMDLab.layer.borderWidth = 0.5f;
    _YMDLab.layer.borderColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#dee2e5"].CGColor;
    [chooseView addSubview:_YMDLab];
    
    UIButton *YMDBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [YMDBtn setFrame:CGRectMake(15, 52.5, 140, 35)];
    [YMDBtn setBackgroundColor:[UIColor clearColor]];
    [YMDBtn setTag:1];
    [YMDBtn addTarget:self action:@selector(pushPickerView:) forControlEvents:UIControlEventTouchUpInside];
    [chooseView addSubview:YMDBtn];
    
    _TIMELab = [[UILabel alloc] initWithFrame:CGRectMake(165, 52.5f, 140, 35)];
    _TIMELab.text = @"请选择时间";
    [_TIMELab setFont:[UIFont systemFontOfSize:17]];
    [_TIMELab setTextAlignment:NSTextAlignmentCenter];
    _TIMELab.layer.cornerRadius = 5;
    [_TIMELab setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#3b3631"]];
    _TIMELab.layer.borderWidth = 0.5f;
    _TIMELab.layer.borderColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#dee2e5"].CGColor;
    [chooseView addSubview:_TIMELab];
    
    UIButton *TIMEBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [TIMEBtn setFrame:CGRectMake(164, 52.5, 140, 35)];
    [TIMEBtn setBackgroundColor:[UIColor clearColor]];
    [TIMEBtn setTag:2];
    [TIMEBtn addTarget:self action:@selector(pushPickerView:) forControlEvents:UIControlEventTouchUpInside];
    [chooseView addSubview:TIMEBtn];
    
    if (iPhone6Plus) {
        [chooseView setFrame:CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, 370/3)];
        [fengexian setFrame:CGRectMake(0, 148/3, VIEW_FRAME_SIZE_WIDTH, 0.5)];
        [timeImage setFrame:CGRectMake(60/3, 50/3, 55/3, 55/3)];
        [timeLab setFrame:CGRectMake(120/3, 50/3, (58*6)/3, 58/3)];
        [timeLab setFont:[UIFont systemFontOfSize:58/3]];
        [_YMDLab setFrame:CGRectMake(60/3, 188/3, 540/3, 142/3)];
        [_YMDLab setFont:[UIFont systemFontOfSize:50/3]];
        [YMDBtn setFrame:CGRectMake(60/3, 188/3, 540/3, 142/3)];
        [_TIMELab setFrame:CGRectMake(640/3, 188/3, 540/3, 142/3)];
        [_TIMELab setFont:[UIFont systemFontOfSize:50/3]];
        [TIMEBtn setFrame:CGRectMake(640/3, 188/3, 540/3, 142/3)];
    }else if (iPhone6){
        [chooseView setFrame:CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, 110)];
        [fengexian setFrame:CGRectMake(0, 90/2, VIEW_FRAME_SIZE_WIDTH, 0.5)];
        [timeImage setFrame:CGRectMake(20, 15, 35/2, 35/2)];
        [timeLab setFrame:CGRectMake(42.5, 15, (30*6)/2, 30/2)];
        [timeLab setFont:[UIFont systemFontOfSize:15]];
        [_YMDLab setFrame:CGRectMake(20, 114/2, 323/2, 41)];
        [_YMDLab setFont:[UIFont systemFontOfSize:17]];
        [YMDBtn setFrame:CGRectMake(20, 114/2, 323/2, 41)];
        [_TIMELab setFrame:CGRectMake(387/2, 114/2, 323/2, 41)];
        [_TIMELab setFont:[UIFont systemFontOfSize:17]];
        [TIMEBtn setFrame:CGRectMake(387/2, 114/2, 323/2, 41)];
    }
}

#pragma  mark - 获取当前年月日
- (NSString *)getNowTime
{
    NSDate *sendDate = [NSDate date];
    //当前天
    NSDateFormatter *dateForMatter = [[NSDateFormatter alloc] init];
    [dateForMatter setDateFormat:@"dd"];
    NSString *locationString = [dateForMatter stringFromDate:sendDate];
    NSInteger day = [locationString integerValue];
    //当前时
    NSDateFormatter  *dateformatter4=[[NSDateFormatter alloc] init];
    [dateformatter4 setDateFormat:@"HH"];
    NSString *  locationString4=[dateformatter4 stringFromDate:sendDate];
    NSInteger hour = [locationString4 integerValue];
    //当前月
    NSDateFormatter  *dateformatter1=[[NSDateFormatter alloc] init];
    [dateformatter1 setDateFormat:@"MM"];
    NSString *  locationString1=[dateformatter1 stringFromDate:sendDate];
    NSInteger month = [locationString1 integerValue];
    if (hour >=18) {
        day = day+1;
        return [NSString stringWithFormat:@"%ld/%@/%@",(long)[self withTTTYYYY:day withMM:month withchae:0],[self withTY:day withTYchae:0],[self withdd:day withchae:0]];
    }else{
        return [NSString stringWithFormat:@"%ld/%@/%@",(long)[self withTTTYYYY:day withMM:month withchae:0],[self withTY:day withTYchae:0],[self withdd:day withchae:0]];
    }
}
#pragma  mark - 选择取件地址
- (void)chooseAddress
{
    UIView *choosAddressView = [[UIView alloc] initWithFrame:CGRectMake(0, 181.5, VIEW_FRAME_SIZE_WIDTH, 195/2)];
    [choosAddressView setBackgroundColor:[UIColor whiteColor]];
    choosAddressView.layer.borderColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#dee2e5"].CGColor;
    choosAddressView.layer.borderWidth = 0.5;
    [self.view addSubview:choosAddressView];
    
    UIImageView *addressImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 15, 15)];
    [addressImage setImage:[UIImage imageNamed:@"map.png"]];
    [choosAddressView addSubview:addressImage];
    
    UILabel *fengexian = [[UILabel alloc] initWithFrame:CGRectMake(0, 75/2, VIEW_FRAME_SIZE_WIDTH, 0.5)];
    [fengexian setBackgroundColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#dee2e5"]];
    [choosAddressView addSubview:fengexian];
    UILabel *addressLab = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, 100, 15)];
    [addressLab setText:@"选择取件地址"];
    [addressLab setFont:[UIFont systemFontOfSize:15]];
    [choosAddressView addSubview:addressLab];
    
     _userLab= [[UILabel alloc] initWithFrame:CGRectMake(15, 47.5, 300, 15)];
    [_userLab setText:@"陈先生 15899999999"];
    [_userLab setFont:[UIFont systemFontOfSize:17]];
    [_userLab setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#3b3631"]];
    [_userLab setTextAlignment:NSTextAlignmentLeft];
    [choosAddressView addSubview:_userLab];
    
     _address= [[UILabel alloc] initWithFrame:CGRectMake(15, 72.5, 300, 15)];
    [_address setText:@"西湖区西溪花园1幢2单元3室"];
    [_address setFont:[UIFont systemFontOfSize:16]];
    [_address setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#9ba2b2"]];
    [_address setTextAlignment:NSTextAlignmentLeft];
    [choosAddressView addSubview:_address];
    
    UIImageView *xImage = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 57.5, 10, 20)];
    [xImage setImage:[UIImage imageNamed:@"箭头@3x.png"]];
    [choosAddressView addSubview:xImage];
    
    _addressBtnLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 42.5, VIEW_FRAME_SIZE_WIDTH-15, 52.5)];
    [_addressBtnLab setBackgroundColor:[UIColor clearColor]];
    [_addressBtnLab setTextColor:[UIColor blackColor]];
    [_addressBtnLab setTextAlignment:NSTextAlignmentLeft];
    [choosAddressView addSubview:_addressBtnLab];
    
    _addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addressBtn setFrame:CGRectMake(0, 37.5, VIEW_FRAME_SIZE_WIDTH, 52.5)];
    [_addressBtn addTarget:self action:@selector(pushManagementAddress) forControlEvents:UIControlEventTouchUpInside];
    [_addressBtn setBackgroundColor:[UIColor clearColor]];
    [choosAddressView addSubview:_addressBtn];
    
    if (iPhone6Plus) {
        [choosAddressView setFrame:CGRectMake(0, 410/3+64, VIEW_FRAME_SIZE_WIDTH, 350/3)];
        [addressImage setFrame:CGRectMake(60/3, 40/3, 55/3, 55/3)];
        [fengexian setFrame:CGRectMake(0, 135/3, VIEW_FRAME_SIZE_WIDTH, 0.5)];
        [addressLab setFrame:CGRectMake(120/3, 40/3, (58*6)/3, 55/3)];
        [addressLab setFont:[UIFont systemFontOfSize:58/3]];
        [_userLab setFrame:CGRectMake(120/3, 165/3, (58*16)/3, 58/3)];
        [_userLab setFont:[UIFont systemFontOfSize:58/3]];
        [_address setFrame:CGRectMake(120/3, (165+58+40)/3, (58*15)/3, 48/3)];
        [_address setFont:[UIFont systemFontOfSize:48/3]];
        [xImage setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH-40, 211/3, 30/3, 60/3)];
    }else if (iPhone6){
        [choosAddressView setFrame:CGRectMake(0, 244/2+64, VIEW_FRAME_SIZE_WIDTH, 210/2)];
        [addressImage setFrame:CGRectMake(20, 25/2, 35/2, 35/2)];
        [fengexian setFrame:CGRectMake(0, 40, VIEW_FRAME_SIZE_WIDTH, 0.5)];
        [addressLab setFrame:CGRectMake(42.5, 25/2, (30*6)/2, 30/2)];
        [addressLab setFont:[UIFont systemFontOfSize:15]];
        [_userLab setFrame:CGRectMake(20, 53, (34*15)/2, 34/2)];
        [_userLab setFont:[UIFont systemFontOfSize:17]];
        [_address setFrame:CGRectMake(20, 78, 20*15, 16)];
        [_address setFont:[UIFont systemFontOfSize:16]];
        [xImage setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH-40, 125/2, 10, 20)];
    }
}
#pragma  mark - 时间选择器
- (void)pushPickerView:(UIButton *)sender
{
//    NSLog(@"时间选择器-%ld",(long)sender.tag);
    if (sender.tag == 1) {
        YMD = YES;
        TIME = NO;
        _YMD_Array = [self getTimes];
        [_time_pickerView removeFromSuperview];
        _ymd_pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 216)];
        _ymd_pickerView.dataSource = self;
        _ymd_pickerView.delegate = self;
        _ymd_pickerView.backgroundColor = [UIColor whiteColor];
        
        LZWCustomActionSheet *actionSheet = [[LZWCustomActionSheet alloc] initWithView:_ymd_pickerView AndHeight:260];
        actionSheet.doneDelegate = self;
        [actionSheet showInView:self.view];
    }else if (sender.tag == 2){
        YMD = NO;
        TIME = YES;
        _TIME_array = [self gettimeNode];
        [_ymd_pickerView removeFromSuperview];
        _time_pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 216)];
        _time_pickerView.dataSource = self;
        _time_pickerView.delegate = self;
        _time_pickerView.backgroundColor = [UIColor whiteColor];
        
        LZWCustomActionSheet *actionSheet = [[LZWCustomActionSheet alloc] initWithView:_time_pickerView AndHeight:260];
        actionSheet.doneDelegate = self;
        [actionSheet showInView:self.view];
    }
}

#pragma  mark - push添加地址
- (void)pushManagementAddress
{
//    NSLog(@"进入选择地址界面");
    if ([_addressBtnLab.text rangeOfString:@"请先点击填写取件地址"].location != NSNotFound) {
        AddAddressViewController *add = [[AddAddressViewController alloc] init];
        [self.navigationController pushViewController:add animated:YES];
    }else{
        ManagementAddress *management = [[ManagementAddress alloc] initWithBlock:(^(NSMutableDictionary *dic){
            
            self.nameStr = [dic valueForKey:@"username"];
            self.cityStr = [dic valueForKey:@"area_name"];
            self.numberSte = [dic valueForKey:@"mobile"];
            self.detailedStr = [dic valueForKey:@"address"];
            self.addrId = [dic valueForKey:@"addr_id"];
            
//            NSLog(@"姓名%@",[dic valueForKey:@"username"]);
//            NSLog(@"地址城市区域%@",[dic valueForKey:@"area_name"]);
//            NSLog(@"手机%@",[dic valueForKey:@"mobile"]);
//            NSLog(@"详细地址%@",[dic valueForKey:@"address"]);
//            NSLog(@"地址编号%@",[dic valueForKey:@"addr_id"]);
            
            _userLab.text = [NSString stringWithFormat:@"%@   %@",self.nameStr,self.numberSte];
            _address.text = [NSString stringWithFormat:@"%@ %@",self.cityStr,self.detailedStr];
            [_addressBtnLab setText:@""];
            mange_block_bool = NO;
        })];
        mange_block_bool = YES;
        management.order_manage = @"1";
        [self.navigationController pushViewController:management animated:YES];
    }
    
}
#pragma  mark - 备注及下单
- (void)clickOk
{
    _textView = [[XMTextViewPlaceHolder alloc] initWithFrame:CGRectMake(0, 288, VIEW_FRAME_SIZE_WIDTH, 75)];
    _textView.placeholder = @"   若您对订单有特殊要求，可在此备注！";
    _textView.placeholderFont = @"17";
    _textView.placeholderColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#b4bac5"];
    _textView.layer.borderColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#dee2e5"].CGColor;
    [_textView setFont:[UIFont systemFontOfSize:17]];
    _textView.layer.borderWidth = 0.5;
    _textView.layer.masksToBounds = YES;
    _textView.delegate = self;
    _textView.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_textView];
    
    UIButton *OKBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [OKBtn setFrame:CGRectMake(15, 383, 290, 40)];
    [OKBtn setBackgroundImage:[UIImage imageNamed:@"保存btn.png"] forState:UIControlStateNormal];
    [OKBtn addTarget:self action:@selector(postTJ) forControlEvents:UIControlEventTouchUpInside];
    [OKBtn setTitle:@"立即下单" forState:UIControlStateNormal];
    [OKBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:OKBtn];
    
    if (iPhone6Plus) {
        [_textView setFrame:CGRectMake(0, 800/3+64, VIEW_FRAME_SIZE_WIDTH, 295/3)];
        [_textView setFont:[UIFont systemFontOfSize:58/3]];
        [_textView setPlaceholderFont:[NSString stringWithFormat:@"%d",58/3]];
        [OKBtn setFrame:CGRectMake(20, (880+295)/3+64, VIEW_FRAME_SIZE_WIDTH-40, 170/3)];
        [OKBtn.titleLabel setFont:[UIFont systemFontOfSize:58/3]];
    }else if (iPhone6){
        [_textView setFrame:CGRectMake(0, 478/2+64, VIEW_FRAME_SIZE_WIDTH, 175/2)];
        [OKBtn setFrame:CGRectMake(20, 703/2+64, VIEW_FRAME_SIZE_WIDTH-40, 40)];
        [OKBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
    }
}

#pragma  mark - 下单
- (void)postTJ
{
    //取件日期
    NSMutableString *getdata = [NSMutableString stringWithFormat:@"%@",_YMDLab.text];
    self.getDate = [self withNSString:getdata];
    //取件时间
    NSMutableString *gettime = [NSMutableString stringWithFormat:@"%@",_TIMELab.text];
    self.getTime = [self tjWithtime:gettime];
    //备注
    self.mark = _textView.text;
    
    if ([_addressBtnLab.text rangeOfString:@"请先点击填写取件地址"].location !=NSNotFound) {
        UIAlertView *shouci = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请确认用户信息是否正确" delegate:self cancelButtonTitle:@"返回检查" otherButtonTitles:nil];
        [shouci show];
    } else if (getTimeBool == NO){
        
        UIAlertView *shouci = [[UIAlertView alloc] initWithTitle:@"提示" message:@"\n请选择取件时间" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [shouci show];
        
    }else{
        _xiadanAlert= [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确定信息填写正确？" delegate:self cancelButtonTitle:@"确定下单" otherButtonTitles: @"返回检查",nil];
        _xiadanAlert.delegate = self;
        [_xiadanAlert show];
    }
}

#pragma  mark - 点击空白处收起键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textView resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [_textView resignFirstResponder];
        
        return NO;
    }
    return YES;
}

#pragma  mark - 选择取件时间

- (NSArray *)getTimes
{
    NSArray *array =[[NSArray alloc] init];
    NSDate *sendDate = [NSDate date];
    //当前天
    NSDateFormatter *dateForMatter = [[NSDateFormatter alloc] init];
    [dateForMatter setDateFormat:@"dd"];
    NSString *locationString = [dateForMatter stringFromDate:sendDate];
    NSInteger day = [locationString integerValue];
    //当前时
    NSDateFormatter  *dateformatter4=[[NSDateFormatter alloc] init];
    [dateformatter4 setDateFormat:@"HH"];
    NSString *  locationString4=[dateformatter4 stringFromDate:sendDate];
    NSInteger hour = [locationString4 integerValue];
    //当前月
    NSDateFormatter  *dateformatter1=[[NSDateFormatter alloc] init];
    [dateformatter1 setDateFormat:@"MM"];
    NSString *  locationString1=[dateformatter1 stringFromDate:sendDate];
    NSInteger month = [locationString1 integerValue];
    
    if (hour >=18) {
        day = day +1;
        array = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%ld/%@/%@",(long)[self withTTTYYYY:day withMM:month withchae:0],[self withTY:day withTYchae:0],[self withdd:day withchae:0]],[NSString stringWithFormat:@"%ld/%@/%@",(long)[self withTTTYYYY:day withMM:month withchae:1],[self withTY:day withTYchae:1],[self withdd:day withchae:1]],[NSString stringWithFormat:@"%ld/%@/%@",(long)[self withTTTYYYY:day withMM:month withchae:2],[self withTY:day withTYchae:2],[self withdd:day withchae:2]],[NSString stringWithFormat:@"%ld/%@/%@",(long)[self withTTTYYYY:day withMM:month withchae:3],[self withTY:day withTYchae:3],[self withdd:day withchae:3]],[NSString stringWithFormat:@"%ld/%@/%@",(long)[self withTTTYYYY:day withMM:month withchae:4],[self withTY:day withTYchae:4],[self withdd:day withchae:4]],[NSString stringWithFormat:@"%ld/%@/%@",(long)[self withTTTYYYY:day withMM:month withchae:5],[self withTY:day withTYchae:5],[self withdd:day withchae:5]],[NSString stringWithFormat:@"%ld/%@/%@",(long)[self withTTTYYYY:day withMM:month withchae:6],[self withTY:day withTYchae:6],[self withdd:day withchae:6]], nil];
        return array;
    }else{
//        NSLog(@"y-%d,m-%@,d-%@",[self withTTTYYYY:day withMM:month withchae:3],[self withTY:day withTYchae:3],[self withdd:day withchae:3]);
        array = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%ld/%@/%@",(long)[self withTTTYYYY:day withMM:month withchae:0],[self withTY:day withTYchae:0],[self withdd:day withchae:0]],[NSString stringWithFormat:@"%ld/%@/%@",(long)[self withTTTYYYY:day withMM:month withchae:1],[self withTY:day withTYchae:1],[self withdd:day withchae:1]],[NSString stringWithFormat:@"%ld/%@/%@",(long)[self withTTTYYYY:day withMM:month withchae:2],[self withTY:day withTYchae:2],[self withdd:day withchae:2]],[NSString stringWithFormat:@"%ld/%@/%@",(long)[self withTTTYYYY:day withMM:month withchae:3],[self withTY:day withTYchae:3],[self withdd:day withchae:3]],[NSString stringWithFormat:@"%ld/%@/%@",(long)[self withTTTYYYY:day withMM:month withchae:4],[self withTY:day withTYchae:4],[self withdd:day withchae:4]],[NSString stringWithFormat:@"%ld/%@/%@",(long)[self withTTTYYYY:day withMM:month withchae:5],[self withTY:day withTYchae:5],[self withdd:day withchae:5]],[NSString stringWithFormat:@"%ld/%@/%@",(long)[self withTTTYYYY:day withMM:month withchae:6],[self withTY:day withTYchae:6],[self withdd:day withchae:6]], nil];
        return array;
    }
}

#pragma  mark - 取件时间段
- (NSArray *)gettimeNode
{
    NSArray * arr = [[NSArray alloc] init];
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    NSInteger i = [locationString integerValue];
    
    NSDateFormatter  *dateformatter1=[[NSDateFormatter alloc] init];
    [dateformatter1 setDateFormat:@"mm"];
    NSString *  locationString1=[dateformatter1 stringFromDate:senddate];
    NSInteger ii = [locationString1 integerValue];
    
//    NSLog(@"%ld点%ld分",(long)i,(long)ii);
    if (ii >= 59) {
        
        i=i+1;
        
    }
    if ([_YMDLab.text isEqualToString:[self getNowTime]] == NO) {
        
//        NSLog(@"YMD-%@---GETNOWTIME-%@",_YMDLab.text,[self getNowTime]);
        arr = [NSArray arrayWithObjects:@"9:00-10:00",@"10:00-11:00",@"11:00-12:00",@"12:00-13:00",@"13:00-14:00",@"14:00-15:00",@"15:00-16:00",@"16:00-17:00",@"17:00-18:00",@"18:00-19:00",@"19:00-20:00", nil];
        return arr;
    }else{
        if (i == 7) {
            
            arr = [NSArray arrayWithObjects:@"9:00-10:00",@"10:00-11:00",@"11:00-12:00",@"12:00-13:00",@"13:00-14:00",@"14:00-15:00",@"15:00-16:00",@"16:00-17:00",@"17:00-18:00",@"18:00-19:00",@"19:00-20:00", nil];
            
            return arr;
        } else if (i == 8) {
            
            
            arr = [NSArray arrayWithObjects:@"10:00-11:00",@"11:00-12:00",@"12:00-13:00",@"13:00-14:00",@"14:00-15:00",@"15:00-16:00",@"16:00-17:00",@"17:00-18:00",@"18:00-19:00",@"19:00-20:00", nil];
            
            return arr;
        } else if (i == 9){
            
            arr = [NSArray arrayWithObjects:@"11:00-12:00",@"12:00-13:00",@"13:00-14:00",@"14:00-15:00",@"15:00-16:00",@"16:00-17:00",@"17:00-18:00",@"18:00-19:00",@"19:00-20:00", nil];
            
            return arr;
        } else if (i == 10) {
            
            arr = [NSArray arrayWithObjects:@"12:00-13:00",@"13:00-14:00",@"14:00-15:00",@"15:00-16:00",@"16:00-17:00",@"17:00-18:00",@"18:00-19:00",@"19:00-20:00", nil];
            
            return arr;
        } else if (i == 11){
            
            arr = [NSArray arrayWithObjects:@"13:00-14:00",@"14:00-15:00",@"15:00-16:00",@"16:00-17:00",@"17:00-18:00",@"18:00-19:00",@"19:00-20:00", nil];
            
            return arr;
        } else if (i == 12) {
            
            arr = [NSArray arrayWithObjects:@"14:00-15:00",@"15:00-16:00",@"16:00-17:00",@"17:00-18:00",@"18:00-19:00",@"19:00-20:00", nil];
            
            return arr;
        } else if (i == 13) {
            
            arr = [NSArray arrayWithObjects:@"15:00-16:00",@"16:00-17:00",@"17:00-18:00",@"18:00-19:00",@"19:00-20:00", nil];
            
            return arr;
        } else if (i == 14) {
            
            arr = [NSArray arrayWithObjects:@"16:00-17:00",@"17:00-18:00",@"18:00-19:00",@"19:00-20:00", nil];
            
            return arr;
        } else if (i == 15){
            
            arr = [NSArray arrayWithObjects:@"17:00-18:00",@"18:00-19:00",@"19:00-20:00", nil];
            
            return arr;
        } else if (i == 16) {
            
            arr = [NSArray arrayWithObjects:@"18:00-19:00",@"19:00-20:00", nil];
            
            return arr;
        } else if (i == 17){
            
            arr = [NSArray arrayWithObjects:@"19:00-20:00", nil];
            
            return arr;
        } else {
            
            arr = [NSArray arrayWithObjects:@"9:00-10:00",@"10:00-11:00",@"11:00-12:00",@"12:00-13:00",@"13:00-14:00",@"14:00-15:00",@"15:00-16:00",@"16:00-17:00",@"17:00-18:00",@"18:00-19:00",@"19:00-20:00", nil];
            
            return arr;
        }
    }
}

#pragma  mark - 月跳年
- (NSInteger)withTTTYYYY:(NSInteger)dd  withMM:(NSInteger)mm withchae:(NSInteger)chae
{
//    NSLog(@"huoqunianshu-dd-%ld-mm-%ld-chae-%ld",(long)dd,(long)mm,(long)chae);
    NSDate *  senddate=[NSDate date];
    
    if (dd + chae > [self lllll]) {
//        NSLog(@"大于本月天数");
        NSInteger iii;
        mm = mm +1;
        
        NSDateFormatter  *dateformatter2=[[NSDateFormatter alloc] init];
        [dateformatter2 setDateFormat:@"YYYY"];
        NSString *  locationString2=[dateformatter2 stringFromDate:senddate];
        iii = [locationString2 integerValue];
        if (mm > 12) {
//            NSLog(@"大于当月月号");
//            NSLog(@"当前年%ld-%ld",(long)iii,(long)iii+1);
            iii = iii +1;
        }
        return iii;
    }else{
        
        NSDateFormatter  *dateformatter2=[[NSDateFormatter alloc] init];
        [dateformatter2 setDateFormat:@"YYYY"];
        
        NSString *  locationString2=[dateformatter2 stringFromDate:senddate];
        NSInteger iii = [locationString2 integerValue];
//        NSLog(@"budayudangqianyuehao");
//        NSLog(@"dangqiannian%ld",(long)iii);
        return iii;
    }
}

#pragma  mark - 日跳月
- (NSString *)withTY:(NSInteger)dd withTYchae:(NSInteger)chae
{
//    NSLog(@"dd-%ld+chae-%ld-=%ld",(long)dd,(long)chae,(long)dd+chae);
    NSString *strTY;
    if (dd+chae > [self lllll]) {
        NSDate *  senddate=[NSDate date];
        
        NSDateFormatter  *dateformatter1=[[NSDateFormatter alloc] init];
        [dateformatter1 setDateFormat:@"MM"];
        NSString *  locationString1=[dateformatter1 stringFromDate:senddate];
        NSInteger ii = [locationString1 integerValue];
        ii = ii +1;
        if (ii > 12) {
            ii = 1;
        }
        
        if ([NSString stringWithFormat:@"%ld",(long)ii].length == 1) {
            strTY = [NSString stringWithFormat:@"0%ld",(long)ii];
        }else{
            strTY = [NSString stringWithFormat:@"%ld",(long)ii];
        }
//        NSLog(@"TY- %@",strTY);
        return strTY;
    }else {
        
        NSDate *  senddate=[NSDate date];
        
        NSDateFormatter  *dateformatter1=[[NSDateFormatter alloc] init];
        [dateformatter1 setDateFormat:@"MM"];
        NSString *  locationString1=[dateformatter1 stringFromDate:senddate];
        NSInteger ii = [locationString1 integerValue];
        ii = ii;
        if ([NSString stringWithFormat:@"%ld",(long)ii].length == 1) {
            strTY = [NSString stringWithFormat:@"0%ld",(long)ii];
        }else{
            strTY = [NSString stringWithFormat:@"%ld",(long)ii];
        }
//        NSLog(@"TY--%@",strTY);
        return strTY;
    }
}

#pragma  mark - 判断时间跨度
- (NSString *)withdd:(NSInteger)dd withchae:(NSInteger)chae
{
    NSString *strDD;
    if (dd + chae > [self lllll]) {
//        NSLog(@"三天后超过本月天数");
        NSInteger i = (dd+chae) - [self lllll];
        if ([NSString stringWithFormat:@"%ld",(long)i].length == 1) {
            strDD = [NSString stringWithFormat:@"0%ld",(long)i];
        }else{
            strDD = [NSString stringWithFormat:@"%ld",(long)i];
        }
        return strDD;
    }else{
//        NSLog(@"三天后没有超过本月天数");
        NSInteger i = dd + chae;
        if ([NSString stringWithFormat:@"%ld",(long)i].length == 1) {
            strDD = [NSString stringWithFormat:@"0%ld",(long)i];
        }else{
            strDD = [NSString stringWithFormat:@"%ld",(long)i];
        }
//        NSLog(@"nsl--%ld--%@",(long)i,strDD);
        return strDD;
    }
}

#pragma  mark - 获取当前月的天数
- (NSInteger)lllll
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]];
    
    NSInteger numberOfDaysInMonth = (NSInteger)range.length;
    
    NSLog(@"numberofdaysinmonth-%ld",(long)numberOfDaysInMonth);
    
    return numberOfDaysInMonth;
}

#pragma  mark -UIPickerViewDataSource,UIPickerViewDelegate,doneSelect
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{ 
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    //    NSLog(@"%@",[_zongArray objectAtIndex:component]);
    if (pickerView == _ymd_pickerView) {
        return [_YMD_Array  count];
    }else{
        return [_TIME_array count];
    }
    
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //先根据component找到大数组中对应的小数组，然后根据row从小数组中找到对应的title
    if (pickerView == _ymd_pickerView) {
        return _YMD_Array[row];
    }else{
        return _TIME_array[row];
    }
    
}

- (void)done
{
    if (YMD == YES) {
//        NSLog(@"年月日选择器");
        NSInteger provinceRow = [_ymd_pickerView selectedRowInComponent:0];
//        NSLog(@"年月日选择器--%@",[_YMD_Array objectAtIndex:provinceRow]);
        _YMDLab.text = [_YMD_Array objectAtIndex:provinceRow];
        [self valve];
    }else if (TIME == YES){
//        NSLog(@"时间选择器");
        NSInteger provinceRow = [_time_pickerView selectedRowInComponent:0];
//        NSLog(@"时间选择器--%@",[_TIME_array objectAtIndex:provinceRow]);
        _TIMELab.text = [_TIME_array objectAtIndex:provinceRow];
        getTimeBool =YES;
        [self valve];
    }
    
}

#pragma  mark - 获取用户信息
- (void)getUser
{
    [[BoolViewController alloc] testOut];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:USER_ID(QQQQ) forKey:@"user_id"];
//    NSLog(@"--duc-%@",dic);
    [PerAFNetBlockRequest AFNRequest:@"/index.php?s=/Api/Address/getdefault" dic:dic AFNBlock:^(NSDictionary *resp, NSStringEncoding encoding){
//        NSLog(@"resp-%@,--encoding-%lu",resp,(unsigned long)encoding);
        [self getUserInformation:resp];
    }AFNEror:^(NSError *error){
//        NSLog(@"ERRPR--%@",error);
    }];
}

- (void)getUserInformation:(NSDictionary *)resp
{
    NSInteger status = [[resp valueForKey:@"status"] integerValue];
    if (status == 0) {
        NSDictionary *data = [resp valueForKey:@"data"];
        //        UILabel *_informationLab;//用户明、手机号
        //        UILabel *_addressInformationLab;//地址
        if ([data valueForKey:@"username"] == nil || [data valueForKey:@"username"] == NULL || [[NSString stringWithFormat:@"%@",data] rangeOfString:@"(\n)"].location !=NSNotFound ||data == nil) {
//            NSLog(@"k空了");
            [_userLab setText:@""];
            [_address setText:@""];
            [_addressBtnLab setText:@"请先点击填写取件地址"];
        }else{
//            NSLog(@"%@    %@ \n%@   %@",[data valueForKey:@"username"],[data valueForKey:@"mobile"],[data valueForKey:@"address"],[data valueForKey:@"location"]);
            //        NSString *_nameStr;//姓名
            //        NSString *_cityStr;//城市
            //        NSString *_areaStr;//区域
            //        NSString *_numeberStr;//手机号码
            //        NSString *_detailedStr;//详细地址
            //        NSString *_userId;//用户编号
            //        NSString *_addrId;//区域id
            //        NSString *_getDate;//取件日期
            //        NSString *_getTime;//取件时间
            //        NSString *_sendDate;//送件日期
            //        NSString *_sendTime;//送件时间段
            //        NSString *_flag;//是否加急
            //        NSString *_mark;//备注
            //用户昵称
            self.nameStr = [data valueForKey:@"username"];
            //收货地址ID
            self.addrId = [data valueForKey:@"addr_id"];
            //详细地址
            self.detailedStr = [data valueForKey:@"address"];
            //手机号码
            self.numberSte = [data valueForKey:@"mobile"];
            //城市区域
            self.cityStr = [data valueForKey:@"location"];
            
            [_userLab setText:[NSString stringWithFormat:@"%@   %@",self.nameStr,self.numberSte]];
            [_address setText:[NSString stringWithFormat:@"%@ %@",self.cityStr,self.detailedStr]];
            [_addressBtnLab setText:@""];
        }
        
    } else {

        YBMB(@"请设置联系人信息")
    }
}

#pragma  mark - 获取阀值
- (void)valve
{
    NSMutableString *gettime = [NSMutableString stringWithFormat:@"%@",_YMDLab.text];
//    NSLog(@"++huoquriqi%@",gettime);
    NSString *strUrl = [self withNSString:gettime];
//    NSLog(@"dingdanfazhi--%@",strUrl);
    
    NSMutableDictionary *diccct = [[NSMutableDictionary alloc] init];
    [diccct setValue:strUrl forKey:@"get_date"];
    NSDictionary *dic = [PersonalRequest withAllUrll:@"/index.php?s=/Api/Order/getmax" WithDic:diccct];
    NSInteger status = [[dic valueForKey:@"status"] integerValue];
//    NSLog(@"---%@",dic);
//    NSLog(@"订单阀值-%@",[dic valueForKey:@"data"]);
    if (status == 0) {
//        NSLog(@"订单阀值-%@",[dic valueForKey:@"data"]);
    }else{
        _valeAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲~今日订单已满额\n 请选择其他时间段取件！" delegate:self cancelButtonTitle:@"重新选择" otherButtonTitles:nil];
        [_valeAlert show];
    }
}

#pragma  mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _valeAlert) {
        [_TIMELab setText:@"请选择时间"];
        UIButton *btn;
        btn.tag = 1;
        [self pushPickerView:btn];
    }
    
    if (alertView == _xiadanAlert) {
        if (buttonIndex == 0) {
//            NSLog(@"姓名-%@区域-%@手机号码-%@详细地址-%@用户编号-%@区域id-%@取件日期-%@取件时间-%@备注-%@",self.nameStr,self.cityStr,self.numberSte,self.detailedStr,USER_ID(QQQQ),self.addrId,self.getDate,self.getTime,self.mark);
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:USER_ID(QQQQ) forKey:@"user_id"];
            NSMutableDictionary *dics = [[NSMutableDictionary alloc] init];
            [dics setValue:self.nameStr forKey:@"username"];
            [dics setValue:self.cityStr forKey:@"location"];
            [dics setValue:self.numberSte forKey:@"mobile"];
            [dics setValue:self.detailedStr forKey:@"address"];
            [dics setValue:self.addrId forKey:@"addr_id"];
            [dics setValue:self.getDate forKey:@"get_date"];
            [dics setValue:self.getTime forKey:@"get_time"];
            [dics setValue:self.sendType forKey:@"send_type"];
            [dics setValue:self.mark forKey:@"mark"];
            
            [dic setValue:@"3" forKey:@"platform"];
            [dic setValue:dics forKey:@"field"];
            
            [PerAFNetBlockRequest AFNRequest:@"/index.php?s=/Api/Order/add" dic:dic AFNBlock:^(NSDictionary *resp,NSStringEncoding encoding){
                [self postTJDD:resp];
            }AFNEror:^(NSError *error){
//                NSLog(@"postTJDDerror-%@",error);
            }];
        }
    }
}

- (void)postTJDD:(NSDictionary *)dic
{
    NSInteger status = [[dic valueForKey:@"status"] integerValue];
//    NSLog(@"postTJDD-%@",dic);
    if (status == 0) {
        YBMB(@"提交成功!")
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        SHOW_ALERT([dic valueForKey:@"data"])
    }
}

#pragma  mark - 提交的日期
- (NSString *)withNSString:(NSMutableString *)timeStr
{
//    NSDate *  senddate=[NSDate date];
    
//    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"YYYY"];
//    NSString *  locationString=[dateformatter stringFromDate:senddate];
    NSString * str =[timeStr stringByReplacingOccurrencesOfString:@"星期一" withString:@""];
    str =[str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str =[str stringByReplacingOccurrencesOfString:@"星期" withString:@""];
    str =[str stringByReplacingOccurrencesOfString:@"二" withString:@""];
    str =[str stringByReplacingOccurrencesOfString:@"三" withString:@""];
    str =[str stringByReplacingOccurrencesOfString:@"四" withString:@""];
    str =[str stringByReplacingOccurrencesOfString:@"五" withString:@""];
    str =[str stringByReplacingOccurrencesOfString:@"六" withString:@""];
    str =[str stringByReplacingOccurrencesOfString:@"日" withString:@""];
    str =[str stringByReplacingOccurrencesOfString:@"月" withString:@""];
    str =[str stringByReplacingOccurrencesOfString:@"年" withString:@""];
    str =[str stringByReplacingOccurrencesOfString:@"/" withString:@""];
    
    str = [NSString stringWithFormat:@"%@",str];
    return str;
}

#pragma  mark - 提交的时间
- (NSString *)tjWithtime:(NSMutableString *)timeStr
{
    if ([timeStr isEqualToString:@"9:00-10:00"]) {
        return @"9";
    }else if ([timeStr isEqualToString:@"10:00-11:00"]) {
        return @"10";
    }else if ([timeStr isEqualToString:@"11:00-12:00"]) {
        return @"11";
    }else if ([timeStr isEqualToString:@"12:00-13:00"]) {
        return @"12";
    }else if ([timeStr isEqualToString:@"13:00-14:00"]) {
        return @"13";
    }else if ([timeStr isEqualToString:@"14:00-15:00"]) {
        return @"14";
    }else if ([timeStr isEqualToString:@"15:00-16:00"]) {
        return @"15";
    }else if ([timeStr isEqualToString:@"16:00-17:00"]) {
        return @"16";
    }else if ([timeStr isEqualToString:@"17:00-18:00"]) {
        return @"17";
    }else if ([timeStr isEqualToString:@"18:00-19:00"]) {
        return @"18";
    }else if ([timeStr isEqualToString:@"19:00-20:00"]) {
        return @"19";
    }else if ([timeStr isEqualToString:@"20:00-21:00"]) {
        return @"20";
    }else if ([timeStr isEqualToString:@"21:00-22:00"]) {
        return @"21";
    }else
    {
        return @"9";
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)viewDidDisappear:(BOOL)animated
{
    if (mange_block_bool == YES) {
        
        [NSThread detachNewThreadSelector:@selector(getUser) toTarget:self withObject:nil];
    }else{
        
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    if (mange_block_bool == YES) {
        [NSThread detachNewThreadSelector:@selector(getUser) toTarget:self withObject:nil];
    }else{
        
    }
    
}
@end
