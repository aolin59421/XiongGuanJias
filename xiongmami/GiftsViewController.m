//
//  GiftsViewController.m
//  xiongmami
//
//  Created by iMac on 15/3/20.
//  Copyright (c) 2015年 杭州熊管佳电子商务有限公司. All rights reserved.
//

#import "GiftsViewController.h"

@interface GiftsViewController ()

@end

@implementation GiftsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0f green:239/255.0f blue:235/255.0f alpha:1];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(bback)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.title = @"红包";
    [self getAllGiftsData];
    
}
- (void)bback
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma  mark - tableCIew
- (void)tableView
{
    _giftsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT-64) style:UITableViewStylePlain];
    [_giftsTableView setDataSource:self];
    [_giftsTableView setDelegate:self];
    _giftsTableView.backgroundColor = [UIColor colorWithRed:245/255.0f green:239/255.0f blue:235/255.0f alpha:1];
    [_giftsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_giftsTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_giftsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil];
    TableViewCell *cell = [arr objectAtIndex:0];
//    cell.numberLab.text = [NSString stringWithFormat:@"编号:%@",[[_giftsArray objectAtIndex:indexPath.section] valueForKey:@"card_id"]];
    //红包名称和价值
    cell.giftsLab.text = [NSString stringWithFormat:@"%@",[[_giftsArray objectAtIndex:indexPath.section] valueForKey:@"title"]];
    //有效期
    cell.timeLab.text = [NSString stringWithFormat:@"有效期至:%@",[self getOrderDate:[[_giftsArray objectAtIndex:indexPath.section] valueForKey:@"etime"]]];
    //红包图片
    if ([[NSString stringWithFormat:@"%@",[[_giftsArray objectAtIndex:indexPath.section] valueForKey:@"repeat"]] integerValue] == 1) {
        cell.chai.image = [UIImage imageNamed:@"tb_01.png"];
        cell.chai.frame = CGRectMake(70+cell.giftsLab.text.length*15, 14, 15, 15);
    }else{
        cell.chai.image = [UIImage imageNamed:@""];
        cell.chai.frame = CGRectMake(70+cell.giftsLab.text.length*15, 14, 15, 15);
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([BoolViewController isNOTNull:[[_giftsArray objectAtIndex:indexPath.section] valueForKey:@"image"]] == NO) {
        NSLog(@"空了");
    }else{
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[[_giftsArray objectAtIndex:indexPath.section] valueForKey:@"image"]]];
        [cell.giftsImage setImageWithURL:url];
    }
    NSInteger amount = [[[_giftsArray objectAtIndex:indexPath.section] valueForKey:@"amount"] integerValue];
    cell.money_lab.text = [NSString stringWithFormat:@"¥%ld",(long)amount];
    
//    cell.imageView.image = [UIImage imageNamed:@"icon.png"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:245/255.0f green:239/255.0f blue:235/255.0f alpha:1];
    return view;
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
#pragma  mark - 获取红包信息
- (void)getAllGiftsData
{
    [[BoolViewController alloc] testOut];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:USER_ID(QQQQ) forKey:@"user_id"];
    [dic setValue:USER_TOKEN(QQQQ) forKey:@"skey"];
//    NSLog(@"--duc-%@",dic);
    
    [PerAFNetBlockRequest AFNRequest:@"/index.php?s=/Api/User/getcardlist" dic:dic AFNBlock:^(NSDictionary *resp, NSStringEncoding encoding){
//        NSLog(@"resp-%@",resp);
        [self getUserInformation:resp];
        
        
    }AFNEror:^(NSError *error){
        NSLog(@"ERRPR--%@",error);
    }];
    
}

- (void)getUserInformation:(NSDictionary *)resp
{
//    NSLog(@"da-%@",resp);
    _giftsArray = [resp valueForKey:@"data"];
//    NSLog(@"yi-%@",[resp valueForKey:@"data"]);
//    NSLog(@"er-%@",_giftsArray);
    [self tableView];
    [_giftsTableView reloadData];
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
