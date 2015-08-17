//
//  JfViewController.m
//  xiongmami
//
//  Created by iMac on 14/11/22.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "JfViewController.h"
#import "JfTableViewCell.h"
#import "HexadecimalConversionUICOLOR.h"

@implementation JfViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"积分";
    self.view.backgroundColor = [UIColor blueColor];
    [self addIntegralTableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(delete)];
    self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"Delete.png"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(bback)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)bback
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark - tableView
- (void)addIntegralTableView
{
    _integralTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT) style:UITableViewStyleGrouped];
    _integralTableView.delegate = self;
    _integralTableView.dataSource = self;
    _integralTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_integralTableView];
}

#pragma  mark -UITableViewDelegate&DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIDF = @"Cell";
    JfTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:CellIDF];
    if (Cell == nil) {
        Cell = [[JfTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIDF];
    }
    Cell.selectionStyle = UITableViewCellSeparatorStyleNone;

    NSDictionary *dic = [_listArray objectAtIndex:indexPath.row];
    Cell.nameLab.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"mark"]];
    if ([[dic valueForKey:@"score"] intValue] >= 0 ) {
        Cell.numberLab.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"score"]];
        Cell.numberLab.textColor = [UIColor colorWithRed:48/255.0f green:116/255.0f blue:11/255.0f alpha:1];
    } else if ([[dic valueForKey:@"score"] intValue] < 0 ) {
        Cell.numberLab.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"score"]];
        Cell.numberLab.textColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:1];
    }
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@",[dic valueForKey:@"ctime"]] intValue]];
    NSString *ssttrr = [NSString stringWithFormat:@"%@",confromTimesp];
    NSString *sstr = [ssttrr stringByReplacingOccurrencesOfString:@"+0000" withString:@""];
//    NSLog(@"-%@",sstr);
    Cell.timeLab.text = sstr;
    
    return Cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
#pragma  mark - 取用户积分详细
- (void)getUserJF
{

    [[BoolViewController alloc] testOut];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *userID = [userDefault objectForKey:@"user_id"];
    
    NSDictionary *jfDic = [PersonalRequest withURLStr:@"/index.php?s=/Api/User/getscorelist" withSetValue:userID withSetValue:nil withSetValue:nil withSetValue:nil withForKey:@"user_id" withForKey:nil withForKey:nil withForKey:nil];
    
    
    NSInteger status = [[jfDic valueForKey:@"status"] intValue];
    
    if (status == 0) {
        _listArray = [jfDic valueForKey:@"data"];

        //mark - 原因  score - 分数 time - 时间
    } else if(status == 1){
        [[YBProgressShow defaultProgress] showText:[jfDic valueForKey:@"data"] InMode:MBProgressHUDModeDeterminate OriginViewEnableTouch:YES HideAfterDelayTime:1];
    }
}

- (void)delete
{
    _alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否全部删除" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [_alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[BoolViewController alloc] testOut];
        NSDictionary *jfDic = [PersonalRequest withURLStr:@"/index.php?s=/Api/User/delscore" withSetValue:USER_ID(QQQQ) withSetValue:nil withSetValue:nil withSetValue:nil withForKey:@"user_id" withForKey:nil withForKey:nil withForKey:nil];
        
        
        NSInteger status = [[jfDic valueForKey:@"status"] intValue];
        
        if (status == 0) {
            
//            NSLog(@"zzzz%@",jfDic);

            YBMB(@"删除成功")
            
            //mark - 原因  score - 分数 time - 时间
        } else if(status == 1){
            [[YBProgressShow defaultProgress] showText:[jfDic valueForKey:@"data"] InMode:MBProgressHUDModeDeterminate OriginViewEnableTouch:YES HideAfterDelayTime:1];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [NSThread detachNewThreadSelector:@selector(getUserJF) toTarget:self withObject:nil];
}
@end
