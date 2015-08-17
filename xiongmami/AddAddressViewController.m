//
//  AddAddressViewController.m
//  xiongmami
//
//  Created by iMac on 14/11/19.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "AddAddressViewController.h"


@interface AddAddressViewController ()
@end

@implementation AddAddressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加地址";
    [self addAddress];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];
//    NSLog(@"用户名字%@",_nameTextFieldField);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(bback)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}
- (void)bback
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma  mark - 添加地址信息
- (void)addAddress
{
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 74, VIEW_FRAME_SIZE_WIDTH/4,40)];
    nameLab.text = @"姓名";
    [nameLab setTextColor:[UIColor blackColor]];
    [nameLab setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:nameLab];
    
    UILabel *fengexian = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 114, VIEW_FRAME_SIZE_WIDTH*0.9, 0.5)];
    fengexian.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#d9dee1" ] ;
    [self.view addSubview:fengexian];
    
    UILabel *fengexian1 = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 164, VIEW_FRAME_SIZE_WIDTH*0.9, 0.5)];
    fengexian1.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#d9dee1" ] ;
    [self.view addSubview:fengexian1];
    
    UILabel *fengexian2 = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 214, VIEW_FRAME_SIZE_WIDTH*0.9, 0.5)];
    fengexian2.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#d9dee1" ] ;
    [self.view addSubview:fengexian2];
    
    UILabel *fengexian3 = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 264, VIEW_FRAME_SIZE_WIDTH*0.9, 0.5)];
    fengexian3.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#d9dee1" ] ;
    [self.view addSubview:fengexian3];
    
    UILabel *fengexian4 = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 314, VIEW_FRAME_SIZE_WIDTH*0.9, 0.5)];
    fengexian4.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#d9dee1" ] ;
    [self.view addSubview:fengexian4];
    
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(nameLab.frame.size.width+30, 74, nameLab.frame.size.width*2.5, 40)];
    [_nameTextField setTextColor:[UIColor lightGrayColor]];
    _nameTextField.delegate= self;
    if (!_bianjidizhi) {
        [_nameTextField setPlaceholder:@"请填写姓名"];
    }else{
//        NSLog(@"%@",_nameTextFieldField);
        [_nameTextField setText:_nameTextFieldField];
    }
    _nameTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_nameTextField];
    
    UILabel *numberLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 124, VIEW_FRAME_SIZE_WIDTH/4,40)];
    numberLab.text = @"手机号码";
    [numberLab setTextColor:[UIColor blackColor]];
    [numberLab setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:numberLab];
    
    _numberTextField = [[UITextField alloc] initWithFrame:CGRectMake(nameLab.frame.size.width+30, 124, nameLab.frame.size.width*2.5, 40)];
    [_numberTextField setTextColor:[UIColor lightGrayColor]];
    if (!_bianjidizhi) {
        [_numberTextField setPlaceholder:@"请填写手机号码"];
    } else{
        [_numberTextField setText:_numberTextFieldField];
    }
    
    _numberTextField.delegate = self;
    _numberTextField.layer.cornerRadius = 0.9f;
    _numberTextField.returnKeyType = UIReturnKeyDone;
    _numberTextField.keyboardType = UIKeyboardTypePhonePad;
    _numberTextField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_numberTextField];
    
    UILabel *cityLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, VIEW_FRAME_SIZE_WIDTH/4,40)];
    cityLab.text = @"选择城市";
    [cityLab setTextColor:[UIColor blackColor]];
    [cityLab setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:cityLab];
    
    UIImageView *cityImage = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 20, 179, 10, 20)];
    [cityImage setImage:[UIImage imageNamed:@"箭头@3x.png"]];
    [self.view addSubview:cityImage];
    
     _xzcsButton= [UIButton buttonWithType:UIButtonTypeCustom];
    _xzcsButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 130, 170, 100, 40);
    if (!_bianjidizhi) {
        [_xzcsButton setTitle:@"城市" forState:UIControlStateNormal];
    }else{
        [_xzcsButton setTitle:@"杭州市" forState:UIControlStateNormal];
    }
    [_xzcsButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_xzcsButton setBackgroundColor:[UIColor whiteColor]];
    _xzcsButton.tag = 100;
    [_xzcsButton addTarget:self action:@selector(xuanze:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_xzcsButton];
    
    UILabel *areaLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 219, VIEW_FRAME_SIZE_WIDTH/4,40)];
    areaLab.text = @"获取区域";
    [areaLab setTextColor:[UIColor blackColor]];
    [areaLab setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:areaLab];
    
    UIImageView *areaImage = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 20, 229, 10, 20)];
    [areaImage setImage:[UIImage imageNamed:@"箭头@3x.png"]];
    [self.view addSubview:areaImage];
   
     _xzqyButton= [UIButton buttonWithType:UIButtonTypeCustom];
    _xzqyButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 130, 219, 100, 40);
    if (!_bianjidizhi) {
        [_xzqyButton setTitle:@"区域" forState:UIControlStateNormal];
    }else {
        [_xzqyButton setTitle:[NSString stringWithFormat:@"%@",_area] forState:UIControlStateNormal];
    }
    
    [_xzqyButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_xzqyButton setBackgroundColor:[UIColor whiteColor]];
    [_xzqyButton addTarget:self action:@selector(xuanzequyu:) forControlEvents:UIControlEventTouchUpInside];
    _xzqyButton.tag = 1000;
    [self.view addSubview:_xzqyButton];
    
    
    UILabel *addressLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 269, VIEW_FRAME_SIZE_WIDTH/4,40)];
    addressLab.text = @"详细地址";
    [addressLab setTextColor:[UIColor blackColor]];
    [addressLab setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:addressLab];
    
    _textView = [[UITextField alloc] initWithFrame:CGRectMake(nameLab.frame.size.width+30, 269, nameLab.frame.size.width*2.5, 40)];
    if (_textViewView == nil || _textViewView == NULL) {
        _textView.placeholder = @"请输入详细地址";
    }else{
        _textView.text = _textViewView;
    }
    [_textView setTextColor:[UIColor lightGrayColor]];
    _textView.font = [UIFont systemFontOfSize:17];
    _textView.delegate =self;
    _textView.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_textView];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 350, VIEW_FRAME_SIZE_WIDTH*0.9, 40)];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"保存btn.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(postAddressData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    if (iPhone6Plus) {
        [button setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 350, VIEW_FRAME_SIZE_WIDTH*0.9, 154/3)];
    }
}

#pragma  mark - 添加
- (void)postAddressData
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *userID = [userDefault objectForKey:@"user_id"];
    [[BoolViewController alloc] testOut];

    if ([_nameTextField.text isEqualToString:nil] || [_numberTextField.text isEqualToString:nil] || [_textView.text isEqualToString:nil] || [_xzcsButton.titleLabel.text isEqualToString:@"城市"] || [_xzcsButton.titleLabel.text isEqualToString:nil] || [_xzqyButton.titleLabel.text isEqualToString:@"区域"] || [_xzqyButton.titleLabel.text isEqualToString:nil] || _nameTextField.text == nil || _nameTextField.text == NULL || _nameTextField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请正确输入信息" delegate:self cancelButtonTitle:@"重新编辑" otherButtonTitles: nil];
        [alert show];
    } else if (_nameTextField.text.length > 6){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正常姓名" delegate:self cancelButtonTitle:@"重新编辑" otherButtonTitles: nil];
        [alert show];
        
    } else if (_textView.text.length <= 4){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入详细地址" delegate:self cancelButtonTitle:@"重新编辑" otherButtonTitles: nil];
        [alert show];
        
    }else if (_bianjidizhi != nil || _bianjidizhi != NULL){
        
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = @"加载中";
        [HUD show:YES];
        //编辑地址
        NSMutableDictionary *diiict = [[NSMutableDictionary alloc] init];
        [diiict setValue:_nameTextField.text forKey:@"username"];
        [diiict setValue:_numberTextField.text forKey:@"mobile"];
        [diiict setValue:_textView.text forKey:@"address"];
        [diiict setValue:userID forKey:@"user_id"];
        [diiict setValue:_xzcsButton.titleLabel.text forKey:@"city"];
        [diiict setValue:_xzqyButton.titleLabel.text forKey:@"area_name"];
        [diiict setValue:_bianjidizhi forKey:@"addr_id"];
        
        NSDictionary *dic = [PersonalRequest withAllUrll:@"/index.php?s=/Api/Address/edit" WithDic:diiict];
        
        NSInteger status = [[dic valueForKey:@"status"] intValue];
//        NSLog(@"status-%ld,data-%@",(long)status,[dic valueForKey:@"data"]);
        
        if (status == 0) {
            [HUD removeFromSuperview];
            [[YBProgressShow defaultProgress] showText:@"保存成功" InMode:MBProgressHUDModeDeterminate OriginViewEnableTouch:YES HideAfterDelayTime:1];
            [self.navigationController popViewControllerAnimated:YES];
        }else if (status == 1){
            [HUD removeFromSuperview];
            [[YBProgressShow defaultProgress] showText:[dic valueForKey:@"data"] InMode:MBProgressHUDModeDeterminate OriginViewEnableTouch:YES HideAfterDelayTime:1];
        }
    } else {
        
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = @"加载中";
        [HUD show:YES];
        //添加地址
        NSMutableDictionary *diiict = [[NSMutableDictionary alloc] init];
        [diiict setValue:_nameTextField.text forKey:@"username"];
        [diiict setValue:_numberTextField.text forKey:@"mobile"];
        [diiict setValue:_textView.text forKey:@"address"];
        [diiict setValue:userID forKey:@"user_id"];
        [diiict setValue:_xzcsButton.titleLabel.text forKey:@"city"];
        [diiict setValue:_xzqyButton.titleLabel.text forKey:@"area_name"];
        
        NSDictionary *dic = [PersonalRequest withAllUrll:@"/index.php?s=/Api/Address/add" WithDic:diiict];
        
        NSInteger status = [[dic valueForKey:@"status"] intValue];
        NSLog(@"status-%ld,data-%@",(long)status,[dic valueForKey:@"data"]);
        
        if (status == 0) {
            [HUD removeFromSuperview];
            [[YBProgressShow defaultProgress] showText:@"保存成功" InMode:MBProgressHUDModeDeterminate OriginViewEnableTouch:YES HideAfterDelayTime:1];
            [self.navigationController popViewControllerAnimated:YES];
        }else if (status == 1){
            [HUD removeFromSuperview];
            [[YBProgressShow defaultProgress] showText:[dic valueForKey:@"data"] InMode:MBProgressHUDModeDeterminate OriginViewEnableTouch:YES HideAfterDelayTime:1];
        }
    }
}

- (void)xuanze:(UIButton *)sender
{
    _city_area_Bool = NO;
    _city_Array = [[NSArray alloc] initWithObjects:@"杭州市", nil];
    [_area_Picker removeFromSuperview];
    _city_Picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 216)];
    [_city_Picker setBackgroundColor:[UIColor whiteColor]];
    _city_Picker.dataSource = self;
    _city_Picker.delegate = self;
    
    LZWCustomActionSheet *actionSheet = [[LZWCustomActionSheet alloc] initWithView:_city_Picker AndHeight:260];
    actionSheet.doneDelegate = self;
    [actionSheet showInView:self.view];
}

#pragma  mark - UIPickerViewDelegate & UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    //    NSLog(@"%@",[_zongArray objectAtIndex:component]);
    if (pickerView == _city_Picker) {
        return _city_Array.count;
    }else{
        return _area_Array.count;
    }
    
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //先根据component找到大数组中对应的小数组，然后根据row从小数组中找到对应的title
    if (pickerView == _city_Picker) {
        return _city_Array[row];
    }else{
        return _area_Array[row];
    }
}

- (void)xuanzequyu:(UIButton *)sender
{
    _city_area_Bool =YES;
    _area_Array = [[NSArray alloc] initWithObjects:@"西湖区",@"江干区",@"拱墅区",@"上城区",@"下城区", nil];
    [_city_Picker removeFromSuperview];
    _area_Picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 216)];
    [_area_Picker setBackgroundColor:[UIColor whiteColor]];
    _area_Picker.dataSource = self;
    _area_Picker.delegate = self;
    
    LZWCustomActionSheet *actionSheet = [[LZWCustomActionSheet alloc] initWithView:_area_Picker AndHeight:260];
    actionSheet.doneDelegate = self;
    [actionSheet showInView:self.view];
}

#pragma  mark - UITextFiel&UITextViewdDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == _numberTextField) {
        if (range.location >= 11)
        {
            return NO;
        }
    }
    
    if ([string isEqualToString:@"\n"]) {
        [_numberTextField resignFirstResponder];
        [_nameTextField resignFirstResponder];
        [_textView resignFirstResponder];
        return NO;
    }
    
    NSCharacterSet *cs;
    if(textField == _numberTextField)
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_nameTextField resignFirstResponder];
    [_numberTextField resignFirstResponder];
    [_textView resignFirstResponder];
}

#pragma  mark -  选择时间触发方法
- (void)done
{
    if (_city_area_Bool == NO) {
        NSInteger provinceRow = [_city_Picker selectedRowInComponent:0];
        //    NSInteger city = [_city_Picker selectedRowInComponent:1];
        [_xzcsButton setTitle:[_city_Array objectAtIndex:provinceRow] forState:UIControlStateNormal];
//        NSLog(@"---%@",[_city_Array objectAtIndex:provinceRow]);
        [_city_Picker reloadAllComponents];
    }else if (_city_area_Bool == YES){
        NSInteger provinceRow = [_area_Picker selectedRowInComponent:0];
        [_area_Picker reloadAllComponents];
        //    NSInteger city = [_city_Picker selectedRowInComponent:1];
        [_xzqyButton setTitle:[_area_Array objectAtIndex:provinceRow] forState:UIControlStateNormal];
//        NSLog(@"---%@",[_area_Array objectAtIndex:provinceRow]);
    }
}
@end
