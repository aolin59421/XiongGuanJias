//
//  YJFKViewController.m
//  xiongmami
//
//  Created by iMac on 14/11/24.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "YJFKViewController.h"
#import "XMTextViewPlaceHolder.h"
#import "HexadecimalConversionUICOLOR.h"

@interface YJFKViewController ()
{
    UIButton *_fankuileixingButton;
    XMTextViewPlaceHolder *_fankuiTextField;

}
@end

@implementation YJFKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addCustomView];

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(bback)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)bback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addCustomView
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 75, VIEW_FRAME_SIZE_WIDTH*0.9, 60)];
    lab.text = @"亲，使用我们的服务有什么意见和建议请赐教！";
    lab.numberOfLines = 0 ;
    [lab setFont:[UIFont systemFontOfSize:17]];
    [self.view addSubview:lab];
    
     _fankuileixingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_fankuileixingButton setFrame: CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 140, VIEW_FRAME_SIZE_WIDTH*0.9, 40)];
    [_fankuileixingButton setTitle:@" 请选择你反馈的类型" forState:UIControlStateNormal];
    [_fankuileixingButton  setBackgroundImage:[UIImage imageNamed:@"反馈类型@3x.png"] forState:UIControlStateNormal];
    [_fankuileixingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_fankuileixingButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_fankuileixingButton addTarget:self action:@selector(pushPickerView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_fankuileixingButton];
    
    _fankuiTextField = [[XMTextViewPlaceHolder alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 190, VIEW_FRAME_SIZE_WIDTH*0.9, 120)];
    _fankuiTextField.placeholderFont = @"17";
    _fankuiTextField.placeholder = @"请小主提笔！";
    _fankuiTextField.layer.borderWidth = 0.1f;
    _fankuiTextField.layer.cornerRadius = 9.0f;
    _fankuiTextField.layer.masksToBounds = YES;
    _fankuiTextField.layer.backgroundColor = [UIColor colorWithRed:214/255.0f green:219/255.0f blue:223/255.0f alpha:1.0f].CGColor;
    _fankuiTextField.delegate = self;
    _fankuiTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_fankuiTextField];
    
    UIButton *TJButton = [UIButton buttonWithType:UIButtonTypeCustom];
    TJButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 330, VIEW_FRAME_SIZE_WIDTH*0.9, 40);
    [TJButton  setBackgroundImage:[UIImage imageNamed:@"保存btn.png"] forState:UIControlStateNormal];
    [TJButton setTitle:@"提交" forState:UIControlStateNormal];
    [TJButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [TJButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [TJButton addTarget:self action:@selector(TJ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:TJButton];
    if (iPhone6Plus) {
        
        [_fankuileixingButton setFrame: CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 140, VIEW_FRAME_SIZE_WIDTH*0.9, 55)];
        _fankuiTextField.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 205, VIEW_FRAME_SIZE_WIDTH*0.9, 120);
        
        TJButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 350, VIEW_FRAME_SIZE_WIDTH*0.9, 55);
    }else if (iPhone6){
        _fankuiTextField.layer.borderWidth = 0.5;
        _fankuiTextField.layer.cornerRadius = 5.0f;
        
        [_fankuileixingButton setFrame: CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 140, VIEW_FRAME_SIZE_WIDTH*0.9, 50)];
        _fankuiTextField.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 200, VIEW_FRAME_SIZE_WIDTH*0.9, 120);
        
        TJButton.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 350, VIEW_FRAME_SIZE_WIDTH*0.9, 55);
    }
    
}

#pragma  mark - 提交
- (void)TJ
{
//    NSLog(@"提交");
    NSString *fankuiStr;
    if ([_fankuileixingButton.titleLabel.text rangeOfString:@" 洗衣质量"].location !=NSNotFound) {
        fankuiStr = @"1";
    }else if ([_fankuileixingButton.titleLabel.text rangeOfString:@" 服务态度"].location !=NSNotFound)
    {
        fankuiStr = @"2";
    }else if ([_fankuileixingButton.titleLabel.text rangeOfString:@" 物流速度"].location !=NSNotFound)
    {
        fankuiStr = @"3";
    }else if ([_fankuileixingButton.titleLabel.text rangeOfString:@" 付款便捷性"].location !=NSNotFound){
        fankuiStr = @"4";
        
    }else if ([_fankuileixingButton.titleLabel.text rangeOfString:@" 其他"].location !=NSNotFound){
        fankuiStr = @"5";
    }
    
    if (_fankuiTextField.text.length <=0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"反馈内容为空，请写入反馈内容后提交！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }else{
        [[BoolViewController alloc] testOut];
        NSDictionary *dic = [PersonalRequest withURLStr:@"/index.php?s=/Api/User/feedback" withSetValue:USER_ID(QQQQ) withSetValue:fankuiStr withSetValue:_fankuiTextField.text withSetValue:nil withForKey:@"user_id" withForKey:@"feed_type" withForKey:@"content" withForKey:nil];
        int status = [[dic valueForKey:@"status"] intValue];
        //    NSLog(@"=-=+++%@",dic);
        if (status == 0) {
            
            YBMB(@"提交成功")
            [self.navigationController popViewControllerAnimated:YES];
            
            
        } else if (status == 1) {
            YBMB([dic valueForKey:@"data"])
            
        }
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_fankuiTextField resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [_fankuiTextField resignFirstResponder];
        
        return NO;
    }
    return YES;
}

#pragma  mark -  UIPickerViewDataSource,UIPickerViewDelegate
- (void)pushPickerView
{
    _yjfkArray =[[NSArray alloc] initWithObjects:@" 洗衣质量",@" 服务态度",@" 物流速度",@" 付款便捷性",@" 其他", nil];
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, VIEW_FRAME_SIZE_WIDTH, 216)];
    [_pickerView setBackgroundColor:[UIColor whiteColor]];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    
    LZWCustomActionSheet *actionSheet = [[LZWCustomActionSheet alloc] initWithView:_pickerView AndHeight:260];
    actionSheet.doneDelegate = self;
    [actionSheet showInView:self.view];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
//    NSLog(@"%lu",(unsigned long)_yjfkArray.count);
    return _yjfkArray.count;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //先根据component找到大数组中对应的小数组，然后根据row从小数组中找到对应的title
//    NSLog(@"--%@",[_yjfkArray objectAtIndex:row]);
    return [_yjfkArray objectAtIndex:row];
}

//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//    [pickerView reloadAllComponents];
//    if (component == 0) {
//        [pickerView selectRow:0 inComponent:1 animated:YES];
//    }
//}

- (void)done
{
    NSInteger provinceRow = [_pickerView selectedRowInComponent:0];
//    NSLog(@"--%ld",(long)provinceRow);
    [_fankuileixingButton setTitle:[_yjfkArray objectAtIndex:provinceRow] forState:UIControlStateNormal];
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
