//
//  HeaderViewController.m
//  xiongmami
//
//  Created by iMac on 14/11/24.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "HeaderViewController.h"
#import "HexadecimalConversionUICOLOR.h"
#import "NIDropDown.h"

@interface HeaderViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation HeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的资料";
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0f green:239/255.0f blue:235/255.0f alpha:1];
    [self  addCustomView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(bback)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)bback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)addCustomView
{
    UIView *views = [[UIView alloc] initWithFrame:CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, 80)];
    views.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:views];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 4, 60, 30)];
    nameLab.text = @"昵称:";
    [nameLab setFont:[UIFont systemFontOfSize:20]];
    [views addSubview:nameLab];
    
     _NickNameTextField= [[UITextField alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20+60, 0, 200, 40)];
    _NickNameTextField.text = _NickName;
    [_NickNameTextField setTextColor:[UIColor lightGrayColor]];
    _NickNameTextField.placeholder = @"请输入昵称";
    _NickNameTextField.font = [UIFont systemFontOfSize:20];
    _NickNameTextField.delegate = self;
    [views addSubview:_NickNameTextField];
    
    UILabel *fengexianLab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 40, VIEW_FRAME_SIZE_WIDTH*0.9, 0.5)];
    [fengexianLab setBackgroundColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#f0f3f5"]];
    [views addSubview:fengexianLab];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 45, 60, 30)];
    lab.text = @"性别:";
    [lab setFont:[UIFont systemFontOfSize:20]];
    [views addSubview:lab];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 25,  50, 10, 20)];
    [image setImage:[UIImage imageNamed:@"箭头@3x.png"]];
    [views addSubview:image];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake([UIScreen  mainScreen].bounds.size.width - 125, 105, 80, 40);
    if ([_Sex intValue] == 0) {
        [_button setTitle:@"请选择" forState:UIControlStateNormal];
    }else{
        if ([_Sex intValue] == 1) {
            [_button setTitle:@"男" forState:UIControlStateNormal];
        }else{
            [_button setTitle:@"女" forState:UIControlStateNormal];
        }
        
    }
//    [_button setTitle:@"请选择" forState:UIControlStateNormal];
    
    [_button.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [_button.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [_button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(pushPickerView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    UIButton *tijiaoButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [tijiaoButton setTitle:@"保存" forState:UIControlStateNormal];
    [tijiaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tijiaoButton setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 180, VIEW_FRAME_SIZE_WIDTH*0.9, 40)];
    [tijiaoButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [tijiaoButton setBackgroundImage:[UIImage imageNamed:@"保存btn.png"] forState:UIControlStateNormal];
    [tijiaoButton addTarget:self action:@selector(tijiaoUserRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tijiaoButton];
    
    if (iPhone6Plus) {
        views.frame = CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, 110);
        
        nameLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 10, 60, 40);
        
        _NickNameTextField.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20+60, 4, 200, 55);
        
        fengexianLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 55, VIEW_FRAME_SIZE_WIDTH*0.9, 0.5);
        
        lab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 60, 60, 40);
        
        image.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 25,  70, 10, 20);
        
        _button.frame = CGRectMake([UIScreen  mainScreen].bounds.size.width - 125, 125, 80, 40);
        
        [tijiaoButton setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 225, VIEW_FRAME_SIZE_WIDTH*0.9, 154/3)];
    }else if (iPhone6){
        views.frame = CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, 50*2);
        
        nameLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 9, 60, 40);
        
        _NickNameTextField.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20+60, 9, 200, 40);
        
        fengexianLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 50, VIEW_FRAME_SIZE_WIDTH*0.9, 0.5);
        
        lab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 56, 60, 40);
        
        image.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 25,  64, 10, 20);
        
        _button.frame = CGRectMake([UIScreen  mainScreen].bounds.size.width - 125, 119, 80, 40);
    }
}

- (void)tijiao
{
    NSLog(@"保存");
}

- (void)xiala:(UIButton *)sender
{
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"男",@"女", nil];
    if(niDrop == nil) {
        CGFloat f = 40*[arr count];
        niDrop = [[NIDropDown alloc]showDropDown:_button :&f :arr];
        niDrop.delegate = self;
        //        _areaDrop.text = sender.titleLabel.text;
    }
    else {
        [niDrop hideDropDown:sender];
        [self rel];
    }
}

#pragma  mark - NIDropDelegate
- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel
{
    niDrop = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tijiaoUserRequest
{
    
    if (_NickNameTextField.text.length >6) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"昵称不能超过6个字符" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else if (_NickNameTextField.text.length == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入昵称" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
    }else if ([_button.titleLabel.text rangeOfString:@"请选择"].location !=NSNotFound){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择性别" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{
    [[BoolViewController alloc] testOut];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *userID = [userDefault objectForKey:@"user_id"];
    
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] init];
    
    [userDic setValue:_NickNameTextField.text forKey:@"nickname"];
        NSString *sex;
        if ([_button.titleLabel.text rangeOfString:@"男"].location !=NSNotFound) {
            sex = @"1";
        }else if ([_button.titleLabel.text rangeOfString:@"女"].location !=NSNotFound){
            sex = @"2";
        }
    [userDic setValue:sex forKey:@"sex"];
//        NSLog(@"yonghu--%@",_button.titleLabel.text);
        
    NSMutableDictionary *mutableDic =[[NSMutableDictionary alloc] init];
    [mutableDic setValue:userID forKey:@"user_id"];
    [mutableDic setValue:userDic forKey:@"field"];
    NSDictionary *dic = [PersonalRequest withAllUrll:@"/index.php?s=/Api/User/setinfo" WithDic:mutableDic];
//    NSLog(@"dic--%@",dic);
    NSInteger status = [[dic valueForKey:@"status"] intValue];
//    NSLog(@"yonghuxinxi--%ld",(long)status);
    if (status == 0) {
        [[YBProgressShow defaultProgress] showText:@"添加成功" InMode:MBProgressHUDModeDeterminate OriginViewEnableTouch:YES HideAfterDelayTime:1];
        
        [self.navigationController popViewControllerAnimated:YES];
    } else if (status == 1) {
        [[YBProgressShow defaultProgress] showText:[dic valueForKey:@"data"] InMode:MBProgressHUDModeDeterminate OriginViewEnableTouch:YES HideAfterDelayTime:1];
        [self.navigationController popViewControllerAnimated:YES];
    }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_NickNameTextField resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string isEqualToString:@"\n"]) {
        [_NickNameTextField resignFirstResponder];
        [niDrop hideDropDown:_button];
        return NO;
    }
    return YES;
}

#pragma  mark - UIPickerViewDataSource,UIPickerViewDelegate

- (void)pushPickerView
{
    _sex_Array =[[NSArray alloc] initWithObjects:@"男",@"女", nil];
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, VIEW_FRAME_SIZE_WIDTH, 216)];
    [_pickerView setBackgroundColor:[UIColor whiteColor]];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    
    LZWCustomActionSheet *actionSheet = [[LZWCustomActionSheet alloc] initWithView:_pickerView AndHeight:260];
    actionSheet.doneDelegate = self;
    [actionSheet showInView:self.view];
    [_NickNameTextField resignFirstResponder];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
//        NSLog(@"%lu",(unsigned long)_sex_Array.count);
    return _sex_Array.count;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //先根据component找到大数组中对应的小数组，然后根据row从小数组中找到对应的title
//    NSLog(@"--%@",[_sex_Array objectAtIndex:row]);
    return [_sex_Array objectAtIndex:row];
}

- (void)done
{
    NSInteger provinceRow = [_pickerView selectedRowInComponent:0];
    NSLog(@"--%ld",(long)provinceRow);
    [_button setTitle:[_sex_Array objectAtIndex:provinceRow] forState:UIControlStateNormal];
    [_pickerView reloadAllComponents];
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
