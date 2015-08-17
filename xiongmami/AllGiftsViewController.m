//
//  AllGiftsViewController.m
//  xiongmami
//
//  Created by iMac on 15/3/24.
//  Copyright (c) 2015年 杭州熊管佳电子商务有限公司. All rights reserved.
//

#import "AllGiftsViewController.h"

@interface AllGiftsViewController ()
{
    NSMutableArray *_flagArray;//设置全局可变数组用来记录被点击状态
}
@end

@implementation AllGiftsViewController

- (id)initWithBlock:(XGJALLGIFTS_BLOCK)dic
{
    self = [super init];
    if(self)
    {
        user_Block = dic;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"红包";
    self.view.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#f8f3f0"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(bback)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self getAllGiftsData];
}

- (void)bback
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark - UITableViewDataSource,UITableViewDelegate
- (void)customTableView
{
    _allGiftsTableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT - 64) style:UITableViewStyleGrouped];
    _allGiftsTableView.delegate = self;
    _allGiftsTableView.dataSource = self;
    [_allGiftsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_allGiftsTableView setBackgroundColor:[UIColor colorWithRed:245/255.0f green:239/255.0f blue:235/255.0f alpha:1]];
    [self.view addSubview:_allGiftsTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    NSLog(@"-%ld",(long)[_gifts_Array count]);
    return [_gifts_Array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell0%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    AllGiftsTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"AllGiftsTableViewCell" owner:nil options:nil];
        cell = [arr lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.giftsNumLab.text = [NSString stringWithFormat:@"%@",[[_gifts_Array objectAtIndex:indexPath.section] valueForKey:@"card_id"]];
    cell.pjGiftsBtn.text = [NSString stringWithFormat:@"%@",[[_gifts_Array objectAtIndex:indexPath.section] valueForKey:@"title"]];
    cell.giftsTimeLab.text = [NSString stringWithFormat:@"%@",[self getOrderDate:[[_gifts_Array objectAtIndex:indexPath.section] valueForKey:@"etime"]]];

    if ([[NSString stringWithFormat:@"%@",[[_gifts_Array objectAtIndex:indexPath.section] valueForKey:@"repeat"]] integerValue] == 1) {
        cell.chai.image = [UIImage imageNamed:@"tb_01.png"];
//        NSLog(@"asdasdasd\n%ld",(long)cell.pjGiftsBtn.text.length*15);
        cell.chai.frame = CGRectMake(70+(NSInteger)cell.pjGiftsBtn.text.length*15, 14, 15, 15);
    }else{
        cell.chai.image = [UIImage imageNamed:@""];
        cell.chai.frame = CGRectMake(70+(NSInteger)cell.pjGiftsBtn.text.length*15, 14, 15, 15);
    }
    
    if ([_flagArray[indexPath.section] integerValue] == 0) {
        [cell.xzImgae setImage:[UIImage imageNamed:@"fuxuan2.png"]];
    }else{
        [cell.xzImgae setImage:[UIImage imageNamed:@"fuxuan.png"]];
    }
//    [[NSString stringWithFormat:@"%@",sex] rangeOfString:@"1"].location !=NSNotFound
    
    if ([BoolViewController isNOTNull:[[_gifts_Array objectAtIndex:indexPath.section] valueForKey:@"image"]] == NO) {
        NSLog(@"空了");
    }else{
        NSLog(@"nil");
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[[_gifts_Array objectAtIndex:indexPath.section] valueForKey:@"image"]]];
        [cell.cellImage setImageWithURL:url];
    }
//    cell.str = [NSString stringWithFormat:@"￥%@",[[_gifts_Array objectAtIndex:indexPath.section] valueForKey:@"amount"]];
//    NSLog(@"%ld",(long)[cell.str length]);
//    cell.mabs =[self allGifts:[UIFont systemFontOfSize:15] withText:cell.str withRange:NSMakeRange(1, [cell.str length]-1) withColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#e12e11"]];
//    
//    cell.money_lab.attributedText = cell.mabs;
//    cell.money_lab.adjustsFontSizeToFitWidth = YES;
//    [cell.money_lab sizeToFit];
    NSInteger amount = [[[_gifts_Array objectAtIndex:indexPath.section] valueForKey:@"amount"] integerValue];
    cell.money_lab.text = [NSString stringWithFormat:@"¥%ld",(long)amount];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"Selected section %lu, cell %lu",
    
//          (unsigned long)[ indexPath indexAtPosition: 0 ], (unsigned long)[ indexPath indexAtPosition: 1 ]);
    
    //获的当前选择项
    //判断是否被点击过
    if ([_flagArray[indexPath.section] integerValue] == 0){
        //没被点击  记录数组为1
    _flagArray[indexPath.section] = [NSNumber numberWithInt:1];
        //把需要的数据存进字典里
        [_dic setValue:_flagArray[indexPath.section] forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
    }
    else{
        //被点击过  记录数组为0
        _flagArray[indexPath.section] = [NSNumber numberWithInt:0];
        
        //把需要的数据存进字典里
        [_dic removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
    }
//    NSLog(@"-%@",_flagArray[indexPath.section]);
    
//    NSLog(@"dic-%@",_dic);
    
    [tableView reloadData];
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

#pragma  mark - 底部全选标签栏
- (void)downToolBar
{
    UIView *downToolBarView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_FRAME_SIZE_HEIGHT -49, VIEW_FRAME_SIZE_WIDTH, 49)];
    downToolBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:downToolBarView];
    
     imageViewBtn= [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 25, 25)];
    [imageViewBtn setImage:[UIImage imageNamed:@"fuxuan2.png"]];
    [downToolBarView addSubview:imageViewBtn];
    
    UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageBtn setFrame:CGRectMake(0, 0, 95, 49)];
    [imageBtn setBackgroundColor:[UIColor clearColor]];
    [imageBtn addTarget:self action:@selector(quanxuan:) forControlEvents:UIControlEventTouchUpInside];
    cellBtn = NO;
    [downToolBarView addSubview:imageBtn];
    
    UIButton *Okbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Okbtn setFrame:CGRectMake(95, 6, VIEW_FRAME_SIZE_WIDTH-110, 37)];
    [Okbtn setBackgroundImage:[UIImage imageNamed:@"保存btn.png"] forState:UIControlStateNormal];
    [Okbtn setTitle:@"确定" forState:UIControlStateNormal];
    [Okbtn addTarget:self action:@selector(OKtijiao:) forControlEvents:UIControlEventTouchUpInside];
    [downToolBarView addSubview:Okbtn];
    
    UILabel *quanxuanLab = [[UILabel alloc] initWithFrame:CGRectMake(45, 15, 40, 20)];
    quanxuanLab.text = @"全选";
    [quanxuanLab setFont:[UIFont systemFontOfSize:20]];
    [downToolBarView addSubview:quanxuanLab];
}

- (void)quanxuan:(UIButton*)sender
{
    NSLog(@"全选");
    //获取所有cell   AllGiftsTableViewCell 自定义Cell类
    AllGiftsTableViewCell *cell = (AllGiftsTableViewCell *)[_allGiftsTableView cellForRowAtIndexPath:0];
    //判断是否被点击
    if (cellBtn == NO) {
        //没被点  设置cell点击状态图片或按钮状态
        //底部全选按钮状态图片
        [imageViewBtn setImage:[UIImage imageNamed:@"fuxuan.png"]];
        //cell中标示是否点击的状态图片
        [cell.xzImgae setImage:[UIImage imageNamed:@"fuxuan.png"]];
        for (int i = 0; i < [_flagArray count]; i++) {
            //被点击过  数组记录所有CELL为1
            _flagArray[i] = [NSNumber numberWithInt:1];
            //存储所有CELL中所需要的数据
            [_dic setValue:_flagArray[i] forKey:[NSString stringWithFormat:@"%d",i]];
        }
        //bool值设为yes  标示已被点击
        cellBtn = YES;
    }else{
        //被点 设置cell没被点击状态图片或按钮状态
        //底部全选按钮状态图片
        [imageViewBtn setImage:[UIImage imageNamed:@"fuxuan2.png"]];
        //cell中标示是否点击的状态图片
        [cell.xzImgae setImage:[UIImage imageNamed:@"fuxuan2.png"]];
        for (int i = 0; i < [_flagArray count]; i++) {
            //没被点击  数组记录cell为0
            _flagArray[i] = [NSNumber numberWithInt:0];
            //没被选 删除所有记录在字典中的数据
            [_dic removeObjectForKey:[NSString stringWithFormat:@"%d",i]];
        }
        //bool值设为NO  标示取消点击
        cellBtn = NO;
    }
    //刷新表
    [_allGiftsTableView  reloadData];
//    NSLog(@"quanxuan-%@",_dic);
    
//    NSString *dic_array;
//    for (dic_array in _dic) {
//        NSLog(@"dic_array-%@",dic_array);
//        if ([dic_array integerValue] == 1) {
//            
//        }
//    }
}

- (void)OKtijiao:(UIButton *)sender
{
    
    NSString *dic_array;//遍历接受所选红包编号
    NSString *zje;//金额
    NSString *cardId;//红包编号
//    NSLog(@"_dic-\n%@",_dic);
    for (dic_array in _dic) {
//        NSLog(@"dic_array-%@",dic_array);
//        NSLog(@"_gifts_array-\n%ld",(long)[dic_array integerValue]);
        //获取选中红包金额
        zje = [[_gifts_Array objectAtIndex:[dic_array integerValue]] valueForKey:@"amount"];
//        NSLog(@"dsaasdadasdd\n%@",zje);
        //获取选中红包编号
        cardId = [[_gifts_Array objectAtIndex:[dic_array integerValue]] valueForKey:@"id"];
//        NSLog(@"asdasdasdasdadsadds\n%@",cardId);
        //存储选中红包金额
        [_gifts_amount addObject:zje];
        //存储选中红包编号
        [_gifts_card_id addObject:cardId];
    }
//    NSLog(@"-----%@",_gifts_amount);
    //选中红包金额求和
    NSNumber *amountNumber = [_gifts_amount valueForKeyPath:@"@sum.floatValue"];
//    NSLog(@"-1-%@\n-2-%@",amountNumber,_gifts_card_id);
    [_dicVal setValue:amountNumber forKey:@"amountNumber"];
    [_dicVal setValue:_gifts_card_id forKey:@"card_id"];
//    NSLog(@"OK-%@",_dicVal);
    if (user_Block) {
        user_Block(_dicVal);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
    //添加POST请求参数
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:USER_ID(QQQQ) forKey:@"user_id"];
    [dic setValue:USER_TOKEN(QQQQ) forKey:@"skey"];
//    NSLog(@"--duc-%@",dic);
    //设置URL 添加请求DIC参数
    [PerAFNetBlockRequest AFNRequest:@"/index.php?s=/Api/User/getcardlist" dic:dic AFNBlock:^(NSDictionary *resp, NSStringEncoding encoding){
//        NSLog(@"resp-%@",resp);
        //调方法传回调数据DICresp
        [self getUserInformation:resp];
        
    }AFNEror:^(NSError *error){
        NSLog(@"ERRPR--%@",error);
    }];
}

- (void)getUserInformation:(NSDictionary *)resp
{
//    NSLog(@"da-%@",resp);
    _gifts_Array = [resp valueForKey:@"data"];
//    NSLog(@"yi-%@",[resp valueForKey:@"data"]);
//    NSLog(@"er-%@",_gifts_Array);
    
    [self customTableView];
    [self downToolBar];
    _dic= [[NSMutableDictionary alloc] init];
    _dicVal = [[NSMutableDictionary alloc] init];
    _gifts_amount = [[NSMutableArray alloc] init];
    _flagArray = [[NSMutableArray alloc] init];
    _gifts_card_id = [[NSMutableArray alloc] init];
    
    //把数组置为0
    for (int i = 0; i <[_gifts_Array count]; i++) {
        _flagArray[i] = [NSNumber numberWithInt:0];
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

#pragma  mark - 改变部分字符串  大小
- (NSMutableAttributedString *)allGifts:(UIFont *)font
                               withText:(NSString *)text
                              withRange:(NSRange)range
                              withColor:(UIColor*)color
{
    //设置字体大小
//    NSMutableDictionary *attrsDictionary = [NSMutableDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    //设置类型
//    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
//    [attrsDictionary setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    //输入需要改变的文本
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text]; //attributes:attrsDictionary];
    //需要修改的颜色
//    [attributedText addAttribute:NSForegroundColorAttributeName value:color range:range];
    //设置字间距
    NSNumber *number = 0;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [attributedText addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[text length])];
    
    return attributedText;
}
@end
