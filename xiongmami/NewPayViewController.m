//
//  NewPayViewController.m
//  xiongmami
//
//  Created by iMac on 15/3/23.
//  Copyright (c) 2015年 杭州熊管佳电子商务有限公司. All rights reserved.
//

#import "NewPayViewController.h"
#import "AllGiftsViewController.h"

@interface NewPayViewController ()

@end

@implementation NewPayViewController
@synthesize quickPayPlugin;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self topCustomView];
    [self mainCustomView];
    [self getAllGiftsList];
    [self getReain];
    [self ONPQuickPay];
    self.title = @"付款";
    self.view.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#f8f3f0"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(bback)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)bback
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)topCustomView
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, 65)];
    topView.backgroundColor = [UIColor whiteColor];
    topView.layer.borderColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#dee2e5"].CGColor;
    topView.layer.borderWidth = 0.5;
    [self.view addSubview:topView];
    //订单编号
    UILabel *ddxq = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 80, 15)];
    ddxq.text = @"订单编号:";
    [ddxq setFont:[UIFont systemFontOfSize:15]];
    [ddxq setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"]];
    [ddxq setTextAlignment:NSTextAlignmentLeft];
    [topView addSubview:ddxq];
    
    _Numb = [[UILabel alloc] initWithFrame:CGRectMake(85, 15, 220, 15)];
    _Numb.text = [NSString stringWithFormat:@"%@",_numbMoney];
    [_Numb setFont:[UIFont systemFontOfSize:15]];
    [_Numb setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"]];
    [_Numb setTextAlignment:NSTextAlignmentLeft];
    [topView addSubview:_Numb];
    
    //订单金额
    UILabel *ddje = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, 80, 15)];
    [ddje setText:@"订单金额:"];
    [ddje setTextAlignment:NSTextAlignmentLeft];
    [ddje setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"]];
    [ddje setFont:[UIFont systemFontOfSize:15]];
    [topView addSubview:ddje];
    
    _moneyNumb = [[UILabel alloc] initWithFrame:CGRectMake(85, 39, 220, 17)];
    _moneyNumb.text = [NSString stringWithFormat:@"%@元",_orderAmount];
    [_moneyNumb setFont:[UIFont systemFontOfSize:17]];
    [_moneyNumb setTextAlignment:NSTextAlignmentLeft];
    [_moneyNumb setTextColor:[UIColor orangeColor]];
    [topView addSubview:_moneyNumb];
}

#pragma  mark - 红包抵用-实付
- (void)mainCustomView
{
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 139, VIEW_FRAME_SIZE_WIDTH, 136/2)];
    [mainView setBackgroundColor:[UIColor whiteColor]];
    mainView.layer.borderColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#dee2e5"].CGColor;
    mainView.layer.borderWidth = 0.5;
    [self.view addSubview:mainView];
    //红包抵用
    UILabel *dyhb = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 85, 17)];
    dyhb.text = @"抵用红包:";
    [dyhb setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"]];
    [dyhb setTextAlignment:NSTextAlignmentLeft];
    [dyhb setFont:[UIFont systemFontOfSize:17]];
    [mainView addSubview:dyhb];
    
    UILabel *fgx = [[UILabel alloc] initWithFrame:CGRectMake(10, 136/4, VIEW_FRAME_SIZE_WIDTH-20, 0.5)];
    [fgx setBackgroundColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#dee2e5"]];
    [mainView addSubview:fgx];
    
    //抵用红包状态变化
    _hongbaoSL = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH - 76, 12, 45, 15)];
    [_hongbaoSL setText:@"个可用"];
    [_hongbaoSL setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"]];
    [_hongbaoSL setFont:[UIFont systemFontOfSize:13]];
    [mainView addSubview:_hongbaoSL];
    
    _hongbaoSLImage = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH-25, 10, 10, 17)];
    [_hongbaoSLImage setImage:[UIImage imageNamed:@"箭头@3x.png"]];
    [mainView addSubview:_hongbaoSLImage];
    
    _giftsLab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH - 144, 10, 68, 17)];
    [_giftsLab setText:@"5"];
    [_giftsLab setFont:[UIFont systemFontOfSize:17]];
    [_giftsLab setTextColor:[UIColor orangeColor]];
    [_giftsLab setTextAlignment:NSTextAlignmentRight];
    [mainView addSubview:_giftsLab];
    
    _giftsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_giftsBtn setFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 136/4)];
    [_giftsBtn addTarget:self action:@selector(pushGifts) forControlEvents:UIControlEventTouchUpInside];
    [_giftsBtn setBackgroundColor:[UIColor clearColor]];
    [mainView addSubview:_giftsBtn];
    
    _gifts_money = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_HEIGHT, 10, 100, 17)];
    [_gifts_money setText:@"9元"];
    [_gifts_money setFont:[UIFont systemFontOfSize:17]];
    [_gifts_money setTextColor:[UIColor orangeColor]];
    [_gifts_money setTextAlignment:NSTextAlignmentRight];
    [mainView addSubview:_gifts_money];
    
    //////////////////////////////////////
    //实付
    UILabel *sfLab  =[[UILabel alloc] initWithFrame:CGRectMake(15, 42, 85, 17)];
    [sfLab setTextAlignment:NSTextAlignmentLeft];
    [sfLab setText:@"实付:"];
    [sfLab setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"]];
    [sfLab setFont:[UIFont systemFontOfSize:17]];
    [mainView addSubview:sfLab];
    
    _sfMoney = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH-102, 43, 85, 17)];
    [_sfMoney setText:[NSString stringWithFormat:@"%@元",_orderAmount]];
    [_sfMoney setTextColor:[UIColor orangeColor]];
    [_sfMoney setFont:[UIFont systemFontOfSize:15]];
    [_sfMoney setTextAlignment:NSTextAlignmentRight];
    [mainView addSubview:_sfMoney];
    
#pragma  mark - down view
    _downView = [[UIView alloc] initWithFrame:CGRectMake(0, 217, VIEW_FRAME_SIZE_WIDTH, 180)];
    [_downView setBackgroundColor:[UIColor whiteColor]];
    _downView.layer.borderColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#dee2e5"].CGColor;
    _downView.layer.borderWidth = 0.5;
    [self.view addSubview:_downView];
    
    UILabel *xzyxfszf = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 140, 17)];
    [xzyxfszf setText:@"选择以下方式支付"];
    [xzyxfszf setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"]];
    [xzyxfszf setFont:[UIFont systemFontOfSize:17]];
    [_downView addSubview:xzyxfszf];
    
    UILabel *fgxs = [[UILabel alloc] initWithFrame:CGRectMake(10, 47, VIEW_FRAME_SIZE_WIDTH-20, 0.5)];
    fgxs.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#dee2e5"];
    [_downView addSubview:fgxs];
    
    //余额
    _ye_image = [[UIImageView alloc] initWithFrame:CGRectMake(15, 57, 17, 17)];
    [_ye_image setImage:[UIImage imageNamed:@"单选btnHover@3x.png"]];
    [_downView addSubview:_ye_image];
    
    UILabel *yeLab = [[UILabel alloc] initWithFrame:CGRectMake(37, 58, 40, 15)];
    [yeLab setText:@"余额"];
    [yeLab setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"]];
    [yeLab setFont:[UIFont systemFontOfSize:15]];
    [_downView addSubview:yeLab];
    //移动金额
    _gifts_mob = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH-65, 58, 50, 15)];
    _gifts_mob.text = [NSString stringWithFormat:@"%@元",_orderAmount];
    [_gifts_mob setTextAlignment:NSTextAlignmentRight];
    [_gifts_mob setTextColor:[UIColor orangeColor]];
    [_gifts_mob setFont:[UIFont systemFontOfSize:15]];
    [_downView addSubview:_gifts_mob];
    
    //现金
    _money_image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 89.5f, 17, 17)];
    [_money_image setImage:[UIImage imageNamed:@"单选btn@3x.png"]];
    [_downView addSubview:_money_image];
    
    UILabel *moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(37, 89.5f, 40, 15)];
    [moneyLab setText:@"现金"];
    [moneyLab setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"]];
    [moneyLab setFont:[UIFont systemFontOfSize:15]];
    [_downView addSubview:moneyLab];
    
    //支付宝
    _aLiPay_image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 122, 17, 17)];
    [_aLiPay_image setImage:[UIImage imageNamed:@"单选btn@3x.png"]];
    [_downView addSubview:_aLiPay_image];
    
    UILabel *zfbLab = [[UILabel alloc] initWithFrame:CGRectMake(37, 122, 50, 15)];
    [zfbLab setText:@"支付宝"];
    [zfbLab setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"]];
    [zfbLab setFont:[UIFont systemFontOfSize:15]];
    [_downView addSubview:zfbLab];
    
    //网银
    _19Pay_image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 154.5f, 17, 17)];
    [_19Pay_image setImage:[UIImage imageNamed:@"单选btn@3x.png"]];
    [_downView addSubview:_19Pay_image];
    
    UILabel *wyLab = [[UILabel alloc] initWithFrame:CGRectMake(37, 154.5f, 40, 15)];
    [wyLab setText:@"网银"];
    [wyLab setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"]];
    [wyLab setFont:[UIFont systemFontOfSize:15]];
    [_downView addSubview:wyLab];
    _ye_bool = YES;
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 47+(33*i), VIEW_FRAME_SIZE_HEIGHT, 33)];
        [button setTag:i+100];
        [button addTarget:self action:@selector(xzyxfszf:) forControlEvents:UIControlEventTouchUpInside];
        
        [_downView addSubview:button];
    }
    
#pragma  mark - ok btn
    
    _OK_Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_OK_Button setFrame:CGRectMake(15, 420, VIEW_FRAME_SIZE_WIDTH-30, 35)];
    [_OK_Button setBackgroundImage:[UIImage imageNamed:@"保存btn.png"] forState:UIControlStateNormal];
    [_OK_Button setTitle:@"确定" forState:UIControlStateNormal];
    [_OK_Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_OK_Button addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
    
    if (iPhone6) {
        [_OK_Button setFrame:CGRectMake(15, 420, VIEW_FRAME_SIZE_WIDTH-30, 40)];
    }
    
    
    [self.view addSubview:_OK_Button];
}

#pragma  mark - push
- (void)pushGifts
{
    AllGiftsViewController *allGifts = [[AllGiftsViewController alloc] initWithBlock:^(NSMutableDictionary * dic){
        
        NSString *ary = [dic valueForKey:@"amountNumber"];
//        NSLog(@"-allgifts-\n%@",dic);
        [_gifts_money setText:[NSString stringWithFormat:@"%@元",ary]];
        _gifts_Array = [dic valueForKey:@"card_id"];
//        NSLog(@"sadgfsdaf-\n%@",_gifts_Array);
        
        if ([ary integerValue] == 0 || [_gifts_Array count] == 0) {
            [self getAllGiftsList];
            _gifts_money.text = @"";
            
            _sfMoney.text = [NSString stringWithFormat:@"%@元",_orderAmount];
            _gifts_mob.text = [NSString stringWithFormat:@"%@元",_orderAmount];
            [self downView:2];
            
//            NSLog(@"1");
        }else if ([_gifts_money.text integerValue] == 0) {
            [self giftsWithState:0];
            [self getReain];
//            NSLog(@"2");
        }else{
            [self giftsWithState:1];
            [self getReain];
            
            if ((([_moneyNumb.text integerValue]-[ary integerValue])<=0)) {
                _sfMoney.text = @"0元";
                _gifts_mob.text = @"";
                [self downView:1];
            }else{
//                NSLog(@"3");
                _sfMoney.text = [NSString stringWithFormat:@"%ld元",(long)([_moneyNumb.text integerValue]-[ary integerValue])];
                _gifts_mob.text = [NSString stringWithFormat:@"%ld元",(long)([_moneyNumb.text integerValue]-[ary integerValue])];
                [self downView:2];
            }
        }
    }];
    [self.navigationController pushViewController:allGifts animated:YES];
}

- (void)downView:(NSInteger)i
{
    if (i == 1) {
        [_downView setFrame:CGRectMake(10000, 217, VIEW_FRAME_SIZE_WIDTH, 180)];
        [_OK_Button setFrame:CGRectMake(15, 230, 290, 35)];
    }else{
        [_downView setFrame:CGRectMake(0, 217, VIEW_FRAME_SIZE_WIDTH, 180)];
        [_OK_Button setFrame:CGRectMake(15, 420, 290, 35)];
    }

}

- (void)tijiao
{
//    NSLog(@"OK");
//
//    [self giftsWithState:2];
//    [self downView:2];
    if ([_sfMoney.text integerValue] > 0 && _ye_bool == YES) {
        //余额
        if ([_outMoney integerValue]<[_sfMoney.text integerValue]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"余额不足" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [alert show];
        }else{
            NSString *ste = [NSString stringWithFormat:@"确认余额支付%@？",_sfMoney.text];
            _outMoney_Alert = [[UIAlertView alloc] initWithTitle:@"提示" message:ste delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [_outMoney_Alert show];
        }
        
    }else if ([_sfMoney.text integerValue] > 0 && _money_bool == YES){
        //现金
        NSString *ste = [NSString stringWithFormat:@"确认现金支付%@？",_sfMoney.text];
        _money_Alert = [[UIAlertView alloc] initWithTitle:@"提示" message:ste delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [_money_Alert show];
    }else if ([_sfMoney.text integerValue] > 0 && _aLiPay_bool == YES){
//        支付宝
        NSString *ste = [NSString stringWithFormat:@"确认支付宝支付%@？",_sfMoney.text];
        _aliMoney_Alert = [[UIAlertView alloc] initWithTitle:@"提示" message:ste delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [_aliMoney_Alert show];
    }else if ([_sfMoney.text integerValue] > 0 && _19pay_bool == YES){
//        网银
        NSString *ste = [NSString stringWithFormat:@"确认网银支付%@？",_sfMoney.text];
        _payMoney_Alert = [[UIAlertView alloc] initWithTitle:@"提示" message:ste delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [_payMoney_Alert show];
    }else{
//        红包
        NSString *ste = [NSString stringWithFormat:@"确认红包支付%@？",_sfMoney.text];
        _giftsMoney_Alert = [[UIAlertView alloc] initWithTitle:@"提示" message:ste delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [_giftsMoney_Alert show];
    }
}
- (void)xzyxfszf:(UIButton *)sender
{
//    NSLog(@"-%ld-",(long)sender.tag);
    
    switch (sender.tag) {
        case 100:
        {
            //余额
            [_ye_image setImage:[UIImage imageNamed:@"单选btnHover@3x.png"]];
            [_money_image setImage:[UIImage imageNamed:@"单选btn@3x.png"]];
            [_aLiPay_image setImage:[UIImage imageNamed:@"单选btn@3x.png"]];
            [_19Pay_image setImage:[UIImage imageNamed:@"单选btn@3x.png"]];
            [_gifts_mob setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH-65, 58, 50, 15)];
            _ye_bool = YES;
            _money_bool = NO;
            _aLiPay_bool = NO;
            _19pay_bool = NO;
            
        }
            break;
        case 101:
        {
            //现金
            [_ye_image setImage:[UIImage imageNamed:@"单选btn@3x.png"]];
            [_money_image setImage:[UIImage imageNamed:@"单选btnHover@3x.png"]];
            [_aLiPay_image setImage:[UIImage imageNamed:@"单选btn@3x.png"]];
            [_19Pay_image setImage:[UIImage imageNamed:@"单选btn@3x.png"]];
            [_gifts_mob setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH-65, 89.5f, 50, 15)];
            _ye_bool = NO;
            _money_bool = YES;
            _aLiPay_bool = NO;
            _19pay_bool = NO;
        }
            break;
        case 102:
        {
            //支付宝
            [_ye_image setImage:[UIImage imageNamed:@"单选btn@3x.png"]];
            [_money_image setImage:[UIImage imageNamed:@"单选btn@3x.png"]];
            [_aLiPay_image setImage:[UIImage imageNamed:@"单选btnHover@3x.png"]];
            [_19Pay_image setImage:[UIImage imageNamed:@"单选btn@3x.png"]];
            [_gifts_mob setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH-65, 122, 50, 15)];
            _ye_bool = NO;
            _money_bool = NO;
            _aLiPay_bool = YES;
            _19pay_bool = NO;
        }
            break;
        case 103:
        {
            //网银
            [_ye_image setImage:[UIImage imageNamed:@"单选btn@3x.png"]];
            [_money_image setImage:[UIImage imageNamed:@"单选btn@3x.png"]];
            [_aLiPay_image setImage:[UIImage imageNamed:@"单选btn@3x.png"]];
            [_19Pay_image setImage:[UIImage imageNamed:@"单选btnHover@3x.png"]];
            [_gifts_mob setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH-65, 154.5f, 50, 15)];
            _ye_bool = NO;
            _money_bool = NO;
            _aLiPay_bool = NO;
            _19pay_bool = YES;
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark - 获取红包数量
- (void)getAllGiftsList
{
    [[BoolViewController alloc] testOut];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:USER_ID(QQQQ) forKey:@"user_id"];
    [dic setValue:USER_TOKEN(QQQQ) forKey:@"skey"];
//    NSLog(@"--duc-%@",dic);
    
    [PerAFNetBlockRequest AFNRequest:@"/index.php?s=/Api/User/getcardcount" dic:dic AFNBlock:^(NSDictionary *resp, NSStringEncoding encoding){
//        NSLog(@"resp-%@",resp);
        [self getUserInformation:resp];
        
    }AFNEror:^(NSError *error){
        NSLog(@"ERRPR--%@",error);
    }];
}

- (void)getUserInformation:(NSDictionary *)resp
{
    _giftsLab.text = [NSString stringWithFormat:@"%@",[resp valueForKey:@"data"]];
    if ([_giftsLab.text integerValue] == 0) {
        [self giftsWithState:2];
    }else if ([_orderAmount integerValue] == 0){
        [self giftsWithState:1];
    }else{
        [self giftsWithState:0];
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

#pragma  mark - 红包状态

- (void)giftsWithState:(NSInteger)numb
{
    if (numb == 0) {
        //有红包
        //抵用红包状态变化
        _hongbaoSL.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH - 76, 12, 45, 15);
        _hongbaoSLImage.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH-25, 10, 10, 17);
        _giftsLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH - 144, 10, 68, 17);
        [_giftsBtn setFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 136/4)];
        [_gifts_money setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH, 10, 100, 17)];
    }else if (numb ==1){
        //显示选择红包金额
        _hongbaoSL.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH, 12, 45, 15);
        _hongbaoSLImage.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH, 10, 10, 17);
        _giftsLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH, 10, 68, 17);
        [_giftsBtn setFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 136/4)];
        [_gifts_money setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH - 115, 10, 100, 17)];
    }else if (numb == 2){
        //无可用红包
        //抵用红包状态变化
        _hongbaoSL.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH - 85, 12, 75, 15);
        [_hongbaoSL setText:@"无可用红包"];
        _hongbaoSLImage.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH, 10, 10, 17);
        _giftsLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH, 10, 68, 17);
        [_giftsBtn setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH, 0, VIEW_FRAME_SIZE_WIDTH, 136/4)];
        [_gifts_money setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH, 10, 100, 17)];
    }
}

#pragma  mark - 获取余额
- (void)getReain
{
    [[BoolViewController alloc] testOut];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:USER_ID(QQQQ) forKey:@"user_id"];
    [dic setValue:USER_TOKEN(QQQQ) forKey:@"skey"];
//    NSLog(@"--remainduc-%@",dic);
    
    [PerAFNetBlockRequest AFNRequest:@"/index.php?s=/api/Pay/get_remain" dic:dic AFNBlock:^(NSDictionary *resp, NSStringEncoding encoding){
//        NSLog(@"remainresp-%@",resp);
        [self getReainWithResp:resp];
        
    }AFNEror:^(NSError *error){
//        NSLog(@"remainERRPR--%@",error);
    }];
}
- (void)getReainWithResp:(NSDictionary *)resp
{
    _outMoney = [NSString stringWithFormat:@"%@",[[resp valueForKey:@"data"] valueForKey:@"remain"]];
//    NSLog(@"余额-%@",_outMoney);
}

#pragma  mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _outMoney_Alert) {
        if (buttonIndex ==0) {
            //余额
//            NSLog(@"余额");
            [self remainAndMoney:@"2"];
        }
    }else if (alertView == _money_Alert){
        if (buttonIndex ==0) {
//            现金
//            NSLog(@"现金");
            [self remainAndMoney:@"1"];
        }
    }else if (alertView == _payMoney_Alert){
        if (buttonIndex ==0) {
//            网银
//            NSLog(@"网银");
//            [self remainAndMoney:@"5"];
            NSString * ssstr =[_sfMoney.text stringByReplacingOccurrencesOfString:@"元" withString:@""];
            [self payWithOrderID:_numbMoney withMoney:ssstr];
        }
    }else if (alertView == _aliMoney_Alert){
        if (buttonIndex ==0) {
//            支付宝
//            NSLog(@"支付宝");
//            [self remainAndMoney:@"4"];
            NSString * ssstr =[_sfMoney.text stringByReplacingOccurrencesOfString:@"元" withString:@""];
            [self tijiao:_numbMoney withMoney:ssstr];
        }
    }else if (alertView == _giftsMoney_Alert){
        if (buttonIndex ==0) {
            //红包
//            NSLog(@"红包");
            [self remainAndMoney:@"6"];
        }
    }else if (alertView == _back_Alert){
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma  mark - 支付

- (void)remainAndMoney:(NSString *)pay_type
{
    NSMutableDictionary *diccctt = [[NSMutableDictionary alloc] init];
    [diccctt setValue:USER_ID(QQQQ) forKey:@"user_id"];
    [diccctt setValue:_numbMoney forKey:@"order_id"];
    [diccctt setValue:pay_type forKey:@"pay_type"];
    [diccctt setValue:_gifts_Array forKey:@"card_id"];
//    NSLog(@"asdbsfakgb---\n%@",diccctt);
    [[BoolViewController alloc] testOut];
    [PerAFNetBlockRequest AFNRequest:@"/index.php?s=/api/Pay/pay_money" dic:diccctt AFNBlock:^(NSDictionary *resp, NSStringEncoding encoding){
//        NSLog(@"pay_moneyresp-%@",resp);
        [self remainWithOkAndNo:resp];
        
    }AFNEror:^(NSError *error){
//        NSLog(@"pay_moneyERRPR--%@",error);
        UIAlertView *alertTemp = [[UIAlertView alloc] initWithTitle:@"提示" message:@"支付失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertTemp show];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
- (void)remainWithOkAndNo:(NSDictionary *)dic
{
    NSInteger status = [[dic valueForKey:@"status"] integerValue];
    if (status == 0) {
        _back_Alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"支付成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [_back_Alert show];
    }else{
        _back_Alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"支付失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [_back_Alert show];
    }
}
#pragma  mark - 网银支付
#pragma  mark - 充值请求
- (void)payWithOrderID:(NSString *)orderid withMoney:(NSString *)money
{
    //orderid订单编号
    //money充值金额
    float floatMoney = [money floatValue];
    NSString *money_flot = [NSString stringWithFormat:@"%.2f",floatMoney];
    // 模拟支付订单
    NSString *strOrderDate = [self getOrderDate];//订单日期
    NSString *strOrderID = [NSString stringWithFormat:@"%@", orderid];
    PayPlugin *entity = [[PayPlugin alloc] initWithUserID:[NSString stringWithFormat:@"%@",USER_ID(QQQQ)] ShopName:@"熊管家" ProductName:@"熊管家洗衣" ProductDesc:@"熊管家洗衣服务" Amount:money_flot];
    
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
            [self remainAndMoney:@"5"];
        }else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"支付失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}
#pragma  mark - 19支付配置
- (void)ONPQuickPay
{
    _strMerchantID = @"175093";
    _strMerchantName = @"熊管家";
    _strMerchantKey = @"i8mz5bwvw0buw5xxgbw2szzgwilafxv1hf6eep7yyn52ixtcgxrrz803504cegg9jwemktgnw5a8j03xois7t9da8nkmyoshzi0b4bmdpdzwqe31125qzd9wty3hhim5";
    //测试环境
//    _strNotifyUrl = @"http://mptest.xiongguanjia.cn/api/OneNinePay/get_data_server";
    //线上环境
    _strNotifyUrl = @"http://mp.5k.com/api/OneNinePay/get_data_server";
    
    //生成商家权限验证码
    _strIdentityCode = [self getIdentityCodeWithMerchantID:_strMerchantID MerchantKey:_strMerchantKey];
    
    quickPayPlugin = [[ONPQuickPayPlugin alloc] init];
    quickPayPlugin.delegate = self;
}
#pragma mark - 生成商家权限验证码

- (NSString *)getIdentityCodeWithMerchantID:(NSString*)merchantID MerchantKey:(NSString *)merchantKey {
    unsigned char md5_MerchantKey[32];
    const char *chID = [merchantID UTF8String];
    const char *chKey = [merchantKey UTF8String];
    
    NSString *strIdentityCode = GetMd5withKey((void *)chKey, (int)strlen(chKey), (void*)chID, (int)strlen(chID), md5_MerchantKey);
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
#pragma  mark - 支付宝支付
-(void)paymentResultDelegate:(NSString *)result
{
//    NSLog(@"result%@",result);
}

- (void)tijiao:(NSString *)orderID withMoney:(NSString *)money
{
//    [self userDefaults];
    
//    NSLog(@"tijiaodingdan");
    Order *order = [[Order alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    order.tradeNO = orderID; //订单ID（由商家自行制定）
    order.productName = @"熊管家洗衣"; //商品标题
    order.productDescription = @"熊管家洗衣服务"; //商品描述
    order.amount = money; //商品价格
    //测试环境
//    order.notifyURL =  @"http%3A%2F%2Fmptest.xiongguanjia.cn/api/AliPay/get_data_server_new"; //回调URL
    //线上环境
    order.notifyURL =  @"http%3A%2F%2Fmp.5k.com/api/AliPay/get_data_server_new"; //回调URL
    
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
            [self.leveyTabBarController hidesTabBar:YES animated:NO];
            if ([[resultDic valueForKey:@"resultStatus"] integerValue] == 9000) {
//                NSLog(@"支付宝支付回调");
                [self remainAndMoney:@"4"];
                [self.leveyTabBarController hidesTabBar:YES animated:NO];
                [[[[UIApplication sharedApplication] windows] objectAtIndex:0] setHidden:YES];
            }else{
//                NSLog(@"支付失败asd");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"支付失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                [self.leveyTabBarController hidesTabBar:YES animated:NO];
                [[[[UIApplication sharedApplication] windows] objectAtIndex:0] setHidden:YES];
            }
        }];
    }
}
@end
