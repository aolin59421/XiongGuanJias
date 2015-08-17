//
//  PersonalViewController.m
//  xiongmami
//
//  Created by iMac on 14/11/18.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "PersonalViewController.h"
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


@interface PersonalViewController ()<UITextFieldDelegate,UIAlertViewDelegate,UMSocialUIDelegate>
{
    UIImageView * _imageHeard;//头像
    UITextField * _nameTextField;//账号
    UITextField * _passWord;//密码
    XMMCustomSegmentedButton*_imageSegmentedButton;
    MBProgressHUD *HUD;
}
@end

@implementation PersonalViewController


- (void)viewWillAppear:(BOOL)animated
{
//    NSLog(@"willApper");
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.leveyTabBarController hidesTabBar:NO animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.title = @"登录";
//    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0f green:239/255.0f blue:235/255.0f alpha:1];
    [self addCustomView];

    UILabel *navLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 64)];
    navLab.backgroundColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];
    navLab.text = @"\n登录";
    [navLab setNumberOfLines:0];
    navLab.textAlignment = NSTextAlignmentCenter;
    navLab.font = [UIFont systemFontOfSize:20];
    navLab.textColor = [UIColor whiteColor];
    [self.view addSubview:navLab];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(5, 20, 44, 44);
    [back setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
//    [back setTitle:@"返回" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [back.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    back.tag = 0;
    [self.view addSubview:back];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view ];
    [self.view addSubview:HUD];
    
    HUD.mode = MBProgressHUDModeIndeterminate;
    
    
//    NSLog(@"当前界面尺寸-%@",self.view);
}

- (void)back:(UIButton *)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
//    ViewController *view = [[ViewController alloc] init];
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
#pragma  mark - customView
- (void)addCustomView
{
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 84, VIEW_FRAME_SIZE_WIDTH*0.9, 40)];
    
    [_nameTextField setPlaceholder:@" 请输入手机账号"];
    _nameTextField.delegate = self;
    _nameTextField.background = [UIImage imageNamed:@"登录输入框(1).png"];
    _nameTextField.textAlignment = NSTextAlignmentCenter;
    [_nameTextField setTextColor:[UIColor blackColor]];
    _nameTextField.keyboardType = UIKeyboardTypePhonePad;
    _nameTextField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_nameTextField];
    
    _passWord  = [[UITextField alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 134, VIEW_FRAME_SIZE_WIDTH*0.9, 40)];
    [_passWord setPlaceholder:@" 请输入密码"];
    _passWord.textAlignment = NSTextAlignmentCenter;
    [_passWord setTextColor:[UIColor blackColor]];
    _passWord.delegate =self;
    [_passWord setSecureTextEntry:YES];
    _passWord.background = [UIImage imageNamed:@"密码输入框(2).png"];
    _passWord.keyboardType = UIKeyboardTypeNamePhonePad;
    _passWord.returnKeyType = UIReturnKeyDone;
    _passWord.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_passWord];
    
    //登录
    UIButton *landingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    landingButton.frame = CGRectMake((VIEW_FRAME_SIZE_WIDTH -VIEW_FRAME_SIZE_WIDTH*0.9)/2,  194, VIEW_FRAME_SIZE_WIDTH*0.9, 40);
    [landingButton setBackgroundImage:[UIImage imageNamed:@"loginBtn.png"] forState:UIControlStateNormal];
    [landingButton setTitle:@"登录" forState:UIControlStateNormal];
    [landingButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [landingButton addTarget:self action:@selector(postLanding) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:landingButton];
    
    //忘记密码
    UIButton *forgetPassWordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPassWordButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/1.6,  244, VIEW_FRAME_SIZE_WIDTH/3, 40);
    [forgetPassWordButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetPassWordButton setTitleColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#8a92a5"] forState:UIControlStateNormal];
    [forgetPassWordButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [forgetPassWordButton addTarget:self action:@selector(forgetPassWord) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPassWordButton];
    
    //新用户注册
    UIButton *newRegisteredButton = [UIButton buttonWithType:UIButtonTypeCustom];
    newRegisteredButton.frame = CGRectMake((VIEW_FRAME_SIZE_WIDTH -VIEW_FRAME_SIZE_WIDTH*0.9)/3,  244, VIEW_FRAME_SIZE_WIDTH/3, 40);
    [newRegisteredButton setTitle:@"新用户注册" forState:UIControlStateNormal];
    [newRegisteredButton setTitleColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#8a92a5"] forState:UIControlStateNormal];
    [newRegisteredButton setBackgroundColor:[UIColor clearColor]];
    [newRegisteredButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [newRegisteredButton addTarget:self action:@selector(newRegistered) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newRegisteredButton];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 73.5+284+14, VIEW_FRAME_SIZE_WIDTH*0.9, 0.5f)];
    image.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#8a92a5"];
    [self.view addSubview:image];
    UILabel *warningLab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/3-5, 73.5+284, VIEW_FRAME_SIZE_WIDTH/3+10, 30)];
    warningLab.text = @"可以使用以下第三方登录";
    [warningLab setTextAlignment:NSTextAlignmentCenter];
    [warningLab setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#8a92a5"]];
    [warningLab setBackgroundColor:[UIColor colorWithRed:245/255.0f green:239/255.0f blue:235/255.0f alpha:1]];
    [warningLab setFont:[UIFont systemFontOfSize:10]];
    [self.view addSubview:warningLab];
    
//    NSArray *array = [[NSArray alloc] initWithObjects:@"微博",@"QQ",@"微信", nil];
    for (int i = 0; i < 3; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(30+(i*(VIEW_FRAME_SIZE_WIDTH/3)), 73.5+284+40, 50, 50);
        
        if (iPhone6Plus) {
            button.frame = CGRectMake(60+i*(VIEW_FRAME_SIZE_WIDTH/3.5f), 73.5+284+80, 60, 60);
        }
        
        button.tag = i + 1;
//        [button setBackgroundColor:[UIColor redColor]];
        [button addTarget:self action:@selector(otherLanding:) forControlEvents:UIControlEventTouchUpInside];
//        [button setTitle:[NSString stringWithFormat:@"%@",[array objectAtIndex:i]] forState:UIControlStateNormal];
        
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        switch (i) {
            case 0:
            {
                [button setBackgroundImage:[UIImage imageNamed:@"微博.png"] forState:UIControlStateNormal];
            }
                break;
            case 1:
            {
                
                if ([QQApiInterface isQQInstalled]== YES) {
                    
//                    NSLog(@"install--");
                    [button setBackgroundImage:[UIImage imageNamed:@"QQ.png"] forState:UIControlStateNormal];
                }else{
                    
//                    NSLog(@"no---");
                    
                }
            }
                break;
            case 2:
            {
                if ([WXApi isWXAppInstalled] == YES) {
//                    NSLog(@"微信yes");
                    [button setBackgroundImage:[UIImage imageNamed:@"微信.png"] forState:UIControlStateNormal];
                }else{
//                    NSLog(@"weixinNO");
                }
                
            }
                break;
                
            default:
                break;
        }
        [self.view addSubview:button];
    }
    
    if (iPhone6Plus) {
        _nameTextField.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 84, VIEW_FRAME_SIZE_WIDTH*0.9, 154/3);
        _passWord.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 149, VIEW_FRAME_SIZE_WIDTH*0.9, 154/3);
        
        landingButton.frame = CGRectMake((VIEW_FRAME_SIZE_WIDTH -VIEW_FRAME_SIZE_WIDTH*0.9)/2,  229, VIEW_FRAME_SIZE_WIDTH*0.9, 154/3);
        
        warningLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/3-20, 73.5+284, VIEW_FRAME_SIZE_WIDTH/3+40, 30);
        [warningLab setFont:[UIFont systemFontOfSize:14]];
        
        newRegisteredButton.frame = CGRectMake((VIEW_FRAME_SIZE_WIDTH -VIEW_FRAME_SIZE_WIDTH*0.9)/3,  284, VIEW_FRAME_SIZE_WIDTH/3, 40);
        forgetPassWordButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/1.6,  284, VIEW_FRAME_SIZE_WIDTH/3, 40);
    }
    
}


#pragma  mark - 第三方登录
- (void)otherLanding:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
        {
            //NSLog(@"微博");
            [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//                NSLog(@"login response is %@",response);
                //          获取微博用户名、uid、token等
                
                if (response.responseCode == UMSResponseCodeSuccess) {
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
                    
                    [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina completion:^(UMSocialResponseEntity *response) {
//                        NSLog(@"unOauth response is %@",response);
                    }];
                    
//                    NSLog(@"username is %@, uid is %@, token is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken);
                    if (snsAccount.usid == nil || snsAccount.usid == NULL ||snsAccount.usid.length == 0) {
                        YBMB(@"授权失败")
                    }else{
                        YBMB(@"授权成功")
//                        VerificationViewController *verificationView = [[VerificationViewController alloc] init];
//                        [self presentViewController:verificationView animated:YES completion:nil];
                        [self withOtherLoginWithUserUID:snsAccount.usid withToken:snsAccount.accessToken withFlag:@"2"];
                    }
                    
                }
                //这里可以获取到腾讯微博openid,Qzone的token等
                /*
                 if ([platformName isEqualToString:UMShareToTencent]) {
                 [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToTencent completion:^(UMSocialResponseEntity *respose){
                 NSLog(@"get openid  response is %@",respose);
                 }];
                 }
                 */
                
            });
        }
    
    
            break;
        case 2:
        {
            
            if ([QQApiInterface isQQInstalled]== YES) {
                //QQ
                [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
                UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
                snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//                    NSLog(@"login response is %@",response.data);
                    
                    //          获取微博用户名、uid、token等
                    if (response.responseCode == UMSResponseCodeSuccess) {
                        UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
//                        NSLog(@"username is %@, uid is %@, token is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken);
                        
                        if (snsAccount.usid == nil || snsAccount.usid == NULL ||snsAccount.usid.length == 0) {
                            YBMB(@"授权失败")
                        }else{
                            YBMB(@"授权成功")
                            //                        VerificationViewController *verificationView = [[VerificationViewController alloc] init];
                            //                        [self presentViewController:verificationView animated:YES completion:nil];
                            [self withOtherLoginWithUserUID:snsAccount.usid withToken:snsAccount.accessToken withFlag:@"3"];
                        }
                        
                    }
                    //这里可以获取到腾讯微博openid,Qzone的token等
                    /*
                     if ([platformName isEqualToString:UMShareToTencent]) {
                     [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToTencent completion:^(UMSocialResponseEntity *respose){
                     NSLog(@"get openid  response is %@",respose);
                     }];
                     }
                     */
                    //                [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToQQ completion:^(UMSocialResponseEntity *response) {
                    //                    NSLog(@"unOauth response is %@",response);
                    //                }];
                });

            }else{
                
//                NSLog(@"no---");
                
            }
//            NSLog(@"QQ");
                   }
            break;
        case 3:{
//            NSLog(@"微信");
            
            if ([WXApi isWXAppInstalled] == YES) {
//                NSLog(@"微信yes");
                [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
                UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
                snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//                    NSLog(@"login response is %@",response);
                    ;
                    
                    //          获取微博用户名、uid、token等
                    if (response.responseCode == UMSResponseCodeSuccess) {
                        UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToWechatSession];
//                        NSLog(@"username is %@, uid is %@, token is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken);
                        
                        if (snsAccount.usid == nil || snsAccount.usid == NULL ||snsAccount.usid.length == 0) {
                            YBMB(@"授权失败")
                        }else{
                            YBMB(@"授权成功")
                            //                        VerificationViewController *verificationView = [[VerificationViewController alloc] init];
                            //                        [self presentViewController:verificationView animated:YES completion:nil];
                            [self withOtherLoginWithUserUID:snsAccount.usid withToken:snsAccount.accessToken withFlag:@"0"];
                        }
                    }
                    //这里可以获取到腾讯微博openid,Qzone的token等
                    /*
                     if ([platformName isEqualToString:UMShareToTencent]) {
                     [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToTencent completion:^(UMSocialResponseEntity *respose){
                     NSLog(@"get openid  response is %@",respose);
                     }];
                     }
                     */
                    //                [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToWechatSession completion:^(UMSocialResponseEntity *response) {
                    //                    NSLog(@"unOauth response is %@",response);
                    //                }];
                });
            }else{
//                NSLog(@"weixinNO");
            }
            
        }
            break;
            
        default:
            break;
    }
}

#pragma  mark - 新用户注册
- (void)newRegistered
{
    RegisteredViewController *rehisteredVC = [[RegisteredViewController alloc] init];
    [self presentViewController:rehisteredVC animated:YES completion:nil];
//    [self.navigationController pushViewController:rehisteredVC animated:YES];
}

#pragma  mark - 忘记密码
- (void)forgetPassWord
{
    ForgetPassWordViewController *forgetVC = [[ForgetPassWordViewController alloc] init];
    [self presentViewController:forgetVC animated:YES completion:nil];
//    [self.navigationController pushViewController:forgetVC animated:YES];
}

#pragma  mark - 登录
- (void)postLanding
{
    [self textFieldWarning];
}

#pragma  mark - UITextFieldDelegate
- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    [_nameTextField resignFirstResponder];
    [_passWord resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _nameTextField) {
        textField.background = _nameTextField.background = [UIImage imageNamed:@"登录输入框.png"];
    }else if (textField == _passWord){
        textField.background = [UIImage imageNamed:@"密码输入框.png"];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == _nameTextField) {
        _nameTextField.background = [UIImage imageNamed:@"登录输入框(1).png"];
    } else if (textField == _passWord) {
        textField.background = [UIImage imageNamed:@"密码输入框(2).png"];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [_nameTextField resignFirstResponder];
        [_passWord resignFirstResponder];
        return NO;
    }
    
    if (textField == _nameTextField) {
        
        if (range.location >= 11)
        {
            return NO;
        }
        
    }
    
    if (textField == _passWord) {
        if (range.location >= 16)
        {
            return NO;
        }
        
    }
    
    NSCharacterSet *cs;
    if(textField == _nameTextField)
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
    if (textField == _passWord) {
        if (textField.text.length < 6 && textField.text.length != 0) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请输入4-16位密码"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            
            [alert show];
        }
    }
    
    if (textField == _nameTextField) {
        if (textField.text.length < 11 && textField.text.length != 0) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请输入11位手机号码"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            
            [alert show];
        }
    }
}

- (void)textFieldWarning
{

        if (_passWord.text.length < 6 && _nameTextField.text.length == 11) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请输入4-16位密码"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            
            [alert show];
        } else if (_nameTextField.text.length < 11 && _passWord.text.length >= 6) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请输入11位手机号码"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            
            [alert show];
        } else if (_nameTextField.text.length < 11 && _passWord.text.length < 6) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请输入正确信息"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            
            [alert show];
        }else if(_nameTextField.text.length == 11 && _passWord.text.length >= 6){
            
            
            [self dengluchenggong];
        }

}

- (void)dengluchenggong
{
    [_nameTextField resignFirstResponder];
    [_passWord resignFirstResponder];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = @"登陆中";
    [HUD show:YES];
    
    NSString *userName = [NSString stringWithFormat:@"%@",_nameTextField.text];
    NSString *userPassWord = [NSString stringWithFormat:@"%@",_passWord.text];
    NSString *flag = @"1";
    //登录成功后把用户名和密码存储到UserDefault
    
    
    [[BoolViewController alloc] testOut];//判断是否有网
    
    NSString *urlStr = [NSString stringWithFormat:@"/index.php?s=/Api/User/login"];
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    [dic setValue:userName forKey:@"mobile"];
    [dic setValue:userPassWord forKey:@"passwd"];
    [dic setValue:flag forKey:@"flag"];
    [dic setValue:@"3" forKey:@"platform"];
//    NSString *parameter = [dic JSONString];
//    NSLog(@"登录%@",parameter);
    NSDictionary * dicResponse = [PersonalRequest withAllUrll:urlStr WithDic:dic];
//     NSLog(@"123d123 ^%@",dicResponse);
    int status = [[dicResponse valueForKey:@"status"] intValue];
    NSDictionary *data = [dicResponse valueForKey:@"data"];
    if (status == 0) {
//        NSLog(@"123d ^%@",dicResponse);
        NSString *user_id = [data valueForKey:@"user_id"];
        NSString *token = [data valueForKey:@"token"];
//        NSLog(@"user_id%@",user_id);
        [self denglu:status withName:userName withId:user_id withData:data withMobiel:userName withToken:token];
    }else if (status == 1){
        NSString *datas = [dicResponse valueForKey:@"data"];
        [self denglu:status withName:userName withId:nil withData:datas withMobiel:userName withToken:nil];
//        NSLog(@"status--1---datas;%@",datas);
    }
}

- (void)denglu:(int)status
      withName:(NSString *)userName
        withId:(NSString *)user_id
      withData:(id)data
    withMobiel:(NSString *)mobiel
     withToken:(NSString *)token
{
    if (status == 0) {
//        NSLog(@"----%@",token);
        [[BoolViewController alloc] testOut];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:userName forKey:@"name"];
        [userDefaults setObject:user_id forKey:@"user_id"];
        [userDefaults setObject:mobiel forKey:@"mobiel"];
        [userDefaults setObject:[self base64:[self md5:token]] forKey:@"skey"];
//        NSLog(@"----%@",token);
        
        
//        NSLog(@"user_name-%@ user_id-%@ mobiel-%@",[userDefaults valueForKey:@"name"],[userDefaults valueForKey:@"user_id"],[userDefaults valueForKey:@"mobiel"]);
        self.window = [[UIApplication sharedApplication]keyWindow];
        ViewController *VC = [[ViewController alloc] init];
        OrderViewController *orderVC = [[OrderViewController alloc] init];
        PersonalLanding *personal = [[PersonalLanding alloc] init];
        UINavigationController *VCNav = [[UINavigationController alloc] initWithRootViewController:VC];
        UINavigationController *orderNav = [[UINavigationController alloc] initWithRootViewController:orderVC];
        UINavigationController *personalNav = [[UINavigationController alloc] initWithRootViewController:personal];
        NSArray *navArray = [[NSArray alloc] initWithObjects:VCNav,orderNav,personalNav, nil];
        NSMutableDictionary *imageHomes = [NSMutableDictionary dictionaryWithCapacity:3];
        NSMutableDictionary *imageOrders = [NSMutableDictionary dictionaryWithCapacity:3];
        NSMutableDictionary *imageMys = [NSMutableDictionary dictionaryWithCapacity:3];
        
        if (iPhone6Plus) {
            //6+
            [imageHomes setObject:[UIImage imageNamed:@"home_icon.png"] forKey:@"Default"];
            [imageHomes setObject:[UIImage imageNamed:@"home_iconhover.png"] forKey:@"Highlighted"];
            [imageHomes setObject:[UIImage imageNamed:@"home_iconhover.png"] forKey:@"Seleted"];
            
            [imageOrders setObject:[UIImage imageNamed:@"order_icon.png"] forKey:@"Default"];
            [imageOrders setObject:[UIImage imageNamed:@"order_iconhover.png"] forKey:@"Highlighted"];
            [imageOrders setObject:[UIImage imageNamed:@"order_iconhover.png"] forKey:@"Seleted"];
            
            [imageMys setObject:[UIImage imageNamed:@"my_icon.png"] forKey:@"Default"];
            [imageMys setObject:[UIImage imageNamed:@"my_iconhover.png"] forKey:@"Highlighted"];
            [imageMys setObject:[UIImage imageNamed:@"my_iconhover.png"] forKey:@"Seleted"];
        }else{
            
            [imageHomes setObject:[UIImage imageNamed:@"home.png"] forKey:@"Default"];
            [imageHomes setObject:[UIImage imageNamed:@"homehover.png"] forKey:@"Highlighted"];
            [imageHomes setObject:[UIImage imageNamed:@"homehover.png"] forKey:@"Seleted"];
            
            [imageOrders setObject:[UIImage imageNamed:@"订单.png"] forKey:@"Default"];
            [imageOrders setObject:[UIImage imageNamed:@"订单hover.png"] forKey:@"Highlighted"];
            [imageOrders setObject:[UIImage imageNamed:@"订单hover.png"] forKey:@"Seleted"];
            
            [imageMys setObject:[UIImage imageNamed:@"my.png"] forKey:@"Default"];
            [imageMys setObject:[UIImage imageNamed:@"myhover.png"] forKey:@"Highlighted"];
            [imageMys setObject:[UIImage imageNamed:@"myhover.png"] forKey:@"Seleted"];
        }
        NSArray *imageArray = [NSArray arrayWithObjects:imageHomes,imageOrders,imageMys, nil];
        _leveyTabBarController = [[LeveyTabBarController alloc] initWithViewControllers:navArray imageArray:imageArray];
        [_leveyTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"navBg.png"]];
        [_leveyTabBarController setTabBarTransparent:YES];
        
        [HUD removeFromSuperview];
        
        [self.window setRootViewController:_leveyTabBarController];
    }else if (status == 1){
        [HUD removeFromSuperview];
        [[YBProgressShow defaultProgress] showText:@"登录失败" InMode:MBProgressHUDModeDeterminate OriginViewEnableTouch:YES HideAfterDelayTime:1];
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

#pragma  mark - 
- (void)withOtherLoginWithUserUID:(NSString *)userUID
                        withToken:(NSString *)userToken
                         withFlag:(NSString *)flag
{
    NSMutableDictionary *dicccct = [[NSMutableDictionary alloc] init];
    [dicccct setValue:userUID forKey:@"uid"];
    [dicccct setValue:flag forKey:@"flag"];
    [dicccct setValue:userToken forKey:@"token"];
    [dicccct setValue:@"3" forKey:@"platform"];
    [dicccct setValue:@"" forKey:@"mobile"];
    [dicccct setValue:@"" forKey:@"passwd"];
    
    NSDictionary *dic = [PersonalRequest withAllUrll:@"/index.php?s=/Api/User/login" WithDic:dicccct];
//    NSLog(@"三方登陆%@",dic);
    int status = [[dic valueForKey:@"status"] intValue];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[[dic valueForKey:@"data"] valueForKey:@"flag"] forKey:@"_Flag"];
    if (status == 0) {
        NSLog(@"返回成功");
//        [self.view removeFromSuperview];
        int flagg = [flag intValue];
        
        if ([[[dic valueForKey:@"data"] valueForKey:@"bind_mobile"] intValue] == 0) {
            VerificationViewController *verificationView = [[VerificationViewController alloc] init];
            
            verificationView.open_id = [[dic valueForKey:@"data"] valueForKey:@"open_id"];
            
            switch (flagg) {
                case 2:
                {
                    //sina
                    verificationView.flag = @"2";
                }
                    break;
                case 3:
                {
                    //qq
                    verificationView.flag = @"3";
                }
                    break;
                case 0:
                {
                    //weixin
                    verificationView.flag = @"0";
                }
                    break;
                    
                default:
                    break;
            }
            [self presentViewController:verificationView animated:YES completion:nil];
        }else{
            //name &mobiel =[dic valueForKey:@"bind_mobile"]]
//            NSLog(@"asdfasdgfasdfasdfasd-%@",[[dic valueForKey:@"data"] valueForKey:@"user_id"]);
            [self denglu:status withName:@"" withId:[[dic valueForKey:@"data"] valueForKey:@"user_id"] withData:[dic valueForKey:@"data"] withMobiel:@"" withToken:[[dic valueForKey:@"data"] valueForKey:@"token"]];
        }
        
    }else if (status == 1){
//        NSLog(@"返回失败-%@",[dic valueForKey:@"data"]);
    }
}
@end
