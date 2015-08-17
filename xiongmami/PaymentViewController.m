//
//  PaymentViewController.m
//  xiongmami
//
//  Created by iMac on 14/11/21.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//
/////////////////////已弃用///////////////////
/////////////////////已弃用///////////////////
/////////////////////已弃用///////////////////
/////////////////////已弃用///////////////////
/*
#import "PaymentViewController.h"
#import "cnvUILabel.h"
#import "OtherPay.h"
#import "NIDropDown.h"
#import "MBButtonMenuViewController.h"
#import "HexadecimalConversionUICOLOR.h"

@interface PaymentViewController () <ONPQuickPayPluginDelegate>
{
//    NIDropDown *_fkfsDrop;
    UIButton *_fkfsButton;
    
    UILabel *_dingdanbianhao;
    UILabel *_dingdanjine;
    UILabel *_keyongyue;
    
    BOOL insufficient;
    
}
//快捷支付插件
@property (retain, nonatomic) ONPQuickPayPlugin *quickPayPlugin;

@property (nonatomic, strong) MBButtonMenuViewController *menu;

@end
@implementation PaymentViewController
@synthesize quickPayPlugin;
@synthesize result = _result;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:246/255.0f green:240/255.0f blue:236/255.0f alpha:1];
    self.title = @"付款";
    
    [self numberOrder];
    
    /////////////////////////////////
    _strMerchantID = @"175093";
    _strMerchantName = @"熊管家";
    _strMerchantKey = @"i8mz5bwvw0buw5xxgbw2szzgwilafxv1hf6eep7yyn52ixtcgxrrz803504cegg9jwemktgnw5a8j03xois7t9da8nkmyoshzi0b4bmdpdzwqe31125qzd9wty3hhim5";
    _strNotifyUrl = @"http://mptest.5k.com/api/OneNinePay/get_data_server";
    
    //生成商家权限验证码
    _strIdentityCode = [self getIdentityCodeWithMerchantID:_strMerchantID MerchantKey:_strMerchantKey];
    
    quickPayPlugin = [[ONPQuickPayPlugin alloc] init];
    quickPayPlugin.delegate = self;

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(bback)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
}

- (void)bback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)numberOrder
{
    _lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, 40)];
    //空白区位长度为4
    if (_orderNumber == nil || _orderNumber == NULL) {
        _lab.text = @"    订单编号：2014110460";
    }else{
        _lab.text = _orderNumber;
        [self payTheOrderid];
    }
    [_lab setTextAlignment:NSTextAlignmentLeft];
    [_lab setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_lab];
    
    
    UILabel *dingdanMoney = [[UILabel alloc] initWithFrame:CGRectMake(0, 104, 110, 40)];
    dingdanMoney.text = @"    订单金额：";
    dingdanMoney.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dingdanMoney];
    
    _dingdanJ = [[UILabel alloc] initWithFrame:CGRectMake(100, 104, VIEW_FRAME_SIZE_WIDTH-100, 40)];
    if (_orderAmount == nil || _orderAmount == NULL) {
        _dingdanJ.text = @"99.00元";
    }else{
        _dingdanJ.text = [NSString stringWithFormat:@"%@元",_orderAmount];
    }
    
    [_dingdanJ setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#ed6c44" ]];
    [_dingdanJ setBackgroundColor:[UIColor whiteColor]];
    [_dingdanJ setFont:[UIFont systemFontOfSize:20]];
    [_dingdanJ setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:_dingdanJ];
    
//    [self oneone:0];
    
}

- (void)oneone:(int)key
{
    key_OK = key;
    
//    NSLog(@"key = %d",key);
    if (key == 0) {
        UILabel *kyje = [[UILabel alloc] initWithFrame:CGRectMake(0, 154, 110, 35)];
        [kyje setText:@"    可用金额："];
        [kyje setTextColor:[UIColor blackColor]];
        [kyje setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:kyje];
        insufficient = YES;
        _dingdanY = [[UILabel alloc] initWithFrame:CGRectMake(100, 154, VIEW_FRAME_SIZE_WIDTH -100, 35)];
        [_dingdanY setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#ed6c44"]];
        [_dingdanY setBackgroundColor:[UIColor whiteColor]];
        [_dingdanY setFont:[UIFont systemFontOfSize:20]];
        [_dingdanY setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:_dingdanY];
        
        _yueJ = [[UILabel alloc] initWithFrame:CGRectMake(150, 225, VIEW_FRAME_SIZE_WIDTH - 150, 40)];
        [_yueJ setTextColor:[UIColor clearColor]];
        [_yueJ setFont:[UIFont systemFontOfSize:20]];
        [_yueJ setTextAlignment:NSTextAlignmentLeft];
        [_yueJ setBackgroundColor:[UIColor redColor]];
        [_yueJ setAlpha:0];
        [self.view addSubview:_yueJ];
        
        if (iPhone6) {
            kyje.frame = CGRectMake(0, 154, 110, 50);
            _dingdanY.frame = CGRectMake(100, 154, VIEW_FRAME_SIZE_WIDTH -100, 50);
        }else if (iPhone6Plus){
            kyje.frame = CGRectMake(0, 154, 110, 55);
            _dingdanY.frame = CGRectMake(100, 154, VIEW_FRAME_SIZE_WIDTH -100, 55);
        }
        
    }else if (key == 1) {
        
        UIView *vies = [[UIView alloc] initWithFrame:CGRectMake(0, 194, VIEW_FRAME_SIZE_WIDTH, 70)];
        vies.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:vies];
        
        UILabel *kyje = [[UILabel alloc] initWithFrame:CGRectMake(0, 154, 110, 40)];
        [kyje setText:@"    可用金额："];
        [kyje setTextColor:[UIColor blackColor]];
        [kyje setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:kyje];
        
        _dingdanY = [[UILabel alloc] initWithFrame:CGRectMake(100, 154, VIEW_FRAME_SIZE_WIDTH -100, 40)];
        [_dingdanY setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#ed6c44"]];
        [_dingdanY setBackgroundColor:[UIColor whiteColor]];
        [_dingdanY setFont:[UIFont systemFontOfSize:20]];
        [_dingdanY setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:_dingdanY];
        
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 200, 27*0.8, 27*0.8)];
        [self.view addSubview:_image];
        
        UIButton *buton = [UIButton buttonWithType:UIButtonTypeCustom];
        [buton setFrame:CGRectMake(0, 194, VIEW_FRAME_SIZE_WIDTH, 70)];
        [buton setBackgroundColor:[UIColor clearColor]];
        insufficient = NO;
        _panduan = NO;
        _zhifufangshi = YES;
//        NSLog(@"insufficient = NO");
        if (insufficient == NO) {
            _image.image = [UIImage imageNamed:@"xuanz.png"];
        } else {
            _image.image = [UIImage imageNamed:@"次日达btnhover.png"];
        }
        [buton addTarget:self action:@selector(yuebuzu:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:buton];
        
        UILabel *asd = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 0, VIEW_FRAME_SIZE_WIDTH*0.9, 0.5)];
        [asd setBackgroundColor:[UIColor lightGrayColor]];
        
        UILabel * yezfxq = [[UILabel alloc] initWithFrame:CGRectMake(20+27*0.8, 195, VIEW_FRAME_SIZE_WIDTH - 20+27*0.8, 30)];
        yezfxq.text = @"    余额不足，使用余额加其他方式付款";
        [yezfxq setFont:[UIFont systemFontOfSize:15]];
        [yezfxq setBackgroundColor:[UIColor whiteColor]];
        [yezfxq setTextColor:[UIColor blackColor]];
        [self.view addSubview: yezfxq];
        
        UILabel *yueJE = [[UILabel alloc] initWithFrame:CGRectMake(20, 225, 140, 40)];
        yueJE.text = @"其他方式需再支付：";
        [yueJE setTextColor:[UIColor blackColor]];
        [yueJE setFont:[UIFont systemFontOfSize:15]];
        [yueJE setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:yueJE];
        
        _yueJ = [[UILabel alloc] initWithFrame:CGRectMake(150, 225, VIEW_FRAME_SIZE_WIDTH - 150, 40)];
        [_yueJ setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#ed6c44"]];
//        [_yueJ setBackgroundColor:[UIColor blackColor]];
        [_yueJ setFont:[UIFont systemFontOfSize:20]];
        [_yueJ setTextAlignment:NSTextAlignmentLeft];
        [_yueJ setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:_yueJ];
        
        if (iPhone6) {
            vies.frame = CGRectMake(0, 205, VIEW_FRAME_SIZE_WIDTH, 80);
            kyje.frame = CGRectMake(0, 154, 110, 50);
            _dingdanY.frame = CGRectMake(100, 156, VIEW_FRAME_SIZE_WIDTH -100, 40);
            [buton setFrame:CGRectMake(0, 205, VIEW_FRAME_SIZE_WIDTH, 80)];
            
            _image.frame = CGRectMake(20, 213, 27*0.8, 27*0.8);
//            [_ClickButton setFrame:CGRectMake(20, 213, 27*0.8, 27*0.8)];
            asd.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 0, VIEW_FRAME_SIZE_WIDTH*0.9, 0.5);
            yezfxq.frame = CGRectMake(20+27*0.8, 205, VIEW_FRAME_SIZE_WIDTH - 20+27*0.8, 35);
            yueJE.frame = CGRectMake(20, 235, 140,40);
            
            _yueJ.frame = CGRectMake(150, 235, VIEW_FRAME_SIZE_WIDTH - 150, 40);
        }
    }
    [self fuKuan];
}

#pragma  mark - 付款
- (void)yuebuzu:(UIButton *)sender
{
    if (_panduan == NO) {
        _image.image = [UIImage imageNamed:@"次日达btnhover.png"];
        _panduan = YES;
        _zhifufangshi = NO;
//        NSLog(@"yes");
    }else{
        _image.image = [UIImage imageNamed:@"xuanz.png"];
        _panduan = NO;
        _zhifufangshi = YES;
//        NSLog(@"no");
    }
}

- (void)fuKuan
{
    UILabel *fkfsLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 275, VIEW_FRAME_SIZE_WIDTH, 40)];
    fkfsLab.text = @"  其他付款方式";
    [fkfsLab setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:fkfsLab];
    
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    okButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 335, VIEW_FRAME_SIZE_WIDTH*0.9, 40);
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    [okButton setBackgroundImage:[UIImage imageNamed:@"保存btn.png"] forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(okPay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okButton];
    
    UIImageView *payImage = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 30, 285, 10, 20)];
    [payImage setImage:[UIImage imageNamed:@"箭头.png"]];
    [self.view addSubview:payImage];
    
     _fkfsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _fkfsButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 130, 275, 100, 40);
    [_fkfsButton setBackgroundColor:[UIColor whiteColor]];
    [_fkfsButton setTitle:@"默认支付" forState:UIControlStateNormal];
//    [_fkfsButton addTarget:self action:@selector(xuanzezhifu:) forControlEvents:UIControlEventTouchUpInside];
    [_fkfsButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _fkfsButton.tag = 10000;
    
    [self.view addSubview:_fkfsButton];
    
    UIButton *fkfsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [fkfsBtn setFrame:CGRectMake(0, 275, VIEW_FRAME_SIZE_WIDTH, 40)];
    [fkfsBtn setBackgroundColor:[UIColor clearColor]];
    [fkfsBtn addTarget:self action:@selector(pushPickView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fkfsBtn];
    
    if (key_OK == 0) {
//        NSLog(@"key_ok = 0");
        fkfsLab.frame = CGRectMake(0, 199, VIEW_FRAME_SIZE_WIDTH, 40);
        payImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 30, 209, 10, 20);
        
        _fkfsButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 130, 199, 100, 40);
        [fkfsBtn setFrame:CGRectMake(0, 199, VIEW_FRAME_SIZE_WIDTH, 40)];
        okButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 290, VIEW_FRAME_SIZE_WIDTH*0.9, 40);
        
    }else if (key_OK == 1){
//        NSLog(@"key_ok = 1");
        fkfsLab.frame = CGRectMake(0, 275, VIEW_FRAME_SIZE_WIDTH, 40);
        payImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 30, 285, 10, 20);
        
        _fkfsButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 130, 275, 100, 40);
        [fkfsBtn setFrame:CGRectMake(0, 275, VIEW_FRAME_SIZE_WIDTH, 40)];
        okButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 335, VIEW_FRAME_SIZE_WIDTH*0.9, 40);
    }
    
    if (iPhone6) {
        
        if (key_OK == 0) {
            fkfsLab.frame = CGRectMake(0, 214, VIEW_FRAME_SIZE_WIDTH, 50);
            payImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 30, 229, 10, 20);
            
            _fkfsButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 130, 219, 100, 40);
            [fkfsBtn setFrame:CGRectMake(0, 219, VIEW_FRAME_SIZE_WIDTH, 40)];
            okButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 305, VIEW_FRAME_SIZE_WIDTH*0.9, 50);
        }else if (key_OK == 1){
            
            fkfsLab.frame = CGRectMake(0, 325, VIEW_FRAME_SIZE_WIDTH, 40);
            payImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 30, 325, 10, 20);
            
            _fkfsButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 130, 325, 100, 40);
            [fkfsBtn setFrame:CGRectMake(0, 325, VIEW_FRAME_SIZE_WIDTH, 40)];
            okButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 375, VIEW_FRAME_SIZE_WIDTH*0.9, 40);
        }
        
    }else if (iPhone6Plus){
        if (key_OK == 0) {
            fkfsLab.frame = CGRectMake(0, 219, VIEW_FRAME_SIZE_WIDTH, 55);
            payImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 30, 235, 10, 20);
            
            _fkfsButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 130, 219, 100, 55);
            [fkfsBtn setFrame:CGRectMake(0, 219, VIEW_FRAME_SIZE_WIDTH, 55)];
            okButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 319, VIEW_FRAME_SIZE_WIDTH*0.9, 50);
        }else if (key_OK == 1){
            
            fkfsLab.frame = CGRectMake(0, 275, VIEW_FRAME_SIZE_WIDTH, 50);
            payImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 30, 290, 10, 20);
            
            _fkfsButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 130, 275, 100, 50);
            [fkfsBtn setFrame:CGRectMake(0, 275, VIEW_FRAME_SIZE_WIDTH, 50)];
            okButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 375, VIEW_FRAME_SIZE_WIDTH*0.9, 50);
        }
    }
    
}

- (void)okPay:(UIButton *)sender
{
//    NSLog(@"fdsdgdsdg%d",insufficient);
    
    if ([BoolViewController isNOTNull:_yueJ.text] == NO) {
//        NSLog(@".0.00.0.0..0.0------%@",_yueJ.text);
        NSString *str = @"小主～支付信息错误~请查看网络是否通畅！";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
        
    } else{

        CGFloat chae = [_yueJ.text floatValue];
        
        if (chae > 0 && insufficient == NO && [_fkfsButton.titleLabel.text rangeOfString:@"默认支付"].location !=NSNotFound
            ) {
            SHOW_ALERT(@"默认为余额支付，余额不足，请选择其他支付方式")
//            NSLog(@"1");
        } else if ((([_fkfsButton.titleLabel.text rangeOfString:@"支付宝"].location !=NSNotFound || [_fkfsButton.titleLabel.text rangeOfString:@"现金"].location !=NSNotFound || [_fkfsButton.titleLabel.text rangeOfString:@"银联"].location !=NSNotFound || chae > 0)&& insufficient == NO && _zhifufangshi == NO)){
            
            NSString *str = @"小主～要核对好金额哦。";
            
            _payAndremainAlert = [[UIAlertView alloc] initWithTitle:@"确认支付？" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles: @"取消",nil];
            
            [_payAndremainAlert show];
//            NSLog(@"2");
        } else if (insufficient == YES && [_fkfsButton.titleLabel.text rangeOfString:@"默认支付"].location !=NSNotFound){
            
            SHOW_ALERT(@"默认为余额支付，余额不足，请选择其他支付方式")
//            NSLog(@"3");
        } else if ((insufficient == NO && [_fkfsButton.titleLabel.text rangeOfString:@"余额"].location !=NSNotFound)||(chae > 0 && insufficient == YES && [_fkfsButton.titleLabel.text rangeOfString:@"余额"].location !=NSNotFound)){
            
            SHOW_ALERT(@"余额不足，请选择其他支付方式")
//            NSLog(@"4");
        } else if (chae < 0 && insufficient == YES && [_fkfsButton.titleLabel.text rangeOfString:@"余额"].location !=NSNotFound)
        {
            NSString *str = @"小主～要核对好金额哦.";
            _payAlert = [[UIAlertView alloc] initWithTitle:@"确认支付？" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [_payAlert show];
//            NSLog(@"5");
        }else if (chae > 0 && insufficient == YES && [_fkfsButton.titleLabel.text rangeOfString:@"现金"].location !=NSNotFound){
            NSString *str = @"小主～要核对好金额哦.";
            _payAlert = [[UIAlertView alloc] initWithTitle:@"确认支付？" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [_payAlert show];
//            NSLog(@"6");
        }else if (((([_fkfsButton.titleLabel.text rangeOfString:@"支付宝"].location !=NSNotFound || [_fkfsButton.titleLabel.text rangeOfString:@"现金"].location !=NSNotFound || [_fkfsButton.titleLabel.text rangeOfString:@"银联"].location !=NSNotFound)&& insufficient == NO)|| chae < 0)){
            
            NSString *str = @"小主～要核对好金额哦.";
            _payAlert = [[UIAlertView alloc] initWithTitle:@"确认支付？" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [_payAlert show];
//            NSLog(@"7");
        }else if ((([_fkfsButton.titleLabel.text rangeOfString:@"支付宝"].location !=NSNotFound || [_fkfsButton.titleLabel.text rangeOfString:@"现金"].location !=NSNotFound || [_fkfsButton.titleLabel.text rangeOfString:@"银联"].location !=NSNotFound || chae > 0)&& insufficient == NO && _zhifufangshi ==YES)){
            NSString *str = @"小主～要核对好金额哦.";
            _payAlert = [[UIAlertView alloc] initWithTitle:@"确认支付？" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [_payAlert show];
//            NSLog(@"8");
        }

    }
    
//    NSString *str = @"小主～要核对好金额哦。";
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认支付？" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//    [alert show];
//    [self remainAndOtherPay:@"50"];

}

- (void)getRemain
{
    NSMutableDictionary *dicct = [[NSMutableDictionary alloc] init];
    [dicct setValue:USER_ID(QQQQ) forKey:@"user_id"];
    [[BoolViewController alloc] testOut];
    NSDictionary *dic = [PersonalRequest withAllUrll:@"/index.php?s=/api/Pay/get_remain" WithDic:dicct];
    int status = [[dic valueForKey:@"status"] intValue];
//    NSLog(@"dic== %@",dic);
    if (status == 0) {
//        NSLog(@"data == %@",[dic valueForKey:@"data"]);
        NSString *str = [[dic valueForKey:@"data"] valueForKey:@"remain"];
        
        CGFloat orderMoney = [_orderAmount floatValue];
        CGFloat orderRemain = [str floatValue];

//        NSLog(@"orderMoney=%.2f---orderRemain%.2f",orderMoney,orderRemain);
        if (orderRemain < orderMoney && orderRemain >= 0.00f && orderRemain != orderMoney ) {
//            NSLog(@"余额不足");
            [self oneone:1];
            if (str == nil || str == NULL) {
                _dingdanY.text = @"0元";
            }else{
                _dingdanY.text = [NSString stringWithFormat:@"%.2f元",orderRemain];
            }
            _yueJ.text = [NSString stringWithFormat:@"%.2f",(orderMoney - orderRemain)];
//            NSLog(@"1_yuej%@------%.2f",_yueJ.text,(orderMoney - orderRemain));
        }else if (orderRemain == 0.00f && orderMoney == 00.00f) {
//            NSLog(@"余额为零，所需金额为零!");
            [self oneone:0];
            if (str == nil || str == NULL) {
                _dingdanY.text = @"0元";
            }else{
                _dingdanY.text = [NSString stringWithFormat:@"%.2f元",orderRemain];
//                NSLog(@"可用金额%f",orderRemain);
            }
            _yueJ.text = [NSString stringWithFormat:@"%.2f",(orderMoney - orderRemain)];
//            NSLog(@"2_yuej%@------%.2f",_yueJ.text,(orderMoney - orderRemain));
        }
        else{
            [self oneone:0];
            if (str == nil || str == NULL) {
                _dingdanY.text = @"0";
            }else{
                _dingdanY.text = [NSString stringWithFormat:@"%.2f元",orderRemain];
//                NSLog(@"1可用金额%f",orderRemain);
            }
            _yueJ.text = [NSString stringWithFormat:@"%.2f",(orderMoney - orderRemain)];
//            NSLog(@"4_yuej%@------%.2f",_yueJ.text,(orderMoney - orderRemain));
        }
        
    }else {
        YBMB(@"ERROR")
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [self getRemain];
//    NSLog(@"!_!2");
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
}

#pragma  mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _aliAlert) {
//        NSLog(@"123");

        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    if (alertView ==_payAlert) {
        
        if (buttonIndex == 0) {
            
            _otherPay = YES;
            _remainPay = NO;
            
            if ([_fkfsButton.titleLabel.text rangeOfString:@"银联"].location != NSNotFound){
                NSString *orderID =[_orderNumber stringByReplacingOccurrencesOfString:@"订单编号:" withString:@""];
                orderID =[orderID stringByReplacingOccurrencesOfString:@" " withString:@""];
//                NSLog(@"orderid-%@",orderID);
                [self payWithOrderID:orderID withMoney:_dingdanY.text];
            }

            if ([_fkfsButton.titleLabel.text rangeOfString:@"支付宝"].location != NSNotFound) {
                
                NSString *orderID =[_orderNumber stringByReplacingOccurrencesOfString:@"订单编号:" withString:@""];
                orderID =[orderID stringByReplacingOccurrencesOfString:@" " withString:@""];
//                NSLog(@"orderid-%@",orderID);
                [self tijiao:orderID withMoney:_dingdanY.text];

            }
            
            if ([_fkfsButton.titleLabel.text rangeOfString:@"现金"].location != NSNotFound){
                [self remainAndOtherPay:@"1" ];
            }
            
            if ([_fkfsButton.titleLabel.text rangeOfString:@"余额"].location != NSNotFound){
                [self remainAndOtherPay:@"2" ];
            }
            
            if ([_fkfsButton.titleLabel.text rangeOfString:@"默认支付"].location != NSNotFound){
                [self remainAndOtherPay:@"2" ];
            }
            }
    }
    
    if (alertView == _payAndremainAlert) {
        if (buttonIndex == 0) {
            _remainPay = YES;
            _otherPay = NO;
            if ([_fkfsButton.titleLabel.text rangeOfString:@"支付宝"].location != NSNotFound) {
                
                NSString *orderID =[_orderNumber stringByReplacingOccurrencesOfString:@"订单编号:" withString:@""];
                orderID =[orderID stringByReplacingOccurrencesOfString:@" " withString:@""];
//                NSLog(@"orderid-%@",orderID);
                [self tijiao:orderID withMoney:_yueJ.text];
                
            }
            
            if ([_fkfsButton.titleLabel.text rangeOfString:@"现金"].location != NSNotFound){
                [self remainAndMoney:@"10" ];
            }
            
            if ([_fkfsButton.titleLabel.text rangeOfString:@"银联"].location != NSNotFound){
                
                NSString *orderID =[_orderNumber stringByReplacingOccurrencesOfString:@"订单编号:" withString:@""];
                orderID =[orderID stringByReplacingOccurrencesOfString:@" " withString:@""];
//                NSLog(@"orderid-%@",orderID);
                [self payWithOrderID:orderID withMoney:_yueJ.text];
            }
        }
    }
}

#pragma  mark - payTheOrderid
- (void)payTheOrderid
{
    NSString *order_id =[_orderNumber stringByReplacingOccurrencesOfString:@"订单编号:" withString:@""];
    order_id =[order_id stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:order_id forKey:@"pay_order_id"];
}

#pragma  mark - NSUserDefaults
- (void)userDefaults
{
    NSString *otherPay = [NSString stringWithFormat:@"%d",_otherPay];
    NSString *remainPay = [NSString stringWithFormat:@"%d",_remainPay];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:otherPay forKey:@"otherPay"];
    [userDefaults setObject:remainPay forKey:@"remainPay"];
}

#pragma  mark - 支付返回提交服务器
//余额加现金
- (void)remainAndMoney:(NSString *)pay_type
{
    [[BoolViewController alloc] testOut];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString  * orderID = [userDefaults objectForKey:@"pay_order_id"];
    
//    NSLog(@"MONEYpay-user-orderid-%@",orderID);
    
    NSMutableDictionary *diccctt = [[NSMutableDictionary alloc] init];
    [diccctt setValue:USER_ID(QQQQ) forKey:@"user_id"];
    [diccctt setValue:orderID forKey:@"order_id"];
    [diccctt setValue:pay_type forKey:@"pay_type"];
    
    NSDictionary *dic = [PersonalRequest withAllUrll:@"/index.php?s=/api/Pay/pay_money" WithDic:diccctt];
    
    int status = [[dic valueForKey:@"status"] intValue];
//    NSLog(@"----MONEYpay--%@--status%d",dic,status);
    if (status == 0) {
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud removeObjectForKey:@"order_id"];
        [ud removeObjectForKey:@"remainPay"];
        [ud removeObjectForKey:@"otherPay"];
        
        [ud synchronize];

//        NSLog(@"现金支付- -%@",dic);
        _aliAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请物流人员确认收款后刷新列表！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [_aliAlert show];
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        YBMB(@"ERROR")
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)remainAndOtherPay:(NSString *)pay_type
{

    [[BoolViewController alloc] testOut];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString  * orderID = [userDefaults objectForKey:@"pay_order_id"];
//    NSLog(@"user-orderid-%@",orderID);
    
    NSMutableDictionary *diccctt = [[NSMutableDictionary alloc] init];
    [diccctt setValue:USER_ID(QQQQ) forKey:@"user_id"];
    [diccctt setValue:orderID forKey:@"order_id"];
    [diccctt setValue:pay_type forKey:@"pay_type"];
    
    NSDictionary *dic = [PersonalRequest withAllUrll:@"/index.php?s=/api/Pay/pay_money" WithDic:diccctt];
    
    int status = [[dic valueForKey:@"status"] intValue];
//    NSLog(@"----pay--%@--status%d",dic,status);
    if (status == 0) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud removeObjectForKey:@"order_id"];
        [ud removeObjectForKey:@"remainPay"];
        [ud removeObjectForKey:@"otherPay"];
        [ud synchronize];

//        NSLog(@"ud-order-%@-%d-%d",[ud valueForKey:@"order_id"],[[ud valueForKey:@"otherPay"] boolValue],[[ud valueForKey:@"remainPay"] boolValue]);
        if ([pay_type rangeOfString:@"40"].location != NSNotFound || [pay_type rangeOfString:@"4"].location != NSNotFound) {
            
        }else if ([pay_type rangeOfString:@"1"].location != NSNotFound || [pay_type rangeOfString:@"10"].location != NSNotFound){
//            
//            NSLog(@"现金支付- -%@",dic);
            _aliAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请物流人员确认收款后刷新列表！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [_aliAlert show];
            
        }else{
        
            _aliAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"支付成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [_aliAlert show];
            
        }
    }else{
        YBMB(@"ERROR")
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)nsl
{
//    NSLog(@"_otherpay%d,_remainpay%d",_otherPay,_remainPay);
}
#pragma  mark - 19pay
#pragma  mark - 充值请求
- (void)payWithOrderID:(NSString *)orderid withMoney:(NSString *)money
{
    [self nsl];
    //orderid订单编号
    //money充值金额
    // 模拟支付订单
    NSString *strOrderDate = [self getOrderDate];//订单日期
    NSString *strOrderID = [NSString stringWithFormat:@"%@", orderid];
    PayPlugin *entity = [[PayPlugin alloc] initWithUserID:[NSString stringWithFormat:@"%@",USER_ID(QQQQ)] ShopName:@"熊管家" ProductName:@"熊管家洗衣" ProductDesc:@"熊管家洗衣服务" Amount:_orderAmount];
    
    //初始化快捷支付订单信息
//    BOOL bCreateOrderSuccess = [quickPayPlugin createInfoWithMerchantID:_strMerchantID MerchantName:_strMerchantName MerchantUserID:entity.strUserID OrderID:strOrderID OrderDate:strOrderDate Amount:entity.strAmount IdentityCode:_strIdentityCode NotifyURL:_strNotifyUrl ProductName:entity.strProductName ProductDesc:entity.strProductDesc ShopName:entity.strShopName];
    
    BOOL bCreateOrderSuccess = [quickPayPlugin createInfoWithMerchantID:_strMerchantID
                                                           MerchantName:_strMerchantName
                                                         MerchantUserID:entity.strUserID
                                                                OrderID:strOrderID
                                                              OrderDate:strOrderDate
                                                                 Amount:entity.strAmount
                                                           IdentityCode:_strIdentityCode
                                                            MerchantKey:_strMerchantKey
                                                              NotifyURL:_strNotifyUrl
                                                            ProductName:entity.strProductName
                                                            ProductDesc:entity.strProductDesc
                                                            ProductType:@"3"
                                                               ShopName:entity.strShopName
                                                        BankChannelType:0
                                                               BankName:@""
                                                                 BankId:@""
                                                           BankCardType:@""];
    
//    NSLog(@"uid-%@ shopname-%@ productName-%@ productDesc-%@ amount-%@ strorder-%@ _strMerchantID-%@ _strMerchantName-%@ _strIdentityCode-%@ _strNotifyUrl-%@ ",entity.strUserID,entity.strShopName,entity.strProductName,entity.strProductDesc,entity.strAmount,strOrderID,_strMerchantID,_strMerchantName,_strIdentityCode,_strNotifyUrl);
    
    if (bCreateOrderSuccess) {
        //使用快捷支付插件进行支付
        [quickPayPlugin showPluginInViewController:self];
        
    } else {
        UIAlertView *alertTemp = [[UIAlertView alloc] initWithTitle:@"提示" message:@"生成支付信息失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertTemp show];
    }
}


#pragma mark - ONPQuickPayPlugin Delegate

- (void) finishQuickPayPluginWithController:(ONPQuickPayPlugin *)controller Result:(NSDictionary *)result
{
    if (controller == quickPayPlugin) {
        
        NSString *merchant_id = [result objectForKey:@"merchant_id"];
        NSString *merchant_user_id = [result objectForKey:@"merchant_user_id"];
        NSString *order_id = [result objectForKey:@"order_id"];
        NSString *amount = [result objectForKey:@"amount"];
        NSString *err_code = [result objectForKey:@"err_code"];
        NSString *err_desc = [result objectForKey:@"err_desc"];
        
        NSMutableString *resultMsg = [[NSMutableString alloc] init];
        [resultMsg appendFormat:@"merchant_id=%@\n", merchant_id];
        [resultMsg appendFormat:@"merchant_user_id=%@\n", merchant_user_id];
        [resultMsg appendFormat:@"order_id=%@&\n", order_id];
        [resultMsg appendFormat:@"amount=%@\n", amount];
        [resultMsg appendFormat:@"err_code=%@\n", err_code];
        [resultMsg appendFormat:@"err_desc=%@\n", err_desc];

        int errCode = [err_code intValue];
//        NSLog(@"errCode-%d",errCode);
        if (errCode == 0) {
            if (_otherPay ==YES && _remainPay == NO) {
                [self remainAndOtherPay:@"5" ];
            }else if (_otherPay == NO && _remainPay == YES){
                [self remainAndOtherPay:@"50" ];
            }
            
        }else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"支付失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

#pragma mark - 生成商家权限验证码

- (NSString *)getIdentityCodeWithMerchantID:(NSString*)merchantID MerchantKey:(NSString *)merchantKey {
    unsigned char md5_MerchantKey[32];
    const char *chID = [merchantID UTF8String];
    const char *chKey = [merchantKey UTF8String];
    
    NSString *strIdentityCode = GetMd5withKey((void *)chKey, strlen(chKey), (void*)chID, strlen(chID), md5_MerchantKey);
    return strIdentityCode;
}

#pragma mark 模拟订单日期
- (NSString *) getOrderDate {
    NSString *strDate = [[NSDate date]description];
    NSString *strTemp = [strDate stringByReplacingOccurrencesOfString:@"-" withString:@""];
    strDate = [strTemp stringByReplacingOccurrencesOfString:@":" withString:@""];
    strTemp = [strDate stringByReplacingOccurrencesOfString:@" " withString:@""];
    strDate = [strTemp substringToIndex:14];
    return strDate;
}

#pragma  mark -支付宝

-(void)paymentResultDelegate:(NSString *)result
{
//    NSLog(@"result%@",result);
}


- (void)tijiao:(NSString *)orderID withMoney:(NSString *)money
{
    [self userDefaults];
    
//    NSLog(@"tijiaodingdan");
    Order *order = [[Order alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    order.tradeNO = orderID; //订单ID（由商家自行制定）
    order.productName = @"熊管家洗衣"; //商品标题
    order.productDescription = @"熊管家洗衣服务"; //商品描述
    order.amount = @"0.01"; //商品价格
    order.notifyURL =  @"http%3A%2F%2Fmptest.5k.com/api/AliPay/get_data_server_recharge"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"xiongmami";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
//    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        [[[[UIApplication sharedApplication] windows] objectAtIndex:0] setHidden:NO];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            NSLog(@"reslut = %@",resultDic);
            
            [[[[UIApplication sharedApplication] windows] objectAtIndex:0] setHidden:YES];
            if ([[resultDic valueForKey:@"resultStatus"] integerValue] == 9000) {
                
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                BOOL otherPay = [[userDefaults objectForKey:@"otherPay"] boolValue];
                BOOL remainPay = [[userDefaults objectForKey:@"remainPay"] boolValue];
                
                [[BoolViewController alloc] testOut];
                if (otherPay ==YES && remainPay == NO) {
                    
//                    NSLog(@"第三方支付_otherpay%d,_remainpay%d",otherPay,remainPay);
                    
                    [self remainAndOtherPay:@"4" ];
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"支付成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    
                }else if (otherPay == NO && remainPay == YES){
                    
//                    NSLog(@"1+1_otherpay%d,_remainpay%d",otherPay,remainPay);
                    [self remainAndOtherPay:@"40" ];
                    [self.leveyTabBarController setSelectedIndex:1];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"支付成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    
                }else {
//                    NSLog(@"_otherpay%d,_remainpay%d",otherPay,remainPay);
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"支付成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];         
                }
                
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"充值失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
        }];
        
    }
}

#pragma  mark - UIPickerViewDataSource,UIPickerViewDelegate
- (void)pushPickView
{
    
    if (insufficient == NO) {
         _array_pay = [NSArray arrayWithObjects:@"支付宝",@"现金",@"银联", nil];
    }if (insufficient == YES) {
        _array_pay = [NSArray arrayWithObjects:@"余额",@"支付宝",@"现金",@"银联", nil];
    }
    _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, VIEW_FRAME_SIZE_WIDTH, 216)];
    [_pickView setBackgroundColor:[UIColor whiteColor]];
    _pickView.dataSource = self;
    _pickView.delegate = self;
    
    LZWCustomActionSheet *actionSheet = [[LZWCustomActionSheet alloc] initWithView:_pickView AndHeight:260];
    actionSheet.doneDelegate = self;
    [actionSheet showInView:self.view];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
//    NSLog(@"%lu",(unsigned long)_array_pay.count);
    return _array_pay.count;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //先根据component找到大数组中对应的小数组，然后根据row从小数组中找到对应的title
//    NSLog(@"--%@",[_array_pay objectAtIndex:row]);
    return [_array_pay objectAtIndex:row];
}

- (void)done
{
    NSInteger provinceRow = [_pickView selectedRowInComponent:0];
//    NSLog(@"--%ld",(long)provinceRow);
    [_fkfsButton setTitle:[_array_pay objectAtIndex:provinceRow] forState:UIControlStateNormal];
    [_pickView reloadAllComponents];
}


@end
*/
