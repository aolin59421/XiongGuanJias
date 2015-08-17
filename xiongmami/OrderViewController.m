//
//  OrderViewController.m
//  xiongmami
//
//  Created by iMac on 14/11/18.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "OrderViewController.h"
#import "FwzOrderCell.h"
#import "OrderTracking.h"
#import "PaymentViewController.h"
#import "OvierOrderCell.h"
#import "OverOrderCell.h"
#import "HexadecimalConversionUICOLOR.h"
#import "LeveyTabBarController.h"
#import "PersonalViewController.h"
#import "NewPayViewController.h"

@implementation OrderViewController

- (void)viewWillAppear:(BOOL)animated
{
//    NSLog(@"willApper订单");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#f8f3f0"];
    self.title = @"订单";
    [self addOrderChoose];
    [self fwzTableView];
    [self fwzImage];

    [NSThread detachNewThreadSelector:@selector(lalal) toTarget:self withObject:nil];

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
}

#pragma  mark - 图片
- (void)fwzImage
{
    _fwzImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 103, VIEW_FRAME_SIZE_WIDTH/2, 1)] ;
    
    if (iPhone6Plus) {
        _fwzImage.frame = CGRectMake(0, 119, VIEW_FRAME_SIZE_WIDTH/2, 1);
    }else if (iPhone6){
        _fwzImage.frame = CGRectMake(0, 113, VIEW_FRAME_SIZE_WIDTH/2, 1);
    }
    _fwzImage.image = [UIImage imageNamed:@"line.jpg"];
    [self.view addSubview:_fwzImage];
}

#pragma  mark - 订单选择
- (void)addOrderChoose
{
    NSArray *segmentedData = [[NSArray alloc]initWithObjects:@"服务中",@"已完成",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedData];
    segmentedControl.frame = CGRectMake(0, 64,VIEW_FRAME_SIZE_WIDTH, 40);
    [segmentedControl setBackgroundColor:[UIColor whiteColor]];
    segmentedControl.layer.borderColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#edecec"].CGColor;
    segmentedControl.layer.borderWidth = 1;
    
    if (iPhone6Plus) {
        segmentedControl.frame = CGRectMake(0, 64,VIEW_FRAME_SIZE_WIDTH, 55);
    }else if (iPhone6){
        segmentedControl.frame = CGRectMake(0, 64,VIEW_FRAME_SIZE_WIDTH, 50);
    }
    /*
     这个是设置按下按钮时的颜色
     */
    segmentedControl.tintColor = [UIColor whiteColor];
    segmentedControl.selectedSegmentIndex = 0;//默认选中的按钮索引
    /*
     下面的代码实同正常状态和按下状态的属性控制,比如字体的大小和颜色等
     */
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName,[UIColor colorWithRed:190/255.0f green:190/255.0f blue:190/255.0f alpha:1], NSForegroundColorAttributeName, nil];
    NSDictionary *attributesHeigth = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName,[UIColor blackColor],NSForegroundColorAttributeName, nil];
    
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [segmentedControl setTitleTextAttributes:attributesHeigth forState:UIControlStateSelected];
    
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    
    [segmentedControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    
    //设置分段控件点击相应事件
    [segmentedControl addTarget:self action:@selector(doSomethingInSegment:)forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segmentedControl];
}

-(void)doSomethingInSegment:(UISegmentedControl *)Seg
{
    NSInteger Index = Seg.selectedSegmentIndex;
    switch (Index)
    {
        case 0:{
//            NSLog(@"服务中");
            [self fwzTableView];
            CGRect frame = _fwzImage.frame;
            frame.origin.x = 0;
            _fwzImage.frame = frame;
            [self insertRowAtTop:0];
            [_ywcTableView removeFromSuperview];
//            [_yqxTableView removeFromSuperview];
            break;
        }
        case 1:
        {
//            NSLog(@"已完成");
            [self ywcTableView];
            CGRect frameTwo = _fwzImage.frame;
            frameTwo.origin.x = _fwzImage.frame.size.width;
            _fwzImage.frame = frameTwo;
            [self insertRowAtTop:1];
            [_fwzTableView removeFromSuperview];
//            [_yqxTableView removeFromSuperview];
            break;
        }
//        case 2:
//            NSLog(@"已取消");
//            [self yqxTablView];
//            CGRect frameThree = _fwzImage.frame;
//            frameThree.origin.x = _fwzImage.frame.size.width*2;
//            _fwzImage.frame = frameThree;
//            [_fwzTableView removeFromSuperview];
//            [_ywcTableView removeFromSuperview];
//            break;
        default:
            break;
    }
}

- (void)fwzTableView
{
    _fwzTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 114, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT - 134) style:UITableViewStyleGrouped];
    if (iPhone6Plus) {
        _fwzTableView.frame = CGRectMake(0, 129, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT - 149);
    }else if (iPhone6){
        _fwzTableView.frame = CGRectMake(0, 124, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT - 144);
    }
    
    _fwzTableView.delegate = self;
    _fwzTableView.dataSource =self;
    _fwzTableView.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#f8f3f0"];
    _fwzTableView.contentSize = CGSizeMake(0, VIEW_FRAME_SIZE_HEIGHT);
    [self.view addSubview:_fwzTableView];
    [_no_ywcOrder removeFromSuperview];
    _no_order = [[UILabel alloc] initWithFrame:CGRectMake(0, _fwzTableView.frame.size.height/3, VIEW_FRAME_SIZE_WIDTH, 40)];
    _no_order.text = @"亲～没有服务中的订单哟！";
    _no_order.font = [UIFont systemFontOfSize:17];
    _no_order.textColor = [UIColor lightGrayColor];
    _no_order.textAlignment = NSTextAlignmentCenter;
    [_fwzTableView addSubview:_no_order];

    __weak OrderViewController *orderViewController = self;
    [_fwzTableView addPullToRefreshWithActionHandler:^{
        [orderViewController insertRowAtTop:0];
    }];
}
#pragma  mark -下拉刷新
- (void)insertRowAtTop:(NSInteger)tag
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = @"加载中";
    [HUD show:YES];
    
    if (tag == 0) {
        [NSThread detachNewThreadSelector:@selector(lalal) toTarget:self withObject:nil];
    }else if (tag == 1){
        [NSThread detachNewThreadSelector:@selector(theOrderOver) toTarget:self withObject:nil];
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)ywcTableView
{
    _ywcTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 114, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT - 134) style:UITableViewStyleGrouped];
    if (iPhone6Plus) {
        _ywcTableView.frame = CGRectMake(0, 129, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT - 149);
    }else if (iPhone6){
        _ywcTableView.frame = CGRectMake(0, 124, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT - 144);
    }
    
    _ywcTableView.delegate = self;
    _ywcTableView.dataSource =self;
    _ywcTableView.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#f8f3f0"];
    _ywcTableView.contentSize = CGSizeMake(0, VIEW_FRAME_SIZE_HEIGHT);
    [self.view addSubview:_ywcTableView];
    
    [_no_order removeFromSuperview];
    _no_ywcOrder = [[UILabel alloc] initWithFrame:CGRectMake(0, _fwzTableView.frame.size.height/3, VIEW_FRAME_SIZE_WIDTH, 40)];
    _no_ywcOrder.text = @"亲～没有已完成的订单哟！";
    _no_ywcOrder.font = [UIFont systemFontOfSize:17];
    _no_ywcOrder.textColor = [UIColor lightGrayColor];
    _no_ywcOrder.textAlignment = NSTextAlignmentCenter;
    [_ywcTableView addSubview:_no_ywcOrder];
    
    __weak OrderViewController *orderViewController = self;
    [_ywcTableView addPullToRefreshWithActionHandler:^{
        [orderViewController insertRowAtTop:1];
    }];
}

- (void)yqxTablView
{
    _yqxTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 114, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT - 134) style:UITableViewStyleGrouped];
    _yqxTableView.delegate = self;
    _yqxTableView.dataSource =self;
    _yqxTableView.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#f8f3f0"];
    [self.view addSubview:_yqxTableView];
}

#pragma  mark - tableViewDelegate&tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_fwzTableView]) {
        return 1;
    }else if ([tableView isEqual:_ywcTableView]) {
        return 1;
    } else if ([tableView isEqual:_yqxTableView]){
        return 1;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:_fwzTableView]) {
        
        return [_listArray count];
    }else if ([tableView isEqual:_ywcTableView]) {
        
        return [_listOverArray count];
    } else if ([tableView isEqual:_yqxTableView]){
        return 3;
    }else{
    return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
#pragma  mark - 服务中
    
    if ([tableView isEqual:_fwzTableView]) {
        NSString *cellIDF = [NSString stringWithFormat:@"FWZCell-%ld-%ld",(long)indexPath.section,(long)indexPath.section];
        FwzOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDF];
        if (cell == nil) {
            cell = [[FwzOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIDF];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //商品名
        if ([[_listArray objectAtIndex:indexPath.section] valueForKey:@"store_id"] == nil || [[_listArray objectAtIndex:indexPath.section] valueForKey:@"store_id"] == NULL) {
            cell.nameOrderLab.text = @"按件洗衣";
        }else{
        cell.nameOrderLab.text = @"洗衣服务";//[[_listArray objectAtIndex:indexPath.section] valueForKey:@"store_id"];
        }
        //订单编号
        cell.numberOrderLab.text = [[_listArray objectAtIndex:indexPath.section] valueForKey:@"order_id"] ;

        //订单类型
        switch ([[[_listArray objectAtIndex:indexPath.section] valueForKey:@"flag"] intValue]) {
            case 1:
            {
                cell.leiXingOrderLab.text = @"普通";
            }
                break;
            case 2:
            {
                cell.leiXingOrderLab.text =@"加急";
                cell.leiXingOrderLab.textColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#ed6c44"];
            }
                break;

            default:
                break;
        }
        //订单状态
        switch ([[[_listArray objectAtIndex:indexPath.section] valueForKey:@"status"] intValue]) {
            case 1:
            {
                cell.zhuangTaiOrderLab.text = @"待收件";
                [cell.dingDanZhuiZongButton setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH - 190, 130, 80, 30)];
                
                cell.quXiaoOrderButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100, 130, 80, 30);
                cell.quXiaoOrderButton.tag  = indexPath.section;
                [cell.quXiaoOrderButton addTarget:self action:@selector(quxiaodingdan:) forControlEvents:UIControlEventTouchUpInside];
                [cell.quXiaoOrderButton setEnabled:YES];
                [cell.quXiaoOrderButton setAlpha:1];
                [cell.quXiaoOrderButton setTitle:@"取消订单" forState:UIControlStateNormal];
                [cell.quXiaoOrderButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
//                NSLog(@"quxiaodingdanasdasdasd%ld",(long)cell.quXiaoOrderButton.tag);
                
                [cell.fuKuanOrderButton setEnabled:NO];
                [cell.fuKuanOrderButton setAlpha:0];
                [cell.fuKuanOrderButton setTitle:nil forState:UIControlStateNormal];
                [cell.fuKuanOrderButton setBackgroundImage:nil forState:UIControlStateNormal];
                
            }
                break;
            case 10:
            {
                cell.zhuangTaiOrderLab.text = @"取件中";
                [cell.dingDanZhuiZongButton setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH - 100, 130, 80, 30)];
                
                [cell.quXiaoOrderButton setEnabled:NO];
                [cell.quXiaoOrderButton setAlpha:0];
                [cell.quXiaoOrderButton setTitle:nil forState:UIControlStateNormal];
                [cell.quXiaoOrderButton setBackgroundImage:nil forState:UIControlStateNormal];
                
                [cell.fuKuanOrderButton setEnabled:NO];
                [cell.fuKuanOrderButton setAlpha:0];
                [cell.fuKuanOrderButton setTitle:nil forState:UIControlStateNormal];
                [cell.fuKuanOrderButton setBackgroundImage:nil forState:UIControlStateNormal];
            }
                break;
            case 20:
            {
                cell.zhuangTaiOrderLab.text = @"已收件";
                [cell.dingDanZhuiZongButton setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100, 130, 80, 30)];
                
                [cell.quXiaoOrderButton setEnabled:NO];
                [cell.quXiaoOrderButton setAlpha:0];
                [cell.quXiaoOrderButton setTitle:nil forState:UIControlStateNormal];
                [cell.quXiaoOrderButton setBackgroundImage:nil forState:UIControlStateNormal];
                
                [cell.fuKuanOrderButton setEnabled:NO];
                [cell.fuKuanOrderButton setAlpha:0];
                [cell.fuKuanOrderButton setTitle:nil forState:UIControlStateNormal];
                [cell.fuKuanOrderButton setBackgroundImage:nil forState:UIControlStateNormal];
            }
                break;
            case 25:
            {
                cell.zhuangTaiOrderLab.text = @"异常单";
                [cell.dingDanZhuiZongButton setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH - 190, 130, 80, 30)];
                //取消订单
                cell.quXiaoOrderButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100, 130, 80, 30);
                cell.quXiaoOrderButton.tag  = indexPath.section;
                [cell.quXiaoOrderButton addTarget:self action:@selector(quxiaodingdan:) forControlEvents:UIControlEventTouchUpInside];
                [cell.quXiaoOrderButton setEnabled:YES];
                [cell.quXiaoOrderButton setAlpha:1];
                [cell.quXiaoOrderButton setTitle:@"取消订单" forState:UIControlStateNormal];
                [cell.quXiaoOrderButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
                
                [cell.fuKuanOrderButton setEnabled:NO];
                [cell.fuKuanOrderButton setAlpha:0];
                [cell.fuKuanOrderButton setTitle:nil forState:UIControlStateNormal];
                [cell.fuKuanOrderButton setBackgroundImage:nil forState:UIControlStateNormal];
            }
                break;
            case 30:
            {
                cell.zhuangTaiOrderLab.text = @"清洗中";
                [cell.dingDanZhuiZongButton setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH - 190, 130, 80, 30)];
                
                if ([[[_listArray objectAtIndex:indexPath.section] valueForKey:@"pay_status"] intValue] == 0) {
                    [cell.fuKuanOrderButton setBackgroundImage:[UIImage imageNamed:@"btnHover.png"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTitleColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#ed6c44"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTag:indexPath.section];
                    [cell.fuKuanOrderButton setTitle:@"付款" forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton addTarget:self action:@selector(fuKuan:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.fuKuanOrderButton setEnabled:YES];
                    
                }else if ([[[_listArray objectAtIndex:indexPath.section] valueForKey:@"pay_status"] intValue] == 1){
                    
                    [cell.fuKuanOrderButton setTitle:@"付款中" forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTitleColor:[UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setEnabled:NO];
                    
                }else if ([[[_listArray objectAtIndex:indexPath.section] valueForKey:@"pay_status"] intValue] == 2){
                    
                    [cell.fuKuanOrderButton setTitle:@"已付款" forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTitleColor:[UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setEnabled:NO];
                }
                [cell.fuKuanOrderButton setAlpha:1];
                
                
                [cell.quXiaoOrderButton setEnabled:NO];
                [cell.quXiaoOrderButton setAlpha:0];
                [cell.quXiaoOrderButton setTitle:nil forState:UIControlStateNormal];
                [cell.quXiaoOrderButton setBackgroundImage:nil forState:UIControlStateNormal];
            }
                break;
            case 35:
            {
                cell.zhuangTaiOrderLab.text = @"清洗中";
                [cell.dingDanZhuiZongButton setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH - 190, 130, 80, 30)];

                if ([[[_listArray objectAtIndex:indexPath.section] valueForKey:@"pay_status"] intValue] == 0) {
                    [cell.fuKuanOrderButton setBackgroundImage:[UIImage imageNamed:@"btnHover.png"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTitleColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#ed6c44"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTag:indexPath.section];
                    [cell.fuKuanOrderButton setTitle:@"付款" forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton addTarget:self action:@selector(fuKuan:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.fuKuanOrderButton setEnabled:YES];
                    
                }else if ([[[_listArray objectAtIndex:indexPath.section] valueForKey:@"pay_status"] intValue] == 1){
                    
                    [cell.fuKuanOrderButton setTitle:@"付款中" forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTitleColor:[UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setEnabled:NO];
                    
                }else if ([[[_listArray objectAtIndex:indexPath.section] valueForKey:@"pay_status"] intValue] == 2){
                    
                    [cell.fuKuanOrderButton setTitle:@"已付款" forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTitleColor:[UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setEnabled:NO];
                }
                [cell.fuKuanOrderButton setAlpha:1];
                
                [cell.quXiaoOrderButton setEnabled:NO];
                [cell.quXiaoOrderButton setAlpha:0];
                [cell.quXiaoOrderButton setTitle:nil forState:UIControlStateNormal];
                [cell.quXiaoOrderButton setBackgroundImage:nil forState:UIControlStateNormal];
            }
                break;
            case 40:
            {
                cell.zhuangTaiOrderLab.text = @"清洗中";
                [cell.dingDanZhuiZongButton setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH - 190, 130, 80, 30)];
                
                if ([[[_listArray objectAtIndex:indexPath.section] valueForKey:@"pay_status"] intValue] == 0) {
                    [cell.fuKuanOrderButton setBackgroundImage:[UIImage imageNamed:@"btnHover.png"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTitleColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#ed6c44"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTag:indexPath.section];
                    [cell.fuKuanOrderButton setTitle:@"付款" forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton addTarget:self action:@selector(fuKuan:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.fuKuanOrderButton setEnabled:YES];
                    
                }else if ([[[_listArray objectAtIndex:indexPath.section] valueForKey:@"pay_status"] intValue] == 1){
                    
                    [cell.fuKuanOrderButton setTitle:@"付款中" forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTitleColor:[UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setEnabled:NO];
                    
                }else if ([[[_listArray objectAtIndex:indexPath.section] valueForKey:@"pay_status"] intValue] == 2){
                    
                    [cell.fuKuanOrderButton setTitle:@"已付款" forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTitleColor:[UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setEnabled:NO];
                }
                [cell.fuKuanOrderButton setAlpha:1];
                
                [cell.quXiaoOrderButton setEnabled:NO];
                [cell.quXiaoOrderButton setAlpha:0];
                [cell.quXiaoOrderButton setTitle:nil forState:UIControlStateNormal];
                [cell.quXiaoOrderButton setBackgroundImage:nil forState:UIControlStateNormal];
            }
                break;
            case 50:
            {
                cell.zhuangTaiOrderLab.text = @"派送中";
                cell.zhuangTaiOrderLab.textColor =[HexadecimalConversionUICOLOR colorWithHexString:@"#ed6c44"];
                [cell.dingDanZhuiZongButton setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH - 190, 130, 80, 30)];
                
                if ([[[_listArray objectAtIndex:indexPath.section] valueForKey:@"pay_status"] intValue] == 0) {
                    [cell.fuKuanOrderButton setBackgroundImage:[UIImage imageNamed:@"btnHover.png"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTitleColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#ed6c44"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTag:indexPath.section];
                    [cell.fuKuanOrderButton setTitle:@"付款" forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton addTarget:self action:@selector(fuKuan:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.fuKuanOrderButton setEnabled:YES];
                    
                }else if ([[[_listArray objectAtIndex:indexPath.section] valueForKey:@"pay_status"] intValue] == 1){
                    
                    [cell.fuKuanOrderButton setTitle:@"付款中" forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTitleColor:[UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setEnabled:NO];
                    
                }else if ([[[_listArray objectAtIndex:indexPath.section] valueForKey:@"pay_status"] intValue] == 2){
                    
                    [cell.fuKuanOrderButton setTitle:@"已付款" forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTitleColor:[UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setEnabled:NO];
                }
                [cell.fuKuanOrderButton setAlpha:1];

                [cell.quXiaoOrderButton setEnabled:NO];
                [cell.quXiaoOrderButton setAlpha:0];
                [cell.quXiaoOrderButton setTitle:nil forState:UIControlStateNormal];
                [cell.quXiaoOrderButton setBackgroundImage:nil forState:UIControlStateNormal];

            }
                break;
            case 55:
            {
//                pay_status    0:待付款   1：付款中   2：已付款
//               cell.zhuangTaiOrderLab.text = @"付款中";
                [cell.dingDanZhuiZongButton setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH - 190, 130, 80, 30)];
                
                if ([[[_listArray objectAtIndex:indexPath.section] valueForKey:@"pay_status"] intValue] == 0) {
                    [cell.fuKuanOrderButton setBackgroundImage:[UIImage imageNamed:@"btnHover.png"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTitleColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#ed6c44"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTag:indexPath.section];
                    [cell.fuKuanOrderButton setTitle:@"付款" forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton addTarget:self action:@selector(fuKuan:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.fuKuanOrderButton setEnabled:YES];
                    
                }else if ([[[_listArray objectAtIndex:indexPath.section] valueForKey:@"pay_status"] intValue] == 1){
                    
                    [cell.fuKuanOrderButton setTitle:@"付款中" forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTitleColor:[UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setEnabled:NO];

                }else if ([[[_listArray objectAtIndex:indexPath.section] valueForKey:@"pay_status"] intValue] == 2){
                    
                    [cell.fuKuanOrderButton setTitle:@"已付款" forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTitleColor:[UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setEnabled:NO];
                }
                [cell.fuKuanOrderButton setAlpha:1];
                
                [cell.quXiaoOrderButton setEnabled:NO];
                [cell.quXiaoOrderButton setAlpha:0];
                [cell.quXiaoOrderButton setTitle:nil forState:UIControlStateNormal];
                [cell.quXiaoOrderButton setBackgroundImage:nil forState:UIControlStateNormal];
            }
                break;
            case 60:
            {
                cell.zhuangTaiOrderLab.text = @"已完成";
                
                [cell.quXiaoOrderButton setEnabled:NO];
                [cell.quXiaoOrderButton setAlpha:0];
                [cell.quXiaoOrderButton setTitle:nil forState:UIControlStateNormal];
                [cell.quXiaoOrderButton setBackgroundImage:nil forState:UIControlStateNormal];
                
                [cell.fuKuanOrderButton setEnabled:NO];
                [cell.fuKuanOrderButton setAlpha:0];
                [cell.fuKuanOrderButton setTitle:nil forState:UIControlStateNormal];
                [cell.fuKuanOrderButton setBackgroundImage:nil forState:UIControlStateNormal];
                
            }
                break;
            case 70:
            {
                cell.zhuangTaiOrderLab.text = @"已取消";
                
                [cell.quXiaoOrderButton setEnabled:NO];
                [cell.quXiaoOrderButton setAlpha:0];
                [cell.quXiaoOrderButton setTitle:nil forState:UIControlStateNormal];
                [cell.quXiaoOrderButton setBackgroundImage:nil forState:UIControlStateNormal];
                
                [cell.fuKuanOrderButton setEnabled:NO];
                [cell.fuKuanOrderButton setAlpha:0];
                [cell.fuKuanOrderButton setTitle:nil forState:UIControlStateNormal];
                [cell.fuKuanOrderButton setBackgroundImage:nil forState:UIControlStateNormal];
            }
                break;
            case 80:
            {
                cell.zhuangTaiOrderLab.text = @"服务中";
                
                [cell.quXiaoOrderButton setEnabled:NO];
                [cell.quXiaoOrderButton setAlpha:0];
                [cell.quXiaoOrderButton setTitle:nil forState:UIControlStateNormal];
                [cell.quXiaoOrderButton setBackgroundImage:nil forState:UIControlStateNormal];
                
                [cell.fuKuanOrderButton setEnabled:NO];
                [cell.fuKuanOrderButton setAlpha:0];
                [cell.fuKuanOrderButton setTitle:nil forState:UIControlStateNormal];
                [cell.fuKuanOrderButton setBackgroundImage:nil forState:UIControlStateNormal];
            }
                break;
            case 28:
            {
                cell.zhuangTaiOrderLab.text = @"清洗中";
                [cell.dingDanZhuiZongButton setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH - 190, 130, 80, 30)];
                
                if ([[[_listArray objectAtIndex:indexPath.section] valueForKey:@"pay_status"] intValue] == 0) {
                    [cell.fuKuanOrderButton setBackgroundImage:[UIImage imageNamed:@"btnHover.png"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTitleColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#ed6c44"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTag:indexPath.section];
                    [cell.fuKuanOrderButton setTitle:@"付款" forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton addTarget:self action:@selector(fuKuan:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.fuKuanOrderButton setEnabled:YES];
                    
                }else if ([[[_listArray objectAtIndex:indexPath.section] valueForKey:@"pay_status"] intValue] == 1){
                    
                    [cell.fuKuanOrderButton setTitle:@"付款中" forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTitleColor:[UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setEnabled:NO];
                    
                }else if ([[[_listArray objectAtIndex:indexPath.section] valueForKey:@"pay_status"] intValue] == 2){
                    
                    [cell.fuKuanOrderButton setTitle:@"已付款" forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTitleColor:[UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setEnabled:NO];
                }
                [cell.fuKuanOrderButton setAlpha:1];
                
                [cell.quXiaoOrderButton setEnabled:NO];
                [cell.quXiaoOrderButton setAlpha:0];
                [cell.quXiaoOrderButton setTitle:nil forState:UIControlStateNormal];
                [cell.quXiaoOrderButton setBackgroundImage:nil forState:UIControlStateNormal];
            }
                break;
            case 38:
            {
                cell.zhuangTaiOrderLab.text = @"洗衣完成";
                [cell.dingDanZhuiZongButton setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH - 190, 130, 80, 30)];
                
                if ([[[_listArray objectAtIndex:indexPath.section] valueForKey:@"pay_status"] intValue] == 0) {
                    [cell.fuKuanOrderButton setBackgroundImage:[UIImage imageNamed:@"btnHover.png"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTitleColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#ed6c44"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTag:indexPath.section];
                    [cell.fuKuanOrderButton setTitle:@"付款" forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton addTarget:self action:@selector(fuKuan:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.fuKuanOrderButton setEnabled:YES];
                    
                }else if ([[[_listArray objectAtIndex:indexPath.section] valueForKey:@"pay_status"] intValue] == 1){
                    
                    [cell.fuKuanOrderButton setTitle:@"付款中" forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTitleColor:[UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setEnabled:NO];
                    
                }else if ([[[_listArray objectAtIndex:indexPath.section] valueForKey:@"pay_status"] intValue] == 2){
                    
                    [cell.fuKuanOrderButton setTitle:@"已付款" forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setTitleColor:[UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
                    [cell.fuKuanOrderButton setEnabled:NO];
                }
                [cell.fuKuanOrderButton setAlpha:1];
                
                [cell.quXiaoOrderButton setEnabled:NO];
                [cell.quXiaoOrderButton setAlpha:0];
                [cell.quXiaoOrderButton setTitle:nil forState:UIControlStateNormal];
                [cell.quXiaoOrderButton setBackgroundImage:nil forState:UIControlStateNormal];
            }
                
            default:
                break;
        }
        cell.zhuangTaiOrderLab.textColor =[HexadecimalConversionUICOLOR colorWithHexString:@"#ed6c44"];
        //订单追踪通过按钮tag值传递订单编号
        cell.dingDanZhuiZongButton.tag = indexPath.section;
        //订单追踪
        [cell.dingDanZhuiZongButton addTarget:self action:@selector(dingDanZhuiZong:) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }else if ([tableView isEqual:_ywcTableView]) {
        
#pragma  mark - 已完成
        
        NSString *cellIDF = [NSString stringWithFormat:@"YWCCell-%ld-%ld",(long)indexPath.section,(long)indexPath.section];
        OvierOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDF];
        if (cell == nil) {
            cell = [[OvierOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIDF];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//      商品名
        if ([[_listOverArray objectAtIndex:indexPath.section] valueForKey:@"store_id"] == nil || [[_listOverArray objectAtIndex:indexPath.section] valueForKey:@"store_id"] == NULL) {
            cell.nameOrderLab.text = @"按件洗衣";
        }else{
            cell.nameOrderLab.text = @"洗衣服务";//[[_listOverArray objectAtIndex:indexPath.section] valueForKey:@"store_id"];
        }
        //订单编号
        cell.numberOrderLab.text = [[_listOverArray objectAtIndex:indexPath.section] valueForKey:@"order_id"];
        
        //订单类型
        switch ([[[_listOverArray objectAtIndex:indexPath.section] valueForKey:@"flag"] intValue]) {
            case 1:
            {
                cell.leiXingOrderLab.text = @"普通";
            }
                break;
            case 2:
            {
                cell.leiXingOrderLab.text =@"加急";
                cell.leiXingOrderLab.textColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#ed6c44"];
            }
                break;
                
            default:
                break;
        }
        
        //订单状态
        switch ([[[_listOverArray objectAtIndex:indexPath.section] valueForKey:@"status"] intValue]) {
            case 1:
            {
                cell.zhuangTaiOrderLab.text = @"已下单";
            }
                break;
            case 10:
            {
                cell.zhuangTaiOrderLab.text = @"已派单";
            }
                break;
            case 20:
            {
                cell.zhuangTaiOrderLab.text = @"已收件";
            }
                break;
            case 25:
            {
                cell.zhuangTaiOrderLab.text = @"异常单";
            }
                break;
            case 30:
            {
                cell.zhuangTaiOrderLab.text = @"洗衣中";
            }
                break;
            case 35:
            {
                cell.zhuangTaiOrderLab.text = @"洗衣完成";
            }
                break;
            case 40:
            {
                cell.zhuangTaiOrderLab.text = @"待派送";
            }
                break;
            case 50:
            {
                cell.zhuangTaiOrderLab.text = @"已派送";
                
            }
                break;
            case 55:
            {
                cell.zhuangTaiOrderLab.text = @"付款中";
                
            }
                break;
            case 60:
            {
                cell.zhuangTaiOrderLab.text = @"完成";
            }
                break;
            case 70:
            {
                cell.zhuangTaiOrderLab.text = @"已取消";
            }
                break;
                
            default:
                break;
        }
        //支付方式
        switch ([[[_listOverArray objectAtIndex:indexPath.section] valueForKey:@"pay_type"] intValue]) {
            case 1:
            {
                cell.fuKuanFangShiLab.text = @"现金";
            }
                break;
            case 2:
            {
                cell.fuKuanFangShiLab.text = @"余额";
            }
                break;
            case 3:
            {
                cell.fuKuanFangShiLab.text = @"微信";
            }
                break;
            case 4:
            {
                cell.fuKuanFangShiLab.text = @"支付宝";
            }
                break;
            case 5:
            {
                cell.fuKuanFangShiLab.text = @"网银";
            }
                break;
            case 10:
            {
                cell.fuKuanFangShiLab.text = @"余额+现金";
            }
                break;
            case 0:
            {
                cell.fuKuanFangShiLab.text = @"测试支付";
            }
                break;
            case 50:
            {
                cell.fuKuanFangShiLab.text = @"余额+银联";
            }
                break;
            case 40:
            {
                cell.fuKuanFangShiLab.text = @"余额+支付宝";
            }
                break;
            default:
                break;
        }
        //付款金额
        if ([[[_listOverArray objectAtIndex:indexPath.section] valueForKey:@"is_first"] intValue] == 1) {
            cell.fuKuanJinELab.text = @"首单免费（两件以内）";
        }else {
            cell.fuKuanJinELab.text = [NSString stringWithFormat:@"%@",[[_listOverArray objectAtIndex:indexPath.section] valueForKey:@"amount"]];
        }
//        //评论按钮
        if ([[[_listOverArray objectAtIndex:indexPath.section] valueForKey:@"judge"] intValue] == 1) {
            [cell.pingjia setTitle:@"" forState:UIControlStateNormal];
            [cell.pingjia setEnabled:NO];
            [cell.pingjia setBackgroundImage:nil forState:UIControlStateNormal];
            
            [cell.commentBtn setEnabled:YES];
            [cell.commentBtn setTitle:@"查看评论" forState:UIControlStateNormal];
            [cell.commentBtn setTag:indexPath.section];
            [cell.commentBtn addTarget:self action:@selector(ToViewComments:) forControlEvents:UIControlEventTouchUpInside];
            [cell.commentBtn setBackgroundImage:[UIImage imageNamed:@"btnHover.png"] forState:UIControlStateNormal];
        }else if([[[_listOverArray objectAtIndex:indexPath.section] valueForKey:@"judge"] intValue] == 0) {
            [cell.commentBtn setEnabled:NO];
            [cell.commentBtn setTitle:@"" forState:UIControlStateNormal];
            [cell.commentBtn setBackgroundImage:nil forState:UIControlStateNormal];
            
            [cell.pingjia setEnabled:YES];
            [cell.pingjia setBackgroundImage:[UIImage imageNamed:@"btnHover.png"] forState:UIControlStateNormal];
            [cell.pingjia setTitle:@"评论" forState:UIControlStateNormal];
            [cell.pingjia setTag:indexPath.section];
            [cell.pingjia addTarget:self action:@selector(comint:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    } else if ([tableView isEqual:_yqxTableView]){
        
#pragma  mark - 已取消
 
        static NSString *cellIDF = @"yqxCell";
        OverOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDF];
        if (cell == nil) {
            cell = [[OverOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIDF];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameOrderLab.text = @"按件洗衣";
        cell.numberOrderLab.text = @"2014112160";
        cell.leiXingOrderLab.text = @"普通件";
        NSString *string = @"次日件";
        if (string) {
            cell.leiXingOrderLab.textColor = [UIColor colorWithRed:187/255.0f green:-0/255.0f blue:22/255.0f alpha:1];
        }
        cell.zhuangTaiOrderLab.text = @"取消";
        return cell;
    } else{
        
        static NSString *cellIDF = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDF];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIDF];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:_fwzTableView]) {
        return 1;
    }else if ([tableView isEqual:_ywcTableView]) {
        return 1;
    } else if ([tableView isEqual:_yqxTableView]){
        return 1;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_fwzTableView]) {
        return 170;
    }else if ([tableView isEqual:_ywcTableView]) {
        return 235;
    } else if ([tableView isEqual:_yqxTableView]){
        return 130;
    }else{
        return 20;
    }
}
#pragma  mark - 取消订单
- (void)quxiaodingdan:(UIButton *)sender
{
    _qxddAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定取消本订单吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    _qxddAlertView.tag = sender.tag;
    
    [_qxddAlertView show];

//    NSLog(@"alert获取订单编号%@",[[_listArray objectAtIndex:_qxddAlertView.tag] valueForKey:@"order_id"]);
//    NSLog(@"取消订单");
}
#pragma  mark - 付款
- (void)fuKuan:(UIButton *)sender
{

//    NSLog(@"获取订单编号%@",[[_listArray objectAtIndex:sender.tag] valueForKey:@"order_id"]);
//    NSLog(@"huoqu----%ld",(long)sender.tag);
    
    NewPayViewController *payment = [[NewPayViewController alloc] init];
    payment.numbMoney = [NSString stringWithFormat:@"%@",[[_listArray objectAtIndex:sender.tag] valueForKey:@"order_id"] ];
    payment.orderAmount = [NSString stringWithFormat:@"%ld",(long)[[[_listArray objectAtIndex:sender.tag] valueForKey:@"amount"] integerValue]];
    [self.leveyTabBarController hidesTabBar:YES animated:YES ];
    
    [self.navigationController pushViewController:payment animated:YES];
    
}
#pragma  mark - 订单追踪
- (void)dingDanZhuiZong:(UIButton *)sender
{

//    NSLog(@"获取订单编号%@",[[_listArray objectAtIndex:sender.tag] valueForKey:@"order_id"]);
//    NSLog(@"huoqu----%ld",(long)sender.tag);
    
    OrderTracking *orderTrack = [[OrderTracking alloc] init];
    orderTrack.orderNumber = [[_listArray objectAtIndex:sender.tag] valueForKey:@"order_id"];
    int flag = [[[_listArray objectAtIndex:sender.tag] valueForKey:@"flag"] intValue];
    
    if (flag == 1) {
        orderTrack.orderType = @"普通";
    }else if (flag == 2){
        orderTrack.orderType = @"加急";
    }else{
        orderTrack.orderType = @"异常";
    }
    [self.leveyTabBarController hidesTabBar:YES animated:YES];

    [self.navigationController pushViewController:orderTrack animated:YES];

}

#pragma  mark - 服务中Request
- (void)lalal
{
    _listArray = nil;
    NSLog(@"shibushikongle-%@",_listArray);
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *userID = [userDefault objectForKey:@"user_id"];
    NSDictionary *dict = [[NSDictionary alloc] init];
    
    dict = [PersonalRequest withURLStr:@"/index.php?s=/Api/Order/getlist" withSetValue:userID withSetValue:@"1" withSetValue:@"80" withSetValue:nil withForKey:@"user_id" withForKey:@"order_id" withForKey:@"status" withForKey:nil];
    
    int status = [[dict valueForKey:@"status"] intValue];

    NSLog(@"服务中dic数据%@",dict);
    NSLog(@"--%@",[dict valueForKey:@"data"]);
        if (status == 0) {
            [HUD removeFromSuperview];
        _listArray = [dict valueForKey:@"data"];
            if ([_listArray count] == 0) {
                _no_order.text = @"亲～没有服务中的订单哟！";
            }else{
                _no_order.text = @"";
            }
//        NSLog(@"服务中%d---%@",[_listArray count],_listArray);
            [_fwzTableView reloadData];
            [_fwzTableView.pullToRefreshView stopAnimating];
        
    } else if (status == 1){
        [HUD removeFromSuperview];
        [[YBProgressShow defaultProgress] showText:[dict valueForKey:@"data"] InMode:MBProgressHUDModeDeterminate OriginViewEnableTouch:YES HideAfterDelayTime:1];
        [_fwzTableView.pullToRefreshView stopAnimating];
    }
}

#pragma  mark - 已完成Request

- (void)theOrderOver
{
    [[BoolViewController alloc] testOut];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *userID = [userDefault objectForKey:@"user_id"];
    NSDictionary *dict = [[NSDictionary alloc] init];
    _listOverArray = nil;
    [_ywcTableView reloadData];
    dict = [PersonalRequest withURLStr:@"/index.php?s=/Api/Order/getlist" withSetValue:userID withSetValue:@"1" withSetValue:@"60" withSetValue:nil withForKey:@"user_id" withForKey:@"order_id" withForKey:@"status" withForKey:nil];
    
    int status = [[dict valueForKey:@"status"] intValue];
    NSLog(@"已完成%@",dict);
    
    if (status == 0) {
        
        _listOverArray = [dict valueForKey:@"data"];
        if ([_listOverArray count] == 0) {
            _no_ywcOrder.text = @"亲～没有已完成的订单哟！";
        }else{
            _no_ywcOrder.text = @"";
        }
//        NSLog(@"已完成%d",[_listOverArray  count]);
        [_ywcTableView reloadData];

        
    } else if (status == 1){
        [[YBProgressShow defaultProgress] showText:[dict valueForKey:@"data"] InMode:MBProgressHUDModeDeterminate OriginViewEnableTouch:YES HideAfterDelayTime:1];
        
    }
    [HUD removeFromSuperview];
    [_ywcTableView.pullToRefreshView stopAnimating];
}

#pragma  mark - 取消订单

- (void)qxddRequest:(NSString *)order_id
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = @"加载中";
    [HUD show:YES];
    [[BoolViewController alloc] testOut];
    NSString * orderid =[order_id stringByReplacingOccurrencesOfString:@".00000" withString:@""];
    
    NSMutableDictionary *diccctt= [[NSMutableDictionary alloc] init];
    [diccctt setValue:@"70" forKey:@"status"];
    [diccctt setValue:USER_ID(QQQQ) forKey:@"user_id"];
    [diccctt setValue:orderid forKey:@"order_id"];
//    NSLog(@"%@diccccctt%@",orderid,diccctt);
    NSDictionary * dic = [PersonalRequest withAllUrll:@"/index.php?s=/Api/Order/changestatus" WithDic:diccctt];
    int status = [[dic valueForKey:@"status"] intValue];
//    NSLog(@"取消订单%@",dic);
    if (status == 0) {
//        NSLog(@"quxiaoding%@",[dic valueForKey:@"data"]);
        [_fwzTableView reloadData];
        YBMB(@"取消成功!")
//        [self viewDidLoad];
    }else if(status == 1){
        YBMB([dic valueForKey:@"data"])
    }
    [HUD removeFromSuperview];
    [self insertRowAtTop:0];
}

#pragma  mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _qxddAlertView) {
        
//        NSLog(@"--vytt%ld",(long)buttonIndex);
        if (buttonIndex == 0) {
            
            [self qxddRequest:[NSString stringWithFormat:@"%@",[[_listArray objectAtIndex:alertView.tag] valueForKey:@"order_id"]]];
        }
    }
}

#pragma  mark - PUSH_COMINT
- (void)comint:(UIButton *)sender
{
//    NSLog(@"tag-%@",[[_listOverArray objectAtIndex:sender.tag] valueForKey:@"order_id"]);
    CommentViewController *comint = [[CommentViewController alloc] initWithBlock:(^(NSMutableDictionary *dic) {
//        NSLog(@"从评论返回");
        NSLog(@"comint=%@",[dic valueForKey:@"yes"]);
        if ([[dic valueForKey:@"yes"] rangeOfString:@"yes"].location !=NSNotFound) {
            [self insertRowAtTop:1];
        }
    })];
    comint.numberText = [NSString stringWithFormat:@"%@",[[_listOverArray objectAtIndex:sender.tag] valueForKey:@"order_id"]];
    comint.overOrderTime = [NSString stringWithFormat:@"%@",[[_listOverArray objectAtIndex:sender.tag] valueForKey:@"ctime"]];
    [self.leveyTabBarController hidesTabBar:YES animated:YES ];
    [self.navigationController pushViewController:comint animated:YES];
}
- (void)ToViewComments:(UIButton *)sender
{
    ToViewCommentViewController *toVC =  [[ToViewCommentViewController alloc] init];
    toVC.numberText = [NSString stringWithFormat:@"%@",[[_listOverArray objectAtIndex:sender.tag] valueForKey:@"order_id"]];
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    [self.navigationController pushViewController:toVC animated:YES];
}
- (void)viewDidAppear:(BOOL)animated
{
    [self.leveyTabBarController hidesTabBar:NO animated:NO];
}
@end
