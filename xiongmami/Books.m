//
//  Books.m
//  xiongmami
//
//  Created by iMac on 14/11/22.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "Books.h"
#import "BooksTableViewCell.h"
#import "NIDropDown.h"
#import "HexadecimalConversionUICOLOR.h"

@implementation Books

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"记账本";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addCustomView];
    [self addBoolsTableView];
//    [self withPicker];
    //信息为空时  提示文本
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(bback)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [NSThread detachNewThreadSelector:@selector(getBookList) toTarget:self withObject:nil];
    
}

- (void)bback
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addCustomView
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, 100)];
    //分割线
    UIImageView *fengexian = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/3-10, 74, 0.5, 80)];
//    [fengexian setImage:[UIImage imageNamed:@"mainBg.png"]];
    [fengexian setBackgroundColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#f0f3f5"]];
    [self.view addSubview:fengexian];
    
    UIImageView *fengexian1 = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/3*2, 74, 0.5, 80)];
//    [fengexian1 setImage:[UIImage imageNamed:@"mainBg.png"]];
    [fengexian1 setBackgroundColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#f0f3f5"]];
    [self.view addSubview:fengexian1];
    
    UIView *lalal = [[UIView alloc] initWithFrame:CGRectMake(0, 164, VIEW_FRAME_SIZE_WIDTH, 20)];
    lalal.backgroundColor = [UIColor colorWithRed:246/255.0f green:240/255.0f blue:236/255.0f alpha:1];
    [self.view addSubview:lalal];
//    [topView setBackgroundColor:[UIColor whiteColor]];
//    [self.view addSubview:topView];
    
    //时间
    _yearLab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/9-20, 69, VIEW_FRAME_SIZE_WIDTH/9+30, 40)];
    _yearLab.text =[NSString stringWithFormat:@"%@",[self timetime:@"YYYY"]];
    [_yearLab setTextAlignment:NSTextAlignmentCenter];
    [_yearLab setFont:[UIFont systemFontOfSize:17]];
    [self.view addSubview:_yearLab];
    
    _monthLab = [[UIButton alloc] initWithFrame:CGRectMake(0, topView.frame.size.height/2+64, 80, 40)];
    [_monthLab setTitle:[NSString stringWithFormat:@"%@",[self timetime:@"MM"]] forState:UIControlStateNormal];
    [_monthLab.titleLabel setFont:[UIFont systemFontOfSize:25]];
    [_monthLab.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [_monthLab setTitleColor:[UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:1] forState:UIControlStateNormal];
    [_monthLab addTarget:self action:@selector(withPicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_monthLab];
    

    
    UILabel *monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, topView.frame.size.height/2+5+64, 20, 30)];
    monthLabel.text = @"月";
    [self.view addSubview:monthLabel];
    
    UIImageView *mothImageView = [[UIImageView alloc] initWithFrame:CGRectMake(75, topView.frame.size.height/2+25+64, 10, 5)];
    [mothImageView setImage:[UIImage imageNamed:@"下拉.png"]];
    [self.view addSubview:mothImageView];
    
    //支出
    UILabel *payUpLabel = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/3, 5+64, VIEW_FRAME_SIZE_WIDTH/3, 40)];
    payUpLabel.text =@"支出（元）";
    [payUpLabel setTextAlignment:NSTextAlignmentCenter];
    [payUpLabel setFont:[UIFont systemFontOfSize:17]];
    [self.view addSubview:payUpLabel];
    
    _payUpLab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/3-5, topView.frame.size.height/2+64, VIEW_FRAME_SIZE_WIDTH/3-1, 40)];
    _payUpLab.text = @"500";
    [_payUpLab setFont:[UIFont systemFontOfSize:25]];
    [_payUpLab setTextAlignment:NSTextAlignmentCenter];
    [_payUpLab setTextColor:[UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:1]];
    [self.view addSubview:_payUpLab];
    
    //收入
    UILabel *payInLabel = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/3*2, 5+64, VIEW_FRAME_SIZE_WIDTH/3, 40)];
    payInLabel.text =@"收入（元）";
    [payInLabel setTextAlignment:NSTextAlignmentCenter];
    [payInLabel setFont:[UIFont systemFontOfSize:17]];
    [self.view addSubview:payInLabel];
    
    _payInLab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/3*2-5, topView.frame.size.height/2+64, VIEW_FRAME_SIZE_WIDTH/3, 40)];
    _payInLab.text = @"500";
    [_payInLab setFont:[UIFont systemFontOfSize:25]];
    [_payInLab setTextAlignment:NSTextAlignmentCenter];
    [_payInLab setTextColor:[UIColor colorWithRed:48/255.0f green:117/255.0f blue:10/255.0f alpha:1]];
    [self.view addSubview:_payInLab];

}

-(void)getBookList
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = @"加载中";
    [HUD show:YES];
    
    [self booksListYear:_yearLab.text withMonth:_monthLab.titleLabel.text];
}
#pragma  mark - tableView
- (void)addBoolsTableView
{
    _booksTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 184, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT - 184) style:UITableViewStyleGrouped];
    
    _booksTableView.dataSource = self;
    _booksTableView.delegate = self;
    _booksTableView.bounces = NO;
    _booksTableView.backgroundColor = [UIColor colorWithRed:246/255.0f green:240/255.0f blue:236/255.0f alpha:1];
    [self.view addSubview:_booksTableView];
    
    _lab =[[UILabel alloc] initWithFrame:CGRectMake(0, _booksTableView.frame.size.height/3, VIEW_FRAME_SIZE_WIDTH, 40)];
    if ([_listArray count] == 0) {
        
        _lab.text = @"亲～当月没有账务信息哟！";
        _lab.font = [UIFont systemFontOfSize:17];
        [_lab setNumberOfLines:0];
        _lab.textColor = [UIColor lightGrayColor];
        _lab.textAlignment = NSTextAlignmentCenter;
    }
    [_booksTableView addSubview:_lab];
}

#pragma  mark -UITableViewDelegate&DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_listArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    _rowListArray =  [[_listArray valueForKey:@"record"] objectAtIndex:section];
    
    return [_rowListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIDF = @"Cell";
    BooksTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIDF];
    if (cell == nil) {
        cell = [[BooksTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIDF];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    NSLog(@"%ld",(long)indexPath.section);
    NSDictionary *dic = [[[_listArray objectAtIndex:indexPath.section] valueForKey:@"record"] objectAtIndex:indexPath.row];
    NSString *textMrak = [dic valueForKey:@"mark"];
    cell.nameLab.text = [NSString stringWithFormat:@"%@",textMrak];
    
    CGFloat amount = [[dic valueForKey:@"amount"] floatValue];
    
    if (amount < 0) {
        NSString *str = [NSString stringWithFormat:@"%.2f",amount];
//        NSLog(@"小于0====%@",str);
        cell.numberLab.text = str;
        cell.numberLab.textColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:1];
    }else if (amount > 0) {
        NSString *str = [NSString stringWithFormat:@"%.2f",amount];
//        NSLog(@"大于0====%@",str);
        cell.numberLab.text = str;
        cell.numberLab.textColor = [UIColor colorWithRed:48/255.0f green:116/255.0f blue:11/255.0f alpha:1];
    }else{
        NSString *str = [NSString stringWithFormat:@"%.2f",amount];
//        NSLog(@"呵呵====%@",str);
        cell.numberLab.text = str;
        cell.numberLab.textColor = [UIColor colorWithRed:48/255.0f green:116/255.0f blue:11/255.0f alpha:1];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 60)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    UILabel *headerTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, VIEW_FRAME_SIZE_WIDTH, 40)];
    NSDictionary * dic = [_listArray objectAtIndex:section];
    NSString *str = [dic valueForKey:@"date"];
    headerTimeLable.text = [NSString stringWithFormat:@"%@日",str];
    [headerTimeLable setTextAlignment:NSTextAlignmentLeft];
    [headerTimeLable setFont:[UIFont systemFontOfSize:20]];
    [headerView addSubview:headerTimeLable];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (iPhone6Plus) {
        return 55;
    }else{
        return 44;
    }
}

- (NSString *)timetime:(NSString *)timew
{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:[NSString stringWithFormat:@"%@",timew]];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    return locationString;
}

#pragma  mark - UIPickerViewDataSource & UIPickerViewDelegate
- (void)withPicker
{
    _yearListArray = [NSMutableArray arrayWithObjects:@"2014",@"2015", nil];
    
    _mothListArray = [NSMutableArray arrayWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", nil];
    _bigArray = [[NSMutableArray alloc] initWithObjects:_yearListArray,_mothListArray, nil];
    
    _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, VIEW_FRAME_SIZE_WIDTH, 216)];
    [_picker setBackgroundColor:[UIColor whiteColor]];
    _picker.dataSource = self;
    _picker.delegate = self;
    
    LZWCustomActionSheet *actionSheet = [[LZWCustomActionSheet alloc] initWithView:_picker AndHeight:260];
    actionSheet.doneDelegate = self;
    [actionSheet showInView:self.view];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return [_bigArray count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    //    NSLog(@"%@",[_zongArray objectAtIndex:component]);
    return [[_bigArray objectAtIndex:component] count];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //先根据component找到大数组中对应的小数组，然后根据row从小数组中找到对应的title
    return[[_bigArray objectAtIndex:component] objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickerView reloadAllComponents];
    if (component == 0) {
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
}

#pragma  mark - 查询列表Request
- (void)booksListYear:(NSString *)year withMonth:(NSString *)month
{
    [[BoolViewController alloc] testOut];
    
    _listArray = nil;
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *userID = [userDefault objectForKey:@"user_id"];
    
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] init];
    [userDic setValue:userID forKey:@"user_id"];
    [userDic setValue:[NSString stringWithFormat:@"%@%@",year,month] forKey:@"month"];
    
    NSDictionary *dic = [PersonalRequest withAllUrll:@"/index.php?s=/Api/User/getbalancelist" WithDic:userDic];
    NSInteger status = [[dic valueForKey:@"status"] intValue];
    if (status == 0) {
        NSDictionary *data = [dic valueForKey:@"data"];
        //支出
        NSString *totalpay = [data valueForKey:@"totalpay"];
        
        if (totalpay == nil || totalpay == NULL) {
            _payUpLab.text = @"0";
        }else{
            _payUpLab.text = [NSString stringWithFormat:@"%@",totalpay];
        }
//        NSLog(@"pay-up%@",[NSString stringWithFormat:@"%@",totalpay]);
        //收入
        NSString *totalincome = [data valueForKey:@"totalincome"];
//        NSLog(@"%@",totalincome);
        if (totalincome == nil || totalincome == NULL) {
            _payInLab.text = @"0";
        }else {
            _payInLab.text = [NSString stringWithFormat:@"%@",totalincome];
        }
//        NSLog(@"pay-in%@",[NSString stringWithFormat:@"%@",totalincome]);
        //信息列表
        _listArray = [data valueForKey:@"list"];
        
        if ([_listArray count] != 0) {
            [_lab setText:@""];
        }else if ([_listArray count] == 0) {
            
            _lab.text = @"亲～当月没有账务信息哟！";
            _lab.font = [UIFont systemFontOfSize:17];
            [_lab setNumberOfLines:0];
            _lab.textColor = [UIColor lightGrayColor];
            _lab.textAlignment = NSTextAlignmentCenter;
        }
        
        [_booksTableView reloadData];
        
//        NSLog(@"-z-z-z-%lu,toin%@,,to%@,%@",(unsigned long)[_listArray count],totalincome,totalpay,dic);
        [HUD removeFromSuperview];
    }else if (status == 1){
        [HUD removeFromSuperview];
        [[YBProgressShow defaultProgress] showText:[dic valueForKey:@"data"] InMode:MBProgressHUDModeDeterminate OriginViewEnableTouch:YES HideAfterDelayTime:1];
    }
}

- (void)done
{
    NSInteger provinceRow = [_picker selectedRowInComponent:0];
    
    NSInteger city = [_picker selectedRowInComponent:1];
    
//    NSLog(@"---------%@-%@",[_yearListArray objectAtIndex:provinceRow],[_mothListArray objectAtIndex:city]);
    
    _yearTime = [[NSMutableString alloc] initWithString:[_yearListArray objectAtIndex:provinceRow]];
//    NSLog(@"=====%@",_yearTime);
    
    _yearLab.text = _yearTime;
    
    _monthLab.titleLabel.text = [_mothListArray objectAtIndex:city];
    _monthTime = [_mothListArray objectAtIndex:city];

    [self booksListYear:_yearTime withMonth:_monthTime];
    
    [_picker reloadAllComponents];
}
@end
