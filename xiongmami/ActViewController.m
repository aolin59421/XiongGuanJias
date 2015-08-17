//
//  ActViewController.m
//  xiongmami
//
//  Created by iMac on 14/12/12.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "ActViewController.h"
#import "PlaceTheOrder.h"
#import "ACTTableViewCell.h"
#import "ActivityViewController.h"

@interface ActViewController ()
@property (nonatomic, retain)CycleScrollView *mainScorllView;;
@end

@implementation ActViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动商城";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下单" style:UIBarButtonItemStylePlain target:self action:@selector(xiadan)];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
//    [self customView];
//    [self actTableView];
    
    [NSThread detachNewThreadSelector:@selector(getActView) toTarget:self withObject:nil];
//    [NSThread detachNewThreadSelector:@selector(getImage) toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(actTableView) toTarget:self withObject:nil];
    [self getImage];
//    [self getActView];
//    [self heardScroller];
//    NSLog(@"%@",USER_ID(QQQQ));

    //未登录
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *userID = [userDefault objectForKey:@"user_id"];
    if (userID == nil || userID == NULL) {
        UILabel *navLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 64)];
        navLab.backgroundColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];
        [navLab setNumberOfLines:0];
        navLab.text = @"\n活动商城";
        navLab.textAlignment = NSTextAlignmentCenter;
        navLab.font = [UIFont systemFontOfSize:20];
        navLab.textColor = [UIColor whiteColor];
        [self.view addSubview:navLab];
        
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        back.frame = CGRectMake(5, 20, 44, 44);
        [back setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        [back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [back.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:back];
        
        UIButton *placeTheOrder = [UIButton buttonWithType:UIButtonTypeCustom];
        placeTheOrder.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 70, 20, 60, 44);
        [placeTheOrder setTitle:@"下单" forState:UIControlStateNormal];
        [placeTheOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [placeTheOrder.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [placeTheOrder addTarget:self action:@selector(xiadan) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:placeTheOrder];
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(bback)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    _listArray = [[NSArray alloc]init];
    _imageListArray = [[NSArray alloc] init];
}

- (void)bback
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)actTableView
{
    
    if (USER_ID(QQQQ) != nil) {
        _actTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 174, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT) style:UITableViewStyleGrouped];
        if (iPhone6Plus) {
            _actTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 229, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT) style:UITableViewStyleGrouped];
        }
//        NSLog(@"user_id=%@",USER_ID(QQQQ));
    }else {
        _actTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 174, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT) style:UITableViewStyleGrouped];
        if (iPhone6Plus) {
            _actTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 229                 , VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT) style:UITableViewStyleGrouped];
        }
//        NSLog(@"user_id123=%@",USER_ID(QQQQ));
    }
    _actTableView.delegate = self;
    _actTableView.dataSource = self;
    [self.view addSubview:_actTableView];
    
    _actLab_Null = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 40)];
    _actLab_Null.text = @"亲～没有已完成的订单哟！";
    _actLab_Null.font = [UIFont systemFontOfSize:17];
    _actLab_Null.textColor = [UIColor lightGrayColor];
    _actLab_Null.textAlignment = NSTextAlignmentCenter;
    [_actTableView addSubview:_actLab_Null];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    __weak ActViewController *actViewController = self;
    [_actTableView headerBeginRefreshing];
    [_actTableView addPullToRefreshWithActionHandler:^{
        [actViewController insertRowAtTop];
    }];
}
#pragma  mark - 活动轮播
- (void)heardScroller
{
    
    UIView *views = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 110)];
    if (USER_ID(QQQQ) != nil) {
        views.frame = CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, 110);
        if (iPhone6Plus) {
            views.frame = CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, 165);
        }
    }else{
        views.frame = CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, 110);
        if (iPhone6Plus) {
            views.frame = CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, 165);
        }
    }
        NSInteger imagelist;
        if ([_imageListArray count] > 0) {
            imagelist = 0;
            
            NSMutableArray *viewsArray = [@[] mutableCopy];
            //    NSArray *colorArray = @[[UIColor redColor],[UIColor blueColor],[UIColor orangeColor]];
            for (NSInteger i = 0; i < imagelist; i++) {
                UIImageView *imageviewview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 110)];
                if (iPhone6Plus) {
                    imageviewview.frame = CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 165);
                }
                
                [imageviewview setImageWithURL:[[_imageListArray objectAtIndex:i] valueForKey:@"banner_url"]];
                [viewsArray addObject:imageviewview];
            }
            
            self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 110) animationDuration:2];
            if (iPhone6Plus) {
                self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 165) animationDuration:2];
                [self.mainScorllView.pageControl setFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH - 80, 120, 50, 50)];
            }
            self.mainScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
            //        [self.mainScorllView.scrollView setShowsHorizontalScrollIndicator:NO];
            self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
                return viewsArray[pageIndex];
            };
            
            self.mainScorllView.pageControl.numberOfPages = imagelist;
            self.mainScorllView.totalPagesCount = ^NSInteger(void){
                return imagelist;
            };
            
            __block ActViewController *meSelf = self;
            
            self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
//                NSLog(@"点击了第%ld个",(long)pageIndex);
                [meSelf tiaozhuanhuodongxiangqing:pageIndex];
            };
            
            [views addSubview:self.mainScorllView];
            [self.view addSubview:views];
            [self.mainScorllView.animationTimer setFireDate:[NSDate distantPast]];
        }
    
}

#pragma  mark -下拉刷新
- (void)insertRowAtTop
{
    [NSThread detachNewThreadSelector:@selector(getActView) toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(getImage) toTarget:self withObject:nil];
}
#pragma mark - tableviewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_listArray count] >1) {
        return [_listArray count];
    }else{
        return 0;
    }
   
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIDF = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
    ACTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIDF];
    if (cell == nil) {
        cell = [[ACTTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIDF];
    }
    
//    UIImageView *image;//图片
//    UILabel *titleLab;//标题
//    UILabel *contentLab;//详细信息
//    UILabel *timeLab;//时间
    //活动名称
    if ([_listArray count] > 0)
    {
        if ([[_listArray objectAtIndex:indexPath.row] valueForKey:@"title"] == nil || [[_listArray objectAtIndex:indexPath.row] valueForKey:@"title"] == NULL) {
            
        }else{
            
            cell.titleLab.text = [[_listArray objectAtIndex:indexPath.row] valueForKey:@"title"];
        }
        //活动内容or条件
        if ([[_listArray objectAtIndex:indexPath.row] valueForKey:@"content"] == nil || [[_listArray objectAtIndex:indexPath.row] valueForKey:@"content"] == NULL) {
            
        } else {
            cell.contentLab.text = [NSString stringWithFormat:@"使用条件：%@",[[_listArray objectAtIndex:indexPath.row] valueForKey:@"content"] ];
//            NSLog(@"content-%@----condition-%@",[[_listArray objectAtIndex:indexPath.row] valueForKey:@"content"],[[_listArray objectAtIndex:indexPath.row] valueForKey:@"content"]);
        }
        //活动截止时间
        if ([[_listArray objectAtIndex:indexPath.row] valueForKey:@"end_time"] == nil || [[_listArray objectAtIndex:indexPath.row] valueForKey:@"end_time"] == NULL) {
            
        }else{
            cell.timeLab.text = [NSString stringWithFormat:@"截止时间：%@",[[_listArray objectAtIndex:indexPath.row] valueForKey:@"end_time"] ];
        }
        //活动URL
        if ([[_listArray objectAtIndex:indexPath.row] valueForKey:@"pic_url"] == nil || [[_listArray objectAtIndex:indexPath.row] valueForKey:@"pic_url"] == NULL) {
            
        }else{
            [cell.image setImageWithURL:[[_listArray objectAtIndex:indexPath.row] valueForKey:@"pic_url"]];
//            NSLog(@"url%@",[[_listArray objectAtIndex:indexPath.row] valueForKey:@"pic_url"]);
        }
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    NSLog(@"%ld",(long)indexPath.row);
    if (USER_ID(QQQQ) != nil) {
        ActivityViewController *actView = [[ActivityViewController alloc] init];
        actView.act_id = [[_listArray objectAtIndex:indexPath.row] valueForKey:@"act_id"];
         [self.navigationController pushViewController:actView animated:YES];
    } else {
        ActivityViewController *actView = [[ActivityViewController alloc] init];
        actView.act_id = [[_listArray objectAtIndex:indexPath.row] valueForKey:@"act_id"];
       
        [self presentViewController:actView animated:YES completion:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (iPhone6Plus) {
        return 1;
    }else{
        return 1;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)xiadan
{
    if (USER_ID(QQQQ) == nil) {
        PersonalViewController *person = [[PersonalViewController alloc] init];
        [self presentViewController:person animated:YES completion:nil];
    } else {
        NewPlaceTheOrderViewController *place = [[NewPlaceTheOrderViewController alloc] init];
        [self.navigationController pushViewController:place animated:YES];
//        PlaceTheOrder *adsad = [[PlaceTheOrder alloc] init];
//        [self.leveyTabBarController hidesTabBar:YES animated:NO];
//        [self.navigationController pushViewController:adsad animated:YES];
    }
}

- (void)tiaozhuanhuodongxiangqing:(NSInteger)integer
{
//    NSLog(@"第%ld张图片",(long)integer);
    if (USER_ID(QQQQ) != nil) {
        ActivityViewController *actView = [[ActivityViewController alloc] init];
        actView.webUrl = [[_imageListArray objectAtIndex:0] valueForKey:@"url"];
        actBool = YES;
        [self.navigationController pushViewController:actView animated:YES];
    } else {
        ActivityViewController *actView = [[ActivityViewController alloc] init];
        actView.webUrl = [[_imageListArray objectAtIndex:0] valueForKey:@"url"];
//        NSLog(@"---%@",actView.webUrl);
        [self presentViewController:actView animated:YES completion:nil];
    }
}

- (void)getActView
{
    [[BoolViewController alloc] testOut];
    NSMutableDictionary *diccct = [[NSMutableDictionary alloc] init];
    [diccct setValue:@"3" forKey:@"platform"];
    
    NSDictionary *dic = [PersonalRequest NOTokenWithAllUrll:@"/index.php?s=/Api/Act/getlist" WithDic:diccct];
    NSInteger status = [[dic valueForKey:@"status"] intValue];
    
//    NSLog(@"获取活动列表-%@",dic);
    
    if (status == 0) {
        if ([dic valueForKey:@"data"] == nil || [dic valueForKey:@"data"] == NULL || [[dic valueForKey:@"data"] count] == 0) {
            
            _listArray = @[];
            _actTableView.backgroundColor = [UIColor whiteColor];
            
            if ([_listArray count] == 0) {
                _actLab_Null.text = @"亲～暂时没有新活动，敬请期待！";
            }else{
                _actLab_Null.text = @"";
            }
            
            NSLog(@"数据为空-%lu",(unsigned long)[_listArray count]);
            
        }else{
            _listArray = [dic valueForKey:@"data"];
            NSLog(@"没空");
        }
        NSLog(@"chenggong");
        _listArray = [dic valueForKey:@"data"];
        [errenLab removeFromSuperview];
        [_actTableView reloadData];
//        [HUD removeFromSuperview];
        [_actTableView.pullToRefreshView stopAnimating];
    }else{
//        [HUD removeFromSuperview];
        [_actTableView.pullToRefreshView stopAnimating];
        YBMB(@"网络异常或错误！")
        errenLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _actTableView.frame.size.height/3, VIEW_FRAME_SIZE_WIDTH, 40)];
        errenLab.text = @"网络异常或错误，下拉刷新数据！";
        errenLab.font = [UIFont systemFontOfSize:17];
        errenLab.textColor = [UIColor lightGrayColor];
        errenLab.textAlignment = NSTextAlignmentCenter;
        [_actTableView addSubview:errenLab];
    }
}

- (void)getImage
{
    ///Api/Act/getbanner
    [[BoolViewController alloc] testOut];
    NSMutableDictionary * diccct = [[NSMutableDictionary alloc] init];
    [diccct setValue:@"3" forKey:@"platform"];
    NSDictionary *dic =[PersonalRequest NOTokenWithAllUrll:@"/index.php?s=/Api/Act/getbanner" WithDic:diccct];
    
    int status = [[dic valueForKey:@"status"] intValue];
    
//    NSLog(@"获取图片%@",dic);
    
    if (status == 0) {
        
        NSLog(@"获取图片成功");
        
        if ([dic valueForKey:@"data"] == nil || [dic valueForKey:@"data"] == NULL || [BoolViewController isARRAYNOTNull:[dic valueForKey:@"data"]] == NO) {
            _imageListArray = @[];
            YBMB(@"暂时没有新活动，敬请期待！")
        }else{
            NSLog(@"chaochuyichang");
             _imageListArray = [dic valueForKey:@"data"];
        }
        [self heardScroller];

    }else{

        YBMB(@"网络异常或错误！")
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.mainScorllView.animationTimer setFireDate:[NSDate distantFuture]];
    NSLog(@"ACT  VIEWDIDDISAPPEAR");
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"ACT  viewDidAppear");
    [self.mainScorllView.animationTimer setFireDate:[NSDate distantPast]];
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
