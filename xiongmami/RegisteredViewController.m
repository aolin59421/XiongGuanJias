//
//  RegisteredViewController.m
//  xiongmami
//
//  Created by iMac on 14/11/18.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "Interface.h"
#import "RegisteredViewController.h"
#import "HexadecimalConversionUICOLOR.h"
#import "ForgetPassWordViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Interface.h"
#import "RegisteredViewController.h"
#import "HexadecimalConversionUICOLOR.h"
#import "LeveyTabBarController.h"
#import "VerificationViewController.h"
#import "ViewController.h"
#import "XMMCustomSegmentedButton.h"
#import "XMMMainTabBarViewController.h"
#import "TermsOfServiceViewController.h"


@interface RegisteredViewController ()<UITextFieldDelegate,UIAlertViewDelegate>

{
    UITextField *_phoneTextField;//手机号码
    UITextField *_phoneKeyTextField;//短信验证码
    UITextField *_phonePassWordTextField;//密码
    UIAlertView *_tijiaoAlert;
    MBProgressHUD *HUD;
    
    UIScrollView *textLabScr;//服务条款
}
@end

@implementation RegisteredViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addRegistered];
    self.title = @"手机注册";
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0f green:239/255.0f blue:235/255.0f alpha:1];
    UILabel *navLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 64)];
    navLab.backgroundColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];
    navLab.text = @"\n手机注册";
    [navLab setNumberOfLines:0];
    navLab.textAlignment = NSTextAlignmentCenter;
    navLab.font = [UIFont systemFontOfSize:20];
    navLab.textColor = [UIColor whiteColor];
    [self.view addSubview:navLab]; 
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(5, 20, 44, 44);
    [back setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [back.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
    [self textLabScroll];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addRegistered
{
    //手机号
     _phoneTextField= [[UITextField alloc] initWithFrame:CGRectMake((VIEW_FRAME_SIZE_WIDTH -VIEW_FRAME_SIZE_WIDTH*0.9)/2, 90, VIEW_FRAME_SIZE_WIDTH*0.9, 40)];
    [_phoneTextField setPlaceholder:@"请输入有效手机号码"];
    [_phoneTextField setTextColor:[UIColor blackColor]];
    [_phoneTextField setBackground:[UIImage imageNamed:@"验证码btn.png"]];
    _phoneTextField.delegate = self;
//    [_phoneTextField setTextAlignment:NSTextAlignmentCenter];
    _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    _phoneTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_phoneTextField];
    
    //短信验证码
    _phoneKeyTextField= [[UITextField alloc] initWithFrame:CGRectMake((VIEW_FRAME_SIZE_WIDTH -VIEW_FRAME_SIZE_WIDTH*0.9)/2, 140, VIEW_FRAME_SIZE_WIDTH*0.9/5*3-10, 40)];
    [_phoneKeyTextField setPlaceholder:@"请输入短信验证码"];
    [_phoneKeyTextField setBackground:[UIImage imageNamed:@"验证码btn.png"]];
    [_phoneKeyTextField setTextColor:[UIColor blackColor]];
//    [_phoneKeyTextField setTextAlignment:NSTextAlignmentCenter];
    _phoneKeyTextField.delegate = self;
    _phoneKeyTextField.keyboardType = UIKeyboardTypePhonePad;
    _phoneKeyTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_phoneKeyTextField];
    
    //密码
    _phonePassWordTextField= [[UITextField alloc] initWithFrame:CGRectMake((VIEW_FRAME_SIZE_WIDTH -VIEW_FRAME_SIZE_WIDTH*0.9)/2, 190, VIEW_FRAME_SIZE_WIDTH*0.9, 40)];
    [_phonePassWordTextField setPlaceholder:@"请输入密码"];
    [_phonePassWordTextField setBackground:[UIImage imageNamed:@"验证码btn.png"]];
    [_phonePassWordTextField setTextColor:[UIColor blackColor]];
    _phonePassWordTextField.delegate = self;
//    [_phonePassWordTextField setTextAlignment:NSTextAlignmentCenter];
    [_phonePassWordTextField setSecureTextEntry:YES];
    _phonePassWordTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    _phonePassWordTextField.returnKeyType = UIReturnKeyDone;
    _phonePassWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_phonePassWordTextField];
    
    UIButton *phoneKeyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneKeyButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH*0.8/5*2+(VIEW_FRAME_SIZE_WIDTH*0.8/5*1.7), 140, VIEW_FRAME_SIZE_WIDTH*0.9/5*2, 40);
    [phoneKeyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [phoneKeyButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [phoneKeyButton addTarget:self action:@selector(yourButtonTitleTime:) forControlEvents:UIControlEventTouchUpInside];
    [phoneKeyButton setBackgroundImage:[UIImage imageNamed:@"获取验证码btn.png"] forState:UIControlStateNormal];
    [phoneKeyButton setBackgroundImage:[UIImage imageNamed:@"获取验证码灰btn.png"] forState:UIControlStateSelected];
    [phoneKeyButton setBackgroundImage:[UIImage imageNamed:@"获取验证码灰btn.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:phoneKeyButton];
    
    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/2- VIEW_FRAME_SIZE_WIDTH*0.9/2, 270, VIEW_FRAME_SIZE_WIDTH*0.9, 40);
    [phoneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [phoneButton setTitle:@"注册" forState:UIControlStateNormal];
    [phoneButton setBackgroundImage:[UIImage imageNamed:@"保存btn.png"] forState:UIControlStateNormal];
    [phoneButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [phoneButton addTarget:self action:@selector(postRegisteredData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneButton];
    
    UIButton *textBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    textBtn.frame = CGRectMake((VIEW_FRAME_SIZE_WIDTH -VIEW_FRAME_SIZE_WIDTH*0.9)/2, 243, 15, 15);
    [textBtn setBackgroundImage:[UIImage imageNamed:@"fuxuan2.png"] forState:UIControlStateNormal];
    [textBtn setBackgroundImage:[UIImage imageNamed:@"fuxuan.png"] forState:UIControlStateHighlighted];
    [textBtn setBackgroundImage:[UIImage imageNamed:@"fuxuan.png"] forState:UIControlStateSelected];
    [textBtn addTarget:self action:@selector(textBtn:) forControlEvents:UIControlEventTouchUpInside];
    [textBtn setSelected:NO];
    [self.view addSubview:textBtn];
    
    UILabel *textLab = [[UILabel alloc] initWithFrame:CGRectMake((VIEW_FRAME_SIZE_WIDTH -VIEW_FRAME_SIZE_WIDTH*0.9)/2+20, 238, 220, 25)];
    textLab.text = @"我已认真阅读并同意熊管家的";
    [textLab setFont:[UIFont systemFontOfSize:15]];
    [textLab setTextColor:[UIColor blackColor]];
    [self.view addSubview:textLab];
    
    UILabel *agreementBtn = [[UILabel alloc] init];
    [agreementBtn setFrame:CGRectMake(textLab.bounds.size.width+10, 238, 100, 25)];
    [agreementBtn setText:@"《服务条款》"];
    [agreementBtn setTextColor:[UIColor redColor]];
    [agreementBtn setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:agreementBtn];
    
    UIButton *labTextBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    [labTextBtn setFrame:CGRectMake((VIEW_FRAME_SIZE_WIDTH -VIEW_FRAME_SIZE_WIDTH*0.9)/2+20, 238, VIEW_FRAME_SIZE_WIDTH, 25)];
    [labTextBtn addTarget:self action:@selector(textLab) forControlEvents:UIControlEventTouchUpInside];
    [labTextBtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:labTextBtn];
    
    FWTK = NO;
    if (iPhone6Plus) {
        phoneButton.frame = CGRectMake((VIEW_FRAME_SIZE_WIDTH -VIEW_FRAME_SIZE_WIDTH*0.9)/2, 270, VIEW_FRAME_SIZE_WIDTH*0.9, 154/3);
    }
}

- (void)textBtn:(UIButton *)sender
{
    if (sender.selected == YES) {
        sender.selected = NO;
        FWTK = NO;
//        NSLog(@"点击1");
    }else{
        sender.selected = YES;
//        NSLog(@"点击2");
        FWTK = YES;
    }
}

- (void)textLab
{
    TermsOfServiceViewController *ter = [[TermsOfServiceViewController alloc] init];
    [self presentViewController:ter animated:YES completion:nil];
}

- (void)textLabScroll
{
    
    
}

#pragma  mark - 按钮倒计时
- (void)yourButtonTitleTime:(UIButton *)sender
{
    if (_phoneTextField.text.length != 11) {
        NSString *tishi = @"请正确输入手机号码";
        [[YBProgressShow defaultProgress] showText:tishi InMode:MBProgressHUDModeDeterminate OriginViewEnableTouch:YES HideAfterDelayTime:1];
    }else  if(_phoneTextField.text.length == 11){
        
        NSString *userName = [NSString stringWithFormat:@"%@",_phoneTextField.text];
        NSMutableDictionary *dicccc = [[NSMutableDictionary alloc] init];
        [dicccc setValue:userName forKey:@"mobile"];
        [[BoolViewController alloc] testOut];
        NSString *urlStr = [NSString stringWithFormat:@"/index.php?s=/Api/Other/getvfcode"];
        
//        NSDictionary *dict = [PersonalRequest withAllUrll:urlStr WithDic:dicccc];
        NSDictionary *dict = [PersonalRequest NOTokenWithAllUrll:urlStr WithDic:dicccc];
//        NSLog(@"短信验证码：%@",dict);
        NSString *status = [dict valueForKey:@"status"];
        NSString *data = [dict valueForKey:@"data"];
        int statu = [status intValue];
        [sender setBackgroundImage:[UIImage imageNamed:@"获取验证码灰btn.png"] forState:UIControlStateNormal];
        
//        NSLog(@"status==%d,data==%@",statu,data);
        
        if (statu == 0) {
            __block int timeout=59; //倒计时时间
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        [sender setBackgroundImage:[UIImage imageNamed:@"获取验证码btn.png"] forState:UIControlStateNormal];
                        [sender setTitle:@"重新送验证码" forState:UIControlStateNormal];
                        [sender.titleLabel setFont:[UIFont systemFontOfSize:15]];
                        sender.userInteractionEnabled = YES;
                    });
                }else{
                    //            int minutes = timeout / 60;
                    int seconds = timeout % 60;
                    NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
//                        NSLog(@"____%@",strTime);
                        [sender setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                        [sender.titleLabel setFont:[UIFont systemFontOfSize:15]];
                        sender.userInteractionEnabled = NO;
                    });
                    timeout--;
                    
                }
            });
            dispatch_resume(_timer);
            
        }else if(statu == 1){
            [HUD removeFromSuperview];
            [[YBProgressShow defaultProgress] showText:data InMode:MBProgressHUDModeDeterminate OriginViewEnableTouch:YES HideAfterDelayTime:1];
        }
    }
}

#pragma  mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [_phoneTextField resignFirstResponder];
        [_phonePassWordTextField resignFirstResponder];
        [_phoneKeyTextField resignFirstResponder];
        return NO;
    }
    
    if (textField == _phoneTextField) {
        if (range.location >= 11)
        {
            return NO;
        }
    }
    
    if (textField == _phonePassWordTextField) {
        if (range.location >= 16)
        {
            return NO;
        }
    }
    
    if (textField == _phoneKeyTextField) {
        if (range.location >= 6)
        {
            return NO;
        }
    }
    
    NSCharacterSet *cs;
    if(textField == _phoneTextField || textField == _phoneKeyTextField)
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

- (void)textFieldDidEndEditing:(UITextField *)textField
{
}

#pragma  mark - 提交注册信息
- (void)postRegisteredData
{
//        NSString * phoneString = [NSString stringWithFormat:@"%@",_phoneTextField.text];
//        NSString * phoneKeyString = [NSString stringWithFormat:@"%@",_phoneKeyTextField.text];
//        NSString * phonePassWordString = [NSString stringWithFormat:@"%@",_phonePassWordTextField.text];
//        NSLog(@"-手机号=%@--短信验证码=%@--密码＝%@",phoneString,phoneKeyString,phonePassWordString);
//    NSLog(@"-手机号=%lu--短信验证码=%lu--密码＝%lu",(unsigned long)phoneString.length,(unsigned long)phoneKeyString.length,(unsigned long)phonePassWordString.length);

    
    if (_phoneKeyTextField.text.length < 6 &&_phoneTextField.text.length == 11 &&_phonePassWordTextField.text.length >= 4) {
        _tijiaoAlert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请输入6位短信验证码"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
        [_tijiaoAlert show];
    }else if (_phoneTextField.text.length != 11 && _phonePassWordTextField.text.length >= 4 &&_phoneKeyTextField.text.length == 6) {
        _tijiaoAlert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                  message:@"请输入11位手机号码"
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
        
        [_tijiaoAlert show];
    }else if (_phoneKeyTextField.text.length >= 4 &&_phoneTextField.text.length >= 11 &&_phonePassWordTextField.text.length < 4) {
        _tijiaoAlert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                  message:@"请输入不少于4位密码"
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
        
        [_tijiaoAlert show];
    }else if (_phoneKeyTextField.text.length < 6 && _phoneTextField.text.length < 11 && _phonePassWordTextField.text.length >= 4){
        _tijiaoAlert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                  message:@"请输入不少于11手机号码和6位短信验证码"
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
        
        [_tijiaoAlert show];
    }else if (_phoneKeyTextField.text.length == 6 && _phoneTextField.text.length < 11 && _phonePassWordTextField.text.length < 4){
        _tijiaoAlert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                  message:@"请输入不少于11手机号码和不少于4位密码"
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
        
        [_tijiaoAlert show];

    }else if (_phoneKeyTextField.text.length < 6 && _phoneTextField.text.length >= 11 && _phonePassWordTextField.text.length < 4){
        _tijiaoAlert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                  message:@"请输入6位短信验证码和不少于4位密码"
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
        
        [_tijiaoAlert show];
        
    }else if(_phoneKeyTextField.text.length < 6 && _phoneTextField.text.length < 11 && _phonePassWordTextField.text.length < 4){
        _tijiaoAlert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                  message:@"请正确输入注册信息"
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
        
        [_tijiaoAlert show];
    } else if (FWTK == NO){
        _tijiaoAlert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                  message:@"请阅读熊管家服务条款！"
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
        [_tijiaoAlert show];
    }else {
        
        [_phoneKeyTextField resignFirstResponder];
        [_phonePassWordTextField resignFirstResponder];
        [_phoneTextField resignFirstResponder];
        NSString *userName = [NSString stringWithFormat:@"%@",_phoneTextField.text];
        NSString *userKey = [NSString stringWithFormat:@"%@",_phoneKeyTextField.text];
        NSString *userPassWord = [NSString stringWithFormat:@"%@",_phonePassWordTextField.text];
        NSString *flag = @"1";
        NSString *platform = @"3";
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:userName forKey:@"mobile"];
        [dic setValue:userPassWord forKey:@"passwd"];
        [dic setValue:userKey forKey:@"vfcode"];
        [dic setValue:flag forKey:@"flag"];
        [dic setValue:platform forKey:@"platform"];

        NSString *urlStr = [NSString stringWithFormat:@"/index.php?s=/Api/User/reg"];

        NSDictionary *diccct = [PersonalRequest NOTokenWithAllUrll:urlStr WithDic:dic];
//        NSLog(@"注册--%@",diccct);
        int status = [[diccct valueForKey:@"status"] intValue];
        
        if (status == 0) {
//            NSLog(@"注册成功");
            [self denglu];
        }else if (status == 1){
            YBMB([diccct valueForKey:@"data"])
        }
    }
    
}

- (void)denglu
{
    NSString *userName = [NSString stringWithFormat:@"%@",_phoneTextField.text];
    NSString *userPassWord = [NSString stringWithFormat:@"%@",_phonePassWordTextField.text];
    NSString *flag = @"1";
    //登录成功后把用户名和密码存储到UserDefault
    
    [[BoolViewController alloc] testOut];
    
    NSString *urlStr = [NSString stringWithFormat:@"/index.php?s=/Api/User/login"];
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    [dic setValue:userName forKey:@"mobile"];
    [dic setValue:userPassWord forKey:@"passwd"];
    [dic setValue:flag forKey:@"flag"];

    NSDictionary *dicResponse = [PersonalRequest NOTokenWithAllUrll:urlStr WithDic:dic];
//    NSLog(@"dicresponse-%@",dicResponse);
    int status = [[dicResponse valueForKey:@"status"] intValue];
    NSDictionary *data = [dicResponse valueForKey:@"data"];
    if (status == 0) {
        NSString *user_id = [data valueForKey:@"user_id"];
        NSString *token = [data valueForKey:@"token"];
//        NSLog(@"user_id%@",user_id);
        [self denglu:status withName:userName withId:user_id withData:data withToken:token];
    }else if (status == 1){
//        NSString *datas = [dicResponse valueForKey:@"data"];
        [self denglu:status withName:userName withId:nil withData:nil withToken:nil];
//        NSLog(@"status--1---datas;%@",datas);
    }
}

- (void)denglu:(int)status
      withName:(NSString *)userName
        withId:(NSString *)user_id
      withData:(id)data
     withToken:(id)token
{
    if (status == 0) {
        
        
        [[BoolViewController alloc] testOut];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:userName forKey:@"name"];
        [userDefaults setObject:user_id forKey:@"user_id"];
        [userDefaults setObject:[self base64:[self md5:token]] forKey:@"skey"];
        
        self.window = [[UIApplication sharedApplication]keyWindow];
        ViewController *VC = [[ViewController alloc] init];
        OrderViewController *orderVC = [[OrderViewController alloc] init];
        PersonalLanding *personal = [[PersonalLanding alloc] init];
        UINavigationController *VCNav = [[UINavigationController alloc] initWithRootViewController:VC];
        UINavigationController *orderNav = [[UINavigationController alloc] initWithRootViewController:orderVC];
        UINavigationController *personalNav = [[UINavigationController alloc] initWithRootViewController:personal];
        NSArray *navArray = [[NSArray alloc] initWithObjects:VCNav,orderNav,personalNav, nil];
        NSMutableDictionary *imageHomes = [NSMutableDictionary dictionaryWithCapacity:3];
        [imageHomes setObject:[UIImage imageNamed:@"home.png"] forKey:@"Default"];
        [imageHomes setObject:[UIImage imageNamed:@"homehover.png"] forKey:@"Highlighted"];
        [imageHomes setObject:[UIImage imageNamed:@"homehover.png"] forKey:@"Seleted"];
        NSMutableDictionary *imageOrders = [NSMutableDictionary dictionaryWithCapacity:3];
        [imageOrders setObject:[UIImage imageNamed:@"订单.png"] forKey:@"Default"];
        [imageOrders setObject:[UIImage imageNamed:@"订单hover.png"] forKey:@"Highlighted"];
        [imageOrders setObject:[UIImage imageNamed:@"订单hover.png"] forKey:@"Seleted"];
        NSMutableDictionary *imageMys = [NSMutableDictionary dictionaryWithCapacity:3];
        [imageMys setObject:[UIImage imageNamed:@"my.png"] forKey:@"Default"];
        [imageMys setObject:[UIImage imageNamed:@"myhover.png"] forKey:@"Highlighted"];
        [imageMys setObject:[UIImage imageNamed:@"myhover.png"] forKey:@"Seleted"];
        NSArray *imageArray = [NSArray arrayWithObjects:imageHomes,imageOrders,imageMys, nil];
        _leveyTabBarController = [[LeveyTabBarController alloc] initWithViewControllers:navArray imageArray:imageArray];
        [_leveyTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"navBg.png"]];
        [_leveyTabBarController setTabBarTransparent:YES];
        
        [self.window setRootViewController:_leveyTabBarController];
    }else if (status == 1){
        
        [[YBProgressShow defaultProgress] showText:data InMode:MBProgressHUDModeDeterminate OriginViewEnableTouch:YES HideAfterDelayTime:1];
    }
}

#pragma  mark - MD5加密
- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

#pragma  mark - base64加密
- (NSString *)base64:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString* encoded = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    return encoded;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_phoneTextField resignFirstResponder];
    [_phonePassWordTextField resignFirstResponder];
    [_phoneKeyTextField resignFirstResponder];
}
@end
