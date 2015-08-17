//
//  TopUp.m
//  xiongmami
//
//  Created by iMac on 14/11/20.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "TopUp.h"
#import "HexadecimalConversionUICOLOR.h"

@implementation TopUp
@synthesize quickPayPlugin;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"充值";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addDiSanFangZhiFu];
    [self money];
    [self showLine];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];
    
    UILabel *navLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 64)];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    navLab.backgroundColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];
    navLab.text = @"\n充值";
    [navLab setNumberOfLines:0];
    navLab.textAlignment = NSTextAlignmentCenter;
    navLab.font = [UIFont systemFontOfSize:20];
    navLab.textColor = [UIColor whiteColor];
    [self.view addSubview:navLab];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(5, 20, 44, 44);
    [back setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [back.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    PAY = YES;
    
    /////////////////////////////////
    _strMerchantID = @"175093";
    _strMerchantName = @"熊管家";
    _strMerchantKey = @"i8mz5bwvw0buw5xxgbw2szzgwilafxv1hf6eep7yyn52ixtcgxrrz803504cegg9jwemktgnw5a8j03xois7t9da8nkmyoshzi0b4bmdpdzwqe31125qzd9wty3hhim5";
    //测试环境
//    _strNotifyUrl = @"http://mptest.xiongguanjia.cn/api/OneNinePay/get_data_server_recharge";
    //线上环境
    _strNotifyUrl = @"http://mp.5k.com/api/OneNinePay/get_data_server_recharge";
    
    //生成商家权限验证码
    _strIdentityCode = [self getIdentityCodeWithMerchantID:_strMerchantID MerchantKey:_strMerchantKey];
    
    quickPayPlugin = [[ONPQuickPayPlugin alloc] init];
    quickPayPlugin.delegate = self;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(bback)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    
//    _result = @selector(paymentResult:);
}
- (void)bback
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma  mark - 第三方支付
- (void)addDiSanFangZhiFu
{
    _wxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _wxButton.frame = CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH/2, 40);
    [_wxButton setTitle:@"银联支付" forState:UIControlStateNormal];
    [_wxButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_wxButton addTarget:self action:@selector(weiXinZhiFu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_wxButton];
    
    _zfbButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _zfbButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/2, 64, VIEW_FRAME_SIZE_WIDTH/2, 40);
    [_zfbButton setTitle:@"支付宝支付" forState:UIControlStateNormal];
    [_zfbButton setTitleColor:[UIColor colorWithRed:190/255.0f green:190/255.0f blue:190/255.0f alpha:1] forState:UIControlStateNormal];
    [_zfbButton addTarget:self action:@selector(zhiFuBaoZhiFu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_zfbButton];
    if (iPhone6Plus) {
        _wxButton.frame = CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH/2, 55);
        _zfbButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/2, 64, VIEW_FRAME_SIZE_WIDTH/2, 55);
    }
}
- (void)weiXinZhiFu
{
//    NSLog(@"19Pay银联支付");
    CGRect frame = _imageView.frame;
    frame.origin.x = 0;
    _imageView.frame = frame;
    [_wxButton.titleLabel setTextColor:[UIColor blackColor]];
    [_zfbButton.titleLabel setTextColor:[UIColor colorWithRed:190/255.0f green:190/255.0f blue:190/255.0f alpha:1]];
    PAY = YES;
}

- (void)showLine
{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 104, VIEW_FRAME_SIZE_WIDTH/2, 1)];
    _imageView.image = [UIImage imageNamed:@"line.jpg"];
    [self.view addSubview:_imageView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 104, VIEW_FRAME_SIZE_WIDTH, 0.5f)];
    lab.backgroundColor = [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1];
    [self.view addSubview:lab];
    if (iPhone6Plus) {
        _imageView.frame = CGRectMake(0, 119, VIEW_FRAME_SIZE_WIDTH/2, 1);
        lab.frame = CGRectMake(0, 119, VIEW_FRAME_SIZE_WIDTH, 0.5f);
    }
}

- (void)zhiFuBaoZhiFu
{
//    NSLog(@"支付宝支付");
    CGRect frame = _imageView.frame;
    frame.origin.x = _imageView.frame.size.width;
    _imageView.frame = frame;
    [_wxButton.titleLabel setTextColor:[UIColor colorWithRed:190/255.0f green:190/255.0f blue:190/255.0f alpha:1]];
    [_zfbButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    PAY = NO;
}

#pragma  mark -  金额按钮
- (void)money
{
//    NSLog(@"金额");
    _moneyView = [[UIView alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 120, VIEW_FRAME_SIZE_WIDTH*0.9, VIEW_FRAME_SIZE_HEIGHT/2)];
    [self.view addSubview:_moneyView];
    NSArray *array = [[NSArray alloc] initWithObjects:@"10元",@"20元",@"50元",@"100元",@"300元",@"500元", nil];
    
    for (int i = 0; i < 6; i++) {
        NSInteger index = i % 3;
        NSInteger page = i / 3;
        UIButton *moneyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        moneyButton.frame = CGRectMake(index *(_moneyView.frame.size.height/3)+10, page *50+10, _moneyView.frame.size.width/4, 30);
        if (iPhone6Plus) {
            moneyButton.frame = CGRectMake(index *(_moneyView.frame.size.height/3)+10, page *50+10, _moneyView.frame.size.width/4, 40);
        }
        moneyButton.tag = i +1;
        [moneyButton setTitleColor:[UIColor colorWithRed:117/255.0f green:117/255.0f blue:117/255.0f alpha:1]
                          forState:UIControlStateNormal];
        [moneyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [moneyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [moneyButton setTitle:[NSString stringWithFormat:@"%@",[array objectAtIndex:i]] forState:UIControlStateNormal];
        [moneyButton setBackgroundImage:[UIImage imageNamed:@"xzk@3x.png"] forState:UIControlStateNormal];
        [moneyButton setBackgroundImage:[UIImage imageNamed:@"xzkHover@3x.png"] forState:UIControlStateHighlighted];
        [moneyButton setBackgroundImage:[UIImage imageNamed:@"xzkHover@3x.png"] forState:UIControlStateSelected];
//        [moneyButton setImage:[UIImage imageNamed:@"xzk.png"] forState:UIControlStateNormal];
//        [moneyButton setImage:[UIImage imageNamed:@"xzkHover.png"] forState:UIControlStateHighlighted];
//        [moneyButton setImage:[UIImage imageNamed:@"xzkHover.png"] forState:UIControlStateSelected];
        
        [moneyButton addTarget:self action:@selector(moneyOne:) forControlEvents:UIControlEventTouchUpInside];

        if (moneyButton.tag ==3) {
            _moneyBtn = moneyButton;
            
            [_moneyBtn setSelected:YES];
        }
        [_moneyView addSubview:moneyButton];
    }
//    for (int i = 0; i < 3; i++) {
//        
//        UIButton *moneyButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        moneyButton.frame = CGRectMake(10+i*(moneyView.frame.size.height/3), 70, moneyView.frame.size.width/4, 30);
//        moneyButton.tag = i +4;
//        [moneyButton setTitleColor:[UIColor colorWithRed:117/255.0f green:117/255.0f blue:117/255.0f alpha:1] forState:UIControlStateNormal];
//        [moneyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//        [moneyButton setTitle:[NSString stringWithFormat:@"%@",[array objectAtIndex:i+3]] forState:UIControlStateNormal];
//        [moneyButton setBackgroundImage:[UIImage imageNamed:@"xzk.png"] forState:UIControlStateNormal];
//        [moneyButton setBackgroundImage:[UIImage imageNamed:@"xzkHover.png"] forState:UIControlStateHighlighted];
//        [moneyButton setBackgroundImage:[UIImage imageNamed:@"xzkHover.png"] forState:UIControlStateSelected];
//        [moneyButton addTarget:self action:@selector(moneyOne:) forControlEvents:UIControlEventTouchUpInside];
//        [moneyView addSubview:moneyButton];
//    }
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(_moneyView.frame.size.width/20, 120, _moneyView.frame.size.width*0.9, 0.5)];
    lab.backgroundColor = [UIColor colorWithRed:236/255.0f green:240/255.0f blue:243/255.0f alpha:1];
    [_moneyView addSubview:lab];
    
    UILabel *moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(_moneyView.frame.size.width/20 -10, 130, _moneyView.frame.size.width/3+10, 40)];
    [moneyLab setText:@"充值金额(元):"];
    [moneyLab setFont:[UIFont systemFontOfSize:17]];
    [moneyLab setTextColor:[UIColor blackColor]];
    [_moneyView addSubview:moneyLab];
    
    _moeyTextFiel = [[UITextField alloc] initWithFrame:CGRectMake(_moneyView.frame.size.width/3+20, 130, _moneyView.frame.size.width/3*2-20, 40)];
    [_moeyTextFiel setTextColor:[UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:1]];
    [_moeyTextFiel setFont:[UIFont systemFontOfSize:25]];
    _moeyTextFiel.text = @"50元";
    _moeyTextFiel.delegate = self;
    _moeyTextFiel.keyboardType = UIKeyboardTypePhonePad;
    [_moneyView addSubview:_moeyTextFiel];
    
    UIButton *moneyButtonPay = [UIButton buttonWithType:UIButtonTypeCustom];
    moneyButtonPay.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/40, 180, _moneyView.frame.size.width*0.95, 40);
    [moneyButtonPay setTitle:@"确定" forState:UIControlStateNormal];
    [moneyButtonPay.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [moneyButtonPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [moneyButtonPay setBackgroundImage:[UIImage imageNamed:@"保存btn.png"] forState:UIControlStateNormal];
    [moneyButtonPay.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [moneyButtonPay addTarget:self action:@selector(moneyPay) forControlEvents:UIControlEventTouchUpInside];
    [_moneyView addSubview:moneyButtonPay];
    
    
    if (iPhone6Plus) {
        _moneyView.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 135, VIEW_FRAME_SIZE_WIDTH*0.9, VIEW_FRAME_SIZE_HEIGHT/2);
        lab.frame = CGRectMake(_moneyView.frame.size.width/20, 120, _moneyView.frame.size.width*0.9, 0.5);
        moneyButtonPay.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/40, 180, _moneyView.frame.size.width * 0.95, 154/3);
    }
}

- (void)moneyOne:(UIButton *)sender
{
    if (_moneyBtn == nil){
        _moneyBtn.selected = YES;
        _moneyBtn = sender;
//        NSLog(@"第一次点");
    }
    else if (_moneyBtn !=nil && _moneyBtn == sender){
        sender.selected = YES;
//        NSLog(@"重复点");
    }
    else if (_moneyBtn != sender && _moneyBtn!=nil){
        _moneyBtn.selected = NO;
        sender.selected = YES;
        _moneyBtn = sender;
//        NSLog(@"非重复点");
    }
    switch (sender.tag) {
        case 1:
        {
            sender.selected = YES;
            _moeyTextFiel.text = @"10元";
        }
            break;
        case 2:
        {
            sender.selected = YES;
            _moeyTextFiel.text = @"20元";
        }
            break;
        case 3:
        {
            sender.selected = YES;
            _moeyTextFiel.text = @"50元";
        }
            break;
        case 4:
        {
            sender.selected = YES;
            _moeyTextFiel.text = @"100元";
        }
            break;
        case 5:
        {
            sender.selected = YES;
            _moeyTextFiel.text = @"300元";
        }
            break;
        case 6:
        {
            sender.selected = YES;
            _moeyTextFiel.text = @"500元";
        }
            break;
        default:
            break;
    }
}

#pragma  mark - UITextFiel&UITextViewdDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [_moeyTextFiel resignFirstResponder];
        
        return NO;
    }
    
    NSCharacterSet *cs;
    if(textField == _moeyTextFiel)
    {
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        
        if(!basicTest)
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请输入数字"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            
            [alert show];
            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _moeyTextFiel) {
        _moeyTextFiel.text = @"";
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_moeyTextFiel resignFirstResponder];
}
#pragma  mark - 确认付款
- (void)moneyPay
{
    
    if (_moeyTextFiel.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请正确输入金额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{
        if (PAY == YES) {
//            NSLog(@"19银联支付");
            NSString *str =[NSString stringWithFormat:@"%@",_moeyTextFiel.text];
            
            _unionpayAlert = [[UIAlertView alloc] initWithTitle:@"充值" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [_unionpayAlert show];
            
        }else if (PAY == NO)
        {
//            NSLog(@"支付宝");
            NSString *str =[NSString stringWithFormat:@"%@",_moeyTextFiel.text];
            
            _zhifubaoAlert = [[UIAlertView alloc] initWithTitle:@"充值" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [_zhifubaoAlert show];
        }
    }
    
    
}

#pragma  mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _unionpayAlert) {
        if (buttonIndex == 0) {
            [self unionpayWith:[NSString stringWithFormat:@"%@",_moeyTextFiel.text]];
        }
    }
    if (alertView == _zhifubaoAlert) {
        if (buttonIndex == 0) {
            [self zhifubaozhifu:[NSString stringWithFormat:@"%@",_moeyTextFiel.text]];
        }
    }
}
//支付宝
- (void)zhifubaozhifu:(NSString *)money
{
    NSString * ssstr =[money stringByReplacingOccurrencesOfString:@"元" withString:@""];
    
    NSMutableDictionary *diccct = [[NSMutableDictionary alloc] init];
    [diccct setValue:USER_ID(QQQQ) forKey:@"user_id"];
    [diccct setValue:money forKey:@"money"];
    [diccct setValue:@"4" forKey:@"pay_type"];
    
    NSDictionary *dic = [PersonalRequest withAllUrll:@"/index.php?s=/api/Recharge/add_order" WithDic:diccct];
    
    int status = [[dic valueForKey:@"status"] intValue];
    
    if (status == 0) {
//        NSLog(@"获取订单编号%@",[dic valueForKey:@"data"]);
        
        NSString *str = [[dic valueForKey:@"data"] valueForKey:@"orderno"];
//        NSLog(@"d8hgahsdhu--%@",str);
        [self tijiao:str withMoney:ssstr];
    }else if (status == 1){
        YBMB([dic valueForKey:@"data"])
    }
}

//19pay
- (void)unionpayWith:(NSString *)money
{
    NSString * ssstr =[money stringByReplacingOccurrencesOfString:@"元" withString:@""];
    
    NSMutableDictionary *diccct = [[NSMutableDictionary alloc] init];
    [diccct setValue:USER_ID(QQQQ) forKey:@"user_id"];
    [diccct setValue:money forKey:@"money"];
    [diccct setValue:@"5" forKey:@"pay_type"];
    
    NSDictionary *dic = [PersonalRequest withAllUrll:@"/index.php?s=/api/Recharge/add_order" WithDic:diccct];
    
    int status = [[dic valueForKey:@"status"] intValue];
    
    if (status == 0) {
//        NSLog(@"获取订单编号%@",[dic valueForKey:@"data"]);
        
        NSString *str = [[dic valueForKey:@"data"] valueForKey:@"orderno"];
//        NSLog(@"d8hgahsdhu--%@",str);
        
        [self payWithOrderID:str withMoney:ssstr];
        
    }else if (status == 1){
        YBMB([dic valueForKey:@"data"])
    }
}

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
    PayPlugin *entity = [[PayPlugin alloc] initWithUserID:[NSString stringWithFormat:@"uid%@",USER_ID(QQQQ)] ShopName:@"熊管家" ProductName:@"熊管家充值" ProductDesc:@"熊管家网银充值余额" Amount:money_flot];
//    NSLog(@"uid-%@ shopname-%@ productName-%@ productDesc-%@ amount-%@ strorder-%@",entity.strUserID,entity.strShopName,entity.strProductName,entity.strProductDesc,entity.strAmount,strOrderID);
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"支付成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
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
//    NSLog(@"stridentitycode");
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

#pragma  makr - 支付宝

-(void)paymentResultDelegate:(NSString *)result
{
//    NSLog(@"result%@",result);
}

- (void)tijiao:(NSString *)orderID withMoney:(NSString *)money
{
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
//    NSLog(@"tijiaodingdan");
    Order *order = [[Order alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    order.tradeNO = orderID; //订单ID（由商家自行制定）
    order.productName = @"熊管家充值"; //商品标题
    order.productDescription = @"熊管家余额充值"; //商品描述
    order.amount = money; //商品价格
    //测试环境
//    order.notifyURL =  @"http://mptest.xiongguanjia.cn/api/AliPay/get_data_server_recharge_new"; //回调URL
    //线上环境
    order.notifyURL =  @"http%3A%2F%2Fmp.5k.com/api/AliPay/get_data_server_recharge_new"; //回调URL
    
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
//        [[[UIApplication shareApplication] windows] index:0];
        [[[[UIApplication sharedApplication] windows] objectAtIndex:0] setHidden:NO];
        
//        NSLog(@"uiapp--%@",[[[UIApplication sharedApplication] windows] objectAtIndex:0]);
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            NSLog(@"reslut = %@",resultDic);
            [[[[UIApplication sharedApplication] windows] objectAtIndex:0] setHidden:YES];
            if ([[resultDic valueForKey:@"resultStatus"] integerValue] == 9000) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"充值成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"充值失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
        }];
    }
}
@end
