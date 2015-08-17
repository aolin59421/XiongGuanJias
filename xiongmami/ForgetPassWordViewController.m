//
//  ForgetPassWordViewController.m
//  xiongmami
//
//  Created by iMac on 14/11/18.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "ForgetPassWordViewController.h"
#import "Interface.h"
#import "HexadecimalConversionUICOLOR.h"

@interface ForgetPassWordViewController ()<UITextFieldDelegate>

{
    UITextField *_phoneTextField;//手机号码
    UITextField *_phoneKeyTextField;//短信验证码
    UITextField *_phonePassWordTextField;//密码
    UIAlertView *_tijiaoAlert;
}
@end
@implementation ForgetPassWordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addRegistered];
    self.title = @"忘记密码";
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0f green:239/255.0f blue:235/255.0f alpha:1];
    UILabel *navLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 64)];
    navLab.backgroundColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];
    navLab.text = @"\n忘记密码";
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
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)addRegistered
{
    //手机号
    _phoneTextField= [[UITextField alloc] initWithFrame:CGRectMake((VIEW_FRAME_SIZE_WIDTH -VIEW_FRAME_SIZE_WIDTH*0.9)/2, 90, VIEW_FRAME_SIZE_WIDTH*0.9, 40)];
    [_phoneTextField setPlaceholder:@" 请输入有效手机号码"];
    [_phoneTextField setTextColor:[UIColor blackColor]];
    [_phoneTextField setBackground:[UIImage imageNamed:@"验证码btn.png"]];
    _phoneTextField.delegate = self;
//    [_phoneTextField setTextAlignment:NSTextAlignmentCenter];
    _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    _phoneTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_phoneTextField];
    
    //短信验证码
    _phoneKeyTextField= [[UITextField alloc] initWithFrame:CGRectMake((VIEW_FRAME_SIZE_WIDTH -VIEW_FRAME_SIZE_WIDTH*0.9)/2, 140, VIEW_FRAME_SIZE_WIDTH*0.9/5*3-10, 40)];
    [_phoneKeyTextField setPlaceholder:@" 请输入短信验证码"];
    [_phoneKeyTextField setBackground:[UIImage imageNamed:@"验证码btn.png"]];
    [_phoneKeyTextField setTextColor:[UIColor blackColor]];
    _phoneKeyTextField.delegate = self;
//    [_phoneKeyTextField setTextAlignment:NSTextAlignmentCenter];
    _phoneKeyTextField.keyboardType = UIKeyboardTypePhonePad;
    _phoneKeyTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_phoneKeyTextField];
    
    //密码
    _phonePassWordTextField= [[UITextField alloc] initWithFrame:CGRectMake((VIEW_FRAME_SIZE_WIDTH -VIEW_FRAME_SIZE_WIDTH*0.9)/2, 190, VIEW_FRAME_SIZE_WIDTH*0.9, 40)];
    [_phonePassWordTextField setPlaceholder:@" 请输入新密码"];
    [_phonePassWordTextField setBackground:[UIImage imageNamed:@"验证码btn.png"]];
    [_phonePassWordTextField setTextColor:[UIColor blackColor]];
    _phonePassWordTextField.delegate = self;
//    [_phonePassWordTextField setTextAlignment:NSTextAlignmentCenter];
    _phonePassWordTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    _phonePassWordTextField.returnKeyType = UIReturnKeyDone;
    [_phonePassWordTextField setSecureTextEntry:YES];
    _phonePassWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_phonePassWordTextField];
    
    UIButton *phoneKeyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneKeyButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH*0.8/5*2+(VIEW_FRAME_SIZE_WIDTH*0.8/5*1.7), 140, VIEW_FRAME_SIZE_WIDTH*0.9/5*2, 40);
    [phoneKeyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [phoneKeyButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [phoneKeyButton addTarget:self action:@selector(yourButtonTitleTimes:) forControlEvents:UIControlEventTouchUpInside];
    [phoneKeyButton setBackgroundImage:[UIImage imageNamed:@"获取验证码btn.png"] forState:UIControlStateNormal];
    [phoneKeyButton setBackgroundImage:[UIImage imageNamed:@"获取验证码灰btn.png"] forState:UIControlStateSelected];
    [phoneKeyButton setBackgroundImage:[UIImage imageNamed:@"获取验证码灰btn.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:phoneKeyButton];
    
    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/2- VIEW_FRAME_SIZE_WIDTH*0.9/2, 260, VIEW_FRAME_SIZE_WIDTH*0.9, 40);
    [phoneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [phoneButton setTitle:@"完成" forState:UIControlStateNormal];
    [phoneButton setBackgroundImage:[UIImage imageNamed:@"保存btn.png"] forState:UIControlStateNormal];
    [phoneButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [phoneButton addTarget:self action:@selector(postRegisteredData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneButton];
    
    if (iPhone6Plus) {
        phoneButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/2- VIEW_FRAME_SIZE_WIDTH*0.9/2, 260, VIEW_FRAME_SIZE_WIDTH*0.9, 154/3);
    }
}

#pragma  mark - 按钮倒计时
- (void)yourButtonTitleTimes:(UIButton *)sender
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
        NSInteger statu = [status intValue];
        [sender setBackgroundImage:[UIImage imageNamed:@"获取验证码灰btn.png"] forState:UIControlStateNormal];
//        NSLog(@"status==%ld,data==%@",(long)statu,data);
        
        if (statu == 0) {
            __block NSInteger timeout=59; //倒计时时间
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
                        NSInteger seconds = timeout % 60;
                    NSString *strTime = [NSString stringWithFormat:@"%.2ld", (long)seconds];
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

#pragma  mark - 提交信息
- (void)postRegisteredData
{
//    NSString * phoneString = [NSString stringWithFormat:@"%@",_phoneTextField.text];
//    NSString * phoneKeyString = [NSString stringWithFormat:@"%@",_phoneKeyTextField.text];
//    NSString * phonePassWordString = [NSString stringWithFormat:@"%@",_phonePassWordTextField.text];
//    NSLog(@"-手机号=%@--短信验证码=%@--密码＝%@",phoneString,phoneKeyString,phonePassWordString);
//    NSLog(@"-手机号=%lu--短信验证码=%lu--密码＝%lu",(unsigned long)phoneString.length,(unsigned long)phoneKeyString.length,(unsigned long)phonePassWordString.length);
    if (_phoneKeyTextField.text.length < 6 &&_phoneTextField.text.length == 11 &&_phonePassWordTextField.text.length >= 6) {
        _tijiaoAlert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                  message:@"请输入6位短信验证码"
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
        [_tijiaoAlert show];
    }else if (_phoneTextField.text.length != 11 && _phonePassWordTextField.text.length >= 6 &&_phoneKeyTextField.text.length == 6) {
        _tijiaoAlert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                  message:@"请输入11位手机号码"
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
        [_tijiaoAlert show];
    }else if (_phoneKeyTextField.text.length >= 6 &&_phoneTextField.text.length >= 11 &&_phonePassWordTextField.text.length < 6) {
        _tijiaoAlert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                  message:@"请输入不少于6位密码"
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
        [_tijiaoAlert show];
    }else if (_phoneKeyTextField.text.length < 6 && _phoneTextField.text.length < 11 && _phonePassWordTextField.text.length >= 6){
        _tijiaoAlert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                  message:@"请输入不少于11手机号码和6位短信验证码"
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
        [_tijiaoAlert show];
    }else if (_phoneKeyTextField.text.length == 6 && _phoneTextField.text.length < 11 && _phonePassWordTextField.text.length < 6){
        _tijiaoAlert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                  message:@"请输入不少于11手机号码和不少于6位密码"
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
        [_tijiaoAlert show];
        
    }else if (_phoneKeyTextField.text.length < 6 && _phoneTextField.text.length >= 11 && _phonePassWordTextField.text.length < 6){
        _tijiaoAlert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                  message:@"请输入6位短信验证码和不少于6位密码"
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
        [_tijiaoAlert show];
        
    }else if(_phoneKeyTextField.text.length < 6 && _phoneTextField.text.length < 11 && _phonePassWordTextField.text.length < 6){
        _tijiaoAlert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                  message:@"请请正确输入注册信息"
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
        [_tijiaoAlert show];
    } else {
        [_phoneKeyTextField resignFirstResponder];
        [_phonePassWordTextField resignFirstResponder];
        [_phoneTextField resignFirstResponder];
        
        [[BoolViewController alloc] testOut];
        NSString *userName = [NSString stringWithFormat:@"%@",_phoneTextField.text];
        NSString *userKey = [NSString stringWithFormat:@"%@",_phoneKeyTextField.text];
        NSString *userPassWord = [NSString stringWithFormat:@"%@",_phonePassWordTextField.text];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:userName forKey:@"mobile"];
        [dic setValue:userKey forKey:@"vfcode"];
        [dic setValue:userPassWord forKey:@"passwd"];
        
        NSString *urlStr = [NSString stringWithFormat:@"/index.php?s=/Api/User/forgetpwd"];

        NSDictionary *dict = [PersonalRequest NOTokenWithAllUrll:urlStr WithDic:dic];
        
        NSInteger status = [[dict valueForKey:@"status"] intValue];
        NSString *data = [dict valueForKey:@"data"];
//        NSLog(@"忘记密码status--%ld--data%@",(long)status,data);
        
        if (status == 0) {
            NSString *textStr = @"修改成功";
            [[YBProgressShow defaultProgress] showText:textStr InMode:MBProgressHUDModeDeterminate OriginViewEnableTouch:YES HideAfterDelayTime:1];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else if (status == 1){
            [[YBProgressShow defaultProgress] showText:data InMode:MBProgressHUDModeDeterminate OriginViewEnableTouch:YES HideAfterDelayTime:1];
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_phoneTextField resignFirstResponder];
    [_phonePassWordTextField resignFirstResponder];
    [_phoneKeyTextField resignFirstResponder];
}
@end
