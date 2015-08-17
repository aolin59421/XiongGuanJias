//
//  OrderTracking.m
//  xiongmami
//
//  Created by iMac on 14/11/21.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "OrderTracking.h"
#import "cnvUILabel.h"
#import "OrderList.h"
#import "HexadecimalConversionUICOLOR.h"

@implementation OrderTracking
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#f8f3f0"];
    self.title = @"订单追踪";
    [self addCustomView];
    
//    NSLog(@"订单编号%@",_orderNumber);
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(bback)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [NSThread detachNewThreadSelector:@selector(dingdanRequest) toTarget:self withObject:nil];
}

- (void)bback
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addCustomView
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, 80)];
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.layer.borderColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#edecec"].CGColor;
    titleView.layer.borderWidth = 1;
    [self.view addSubview:titleView];
    
    _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, VIEW_FRAME_SIZE_WIDTH-20, 40)];
    _numberLabel.backgroundColor = [UIColor clearColor];
    if (_orderNumber == nil || _orderNumber == NULL) {
        _numberLabel.text = @"订单编号：暂无订单";
    }else{
        _numberLabel.text = [NSString stringWithFormat:@"订单编号：%@",_orderNumber];
    }
    
    [_numberLabel setTextAlignment:NSTextAlignmentLeft];
    [titleView addSubview:_numberLabel];
    
    _leixingLabel = [[cnvUILabel alloc] initWithFrame:CGRectMake(10, 40, VIEW_FRAME_SIZE_WIDTH - 20, 30)];
    _leixingLabel.backgroundColor = [UIColor clearColor];

    if (_orderType == nil || _orderType == NULL) {
        [_leixingLabel cnv_setUILabelText:@"订单类型：无订单" andKeyWord:@"次日"];
    }else{
        [_leixingLabel cnv_setUILabelText:[NSString stringWithFormat:@"订单类型：%@",_orderType] andKeyWord:@"次日"];
    }
    
    [_leixingLabel cnv_setUIlabelTextColor:[UIColor blackColor] andKeyWordColor:[UIColor redColor]];
    [_leixingLabel setTextAlignment:NSTextAlignmentLeft];
    [titleView addSubview:_leixingLabel];
    
    _orderListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 160, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT-160) style:UITableViewStylePlain];
    _orderListTableView.dataSource = self;
    _orderListTableView.delegate = self;
    _orderListTableView.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#f8f3f0"];
    _orderListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _orderListTableView.bounces = NO;
    [self.view addSubview:_orderListTableView];
}

#pragma  mark - tableViewDelegate&DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_orderStateList count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIDF = [NSString stringWithFormat:@"Cell-%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    OrderList *cell = [tableView dequeueReusableCellWithIdentifier:cellIDF];
    if (cell == nil) {
        cell = [[OrderList alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIDF];
    }
    if (indexPath.row == 0) {
        cell.image.image = [UIImage imageNamed:@"wuliuhover@3x.png"];
        cell.image.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/10+1, 10, 17, 70);
        
        NSString *stringCtime = [self getOrderDate:[[_orderStateList objectAtIndex:indexPath.section] valueForKey:@"ctime"] ];
        
        int status = [[[_orderStateList objectAtIndex:indexPath.row] valueForKey:@"status"] intValue];
        switch (status) {
            case 1:
            {
                NSString *stringStatus  = @"待收件";
                cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
            }
                break;
            case 10:
            {
                NSString *stringStatus  = @"取件中";
                cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
            }
                break;
            case 20:
            {
                NSString *stringStatus  = @"已收件";
                cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
            }
                break;
            case 25:
            {
                NSString *stringStatus  = @"异常单";
                cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
            }
                break;
            case 30:
            {
                NSString *stringStatus  = @"清洗中";
                cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
            }
                break;
            case 35:
            {
                NSString *stringStatus  = @"清洗中";
                cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
            }
                break;
            case 40:
            {
                NSString *stringStatus  = @"清洗中";
                cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
            }
                break;
            case 50:
            {
                NSString *stringStatus  = @"派送中";
                cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
            }
                break;case 55:
            {
                NSString *stringStatus  = @"付款中";
                cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
            }
                break;
            case 60:
            {
                NSString *stringStatus  = @"已完成";
                cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
            }
                break;
            case 70:
            {
                NSString *stringStatus  = @"取消订单";
                cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
            }
                break;
            case 0:
            {
                NSString *stringStatus  = @"删除";
                cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
            }
                break;
            case 28:
            {
                NSString *stringStatus  = @"清洗中";
                cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
            }
                break;
            case 38:
            {
                NSString *stringStatus  = @"洗衣完成";
                cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
            }
                break;
            case 80:
            {
                NSString *stringStatus  = @"已完成";
                cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
            }
                break;
                
            default:
                break;
        }
        cell.orderTimeLab.textColor = [UIColor orangeColor];
        cell.orderTimeLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/10 + 25, 0, 300, 60);
    }
    
    NSString *stringCtime = [self getOrderDate:[[_orderStateList objectAtIndex:indexPath.row] valueForKey:@"ctime"] ];
    
    int status = [[[_orderStateList objectAtIndex:indexPath.row] valueForKey:@"status"] intValue];
    switch (status) {
        case 1:
        {
            NSString *stringStatus  = @"待收件";
            cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
        }
            break;
        case 10:
        {
            NSString *stringStatus  = @"取件中";
            cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
        }
            break;
        case 20:
        {
            NSString *stringStatus  = @"已收件";
            cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
        }
            break;
        case 25:
        {
            NSString *stringStatus  = @"异常单";
            cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
        }
            break;
        case 30:
        {
            NSString *stringStatus  = @"清洗中";
            cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
        }
            break;
        case 35:
        {
            NSString *stringStatus  = @"清洗中";
            cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
        }
            break;
        case 40:
        {
            NSString *stringStatus  = @"清洗中";
            cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
        }
            break;
        case 50:
        {
            NSString *stringStatus  = @"派送中";
            cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
        }
            break;
        case 55:
        {
            NSString *stringStatus  = @"付款中";
            cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
        }
            break;
        case 60:
        {
            NSString *stringStatus  = @"已完成";
            cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
        }
            break;
        case 70:
        {
            NSString *stringStatus  = @"取消订单";
            cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
        }
            break;
        case 0:
        {
            NSString *stringStatus  = @"删除";
            cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
        }
            break;
        case 28:
        {
            NSString *stringStatus  = @"清洗中";
            cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
        }
            break;
        case 38:
        {
            NSString *stringStatus  = @"洗衣完成";
            cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
        }
            break;
        case 80:
        {
            NSString *stringStatus  = @"已完成";
            cell.orderTimeLab.text = [NSString stringWithFormat:@"%@\n%@",stringStatus,stringCtime];
        }
            break;
            
        default:
            break;
    }
    if (iPhone6Plus) {
        if (indexPath.row == 0) {
            cell.image.frame =  CGRectMake(VIEW_FRAME_SIZE_WIDTH/10+2 - 20, 10, 17, 70);
        }else{
            cell.image.frame =  CGRectMake(VIEW_FRAME_SIZE_WIDTH/10+1 - 20, 0, 20, 80);
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

#pragma  mark - 订单数据请求
- (void)dingdanRequest
{
    /*
     NSString *orderNumber;//订单编号
     NSString *orderType;//订单类型
     NSArray  *orderStateList;//订单状态
     NSArray  *orderStateTimeList;//订单状态时间
     */
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = @"加载中";
    [HUD show:YES];
    
    [[BoolViewController alloc] testOut];
    NSMutableDictionary *diccct =[[NSMutableDictionary alloc] init];
    [diccct setValue:_orderNumber forKey:@"order_id"];
    
    NSDictionary *dic = [PersonalRequest NOTokenWithAllUrll:@"/index.php?s=/Api/Order/trace" WithDic:diccct];
    
    int status = [[dic valueForKey:@"status"] intValue];
    NSLog(@"-订单追踪%@",dic);
    if (status == 0) {
        
        if ([dic valueForKey:@"data"] == nil || [dic valueForKey:@"data"] == NULL) {
            _orderStateList = [NSArray arrayWithObjects:nil];
//            NSLog(@"liebiaokongle ");
            UILabel *lab =[[UILabel alloc] initWithFrame:CGRectMake(0, _orderListTableView.frame.size.height/4, VIEW_FRAME_SIZE_WIDTH, 40)];
            lab.text = @"亲～请求数据错误，请点击重试！";
            lab.font = [UIFont systemFontOfSize:17];
            [lab setNumberOfLines:0];
            lab.textColor = [UIColor lightGrayColor];
//            [lab setBackgroundColor:[UIColor redColor]];
            lab.textAlignment = NSTextAlignmentCenter;
            [_orderListTableView addSubview:lab];
            
            UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, _orderListTableView.frame.size.height);
            [button setBackgroundColor:[UIColor clearColor]];
            [button addTarget:self action:@selector(dingdanRequest) forControlEvents:UIControlEventTouchUpInside];
            [_orderListTableView addSubview:button];
            YBMB(@"请求错误！");
            [_orderListTableView reloadData];
        }else{
            _orderStateList = [dic valueForKey:@"data"];
            [_orderListTableView reloadData];
        }
//        [self viewDidLoad];
        [HUD removeFromSuperview];
        
//        NSLog(@"订单追踪列表%@",_orderStateList);
    }else if (status == 1){
        [HUD removeFromSuperview];
        YBMB([dic valueForKey:@"data"])
    }
    
    
}

#pragma mark - 时间戳转化
- (NSString *)getOrderDate:(NSString *)str
{
    int value = [str intValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:value];
    NSString *timeString = [NSString stringWithFormat:@"%@",confromTimesp];
//    NSLog(@"时间戳转化  = %@",timeString);
   
    timeString =[timeString stringByReplacingOccurrencesOfString:@"+0000" withString:@""];
    
    return timeString;
    
}

@end
