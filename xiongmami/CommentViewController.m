//
//  CommentViewController.m
//  xiongmami
//
//  Created by iMac on 15/5/4.
//  Copyright (c) 2015年 杭州熊管佳电子商务有限公司. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"发表评论";
    [self customView];
    self.view.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#f8f3f0"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(bback)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //推送设置
    UILabel *navLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 64)];
    navLab.backgroundColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];
    navLab.text = @"\n发表评论";
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
}

- (id)initWithBlock:(XGJCommertBlock)dic
{
    self = [super init];
    if(self)
    {
        user_Block = dic;
    }
    return self;
}

- (void)back:(UIButton *)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)bback
{
    //设置block传值内容
    if (user_Block) {
        user_Block(nil);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)customView
{
    //订单编号
//    NSLog(@"\n%@\n%@",_numberText,_overOrderTime);
    _orderNum.text = [NSString stringWithFormat:@"订单编号：%@",_numberText];
    if (_overOrderTime) {
        _overTime.text = [NSString stringWithFormat:@"完成时间：%@",[self getOrderDate:_overOrderTime]];
    }else{
        _overTime.text = [NSString stringWithFormat:@"完成时间：%@",_orderOverTime];
    }
    
    //设置文本编辑框不可被点击不可滑动
//    [_textField_wenben setEditable:NO];
//    [_textField_wenben setScrollEnabled:NO];
    
    //设置文本编辑框
    _textPlace = [[XMTextViewPlaceHolder alloc] initWithFrame:CGRectMake(15,423, VIEW_FRAME_SIZE_WIDTH-30, 54)];
    _textPlace.placeholderFont = @"13";
    _textPlace.placeholder = @" 说两句吧～";
    _textPlace.layer.borderWidth = 0.1f;
    _textPlace.layer.cornerRadius = 5.0f;
    _textPlace.layer.masksToBounds = YES;
    _textPlace.layer.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#e7e7e7"].CGColor;
    _textPlace.delegate = self;
    _textPlace.returnKeyType = UIReturnKeyDone;
    if (iPhone6) {
        _textPlace.frame = CGRectMake(15,423, VIEW_FRAME_SIZE_WIDTH-30, 100);
        _textPlace.layer.borderWidth = 0;
    }
    
    if (iPhone6Plus) {
        _textPlace.frame = CGRectMake(15,423, VIEW_FRAME_SIZE_WIDTH-30, 140);
        _textPlace.layer.borderWidth = 0;
    }
    [self.view addSubview:_textPlace];
    
    
    //设置视图描边
    [_topView setBackgroundColor:[UIColor whiteColor]];
    _topView.layer.borderColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#e7e7e7"].CGColor;
    _topView.layer.borderWidth = 0.5;
    
    [_downView setBackgroundColor:[UIColor whiteColor]];
    _downView.layer.borderColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#e7e7e7"].CGColor;
    _downView.layer.borderWidth = 0.5;
//    _downView.frame = CGRectMake(0, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);
    
    ///////修改文字颜色
    _stateLab.textColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#ed6d43"];
    _overTime.textColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"];
    _orderNum.textColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"];
    youorderover.textColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#ed6d43"];
    orderstate.textColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"];
    quyimanyidu.textColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"];
    chaping1.textColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"];
    zhongping1.textColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"];
    haoping1.textColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"];
    songyimanyidu.textColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"];
    chaping2.textColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"];
    zhongping2.textColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"];
    haoping2.textColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"];
    xiyizhiliangmanyidu.textColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"];
    chaping3.textColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"];
    haoping3.textColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"];
    zhongping3.textColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"];
    
    _fengexian = [[UILabel alloc] initWithFrame:CGRectMake(15, 84, 290, 0.5f)];
    _fengexian.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#f0f3f5"];
    [_downView addSubview:_fengexian];
    //////////文本5元变色
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"亲爱的熊宝，本次洗衣服务已完成，请对我们的洗衣质量和闪电熊的取送速度做个小小的评价，评价后最高可得5元红包哦。"];
//    NSLog(@"%ld",(long)[str length]);
    [str addAttribute:NSForegroundColorAttributeName value:[HexadecimalConversionUICOLOR colorWithHexString:@"#ed6d43"] range:NSMakeRange(49,2)];
    [str addAttribute:NSForegroundColorAttributeName value:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"] range:NSMakeRange(0,49)];
    [str addAttribute:NSForegroundColorAttributeName value:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"] range:NSMakeRange(51,4)];
    
    //设置lab行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];//调整行间距
    NSString *sssstttrrr= @"亲爱的熊宝，本次洗衣服务已完成，请对我们的洗衣质量和闪电熊的取送速度做个小小的评价，评价后最高可得5元红包哦。";
    [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [sssstttrrr length])];
    __textLab.adjustsFontSizeToFitWidth = YES;
    __textLab.attributedText = str;
    [__textLab sizeToFit];
    //设置标签
    [__textLab setNumberOfLines:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 时间戳转化
- (NSString *)getOrderDate:(NSString *)str
{
    int value = [str intValue];
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:value];
        NSString *timeString = [NSString stringWithFormat:@"%@",confromTimesp];
//    NSDate * dt = [NSDate dateWithTimeIntervalSince1970:value];
//    NSDateFormatter * df = [[NSDateFormatter alloc] init];
//    [df setDateFormat:@"yyyy年MM月dd日HH点mm分"];
//    NSString *regStr = [df stringFromDate:dt];
//    NSLog(@"时间戳转化  = %@",timeString);
    
    timeString =[timeString stringByReplacingOccurrencesOfString:@"+0000" withString:@""];
    return timeString;
}

#pragma  mark - UITextViewDelegete
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textPlace resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [_textPlace resignFirstResponder];
        
        return NO;
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"点击开始");
    [self.view setFrame:CGRectMake(0, -100, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT)];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"点击结束");
    [self.view setFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT)];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma  mark - 评论按钮
- (IBAction)quyimanyidu:(UIButton *)sender {
//    NSLog(@"1--%ld",(long)sender.tag);
    switch (sender.tag) {
        case 1:
        {
            [_quyi_chaping setImage:[UIImage imageNamed:@"bstar.png"]];
            [_quyi_zhongping setImage:[UIImage imageNamed:@"star.png"]];
            [_quyi_haoping setImage:[UIImage imageNamed:@"star.png"]];
            _quyi_manyidu = @"-1";
        }
            break;
        case 2:
        {
            [_quyi_chaping setImage:[UIImage imageNamed:@"star.png"]];
            [_quyi_zhongping setImage:[UIImage imageNamed:@"gstar.png"]];
            [_quyi_haoping setImage:[UIImage imageNamed:@"star.png"]];
            _quyi_manyidu = @"0";
        }
            break;
        case 3:
        {
            [_quyi_chaping setImage:[UIImage imageNamed:@"star.png"]];
            [_quyi_zhongping setImage:[UIImage imageNamed:@"star.png"]];
            [_quyi_haoping setImage:[UIImage imageNamed:@"rstar.png"]];
            _quyi_manyidu = @"1";
        }
            break;
            
        default:
            break;
    }
}
- (IBAction)songyi:(UIButton *)sender {
//    NSLog(@"2--%ld",(long)sender.tag);
    switch (sender.tag) {
        case 1:
        {
            [_songyi_chaping setImage:[UIImage imageNamed:@"bstar.png"]];
            [_songyi_zhongping setImage:[UIImage imageNamed:@"star.png"]];
            [_songyi_haoping setImage:[UIImage imageNamed:@"star.png"]];
            _songyi_manyidu = @"-1";
        }
            break;
        case 2:
        {
            [_songyi_chaping setImage:[UIImage imageNamed:@"star.png"]];
            [_songyi_zhongping setImage:[UIImage imageNamed:@"gstar.png"]];
            [_songyi_haoping setImage:[UIImage imageNamed:@"star.png"]];
            _songyi_manyidu = @"0";
        }
            break;
        case 3:
        {
            [_songyi_chaping setImage:[UIImage imageNamed:@"star.png"]];
            [_songyi_zhongping setImage:[UIImage imageNamed:@"star.png"]];
            [_songyi_haoping setImage:[UIImage imageNamed:@"rstar.png"]];
            _songyi_manyidu = @"1";
        }
            break;
            
        default:
            break;
    }
    
}
- (IBAction)xiyi:(UIButton *)sender {
//    NSLog(@"3--%ld",(long)sender.tag);
    switch (sender.tag) {
        case 1:
        {
            [_xiyi_chaping setImage:[UIImage imageNamed:@"bstar.png"]];
            [_xiyi_zhongping setImage:[UIImage imageNamed:@"star.png"]];
            [_xiyi_haoping setImage:[UIImage imageNamed:@"star.png"]];
            _xiyizhiliang_manyidu = @"-1";
        }
            break;
        case 2:
        {
            [_xiyi_chaping setImage:[UIImage imageNamed:@"star.png"]];
            [_xiyi_zhongping setImage:[UIImage imageNamed:@"gstar.png"]];
            [_xiyi_haoping setImage:[UIImage imageNamed:@"star.png"]];
            _xiyizhiliang_manyidu = @"0";
        }
            break;
        case 3:
        {
            [_xiyi_chaping setImage:[UIImage imageNamed:@"star.png"]];
            [_xiyi_zhongping setImage:[UIImage imageNamed:@"star.png"]];
            [_xiyi_haoping setImage:[UIImage imageNamed:@"rstar.png"]];
            _xiyizhiliang_manyidu = @"1";
        }
            break;
            
        default:
            break;
    }
}
#pragma  mark - 提交评论

- (IBAction)submit:(UIButton *)sender {
    
    if (_xiyizhiliang_manyidu == nil||_quyi_manyidu==nil||_songyi_manyidu == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请完成评价！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{
        NSLog(@"评论！");
        [self requestForSubmitState];
        
    }
}

- (void)requestForSubmitState
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:USER_ID(QQQQ) forKey:@"user_id"];
    [dic setValue:_numberText forKey:@"order_id"];
    [dic setValue:_quyi_manyidu forKey:@"courier_get"];
    [dic setValue:_songyi_manyidu forKey:@"courier_send"];
    [dic setValue:_xiyizhiliang_manyidu forKey:@"wash"];
    [dic setValue:_textPlace.text forKey:@"content"];
//    NSLog(@"DICICICICICI---%@",dic);
    
    [PerAFNetBlockRequest AFNRequest:@"/index.php?s=/Api/Order/judge" dic:dic AFNBlock:^(NSDictionary *resp, NSStringEncoding encoding) {
        NSLog(@"====%@",resp);
        if ([[resp valueForKey:@"status"] integerValue] == 0) {
            NSString *asd = [resp valueForKey:@"data"];
            NSLog(@"resp-%@",asd);
            _ok_Alert = [[UIAlertView alloc] initWithTitle:@"提示" message:asd delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [_ok_Alert show];
        }else{
            NSString *asd = [resp valueForKey:@"data"];
            NSLog(@"resp-%@",asd);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:asd delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    } AFNEror:^(NSError *error) {
        NSLog(@"error-%@",error);
    }];
}

#pragma  mark - 提示框
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _ok_Alert) {
        if (buttonIndex == 0) {
            //设置block传值内容
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:@"yes" forKey:@"yes"];
            
            if (user_Block) {
                user_Block(dic);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
