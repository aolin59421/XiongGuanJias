//
//  ServiceScopeViewController.m
//  xiongmami
//
//  Created by iMac on 15/1/13.
//  Copyright (c) 2015年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "ServiceScopeViewController.h"

@interface ServiceScopeViewController ()

@end

@implementation ServiceScopeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"服务范围";
    [self addWebView];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];
    
    UILabel *navLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 64)];
    navLab.backgroundColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];
    [navLab setNumberOfLines:0];
    navLab.text = @"\n服务范围";
    navLab.textAlignment = NSTextAlignmentCenter;
    navLab.font = [UIFont systemFontOfSize:20];
    navLab.textColor = [UIColor whiteColor];
    [self.view addSubview:navLab];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(5, 20, 44, 44);
    [back setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [back.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(bback)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)bback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)addWebView
{
    [[BoolViewController alloc] testOut];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT - 64)];
    _webView.delegate = self;
    _webView.scrollView.alwaysBounceHorizontal = NO;
    _webView.scrollView.alwaysBounceVertical = NO;
    [self.view addSubview:_webView];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mp.5k.com/index.php?s=/H5/Index/service.html"]]];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - UIWebViewDelegate
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_HUD removeFromSuperview];
    YBMB(@"加载失败，请检查网络！")
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_HUD removeFromSuperview];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.mode = MBProgressHUDModeText;
    _HUD.labelText = @"加载中";
    [_HUD show:YES];
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
