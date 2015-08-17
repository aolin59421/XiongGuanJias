//
//  PriceViewController.m
//  xiongmami
//
//  Created by iMac on 14/11/20.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "PriceViewController.h"
#import "PlaceTheOrder.h"
#import "HexadecimalConversionUICOLOR.h"

@implementation PriceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"价目";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下单" style:UIBarButtonItemStylePlain target:self action:@selector(addOrder)];
    [self addWebView];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = @"加载中";
    [HUD show:YES];
    [HUD hide:YES afterDelay:3];
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];
    
    //未登录
    
    if ([USER_ID(QQQQ) isEqualToString:nil]) {
    }
        UILabel *navLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 64)];
        navLab.backgroundColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];
        navLab.text = @"\n价目";
        [navLab setNumberOfLines:0];
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
        [placeTheOrder addTarget:self action:@selector(personal) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:placeTheOrder];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(bback)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)bback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)personal
{
//    NSLog(@"123");
    PersonalViewController *place = [[PersonalViewController alloc] init];
    [self presentViewController:place animated:YES completion:nil];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)addOrder
{
//    NSLog(@"321");
    NewPlaceTheOrderViewController *place = [[NewPlaceTheOrderViewController alloc] init];
    [self.navigationController pushViewController:place animated:YES];
}

- (void)addWebView
{
    [[BoolViewController alloc] testOut];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT-64)];
    _webView.delegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mp.5k.com/index.php?s=/H5/Index/price.html"]]];
    //消除webview 头部空白
    self.automaticallyAdjustsScrollViewInsets = NO;
}
@end
