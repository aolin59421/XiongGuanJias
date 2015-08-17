//
//  ChangePasswordViewController.m
//  xiongmami
//
//  Created by iMac on 14/11/24.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "HexadecimalConversionUICOLOR.h"

@interface ChangePasswordViewController ()<UITextFieldDelegate>

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改密码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addCustomView];
 
    _rightButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"完成"
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                    action:nil];
    _rightButton.tintColor = [UIColor lightGrayColor];
    [self.navigationItem setRightBarButtonItem:_rightButton];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(bback)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [NSThread detachNewThreadSelector:@selector(RequestUserMobile) toTarget:self withObject:nil];
}

- (void)bback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)changepwd
{
    if (_ymmTextField.text.length < 4 || _xmmTextField.text.length < 4 || _qrxmmTextField.text.length < 4) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入不少于4位数字" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
        
    }else if ([_xmmTextField.text isEqualToString:_qrxmmTextField.text] == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"新密码与确认密码不符，请重新输入" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
    }else{
        NSMutableDictionary *diccct = [[NSMutableDictionary alloc] init];
        [diccct setValue:USER_ID(QQQQ) forKey:@"user_id"];
        [diccct setValue:_ymmTextField.text forKey:@"oldpwd"];
        [diccct setValue:_xmmTextField.text forKey:@"passwd"];
        [diccct setValue:_qrxmmTextField.text forKey:@"checkpwd"];
        [diccct setValue:_zhLabel.text forKey:@"mobile"];
        
        NSDictionary *dic = [PersonalRequest withAllUrll:@"/index.php?s=/Api/User/changepwd" WithDic:diccct];
        
        int status = [[dic valueForKey:@"status"] intValue];
//        NSLog(@"xiugaimima%@",dic);
        if (status == 0) {
//            NSLog(@"cg");
            [self tuichu];
        }else if (status == 1){
            YBMB([dic valueForKey:@"data"])
        }
    }
}

- (void)addCustomView
{
    UIView *xgmm = [[UIView alloc] initWithFrame:CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, 40*4)];
    xgmm.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:xgmm];
    
    for (int i = 0; i<5; i ++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/40, i*40, VIEW_FRAME_SIZE_WIDTH*0.95, 0.5)];
        if (iPhone6Plus) {
            lab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/40, i*55, VIEW_FRAME_SIZE_WIDTH*0.95, 0.5);
        }else if (iPhone6){
            lab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/40, i*48, VIEW_FRAME_SIZE_WIDTH*0.95, 0.5);

        }
        
        lab.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#f0f3f5"];
        [xgmm addSubview:lab];
    }
    
    //账号
    UILabel *zhLab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 5, 80, 30)];
    zhLab.text = @"账号";
    zhLab.textColor = [UIColor lightGrayColor];
    [zhLab setFont: [UIFont systemFontOfSize:20]];
    [xgmm addSubview:zhLab];
    
    _zhLabel = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/10 + 80, 5, 200, 30)];
    _zhLabel.text = @"1586699****";
    _zhLabel.textColor = [UIColor lightGrayColor];
    _zhLabel.textAlignment = NSTextAlignmentLeft;
    [xgmm addSubview:_zhLabel];
    
    //原密码
    UILabel *ymm = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 45, 80, 30)];
    ymm.text = @"原密码";
    ymm.textColor = [UIColor blackColor];
    [ymm setFont: [UIFont systemFontOfSize:20]];
    [xgmm addSubview:ymm];
    
    _ymmTextField = [[UITextField alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/10+80, 45, 200, 30)];
    _ymmTextField.placeholder = @"请填写原密码";
    _ymmTextField.secureTextEntry = YES;
    _ymmTextField.delegate = self;
    _ymmTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    [_ymmTextField setTextAlignment:NSTextAlignmentLeft];
    [xgmm addSubview:_ymmTextField];
    
    //新密码
    UILabel *xmm = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 85, 80, 30)];
    xmm.text = @"新密码";
    xmm.textColor = [UIColor blackColor];
    [xmm setFont: [UIFont systemFontOfSize:20]];
    [xgmm addSubview:xmm];
    
    _xmmTextField = [[UITextField alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/10+80, 85, 200, 30)];
    _xmmTextField.placeholder = @"请设置新密码";
    _xmmTextField.secureTextEntry = YES;
    _xmmTextField.delegate = self;
    _xmmTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    [_xmmTextField setTextAlignment:NSTextAlignmentLeft];
    [xgmm addSubview:_xmmTextField];
    
    //确认新密码
    UILabel *qrxmm = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 125, 80, 30)];
    qrxmm.text = @"确认密码";
    qrxmm.textColor = [UIColor blackColor];
    [qrxmm setFont: [UIFont systemFontOfSize:20]];
    [xgmm addSubview:qrxmm];
    
    _qrxmmTextField = [[UITextField alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/10+80, 125, 200, 30)];
    _qrxmmTextField.placeholder = @"请再次输入新密码";
    _qrxmmTextField.secureTextEntry = YES;
    _qrxmmTextField.delegate = self;
    _qrxmmTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    [_qrxmmTextField setTextAlignment:NSTextAlignmentLeft];
    [xgmm addSubview:_qrxmmTextField];
    
    if (iPhone6Plus) {
        xgmm.frame = CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, 55*4);
        
        zhLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 10, 80, 40);
        _zhLabel.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/10 + 80, 10, 200, 40);
        
        ymm.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 65, 80, 40);
        _ymmTextField.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/10+80, 65, 200, 40);
        
        xmm.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 120, 80, 40);
        _xmmTextField.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/10+80, 120, 200, 40);
        
        qrxmm.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 175, 80, 40);
        _qrxmmTextField.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/10+80, 175, 200, 40);
    }else if (iPhone6){
        
        xgmm.frame = CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, 50*4);
        
        zhLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 9, 80, 40);
        _zhLabel.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/10 + 80, 9, 200, 40);
        
        ymm.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 56, 80, 40);
        _ymmTextField.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/10+80, 56, 200, 40);
        
        xmm.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 104, 80, 40);
        _xmmTextField.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/10+80, 104, 200, 40);
        
        qrxmm.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 151, 80, 40);
        _qrxmmTextField.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/10+80, 151, 200, 40);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - UITextFielDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
    if ([string isEqualToString:@"\n"]) {
        [_qrxmmTextField resignFirstResponder];
        [_xmmTextField resignFirstResponder];
        [_ymmTextField resignFirstResponder];
        return NO;
    }
    
    if (textField == _ymmTextField || textField == _xmmTextField || textField == _qrxmmTextField) {
        if (range.location >= 16)
        {
            return NO;
        }
    }
    
    if (_ymmTextField.text.length > 3 && _xmmTextField.text.length > 3 &&_qrxmmTextField.text.length >= 3) {
        _rightButton.tintColor = [UIColor blackColor];
        [_rightButton setAction:@selector(changepwd)];
    }else{
        _rightButton.tintColor = [UIColor lightGrayColor];
        [_rightButton setAction:nil];
            }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_ymmTextField.text.length > 3 && _xmmTextField.text.length > 3 &&_qrxmmTextField.text.length >= 3) {
        _rightButton.tintColor = [UIColor blackColor];
        [_rightButton setAction:@selector(changepwd)];
        return YES;
        
    }else{
        return YES;
    }
}

- (void)RequestUserMobile
{
    [[BoolViewController alloc] testOut];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *userID = [userDefault objectForKey:@"user_id"];
    if ([userID isEqualToString:nil]) {
        
    }else{
        
        NSMutableDictionary *informationDic = [[NSMutableDictionary alloc] init];
        
        [informationDic setValue:userID forKey:@"user_id"];
        
//        NSLog(@"yonghuDIC-%@",informationDic);
        
        NSDictionary *dic = [PersonalRequest withAllUrll:@"/index.php?s=/Api/User/getinfo" WithDic:informationDic];
        
        int status = [[dic valueForKey:@"status"] intValue];
//        NSLog(@"yonghuxinxi--%d",status);
        if (status == 0) {
            
            NSDictionary *data = [dic valueForKey:@"data"];
//            NSLog(@"--%@",data);
            NSString *str = [data valueForKey:@"mobile"];
            _zhLabel.text = str;
            [HUD removeFromSuperview];
            
        } else if (status == 1) {
            [HUD removeFromSuperview];
            [[YBProgressShow defaultProgress] showText:@"请设置用户信息" InMode:MBProgressHUDModeDeterminate OriginViewEnableTouch:YES HideAfterDelayTime:2];
        }
    }
}

- (void)tuichu
{
    NSString *message = @"修改完成，请重新登录？";
    _messagealert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    [_messagealert show];
}

#pragma  mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (alertView == _messagealert) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        
        [ud removeObjectForKey:@"name"];
        [ud removeObjectForKey:@"user_id"];
        [ud removeObjectForKey:@"skey"];
        [ud synchronize];
        XMMViewController *xmmVC = [[XMMViewController alloc] init];
        
        [self presentViewController:xmmVC animated:YES completion:nil];
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

@end
