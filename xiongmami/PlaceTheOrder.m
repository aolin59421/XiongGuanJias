//
//  PlaceTheOrder.m
//  xiongmami
//
//  Created by iMac on 14/11/20.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "PlaceTheOrder.h"
#import "AddAddressViewController.h"
#import "XMTextViewPlaceHolder.h"
#import "ManagementAddress.h"
#import "LeveyTabBarController.h"
#import "HexadecimalConversionUICOLOR.h"
#import "LZWCustomActionSheet.h"


@interface PlaceTheOrder ()<UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,doneSelect>
{
    NSArray *_provinceArray;
    NSArray *_zongArray;
    NSArray *_bigArray;
    
    UIView *_pickView;
    
    UILabel *_getNowTime;//获取取件日期
    UILabel *_getNowTimeLab;//获取取件时间段
    
    UILabel *_postThreeTime;//获取送件时间日期
    
    UILabel *_postThreeTimeLab;//获取送件时间段
    
    UIButton *_postTimeBtn;//
    
    BOOL PickBool;
}
@property (nonatomic, strong)XMTextViewPlaceHolder *textField;
@end
@implementation PlaceTheOrder
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"下单";
    
    [self addPlaceTheOrderTabelView];
//    [self addPostOrder];
    [self note];
    [self timePick];
    mange_block_bool = YES;
    Activation = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(bback)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    PickBool = YES;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
}

- (void)bback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    if (mange_block_bool == YES) {
        
        [NSThread detachNewThreadSelector:@selector(userInformation) toTarget:self withObject:nil];
        
    }else{
        
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    
    if (mange_block_bool == YES) {
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = @"加载中";
        [HUD show:YES];
        [NSThread detachNewThreadSelector:@selector(userInformation) toTarget:self withObject:nil];
    }else{
        
    }

}

#pragma  mark - scroller
- (void)addPlaceTheOrderTabelView
{
    //滚动视图
    CGSize newFramSize; //= CGSizeMake(VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT*1.1);
//    if (iPhone6||iPhone6Plus) {
//        NSLog(@"123321312312312312312");
    newFramSize = CGSizeMake(0, 0);
//    }
    _placeTheOrderScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _placeTheOrderScrollView.contentSize = newFramSize;
    _placeTheOrderScrollView.bounces = NO;
    _placeTheOrderScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_placeTheOrderScrollView];
    
    //用户信息
     _informationLab= [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 300, 25)];
//    [_informationLab setText:@"请先点击填写详细地址"];
    [_informationLab setTextColor:[UIColor blackColor]];
    [_informationLab setFont:[UIFont systemFontOfSize:15]];
    [_informationLab setTextAlignment:NSTextAlignmentLeft];
    [_placeTheOrderScrollView addSubview:_informationLab];
    
     _addressInformationLab= [[UILabel alloc] initWithFrame:CGRectMake(20, 30, VIEW_FRAME_SIZE_WIDTH - 50, 25)];
//    [_addressInformationLab setText:@"请填写详细地址"];
    [_addressInformationLab setNumberOfLines:0];
    [_addressInformationLab setTextColor:[UIColor lightGrayColor]];
    [_addressInformationLab setFont:[UIFont systemFontOfSize:14]];
    [_addressInformationLab setTextAlignment:NSTextAlignmentLeft];
    [_placeTheOrderScrollView addSubview:_addressInformationLab];
    
    UIImageView *imageViewAddress =[[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 30, 20, 10, 20)];
    [imageViewAddress setImage:[UIImage imageNamed:@"箭头.png"]];
    [_placeTheOrderScrollView addSubview:imageViewAddress];
    
    //选择地址按钮
    _getAddress = [UIButton buttonWithType:UIButtonTypeCustom];
    [_getAddress setTitle:@"请先点击填写详细地址" forState:UIControlStateNormal];
    [_getAddress setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_getAddress.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [_getAddress addTarget:self action:@selector(pushAddAddress) forControlEvents:UIControlEventTouchUpInside];
    [_getAddress setFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 60)];
    [_placeTheOrderScrollView addSubview:_getAddress];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, VIEW_FRAME_SIZE_WIDTH, 0.5)];
    lable.backgroundColor = [UIColor colorWithRed:214/255.0f green:219/255.0f blue:223/255.0f alpha:1];
    [_placeTheOrderScrollView addSubview:lable];
    
//    UILabel *lables = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 365, VIEW_FRAME_SIZE_WIDTH*0.9, 0.5)];
//    lables.backgroundColor = [UIColor colorWithRed:214/255.0f green:219/255.0f blue:223/255.0f alpha:1];
//    [_placeTheOrderScrollView addSubview:lables];
    
    //取件日期
    UILabel *getTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 75, 80, 60)];
    [getTimeLab setText:@"取件日期"];
    [_placeTheOrderScrollView addSubview:getTimeLab];
    
    UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(100, 75, VIEW_FRAME_SIZE_WIDTH/3*2, 60)];
    [timeView setBackgroundColor:[UIColor colorWithRed:214/255.0f green:219/255.0f blue:223/255.0f alpha:1]];
    timeView.layer.cornerRadius = 10.0f;
    [_placeTheOrderScrollView addSubview:timeView];
    //选取送件日期

    
    _getNowTime = [[UILabel alloc] initWithFrame:CGRectMake(120, 70, timeView.frame.size.width/3, timeView.frame.size.height)];
//    [_getNowTime setText:[self YYYYMMDDTime]];
    [_getNowTime setFont:[UIFont systemFontOfSize:15]];
    [_getNowTime setTextAlignment:NSTextAlignmentCenter];
    [_getNowTime setTextColor:[UIColor blackColor]];
    [_getNowTime setNumberOfLines:0];
    [_placeTheOrderScrollView addSubview:_getNowTime];
    
    //选取取件时间
    
    _getNowTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(120+timeView.frame.size.width/3, 75, timeView.frame.size.width/3*2, timeView.frame.size.height)];
//    [_getNowTimeLab setText:str];
    [_getNowTimeLab setFont:[UIFont systemFontOfSize:17]];
    [_getNowTimeLab setTextAlignment:NSTextAlignmentCenter];
    [_getNowTimeLab setTextColor:[UIColor blackColor]];
    [_placeTheOrderScrollView addSubview:_getNowTimeLab];

    getTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [getTimeButton setFrame:CGRectMake(100, 75, VIEW_FRAME_SIZE_WIDTH/3*2, 60)];
    [getTimeButton setTag:0];
    [getTimeButton setTitle:@"请选择取件时间" forState:UIControlStateNormal];
    [getTimeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [getTimeButton addTarget:self action:@selector(pushPickerView:) forControlEvents:UIControlEventTouchUpInside];
    [_placeTheOrderScrollView addSubview:getTimeButton];
    
    UILabel *getNowLab  = [[UILabel alloc] initWithFrame:CGRectMake(15, 150, VIEW_FRAME_SIZE_WIDTH*0.9, 0.1)];
    getNowLab.backgroundColor = [UIColor blackColor];
    [_placeTheOrderScrollView addSubview:getNowLab];
    
    if (iPhone6Plus) {
        [_informationLab setFont:[UIFont systemFontOfSize:17]];
        [_addressInformationLab setFont:[UIFont systemFontOfSize:15]];
        [_addressInformationLab setFont:[UIFont systemFontOfSize:15]];
    }
}
              
#pragma  mark - 选择取件时间
- (NSArray *)getTimes
{
    NSArray * arr = [[NSArray alloc] init];
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"dd"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    NSInteger i = [locationString integerValue];
    
    NSDateFormatter  *dateformatter4=[[NSDateFormatter alloc] init];
    [dateformatter4 setDateFormat:@"HH"];
    NSString *  locationString4=[dateformatter4 stringFromDate:senddate];
    NSInteger iiii = [locationString4 integerValue];
    
    
    NSDateFormatter  *dateformatter1=[[NSDateFormatter alloc] init];
    [dateformatter1 setDateFormat:@"MM"];
    NSString *  locationString1=[dateformatter1 stringFromDate:senddate];
    NSInteger ii = [locationString1 integerValue];
    //星期
    
    if (iiii >= 18) {
        i = i+1;
        
        NSString *str_1 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:0] withMoth:[self withTY:i withTYchae:0] WithDay:[self withdd:i withchae:0]];
        NSString *str_2 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:1] withMoth:[self withTY:i withTYchae:1] WithDay:[self withdd:i withchae:1]];
        NSString *str_3 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:2] withMoth:[self withTY:i withTYchae:2] WithDay:[self withdd:i withchae:2]];
        NSString *str_4 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:3] withMoth:[self withTY:i withTYchae:3] WithDay:[self withdd:i withchae:3]];
        NSString *str_5 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:4] withMoth:[self withTY:i withTYchae:4] WithDay:[self withdd:i withchae:4]];
        NSString *str_6 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:5] withMoth:[self withTY:i withTYchae:5] WithDay:[self withdd:i withchae:5]];
        NSString *str_7 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:6] withMoth:[self withTY:i withTYchae:6] WithDay:[self withdd:i withchae:6]];
        
        
        arr = [NSArray arrayWithObjects:
               [NSString stringWithFormat:@"%@%@月%@日",str_1,[self withTY:i withTYchae:0],[self withdd:i withchae:0]],
               [NSString stringWithFormat:@"%@%@月%@日",str_2,[self withTY:i withTYchae:1],[self withdd:i withchae:1]],
               [NSString stringWithFormat:@"%@%@月%@日",str_3,[self withTY:i withTYchae:2],[self withdd:i withchae:2]],
               [NSString stringWithFormat:@"%@%@月%@日",str_4,[self withTY:i withTYchae:3],[self withdd:i withchae:3]],
               [NSString stringWithFormat:@"%@%@月%@日",str_5,[self withTY:i withTYchae:4],[self withdd:i withchae:4]],
               [NSString stringWithFormat:@"%@%@月%@日",str_6,[self withTY:i withTYchae:5],[self withdd:i withchae:5]],
               [NSString stringWithFormat:@"%@%@月%@日",str_7,[self withTY:i withTYchae:6],[self withdd:i withchae:6]],
               nil];
        
        return arr;
    }else {
        NSString *str_1 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:0] withMoth:[self withTY:i withTYchae:0] WithDay:[self withdd:i withchae:0]];
        NSString *str_2 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:1] withMoth:[self withTY:i withTYchae:1] WithDay:[self withdd:i withchae:1]];
        NSString *str_3 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:2] withMoth:[self withTY:i withTYchae:2] WithDay:[self withdd:i withchae:2]];
        NSString *str_4 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:3] withMoth:[self withTY:i withTYchae:3] WithDay:[self withdd:i withchae:3]];
        NSString *str_5 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:4] withMoth:[self withTY:i withTYchae:4] WithDay:[self withdd:i withchae:4]];
        NSString *str_6 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:5] withMoth:[self withTY:i withTYchae:5] WithDay:[self withdd:i withchae:5]];
        NSString *str_7 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:6] withMoth:[self withTY:i withTYchae:6] WithDay:[self withdd:i withchae:6]];
        
        arr = [NSArray arrayWithObjects:
               [NSString stringWithFormat:@"%@%@月%@日",str_1,[self withTY:i withTYchae:0],[self withdd:i withchae:0]],
               [NSString stringWithFormat:@"%@%@月%@日",str_2,[self withTY:i withTYchae:1],[self withdd:i withchae:1]],
               [NSString stringWithFormat:@"%@%@月%@日",str_3,[self withTY:i withTYchae:2],[self withdd:i withchae:2]],
               [NSString stringWithFormat:@"%@%@月%@日",str_4,[self withTY:i withTYchae:3],[self withdd:i withchae:3]],
               [NSString stringWithFormat:@"%@%@月%@日",str_5,[self withTY:i withTYchae:4],[self withdd:i withchae:4]],
               [NSString stringWithFormat:@"%@%@月%@日",str_6,[self withTY:i withTYchae:5],[self withdd:i withchae:5]],
               [NSString stringWithFormat:@"%@%@月%@日",str_7,[self withTY:i withTYchae:6],[self withdd:i withchae:6]],
               nil];

        return arr;
    }
}

#pragma  mark - 添加送件视图
- (void)addPostOrder
{
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 147, VIEW_FRAME_SIZE_WIDTH*0.9, 0.5)];
    lable.backgroundColor = [UIColor colorWithRed:214/255.0f green:219/255.0f blue:223/255.0f alpha:1];
    [_placeTheOrderScrollView addSubview:lable];
    //送件时间
    
    UILabel *postTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 136, 70, 60)];//195
    [postTimeLab setText:@"送件日期"];
    [_placeTheOrderScrollView addSubview:postTimeLab];
    
    UIButton *callMelabButton = [UIButton buttonWithType:UIButtonTypeCustom];
    callMelabButton.frame = CGRectMake(0, 151, VIEW_FRAME_SIZE_WIDTH, 25);//215
    [callMelabButton setBackgroundColor:[UIColor clearColor]];
    [callMelabButton addTarget:self action:@selector(callMeClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_placeTheOrderScrollView addSubview:callMelabButton];
    
    UIButton *specifyTimeLabButton = [UIButton buttonWithType:UIButtonTypeCustom];
    specifyTimeLabButton.frame = CGRectMake(0, 196, VIEW_FRAME_SIZE_WIDTH, 25);//245
    [specifyTimeLabButton setBackgroundColor:[UIColor clearColor]];
    [specifyTimeLabButton addTarget:self action:@selector(specifyTimeClick:) forControlEvents:UIControlEventTouchUpInside];
    [_placeTheOrderScrollView addSubview:specifyTimeLabButton];
    
#pragma  mark - 判断取件时间选择
    
    UILabel *callMeLab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20+110, 153, (VIEW_FRAME_SIZE_WIDTH/3*2), 25)];//215
    callMeLab.text = @"现在不选择，洗好通知我";
    [callMeLab setFont:[UIFont systemFontOfSize:14]];
    [callMeLab setTextAlignment:NSTextAlignmentLeft];
    [callMeLab setTextColor:[UIColor lightGrayColor]];
    [_placeTheOrderScrollView addSubview:callMeLab];
    
    UILabel *specifyTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20+110, 190, (VIEW_FRAME_SIZE_WIDTH/3*2), 25)];//245
    specifyTimeLab.text = @"指定送衣时间";
    [specifyTimeLab setFont:[UIFont systemFontOfSize:14]];
    [specifyTimeLab setTextAlignment:NSTextAlignmentLeft];
    [specifyTimeLab setTextColor:[UIColor lightGrayColor]];
    [_placeTheOrderScrollView addSubview:specifyTimeLab];
    
    if (iPhone6Plus) {
        
        [callMeLab setFont:[UIFont systemFontOfSize:15]];
        [specifyTimeLab setFont:[UIFont systemFontOfSize:15]];
    }
#pragma  mark - 是否选择取件时间
    //洗好通知我
    _callMeButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20+80, 155, 20, 20)];//215
//    [_callMeButton setImage:[UIImage imageNamed:@"单选btn.png"] forState:UIControlStateNormal];
//    [_callMeButton setImage:[UIImage imageNamed:@"单选btnHover.png"] forState:UIControlStateSelected];
//    [_callMeButton setImage:[UIImage imageNamed:@"单选btnHover.png"] forState:UIControlStateHighlighted];
//    BoolCallMeBtn = YES;
//    if (BoolCallMeBtn == YES) {
        [_callMeButton setHighlighted:YES];
        [_callMeButton setSelected:NO];
//    }else{
//        [_callMeButton setHighlighted:NO];
//    }
    
    [_callMeButton addTarget:self action:@selector(callMeClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_placeTheOrderScrollView addSubview:_callMeButton];
    
    //洗好通知我图片
    _callMeImage = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20+80, 157, 17, 17)];
    [_callMeImage setImage:[UIImage imageNamed:@"单选btnHover.png"]];
    [_placeTheOrderScrollView addSubview:_callMeImage];
    
    //指定时间
    _SpecifyTimeButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20+80, 193, 20, 20)];//245
//    [_SpecifyTimeButton setImage:[UIImage imageNamed:@"单选btn.png"] forState:UIControlStateNormal];
//    [_SpecifyTimeButton setImage:[UIImage imageNamed:@"单选btnHover.png"] forState:UIControlStateHighlighted];
//    [_SpecifyTimeButton setImage:[UIImage imageNamed:@"单选btnHover.png"] forState:UIControlStateSelected];
    [_SpecifyTimeButton addTarget:self action:@selector(specifyTimeClick:) forControlEvents:UIControlEventTouchUpInside];
    [_placeTheOrderScrollView addSubview:_SpecifyTimeButton];
//指定时间图片
    _specifyTimeImage = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20+80, 193, 17, 17)];
    [_specifyTimeImage setImage:[UIImage imageNamed:@"单选btn.png"]];
    [_placeTheOrderScrollView addSubview:_specifyTimeImage];
//    BoolSpecifyTimes = NO;
//    if (BoolSpecifyTimes == NO) {
        [_SpecifyTimeButton setHighlighted:NO];
        [_SpecifyTimeButton setSelected:NO];
//    }else{
//        [_SpecifyTimeButton setHighlighted:YES];
//    }
    
    if (_callMeButton.userInteractionEnabled == YES) {
        [_postTimeBtn setUserInteractionEnabled:NO];
    }else{
        [_SpecifyTimeButton setHighlighted:YES];
    }
    
    // 分割线
    _fgximageView =[[UIImageView alloc] init];//WithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 147, VIEW_FRAME_SIZE_WIDTH*0.9, 0.5)];
    _fgximageView.backgroundColor = [UIColor colorWithRed:214/255.0f green:219/255.0f blue:223/255.0f alpha:1];
    [_placeTheOrderScrollView addSubview:_fgximageView];
    
    if (iPhone6Plus) {
        
        callMeLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20+100, 153, (VIEW_FRAME_SIZE_WIDTH/3*2), 25);
        [callMeLab setFont:[UIFont systemFontOfSize:15]];
        
        specifyTimeLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20+100, 190, (VIEW_FRAME_SIZE_WIDTH/3*2), 25);
        [specifyTimeLab setFont:[UIFont systemFontOfSize:15]];
    }
}

//送件
- (void)timePick
{
    _postTimeView = [[UIView alloc] init];//WithFrame:CGRectMake(100, 290, VIEW_FRAME_SIZE_WIDTH/3*2, 60)];
    [_postTimeView setBackgroundColor:[UIColor colorWithRed:214/255.0f green:219/255.0f blue:223/255.0f alpha:1]];
    _postTimeView.layer.cornerRadius = 10.0f;
    [_placeTheOrderScrollView addSubview:_postTimeView];
    
    _postTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_postTimeBtn setFrame:CGRectMake(100, 290, VIEW_FRAME_SIZE_WIDTH/3*2, 60)];
    [_postTimeBtn setTag:1];
    [_postTimeBtn addTarget:self action:@selector(pushPickerView:) forControlEvents:UIControlEventTouchUpInside];
    [_placeTheOrderScrollView addSubview:_postTimeBtn];
    
    NSString *str_1 = [self YYYYMMDD];
    NSString *riqiStr = [NSString stringWithFormat:@"%@",str_1];
    
    _postThreeTime =[[UILabel alloc] init];//WithFrame:CGRectMake(120, 290, _postTimeView.frame.size.width/3, _postTimeView.frame.size.height)];
    [_postThreeTime setText:riqiStr];
    [_postThreeTime setFont:[UIFont systemFontOfSize:15]];
    [_postThreeTime setTextAlignment:NSTextAlignmentCenter];
    [_postThreeTime setTextColor:[UIColor blackColor]];
    [_postThreeTime setNumberOfLines:0];
    [_placeTheOrderScrollView addSubview:_postThreeTime];
    
    _postThreeTimeLab = [[UILabel alloc] init];//WithFrame:CGRectMake(120+_postTimeView.frame.size.width/3, 290, _postTimeView.frame.size.width/3*2, _postTimeView.frame.size.height)];
    [_postThreeTimeLab setTextColor:[UIColor blackColor]];
    [_postThreeTimeLab setTextAlignment:NSTextAlignmentCenter];
    [_postThreeTimeLab setText:@"9:00-10:00"];
    [_postThreeTimeLab setFont:[UIFont systemFontOfSize:17]];
    [_placeTheOrderScrollView addSubview:_postThreeTimeLab];
    
}

#pragma  mark - 备注+提交
- (void)note
{
    _textField = [[XMTextViewPlaceHolder alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 165, VIEW_FRAME_SIZE_WIDTH*0.9, 100)];//280 、、221
    _textField.placeholder = @"若您对订单有特殊需求，可在此备注";
    _textField.layer.borderWidth = 0.1f;
    _textField.delegate = self;
    _textField.layer.cornerRadius = 10.0f;
    _textField.layer.masksToBounds = YES;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.font = [UIFont systemFontOfSize:15];
    [_placeTheOrderScrollView addSubview:_textField];
    
    UIButton *textBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    textBtn.frame = CGRectMake(15, 280, 27/2, 27/2);
    [textBtn setBackgroundImage:[UIImage imageNamed:@"fuxuan2.png"] forState:UIControlStateNormal];
    [textBtn setBackgroundImage:[UIImage imageNamed:@"fuxuan.png"] forState:UIControlStateHighlighted];
    [textBtn setBackgroundImage:[UIImage imageNamed:@"fuxuan.png"] forState:UIControlStateSelected];
    [textBtn addTarget:self action:@selector(textBtn:) forControlEvents:UIControlEventTouchUpInside];
    [textBtn setSelected:YES];
    [_placeTheOrderScrollView addSubview:textBtn];
    
    UILabel *textLab = [[UILabel alloc] initWithFrame:CGRectMake(35, 275, 165, 25)];
    textLab.text = @"我已认真阅读并同意熊管家的";
    [textLab setFont:[UIFont systemFontOfSize:12.5]];
    [textLab setTextColor:[UIColor blackColor]];
    [_placeTheOrderScrollView addSubview:textLab];
    
    UILabel *agreementBtn = [[UILabel alloc] init];
    [agreementBtn setFrame:CGRectMake(200, 275, 100, 25)];
    [agreementBtn setText:@"《服务条款》"];
    [agreementBtn setTextColor:[UIColor redColor]];
    [agreementBtn setFont:[UIFont systemFontOfSize:12.5]];
    [_placeTheOrderScrollView addSubview:agreementBtn];
    
    UIButton *labTextBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    [labTextBtn setFrame:CGRectMake(50, 275, 250, 25)];
    [labTextBtn addTarget:self action:@selector(textLab) forControlEvents:UIControlEventTouchUpInside];
    [labTextBtn setBackgroundColor:[UIColor clearColor]];
    [_placeTheOrderScrollView addSubview:labTextBtn];
    
    _xiadanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _xiadanButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 315, VIEW_FRAME_SIZE_WIDTH*0.9, 40);//400、、341
    [_xiadanButton setBackgroundImage:[UIImage imageNamed:@"保存btn.png"] forState:UIControlStateNormal];
    [_xiadanButton setTitle:@"立即下单" forState:UIControlStateNormal];
    [_xiadanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_xiadanButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [_xiadanButton addTarget:self action:@selector(xiadan) forControlEvents:UIControlEventTouchUpInside];
    [_placeTheOrderScrollView addSubview:_xiadanButton];
    if (iPhone6Plus) {
        _xiadanButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 341, VIEW_FRAME_SIZE_WIDTH*0.9, 55);//400
//        [noteLab setFont:[ UIFont systemFontOfSize: 15]];
//        fengexianlabel.frame =CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 208, VIEW_FRAME_SIZE_WIDTH*0.9, 0.5);
    }else if (iPhone6){
        _textField.layer.borderWidth = 0.5;
        _textField.layer.cornerRadius = 5.0f;
        _textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
}

- (void)textBtn:(UIButton *)sender
{
    if (sender.selected == YES) {
        sender.selected = NO;
//        NSLog(@"点击1");
    }else{
        sender.selected = YES;
//        NSLog(@"点击2");
    }
}

- (void)textLab
{
    
}
#pragma  mark - 是否备注
- (void)noteButtonClick:(UIButton *)sender
{
//    NSLog(@"次日达");
    
    if (CallMe == NO) {
        _notButton.highlighted = NO;
        [_notButton setSelected:YES];
        
        //时间按钮
        [_postTimeBtn setUserInteractionEnabled:NO];
        //选择按钮
        [_SpecifyTimeButton setSelected:NO];
        [_SpecifyTimeButton setHighlighted:NO];
        
        _callMeButton.highlighted = NO;
        [_callMeButton setSelected:NO];

        CallMe =YES;
    }else if(CallMe == YES) {
        _notButton.highlighted = YES;
        [_notButton setSelected:YES];

        CallMe = NO;
    }
    _postTimeView.frame =  CGRectMake(-1000, -2900, VIEW_FRAME_SIZE_WIDTH/3*2, 60);
    _postTimeBtn.frame = CGRectMake(-1000, -2900, VIEW_FRAME_SIZE_WIDTH/3*2, 60);
    _postThreeTime.frame = CGRectMake(-1000, -2900, _postTimeView.frame.size.width/3, _postTimeView.frame.size.height);
    _postThreeTimeLab.frame =  CGRectMake(-1000, -2900, _postTimeView.frame.size.width/3*2, _postTimeView.frame.size.height);
    
    _fgximageView.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 150, VIEW_FRAME_SIZE_WIDTH*0.9, 1);
    _textField.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 280, VIEW_FRAME_SIZE_WIDTH*0.9, 100);
    _xiadanButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 400, VIEW_FRAME_SIZE_WIDTH*0.9, 40);
    if (iPhone6Plus) {
        _xiadanButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 400, VIEW_FRAME_SIZE_WIDTH*0.9, 55);
    }
    
}

#pragma  mark - 是否通知
- (void)callMeClick:(UIButton *)sender
{
    [_callMeImage setImage:[UIImage imageNamed:@"单选btnHover.png"]];
    [_specifyTimeImage setImage:[UIImage imageNamed:@"单选btn.png"]];

//        NSLog(@"洗好后通知我yes");
        //时间按钮
        [_postTimeBtn setUserInteractionEnabled:NO];
    
        SpecifyTimes = YES;
        CallMe = NO;
        
        _notButton.highlighted = NO;
        [_notButton setSelected:NO];
    
    _postTimeView.frame =  CGRectMake(-1000, -2900, VIEW_FRAME_SIZE_WIDTH/3*2, 60);
    _postTimeBtn.frame = CGRectMake(-1000, -2900, VIEW_FRAME_SIZE_WIDTH/3*2, 60);
    _postThreeTime.frame = CGRectMake(-1000, -2900, _postTimeView.frame.size.width/3, _postTimeView.frame.size.height);
    _postThreeTimeLab.frame =  CGRectMake(-1000, -2900, _postTimeView.frame.size.width/3*2, _postTimeView.frame.size.height);
    
    _fgximageView.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 1150, VIEW_FRAME_SIZE_WIDTH*0.9, 1);//150
    _textField.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 221, VIEW_FRAME_SIZE_WIDTH*0.9, 100);//280
    _xiadanButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 341, VIEW_FRAME_SIZE_WIDTH*0.9, 40);//400
    if (iPhone6Plus) {
        _xiadanButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 341, VIEW_FRAME_SIZE_WIDTH*0.9, 55);//400
    }
}
- (void)specifyTimeClick:(UIButton *)sender
{

    [_callMeImage setImage:[UIImage imageNamed:@"单选btn.png"]];
    [_specifyTimeImage setImage:[UIImage imageNamed:@"单选btnHover.png"]];
        SpecifyTimes = NO;
        CallMe = NO;
        _notButton.highlighted = NO;
        [_notButton setSelected:NO];
        
//        NSLog(@"指定时间yes");
        [_postTimeBtn setUserInteractionEnabled:YES];
    
    _postTimeView.frame =  CGRectMake(100, 231, VIEW_FRAME_SIZE_WIDTH/3*2, 60);//290
    _postTimeBtn.frame = CGRectMake(100, 231, VIEW_FRAME_SIZE_WIDTH/3*2, 60);//290
    _postThreeTime.frame = CGRectMake(120, 231, _postTimeView.frame.size.width/3, _postTimeView.frame.size.height);//290
    _postThreeTimeLab.frame =  CGRectMake(120+_postTimeView.frame.size.width/3, 231, _postTimeView.frame.size.width/3*2, _postTimeView.frame.size.height);//290
    
    _fgximageView.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 306, VIEW_FRAME_SIZE_WIDTH*0.9, 0.5);//150
    _textField.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 321, VIEW_FRAME_SIZE_WIDTH*0.9, 100);//380
    _xiadanButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 441, VIEW_FRAME_SIZE_WIDTH*0.9, 40);//500
    if (iPhone6Plus) {
        _xiadanButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 441, VIEW_FRAME_SIZE_WIDTH*0.9, 55);//400
    }
}
#pragma  mark - 选择送件时间
- (NSArray *)postTime{
    
    NSArray * arr = [[NSArray alloc] init];
    NSDate *  senddate=[NSDate date];
    

    NSInteger i = [[self aasd:_songjianshijianqian] integerValue];
    if (i == 0) {
        
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"dd"];
        NSString *  locationString=[dateformatter stringFromDate:senddate];
        i = [locationString integerValue];
    }else{
        i = [[self aasd:_songjianshijianqian] integerValue];
    }
    
//    NSLog(@"--i---%ld",(long)i);
    NSDateFormatter  *dateformatter4=[[NSDateFormatter alloc] init];
    [dateformatter4 setDateFormat:@"HH"];
    NSString *  locationString4=[dateformatter4 stringFromDate:senddate];
    NSInteger iiii = [locationString4 integerValue];
    
    
    NSDateFormatter  *dateformatter1=[[NSDateFormatter alloc] init];
    [dateformatter1 setDateFormat:@"MM"];
    NSString *  locationString1=[dateformatter1 stringFromDate:senddate];
    NSInteger ii = [locationString1 integerValue];

    //星期
    
    if (iiii > 18) {
        i = i+1;
//        NSLog(@"当前在18点之后 %ld",(long)i);
    
        NSString *str_1 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:3] withMoth:[self withTY:i withTYchae:3] WithDay:[self withdd:i withchae:3]];
        NSString *str_2 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:4] withMoth:[self withTY:i withTYchae:4] WithDay:[self withdd:i withchae:4]];
        NSString *str_3 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:5] withMoth:[self withTY:i withTYchae:5] WithDay:[self withdd:i withchae:5]];
        NSString *str_4 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:6] withMoth:[self withTY:i withTYchae:6] WithDay:[self withdd:i withchae:6]];
        NSString *str_5 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:7] withMoth:[self withTY:i withTYchae:7] WithDay:[self withdd:i withchae:7]];
        NSString *str_6 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:8] withMoth:[self withTY:i withTYchae:8] WithDay:[self withdd:i withchae:8]];
        NSString *str_7 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:9] withMoth:[self withTY:i withTYchae:9] WithDay:[self withdd:i withchae:9]];
        
        arr = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@\n%@月%@日",str_1,[self withTY:i withTYchae:3],[self withdd:i withchae:3]],
               [NSString stringWithFormat:@"%@%@月%@日",str_2,[self withTY:i withTYchae:4],[self withdd:i withchae:4]],
               [NSString stringWithFormat:@"%@%@月%@日",str_3,[self withTY:i withTYchae:5],[self withdd:i withchae:5]],
               [NSString stringWithFormat:@"%@%@月%@日",str_4,[self withTY:i withTYchae:6],[self withdd:i withchae:6]],
               [NSString stringWithFormat:@"%@%@月%@日",str_5,[self withTY:i withTYchae:7],[self withdd:i withchae:7]],
               [NSString stringWithFormat:@"%@%@月%@日",str_6,[self withTY:i withTYchae:8],[self withdd:i withchae:8]],
               [NSString stringWithFormat:@"%@%@月%@日",str_7,[self withTY:i withTYchae:9],[self withdd:i withchae:9]],
               nil];
        return arr;
    }else {
//        NSLog(@"不是18点之后 %ld",(long)i);

        NSString *str_1 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:3] withMoth:[self withTY:i withTYchae:3] WithDay:[self withdd:i withchae:3]];
        NSString *str_2 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:4] withMoth:[self withTY:i withTYchae:4] WithDay:[self withdd:i withchae:4]];
        NSString *str_3 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:5] withMoth:[self withTY:i withTYchae:5] WithDay:[self withdd:i withchae:5]];
        NSString *str_4 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:6] withMoth:[self withTY:i withTYchae:6] WithDay:[self withdd:i withchae:6]];
        NSString *str_5 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:7] withMoth:[self withTY:i withTYchae:7] WithDay:[self withdd:i withchae:7]];
        NSString *str_6 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:8] withMoth:[self withTY:i withTYchae:8] WithDay:[self withdd:i withchae:8]];
        NSString *str_7 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:9] withMoth:[self withTY:i withTYchae:9] WithDay:[self withdd:i withchae:9]];
//        NSLog(@"3tianhoude shijian - %@",[self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:3] withMoth:[self withTY:i withTYchae:3] WithDay:[self withdd:i withchae:3]]);
//        NSLog(@"3天后的时间--%@",[NSString stringWithFormat:@"%@%@月%@日",str_1,[self withTY:i withTYchae:3],[self withdd:i withchae:3]]);
        arr = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@%@月%@日",str_1,[self withTY:i withTYchae:3],[self withdd:i withchae:3]],
               [NSString stringWithFormat:@"%@%@月%@日",str_2,[self withTY:i withTYchae:4],[self withdd:i withchae:4]],
               [NSString stringWithFormat:@"%@%@月%@日",str_3,[self withTY:i withTYchae:5],[self withdd:i withchae:5]],
               [NSString stringWithFormat:@"%@%@月%@日",str_4,[self withTY:i withTYchae:6],[self withdd:i withchae:6]],
               [NSString stringWithFormat:@"%@%@月%@日",str_5,[self withTY:i withTYchae:7],[self withdd:i withchae:7]],
               [NSString stringWithFormat:@"%@%@月%@日",str_6,[self withTY:i withTYchae:8],[self withdd:i withchae:8]],
               [NSString stringWithFormat:@"%@%@月%@日",str_7,[self withTY:i withTYchae:9],[self withdd:i withchae:9]],
               nil];
        
        return arr;

    }
}

#pragma  mark -push添加地址
- (void)pushAddAddress
{
    
    if ([_getAddress.titleLabel.text rangeOfString:@"请先点击填写详细地址"].location !=NSNotFound && [BoolViewController isNOTNull:_informationLab.text] == NO) {
        AddAddressViewController *add = [[AddAddressViewController alloc] init];
        [self.navigationController pushViewController:add animated:YES];
        
    }else{
        [[BoolViewController alloc] testOut];
//        NSString *_nameStr;//姓名
//        NSString *_cityStr;//城市
//        NSString *_numeberStr;//手机号码
//        NSString *_detailedStr;//详细地址
//        NSString *_addrId;//区域id
        
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
            
            _informationLab.text = [NSString stringWithFormat:@"%@    %@",self.nameStr,self.numberSte];
            _addressInformationLab.text = [NSString stringWithFormat:@"%@ %@",self.cityStr,self.detailedStr];
            mange_block_bool = NO;
        })];
        mange_block_bool = YES;
        management.order_manage = @"1";
    [self.navigationController pushViewController:management animated:YES];
    }
}

#pragma  mark - 判断日跳月 月跳年 判断

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

//日跳月
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

//月跳年
- (NSInteger)withTTTYYYY:(NSInteger)dd  withMM:(NSInteger)mm withchae:(NSInteger)chae
{
//    NSLog(@"huoqunianshu-dd-%ld-mm-%ld-chae-%ld",(long)dd,(long)mm,(long)chae);
        NSDate *  senddate=[NSDate date];
    
        if (dd + chae > [self lllll]) {
//            NSLog(@"大于本月天数");
            NSInteger iii;
            mm = mm +1;
    
            NSDateFormatter  *dateformatter2=[[NSDateFormatter alloc] init];
            [dateformatter2 setDateFormat:@"YYYY"];
            NSString *  locationString2=[dateformatter2 stringFromDate:senddate];
            iii = [locationString2 integerValue];
            if (mm > 12) {
//                NSLog(@"大于当月月号");
//                 NSLog(@"当前年%ld-%ld",(long)iii,(long)(iii+1));
                iii = iii +1;
            }
            return iii;
        }else{
    
            NSDateFormatter  *dateformatter2=[[NSDateFormatter alloc] init];
            [dateformatter2 setDateFormat:@"YYYY"];
    
            NSString *  locationString2=[dateformatter2 stringFromDate:senddate];
            NSInteger iii = [locationString2 integerValue];
//            NSLog(@"budayudangqianyuehao");
//            NSLog(@"dangqiannian%ld",(long)iii);
            return iii;
        }
}

#pragma  mark - 下单
- (void)xiadan
{
    //        NSString *_nameStr;//姓名
    //        //    NSString *_cityStr;//城市
    //        //    NSString *_areaStr;//区域
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
    [[BoolViewController alloc] testOut];
    //取件日期
    NSMutableString *gettime = [NSMutableString stringWithFormat:@"%@",_getNowTime.text];
//    NSLog(@"++huoquriqi%@",gettime);
    NSString *strUrl = [self withNSString:gettime];
//    NSLog(@"获取日期%@",strUrl);
    self.getDate =strUrl;
    //取件时间
    NSMutableString *getTimes = [NSMutableString stringWithFormat:@"%@",_getNowTimeLab.text];
    NSString *strtime = [self tjWithtime:getTimes];
    self.getTime = strtime;
//    NSLog(@"获取时间%@",strtime);
    
    //备注
    self.mark = _textField.text;
    
    //送件日期
    NSMutableString *setTime = [NSMutableString stringWithFormat:@"%@",_postThreeTime.text];
//    NSLog(@"++songjian%@",setTime);
    NSString *setTimeMMDD = [self withNSString:setTime];
//    NSLog(@"送件日期%@",setTimeMMDD);
    self.sendDate = setTimeMMDD;
    //送件时间
    NSMutableString *postTime = [NSMutableString stringWithFormat:@"%@",_postThreeTimeLab.text];
    NSString *postTimessss = [self tjWithtime:postTime];
//    NSLog(@"送件时间%@",postTimessss);
    self.sendTime = postTimessss;
    
    if (CallMe == YES) {
        self.flag = @"2";
        self.sendType = @"3";
    }else{
        self.flag = @"1";
        if (SpecifyTimes == YES) {
            self.sendType = @"1";
        }else{
            self.sendType = @"2";
        }
    }
//    NSLog(@"gettimebubtton---%@",getTimeButton.titleLabel.text);
    if ([_informationLab.text rangeOfString:@"请先点击填写详细地址"].location !=NSNotFound) {
        _shoucixiadan = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请确认用户信息是否正确" delegate:self cancelButtonTitle:@"返回检查" otherButtonTitles:nil];
        [_shoucixiadan show];
    } else if (getTimeBool == NO){
        
        _shoucixiadan = [[UIAlertView alloc] initWithTitle:@"提示" message:@"\n请选择取件时间" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [_shoucixiadan show];
        
    }else{
        _xiadanAlert= [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确定信息填写正确？" delegate:self cancelButtonTitle:@"确定下单" otherButtonTitles: @"返回检查",nil];
        _xiadanAlert.delegate = self;
        [_xiadanAlert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _valeAlert) {
        [getTimeButton setTitle:@"请选择取件时间" forState:UIControlStateNormal];
        [_getNowTime setText:@""];
        [_getNowTimeLab setText:@""];
        [self pushPickerView:0];
    }
    
    if (alertView == _xiadanAlert) {
        //        NSString *_nameStr;//姓名
        //        //    NSString *_cityStr;//城市
        //        //    NSString *_areaStr;//区域
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
        
        if (buttonIndex == 0) {
            [[BoolViewController alloc] testOut];
//            NSLog(@"姓名-%@区域-%@手机号码-%@详细地址-%@用户编号-%@区域id-%@取件日期-%@取件时间-%@送件日期-%@送件时间-%@是否加急-%@备注-%@",self.nameStr,self.cityStr,self.numberSte,self.detailedStr,USER_ID(QQQQ),self.addrId,self.getDate,self.getTime,self.sendDate,self.sendTime,self.flag,self.mark);
            NSMutableDictionary *dicctt =[[NSMutableDictionary alloc] init];
            [dicctt setValue:USER_ID(QQQQ) forKey:@"user_id"];
            
            NSMutableDictionary *dictts = [[NSMutableDictionary alloc] init];
            [dictts setValue:self.nameStr forKey:@"username"];
            [dictts setValue:self.cityStr forKey:@"location"];
            [dictts setValue:self.numberSte forKey:@"mobile"];
            [dictts setValue:self.detailedStr forKey:@"address"];
            [dictts setValue:self.addrId forKey:@"addr_id"];
            [dictts setValue:self.getDate forKey:@"get_date"];
            [dictts setValue:self.getTime forKey:@"get_time"];
            [dictts setValue:self.sendDate forKey:@"send_date"];
            [dictts setValue:self.sendTime forKey:@"send_time"];
            [dictts setValue:self.sendType forKey:@"send_type"];
            [dictts setValue:self.flag forKey:@"flag"];
            [dictts setValue:self.mark forKey:@"mark"];
            [dicctt setValue:@"3" forKey:@"platform"];
            
            [dicctt setValue:dictts forKey:@"field"];
//            NSLog(@"dictts%@",dicctt);
            NSDictionary *dic = [PersonalRequest withAllUrll:@"/index.php?s=/Api/Order/add" WithDic:dicctt];
            
            NSInteger status = [[dic valueForKey:@"status"] integerValue];
//            NSLog(@"xiadan%@",dic);
            if (status == 0) {
                YBMB(@"提交成功")
                [self.navigationController popViewControllerAnimated:YES];
            }else if (status == 1){
//                NSString *data = [dic valueForKey:@"data"];
//                NSLog(@"%@",data);
                SHOW_ALERT([dic valueForKey:@"data"])
            }
        }
    }
    
    
}

- (NSString *)WithWeekYear:(NSInteger)a withMoth:(NSString *)b WithDay:(NSString *)c
{
    NSInteger aa = a;
    NSInteger bb = [b integerValue];
    NSInteger cc = [c integerValue];
//    NSLog(@"a = %ld b = %@ c = %@",(long)a,b,c);
    NSString *aDateString = [NSString stringWithFormat:@"%ld/%ld/%ld",(long)aa,
                             (long)bb,(long)cc];
    
    NSDateFormatter *dateFormatters = [[NSDateFormatter alloc] init];
    
    [dateFormatters setDateFormat:@"YYYY/MM/dd"];
    
    NSDate *aDate = [dateFormatters dateFromString:aDateString];
    
    [dateFormatters setDateFormat:@"eeee"];
    
    NSString *string = [dateFormatters stringFromDate:aDate];//  string为  周日
    
    //    [dateFormatters setDateFormat:@"e"];
//    NSLog(@"星期--%@",string);
    return string;
}

- (NSString *)YYYYMMDDTime
{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"dd"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    NSInteger i = [locationString integerValue];
    
    NSDateFormatter  *dateformatter1=[[NSDateFormatter alloc] init];
    [dateformatter1 setDateFormat:@"MM"];
    NSString *  locationString1=[dateformatter1 stringFromDate:senddate];
    NSInteger ii = [locationString1 integerValue];
    
    NSDateFormatter  *dateformatter2=[[NSDateFormatter alloc] init];
    [dateformatter2 setDateFormat:@"YYYY"];
    NSString *  locationString2=[dateformatter2 stringFromDate:senddate];
    NSInteger iii = [locationString2 integerValue];
    
    NSDateFormatter  *dateformatter4=[[NSDateFormatter alloc] init];
    [dateformatter4 setDateFormat:@"HH"];
    NSString *  locationString4=[dateformatter4 stringFromDate:senddate];
    NSInteger iiii = [locationString4 integerValue];
//    NSLog(@"-------iii%ld---ii%ld----i%ld---iiii%ld",(long)iii,(long)ii,(long)i,(long)iiii);
    if (iiii >= 18) {
        i = i +1;
    }
    NSString *StrI = [NSString stringWithFormat:@"%ld",(long)i];
    NSString *str_1 = [self WithWeekYear:iii withMoth:locationString1 WithDay:StrI];
    
    NSString *str = [NSString stringWithFormat:@"%@\n%ld月%ld日",str_1,(long)ii,(long)i];
    return str;
}

- (NSString *)YYYYMMDD
{
    NSDate *  senddate=[NSDate date];
//
//    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"dd"];
//    NSString *  locationString=[dateformatter stringFromDate:senddate];
    NSInteger i = [[self aasd:_getNowTime.text] integerValue];
//    int i = [locationString intValue];

    NSDateFormatter  *dateformatter1=[[NSDateFormatter alloc] init];
    [dateformatter1 setDateFormat:@"MM"];
    NSString *  locationString1=[dateformatter1 stringFromDate:senddate];
    NSInteger ii = [locationString1 integerValue];
    
//    NSDateFormatter  *dateformatter2=[[NSDateFormatter alloc] init];
//    [dateformatter2 setDateFormat:@"YYYY"];
//    NSString *  locationString2=[dateformatter2 stringFromDate:senddate];
//    int iii = [locationString2 intValue];
    
    NSDateFormatter  *dateformatter4=[[NSDateFormatter alloc] init];
    [dateformatter4 setDateFormat:@"HH"];
    NSString *  locationString4=[dateformatter4 stringFromDate:senddate];
    NSInteger iiii = [locationString4 integerValue];
    
    if (iiii > 18) {
        i = i +1;
    }
    
    NSString *str_1 = [self WithWeekYear:[self withTTTYYYY:i withMM:ii withchae:3] withMoth:[self withTY:i withTYchae:3] WithDay:[self withdd:i withchae:3]];
    
    NSString *str = [NSString stringWithFormat:@"%@\n%@月%@日",str_1,[self withTY:i withTYchae:3],[self withdd:i withchae:3]];
    return str;
}

#pragma  mark - 送件时间段
- (NSArray *)timeNode
{
    NSArray * arr = [[NSArray alloc] initWithObjects:@"9:00-10:00",@"10:00-11:00",@"11:00-12:00",@"12:00-13:00",@"13:00-14:00",@"14:00-15:00",@"15:00-16:00",@"16:00-17:00",@"17:00-18:00",@"18:00-19:00",@"19:00-20:00", nil];
    return arr;
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

#pragma  mark - 当前时间段

- (NSString *)withTimeHH:(NSInteger)a :(NSInteger)b
{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"mm"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    NSInteger i = [locationString integerValue];
    
    NSDateFormatter  *dateformatter4=[[NSDateFormatter alloc] init];
    [dateformatter4 setDateFormat:@"HH"];
    NSString *  locationString4=[dateformatter4 stringFromDate:senddate];
    NSInteger iiii = [locationString4 integerValue];
    if (i >= 59) {
        iiii = iiii +1;
    }
    
    if (iiii == 7){
        NSString *str = [NSString stringWithFormat:@"9:00-10:00"];
        return str;
    }else if (iiii == 8){
        NSString *str = [NSString stringWithFormat:@"10:00-11:00"];
        return str;
    }else if (iiii == 9){
        NSString *str = [NSString stringWithFormat:@"11:00-12:00"];
        return str;
    }else if (iiii == 10){
        NSString *str = [NSString stringWithFormat:@"12:00-13:00"];
        return str;
    }else if (iiii == 11){
        NSString *str = [NSString stringWithFormat:@"13:00-14:00"];
        return str;
    }else if (iiii == 12){
        NSString *str = [NSString stringWithFormat:@"14:00-15:00"];
        return str;
    }else if (iiii == 13){
        NSString *str = [NSString stringWithFormat:@"15:00-16:00"];
        return str;
    }else if (iiii == 14){
        NSString *str = [NSString stringWithFormat:@"16:00-17:00"];
        return str;
    }else if (iiii == 15){
        NSString *str = [NSString stringWithFormat:@"17:00-18:00"];
        return str;
    }else if (iiii == 16){
        NSString *str = [NSString stringWithFormat:@"18:00-19:00"];
        return str;
    }else if (iiii == 17){
        NSString *str = [NSString stringWithFormat:@"19:00-20:00"];
        return str;
    }else {
        NSString *str = [NSString stringWithFormat:@"9:00-10:00"];
        return str;
    }
    
}

#pragma  mark - UITextViewDelegate

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textField resignFirstResponder];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [_textField resignFirstResponder];
        
        return NO;
    }
    return YES;
}
#pragma  mark - 获取联系人信息
- (void)userInformation
{

    [[BoolViewController alloc] testOut];
    NSDictionary *dic = [PersonalRequest withURLStr:@"/index.php?s=/Api/Address/getdefault" withSetValue:USER_ID(QQQQ) withSetValue:nil withSetValue:nil withSetValue:nil withForKey:@"user_id" withForKey:nil withForKey:nil withForKey:nil];
    NSInteger status = [[dic valueForKey:@"status"] integerValue];
//    NSLog(@"=-=+++%@",dic);
    if (status == 0) {

//            YBMB(@"获取信息成功")
            NSDictionary *data = [dic valueForKey:@"data"];
            //        UILabel *_informationLab;//用户明、手机号
            //        UILabel *_addressInformationLab;//地址
        if ([data valueForKey:@"username"] == nil || [data valueForKey:@"username"] == NULL || [[NSString stringWithFormat:@"%@",data] rangeOfString:@"(\n)"].location !=NSNotFound) {
//            [_informationLab setText:@"请先点击填写详细地址"];
//            [_addressInformationLab setText:@""];
            [_getAddress setTitle:@"请先点击填写详细地址" forState:UIControlStateNormal];
            [_informationLab setText:@""];
            [_addressInformationLab setText:@""];
        }else{
            _informationLab.text = [NSString stringWithFormat:@"%@    %@",[data valueForKey:@"username"],[data valueForKey:@"mobile"]];
            _addressInformationLab.text = [NSString stringWithFormat:@"%@ %@",[data valueForKey:@"location"],[data valueForKey:@"address"]];
            [_getAddress setTitle:@"" forState:UIControlStateNormal];
//            NSLog(@"%@    %@ \n%@   %@",[data valueForKey:@"username"],[data valueForKey:@"mobile"],[data valueForKey:@"address"],[data valueForKey:@"location"]);
        }
        
            //        NSString *_nameStr;//姓名
            //        //    NSString *_cityStr;//城市
            //        //    NSString *_areaStr;//区域
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
        [HUD removeFromSuperview];
        
    } else if (status == 1) {
//        [_informationLab setText:@"请先点击填写详细地址"];
//        [_addressInformationLab setText:@""];
        
        [HUD removeFromSuperview];
        YBMB(@"请设置联系人信息")
    }
}

#pragma  mark - 提交的日期
- (NSString *)withNSString:(NSMutableString *)timeStr
{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
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
    
    str = [NSString stringWithFormat:@"%@%@",locationString,str];
    return str;
}

#pragma  mark - 送件日期转换

- (NSString *)aasd:(NSString *)timeStr
{
//    NSLog(@"huoqushijian %@",timeStr);
    if ([BoolViewController isNOTNull:timeStr] == NO) {
        timeStr = [self YYYYMMDDTime];
    }
//    NSLog(@"huoqu时间 %@",timeStr);
    NSDate *  senddate=[NSDate date];

    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MM"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
//    NSInteger locInt = [locationString integerValue];
//    
//    NSString *locStr = [NSString stringWithFormat:@"%d",locInt];
    
    NSInteger locationLength = [locationString length];

//    NSLog(@"songsahdlajsd %@--- %ld",locationString,(long)locationLength);
    
    NSString * str =[timeStr stringByReplacingOccurrencesOfString:@"一" withString:@""];
    
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
    str = [NSString stringWithFormat:@"%@",str];
    
    str = [str substringFromIndex: locationLength];
    
    
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

#pragma  mark - 获取当前月的天数
- (NSInteger)lllll
{
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]];
    
    NSInteger numberOfDaysInMonth = (NSInteger)range.length;
    
//    NSLog(@"numberofdaysinmonth-%ld",(long)numberOfDaysInMonth);
    
    return numberOfDaysInMonth;
}

#pragma  mark - PickView

- (void)pushPickerView:(UIButton *)sender
{
    
    if (sender.tag == 1) {
        PickBool = NO;
        
//        NSLog(@"=======+++++++++_________");
        _provinceArray = [self postTime];
        _bigArray = _bigArray = [[NSArray alloc]initWithObjects:[self timeNode],[self timeNode],[self timeNode],[self timeNode],[self timeNode],[self timeNode],[self timeNode], nil];
        _zongArray = [[NSArray alloc] initWithObjects:_provinceArray,_bigArray, nil];
//        NSLog(@"provinceArray-%@",_provinceArray);
//        NSLog(@"_bigArray-%@",_bigArray);
        [_pickerView reloadAllComponents];
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 216)];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        
        LZWCustomActionSheet *actionSheet = [[LZWCustomActionSheet alloc] initWithView:_pickerView AndHeight:260];
        actionSheet.doneDelegate = self;
        [actionSheet showInView:self.view];

    }else{
        
        getTimeBool = YES;
//        [getTimeButton setTitle:@"" forState:UIControlStateNormal];//选择时间时取消默认文本
//        
//        //选取取件时间
//        NSDate *  senddates=[NSDate date];
//        
//        NSDateFormatter  *dateformatters=[[NSDateFormatter alloc] init];
//        [dateformatters setDateFormat:@"HH"];
//        NSDateFormatter  *dateformatterss=[[NSDateFormatter alloc] init];
//        [dateformatterss setDateFormat:@"mm"];
//        NSString *  locationStrings=[dateformatters stringFromDate:senddates];
//        NSString *  locationStringss=[dateformatterss stringFromDate:senddates];
//        int timeHoursInt = [locationStrings intValue];
//        int timemm = [locationStringss intValue];
//        
//        NSString *str = [self withTimeHH:timeHoursInt :timemm];
//        [_getNowTimeLab setText:str];
//        [_getNowTime setText:[self YYYYMMDDTime]];
        ///////////////////////////////////////////////////////////////
        PickBool = YES;
        
        _provinceArray = [self getTimes];
//        NSLog(@"provinceArray-%@",_provinceArray);
        _bigArray = [[NSArray alloc]initWithObjects:[self gettimeNode],[self timeNode],[self timeNode],[self timeNode],[self timeNode],[self timeNode],[self timeNode], nil];
//        NSLog(@"_bigArray-%@",_bigArray);
        _zongArray = [[NSArray alloc] initWithObjects:_provinceArray,_bigArray, nil];
        [_pickerView reloadAllComponents];

        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 216)];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        
        [_pickView addSubview:_pickerView];
        
        
        LZWCustomActionSheet *actionSheet = [[LZWCustomActionSheet alloc] initWithView:_pickerView AndHeight:260];
        actionSheet.doneDelegate = self;
        [actionSheet showInView:self.view];
    }
    
}


#pragma  mark - UIPickerViewDelegate&&&UIPickerViewDataSource

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickerView reloadAllComponents];
    if (component == 0) {
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

//    NSLog(@"%@",[_zongArray objectAtIndex:component]);
    if (PickBool == YES) {
        
        if (component == 0) {
            return _provinceArray.count;
        }else{
            NSInteger provinceRow = [pickerView selectedRowInComponent:0];
            return [[_bigArray objectAtIndex:provinceRow] count];
        }
    }else{
        if (component == 0) {
            return _provinceArray.count;
        }else{
            NSInteger provinceRow = [pickerView selectedRowInComponent:0];
            return [[_bigArray objectAtIndex:provinceRow] count];
        }
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //先根据component找到大数组中对应的小数组，然后根据row从小数组中找到对应的title
    if (PickBool == YES) {
        if (component == 0) {
            return [_provinceArray objectAtIndex:row];
        }else{
            NSInteger provinceRow = [pickerView selectedRowInComponent:0];
            return [[_bigArray objectAtIndex:provinceRow] objectAtIndex:row];
        }
    }else{
        if (component == 0) {
            return [_provinceArray objectAtIndex:row];
        }else{
            NSInteger provinceRow = [pickerView selectedRowInComponent:0];
            return [[_bigArray objectAtIndex:provinceRow] objectAtIndex:row];
        }
    }
    
    
    [pickerView reloadAllComponents];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
//    NSLog(@"pickerBool-%d",PickBool);
    UILabel *myView = nil;
    if (component == 0) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 180, 40)];
        
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [_provinceArray objectAtIndex:row];
//        NSLog(@"!!!%@",[_provinceArray objectAtIndex:row]);
        myView.font = [UIFont systemFontOfSize:17];
        if (iPhone6Plus) {
            myView.frame = CGRectMake(0.0, 0.0, 200, 40);
            myView.font = [UIFont systemFontOfSize:20];
        }//用label来设置字体大小
        myView.backgroundColor = [UIColor clearColor];
        return myView;
    }else if(component == 1) {
        
        if (PickBool == YES) {
            myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 150, 40)];
            myView.text = [self pickerView:pickerView titleForRow:row forComponent:component];
//            NSLog(@"-----%ld",(long)row);
//            NSLog(@"===++++===%@",_bigArray);
            myView.textAlignment = NSTextAlignmentCenter;
            myView.font = [UIFont systemFontOfSize:17];
            if (iPhone6Plus) {
                myView.frame = CGRectMake(0.0, 0.0, 170, 40);
                myView.font = [UIFont systemFontOfSize:20];
            }
            myView.backgroundColor = [UIColor clearColor];
            return myView;
        }else{
            myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 150, 40)];

            myView.text = [self pickerView:pickerView titleForRow:row forComponent:component];
//            NSLog(@"--%ld---%@",(long)row,_bigArray);
            myView.textAlignment = NSTextAlignmentCenter;
            
            myView.font = [UIFont systemFontOfSize:17];
            if (iPhone6Plus) {
                myView.frame = CGRectMake(0.0, 0.0, 170, 40);
                myView.font = [UIFont systemFontOfSize:20];
            }
            myView.backgroundColor = [UIColor clearColor];
            
            return myView;
        }
 
    }else{
        return myView;
    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat componentWidth = 0.0;

    
    if (iPhone6Plus) {
        if (component == 0)
        {
            componentWidth = 200.0; // 第一个组键的宽度
        }else{
            
            componentWidth = 170.0; // 第2个组键的宽度
        }
    }else{
        if (component == 0)
        {
            componentWidth = 180.0; // 第一个组键的宽度
        }
        else{
            
            componentWidth = 150.0; // 第2个组键的宽度
        }
    }
    return componentWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0;
}

- (void)done
{
//    NSLog(@"123");
    
    [_pickerView reloadAllComponents];
    
    NSInteger provinceRow = [_pickerView selectedRowInComponent:0];
    NSInteger city = [_pickerView selectedRowInComponent:1];
    
//    NSLog(@"iii - %ld  iiii- %ld",(long)provinceRow,(long)city);
//    NSLog(@"---------%@-%@",[_provinceArray objectAtIndex:provinceRow],[[_bigArray objectAtIndex:provinceRow] objectAtIndex:city]);
    
    NSMutableString *String1 = [[NSMutableString alloc] initWithString:[_provinceArray objectAtIndex:provinceRow]];
    [String1 insertString:@"\n" atIndex:3];
//    NSLog(@"=====%@",String1);
    
    if (PickBool == YES) {
        [getTimeButton setTitle:@"" forState:UIControlStateNormal];//选择时间时取消默认文本
//        NSLog(@"aaaaaa%@",[_provinceArray objectAtIndex:provinceRow]);
        _songjianshijianqian = [_provinceArray objectAtIndex:provinceRow];
        _getNowTime.text = String1;
        _getNowTimeLab.text = [[_bigArray objectAtIndex:provinceRow] objectAtIndex:city];
        //当选择了取件时间后 送件时间要及时更换
        NSString *str_1 = [self YYYYMMDD];
        NSString *riqiStr = [NSString stringWithFormat:@"%@",str_1];
        [_postThreeTime setText:riqiStr];
        [self valve];
    }else if (PickBool == NO)
    {
        _postThreeTime.text = String1;
        _postThreeTimeLab.text = [[_bigArray objectAtIndex:provinceRow] objectAtIndex:city];
    }
}

#pragma  mark - 获取阀值
- (void)valve
{
    NSMutableString *gettime = [NSMutableString stringWithFormat:@"%@",_getNowTime.text];
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

@end
