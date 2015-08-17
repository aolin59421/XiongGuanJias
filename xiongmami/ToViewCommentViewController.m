//
//  ToViewCommentViewController.m
//  xiongmami
//
//  Created by iMac on 15/5/4.
//  Copyright (c) 2015年 杭州熊管佳电子商务有限公司. All rights reserved.
//

#import "ToViewCommentViewController.h"

@interface ToViewCommentViewController ()

@end

@implementation ToViewCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"查看评论";
    self.view.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#f8f3f0"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(bback)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self customView];
    [self request];
}

- (void)bback
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark - customView
- (void)customView
{
//    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 120, VIEW_FRAME_SIZE_WIDTH-30, 0.5f)];
//    lab.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#f0f3f5"];
//    [_downView addSubview:lab];
    
    //字体颜色
    [_pinglun setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#ed6d43"]];
    [_over_time setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"]];
    [_xiyizhiliang setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"]];
    [songyimanyidu setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"]];
    [_quyimanyidu setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"]];
    [_chaping setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"]];
    [_zhongping setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"]];
    [_gaoping setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"]];
    [_orderNum setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"]];
    [_pinflunneirong setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"]];
    
    //订单编号
//    NSLog(@"\\\\\\n%@",_numberText);
    _orderNum.text = [NSString stringWithFormat:@"订单编号：%@",_numberText];
    
    //设置行间距
    //设置lab行间距
    NSMutableAttributedString *attronitedString = [[NSMutableAttributedString alloc] initWithString:_pinflunneirong.text];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];//调整行间距
    NSString *sssstttrrr= @"评论内容：洗得不是很干净，不过价格相对其他行业很划算，需要继续努力！";
    [attronitedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [sssstttrrr length])];
    _pinflunneirong.adjustsFontSizeToFitWidth = YES;
    _pinflunneirong.attributedText = attronitedString;
    [_pinflunneirong sizeToFit];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma  mark - request
- (void)request
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:USER_ID(QQQQ) forKey:@"user_id"];
    [dic setValue:_numberText forKey:@"order_id"];
    [PerAFNetBlockRequest AFNRequest:@"/index.php?s=/Api/Order/getcomment" dic:dic AFNBlock:^(NSDictionary *resp, NSStringEncoding encoding) {
//        NSLog(@"asdasdasdasd\n%@",resp);
        [self getDataWithComment:resp];
    } AFNEror:^(NSError *error) {
        NSLog(@"error");
    }];
}

- (void)getDataWithComment:(NSDictionary *)resp
{
    if ([[resp valueForKey:@"status"] integerValue] == 0) {
        //评论时间
        _over_time.text = [NSString stringWithFormat:@"评价时间：%@",[self getOrderDate:[[resp valueForKey:@"data"] valueForKey:@"ctime"]]];
        //物流取件
        switch ([[[resp valueForKey:@"data"] valueForKey:@"coyrier_get"] integerValue]) {
            case -1:
            {
                [_chaping_image setImage:[UIImage imageNamed:@"bstar.png"]];
                _chaping.text = @"差评";
            }
                
                break;
            case 0:
            {
                [_chaping_image setImage:[UIImage imageNamed:@"gstar.png"]];
                _chaping.text = @"中评";
            }
                
                break;
            case 1:
            {
                [_chaping_image setImage:[UIImage imageNamed:@"rstar.png"]];
                _chaping.text = @"好评";
            }
                
                break;
                
            default:
                break;
        }
        
        //物流送件
        switch ([[[resp valueForKey:@"data"] valueForKey:@"courier_send"] integerValue]) {
            case -1:
            {
                [_zhongping_image setImage:[UIImage imageNamed:@"bstar.png"]];
                _zhongping.text = @"差评";
            }
                
                break;
            case 0:
            {
                [_zhongping_image setImage:[UIImage imageNamed:@"gstar.png"]];
                _zhongping.text = @"中评";
            }
                
                break;
            case 1:
            {
                [_zhongping_image setImage:[UIImage imageNamed:@"rstar.png"]];
                _zhongping.text = @"好评";
            }
                
                break;
                
            default:
                break;
        }
        
        //洗衣质量
        switch ([[[resp valueForKey:@"data"] valueForKey:@"wash"] integerValue]) {
            case -1:
            {
                [_haoping_image setImage:[UIImage imageNamed:@"bstar.png"]];
                _gaoping.text = @"差评";
            }
                
                break;
            case 0:
            {
                [_haoping_image setImage:[UIImage imageNamed:@"gstar.png"]];
                _gaoping.text = @"中评";
            }
                
                break;
            case 1:
            {
                [_haoping_image setImage:[UIImage imageNamed:@"rstar.png"]];
                _gaoping.text = @"好评";
            }
                
                break;
                
            default:
                break;
        }
        //评价内容
        if ([[resp valueForKey:@"data"] valueForKey:@"content"] == nil) {
            _pinflunneirong.text = @"评论内容：";
        }else{
            _pinflunneirong.text = [NSString stringWithFormat:@"评论内容：%@",[[resp valueForKey:@"data"] valueForKey:@"content"]];
        }
        
    }else{
        
    }
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

@end
