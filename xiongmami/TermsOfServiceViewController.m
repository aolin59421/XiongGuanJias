//
//  TermsOfServiceViewController.m
//  xiongmami
//
//  Created by iMac on 15/3/19.
//  Copyright (c) 2015年 杭州熊管佳电子商务有限公司. All rights reserved.
//

#import "TermsOfServiceViewController.h"

@interface TermsOfServiceViewController ()

@end

@implementation TermsOfServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0f green:239/255.0f blue:235/255.0f alpha:1];
    UILabel *navLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 64)];
    navLab.backgroundColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];
    navLab.text = @"\n服务条款";
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
    [self htmlText];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)htmlText
{
    [[BoolViewController alloc] testOut];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, VIEW_FRAME_SIZE_HEIGHT - 64)];
    _webView.delegate = self;
    [_webView.scrollView setBounces:NO];
    [self.view addSubview:_webView];
    
    NSString *runAndLink = [NSString stringWithFormat:@"http://mp.5k.com/index.php?s=/app/public/index.html"];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:runAndLink]]];
    self.automaticallyAdjustsScrollViewInsets = NO;
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
