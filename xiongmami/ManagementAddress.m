//
//  ManagementAddress.m
//  xiongmami
//
//  Created by iMac on 14/11/19.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "ManagementAddress.h"
#import "ManagementAddressTableViewCell.h"
#import "AddAddressViewController.h"
#import "ViewController.h"
#import "HexadecimalConversionUICOLOR.h"


@interface ManagementAddress ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_managementAddresTableView;
}
@end

@implementation ManagementAddress

- (id)initWithBlock:(XGJBlock)dic
{
    self = [super init];
    if(self)
    {
        user_Block = dic;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTableView];
    self.title = @"管理地址";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(showAddress)];

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];

    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = @"加载中";
    [HUD show:YES];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(bback)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
}

- (void)bback
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma  mark - tableview
- (void)addTableView
{
    _managementAddresTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT) style:UITableViewStyleGrouped] ;
    _managementAddresTableView.dataSource = self;
    _managementAddresTableView.delegate = self;
    _managementAddresTableView.backgroundColor = [UIColor colorWithRed:246/255.0f green:240/255.0f blue:236/255.0f alpha:1];
    _managementAddresTableView.bounces  = NO;
    [_managementAddresTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.view addSubview:_managementAddresTableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_listArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIf = @"CellIf";
    ManagementAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIf];
    if (cell == nil) {
        cell = [[ManagementAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIf];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    int flag = [[[_listArray objectAtIndex:indexPath.section] valueForKey:@"flag"] intValue];
    if (flag == 1 ) {
        [cell.defaultButton setHighlighted:YES];
        [cell.defaultButton setUserInteractionEnabled:NO];
        [cell.defaultButton setTitle:@"默认地址" forState:UIControlStateHighlighted];
        [cell.defaultButton setBackgroundImage:nil forState:UIControlStateNormal];
        [cell.defaultButton setBackgroundColor:[UIColor clearColor]];
        [cell.defaultButton setTitleColor:[UIColor colorWithRed:253/255.0f green:168/255.0f blue:48/255.0f alpha:1] forState:UIControlStateHighlighted];
    } else {
        cell.defaultButton.tag = [[[_listArray objectAtIndex:indexPath.section] valueForKey:@"addr_id"] intValue];
        [cell.defaultButton addTarget:self action:@selector(sheweimoren:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (iPhone6Plus) {
        [cell.defaultButton setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH - 90, 10, 222/3, 77/3)];
    }

    //删除地址
    [cell.deleteButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteButton setTag:[[[_listArray objectAtIndex:indexPath.section] valueForKey:@"addr_id"] integerValue]];
    //编辑地址
    [cell.operationButton addTarget:self action:@selector(operation:) forControlEvents:UIControlEventTouchUpInside];
    [cell.operationButton setTag:indexPath.section];
    //收件人姓名
    cell.nameLabel.text = [[_listArray objectAtIndex:indexPath.section] valueForKey:@"username"];
    //电话
    cell.numberLabel.text = [[_listArray objectAtIndex:indexPath.section] valueForKey:@"mobile"];
    //收件地址
    
    cell.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",[[_listArray objectAtIndex:indexPath.section] valueForKey:@"city"],[[_listArray objectAtIndex:indexPath.section] valueForKey:@"area_name"],[[_listArray objectAtIndex:indexPath.section] valueForKey:@"address"] ];
    
//    cell.tag = [[[_listArray objectAtIndex:indexPath.section] valueForKey:@"addr_id"] intValue];
    
    return cell;
}

- (void)operation:(UIButton *)sender
{

//    NSLog(@"获取收件人姓名%@",[[_listArray objectAtIndex:sender.tag] valueForKey:@"username"]);
//    NSLog(@"获取收件人手机号%@",[[_listArray objectAtIndex:sender.tag] valueForKey:@"mobile"]);
//    NSLog(@"获取收件人详细地址%@",[[_listArray objectAtIndex:sender.tag] valueForKey:@"address"]);
//    NSLog(@"获取收件人地址编号%@",[[_listArray objectAtIndex:sender.tag] valueForKey:@"addr_id"]);
//    NSLog(@"获取收件人地址区域%@",[[_listArray objectAtIndex:sender.tag] valueForKey:@"area_name"]);

    AddAddressViewController *address = [[AddAddressViewController alloc] init];
    address.nameTextFieldField = [[_listArray objectAtIndex:sender.tag] valueForKey:@"username"];
    address.numberTextFieldField = [[_listArray objectAtIndex:sender.tag] valueForKey:@"mobile"];
    address.textViewView = [[_listArray objectAtIndex:sender.tag] valueForKey:@"address"];
    address.bianjidizhi = [[_listArray objectAtIndex:sender.tag] valueForKey:@"addr_id"];
    address.area = [[_listArray objectAtIndex:sender.tag] valueForKey:@"area_name"];
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    //    [self presentViewController:orderTrack animated:YES completion:nil];
    [self.navigationController pushViewController:address animated:YES];

    
//    AddAddressViewController *address = [[AddAddressViewController alloc] init];
//    
//    [self.navigationController pushViewController:address animated:YES];
}

- (void)delete:(UIButton *)sender
{
//    NSLog(@"--删除--");
    
//    NSLog(@"获取收件人地址编号%@",[NSString stringWithFormat:@"%ld",(long)sender.tag]);
    NSDictionary *dic = [PersonalRequest withURLStr:@"/index.php?s=/Api/Address/delete" withSetValue:USER_ID(QQQQ) withSetValue:[NSString stringWithFormat:@"%ld",(long)sender.tag] withSetValue:nil withSetValue:nil withForKey:@"user_id" withForKey:@"addr_id" withForKey:nil withForKey:nil];
    int status = [[dic valueForKey:@"status"] intValue];
    if (status == 0) {
        YBMB(@"删除成功")
    }else if (status == 1){
        YBMB([dic valueForKey:@"data"])
    }
    [_managementAddresTableView reloadData];
    [NSThread detachNewThreadSelector:@selector(getAddress) toTarget:self withObject:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 155;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 60)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_order_manage) {
        
    }else if (_order_manage){
//        NSLog(@"获取收件人姓名%@",[[_listArray objectAtIndex:indexPath.section] valueForKey:@"username"]);
//        NSLog(@"获取收件人手机号%@",[[_listArray objectAtIndex:indexPath.section] valueForKey:@"mobile"]);
//        NSLog(@"获取收件人详细地址%@",[[_listArray objectAtIndex:indexPath.section]
//                              valueForKey:@"address"]);
//        NSLog(@"获取收件人地址编号%@",[[_listArray objectAtIndex:indexPath.section] valueForKey:@"addr_id"]);
        
        NSString *cityArea = [NSString stringWithFormat:@"%@ %@",[[_listArray objectAtIndex:indexPath.section] valueForKey:@"city"],[[_listArray objectAtIndex:indexPath.section] valueForKey:@"area_name"]];
//        NSLog(@"获取城市区域%@",cityArea);
        [[BoolViewController alloc] testOut];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:[[_listArray objectAtIndex:indexPath.section] valueForKey:@"username"] forKey:@"username"];
        [dic setValue:[[_listArray objectAtIndex:indexPath.section] valueForKey:@"mobile"] forKey:@"mobile"];
        [dic setValue:[[_listArray objectAtIndex:indexPath.section] valueForKey:@"address"] forKey:@"address"];
        [dic setValue:[[_listArray objectAtIndex:indexPath.section] valueForKey:@"addr_id"] forKey:@"addr_id"];
        [dic setValue:cityArea forKey:@"area_name"];
        //设置block传值内容
        if (user_Block) {
            user_Block(dic);
        }
        [self.navigationController popViewControllerAnimated:YES]; 
    }
}

#pragma  mark - 进入添加地址界面
- (void)showAddress
{
    AddAddressViewController *address = [[AddAddressViewController alloc] init];
//    [self presentViewController:address animated:YES completion:nil];
    [self.navigationController pushViewController:address animated:YES];
}

#pragma  mark - 获取地址详情
- (void)getAddress
{
    [[BoolViewController alloc] testOut];
    NSDictionary *dic = [PersonalRequest withURLStr:@"/index.php?s=/Api/Address/getlist" withSetValue:USER_ID(QQQQ) withSetValue:nil withSetValue:nil withSetValue:nil withForKey:@"user_id" withForKey:nil withForKey:nil withForKey:nil];
    int status = [[dic valueForKey:@"status"] intValue];
//    NSLog(@"--%@",[dic valueForKey:@"data"]);
    
    if (status == 0) {
        _listArray = [dic valueForKey:@"data"];
        [HUD removeFromSuperview];
        [_managementAddresTableView reloadData];
    } else if (status == 1) {
        [HUD removeFromSuperview];
        YBMB([dic valueForKey:@"data"])
        [_managementAddresTableView reloadData];

    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [NSThread detachNewThreadSelector:@selector(getAddress) toTarget:self withObject:nil];
}

#pragma  mark - 设置默认地址
- (void)sheweimoren:(UIButton *)sender
{
//    NSLog(@"--设为默认--");

//    NSLog(@"获取收件人地址编号%@",[NSString stringWithFormat:@"%ld",(long)sender.tag]);
    [[BoolViewController alloc] testOut];
    NSDictionary *dic = [PersonalRequest withURLStr:@"/index.php?s=/Api/Address/setdefault" withSetValue:USER_ID(QQQQ) withSetValue:[NSString stringWithFormat:@"%ld",(long)sender.tag] withSetValue:nil withSetValue:nil withForKey:@"user_id" withForKey:@"addr_id" withForKey:nil withForKey:nil];
//    NSLog(@"%@",dic);
    int status = [[dic valueForKey:@"status"] intValue];
    if (status == 0) {
        YBMB(@"已设为默认")
        [NSThread detachNewThreadSelector:@selector(getAddress) toTarget:self withObject:nil];
    }else if (status == 1){
        YBMB([dic valueForKey:@"data"])
    }
}

@end
