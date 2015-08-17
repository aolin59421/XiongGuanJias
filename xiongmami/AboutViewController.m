//
//  AboutViewController.m
//  xiongmami
//
//  Created by iMac on 14/11/24.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "AboutViewController.h"
#import "HexadecimalConversionUICOLOR.h"

@interface AboutViewController ()<UIAlertViewDelegate>
{
    UILabel *versionLab;
    
    HexadecimalConversionUICOLOR * colorConversion;
}
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于";
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0f green:239/255.0f blue:235/255.0f alpha:1];
    [self addCustomView];
    
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
- (void)addCustomView
{
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/2 - 36, 169, 72, 72)];
    [logo setImage:[UIImage imageNamed:@"icon.png"]];
    [self.view addSubview:logo];
    
    versionLab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/2-24, 256, 72, 20)];
    NSString *version = [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
    versionLab.text = [NSString stringWithFormat:@"V %@",version];
    [versionLab setTextColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#b4bac5"]];
    [versionLab setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:versionLab];
    
    UILabel *companyLab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/2 - 110.5f, 281, 221, 20)];
    companyLab.text =@"杭州熊管佳电子商务有限公司";
    [companyLab setFont:[UIFont systemFontOfSize:17]];
    [companyLab setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:companyLab];
    
//    UIButton *jcgx = [UIButton buttonWithType:UIButtonTypeCustom];
//    jcgx.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, [UIScreen mainScreen].bounds.size.height-100, VIEW_FRAME_SIZE_WIDTH*0.9, 40);
//    [jcgx setTitle:@"检查更新" forState:UIControlStateNormal];
//    [jcgx.titleLabel setFont:[UIFont systemFontOfSize:20]];
//    [jcgx setTitleColor:[HexadecimalConversionUICOLOR colorWithHexString:@"#4c4743"] forState:UIControlStateNormal];
//    [jcgx setBackgroundImage:[UIImage imageNamed:@"检查更新btn.png"] forState:UIControlStateNormal];
//    [jcgx addTarget:self action:@selector(jcgx) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:jcgx];
    if (iPhone6Plus) {
        logo.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/2 - (90*1.5)/2, 250, 90*1.5, 90*1.5);
        versionLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/2-24, 400, 72, 20);
        companyLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/2 - 110.5f, 425, 221, 20);
//        jcgx.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, [UIScreen mainScreen].bounds.size.height-200, VIEW_FRAME_SIZE_WIDTH*0.9, 55);
    }else if (iPhone6){
//        jcgx.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, [UIScreen mainScreen].bounds.size.height-200, VIEW_FRAME_SIZE_WIDTH*0.9, 40);
    }
}

- (void)gengxin
{
    NSString *version = [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
    [self doCheckVersion:version];
}

- (void)jcgx
{
    NSLog(@"检查更新");

    [[BoolViewController alloc] testOut];
    NSString *version = [NSString stringWithFormat:@"V%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
//    NSLog(@"版本v%@",version);
    NSMutableDictionary *dicctt =[[NSMutableDictionary alloc] init];
    [dicctt setValue:version forKey:@"version"];
    [dicctt setValue:@"3" forKey:@"type"];
    
    NSDictionary * dic = [PersonalRequest NOTokenWithAllUrll:@"/index.php?s=/Api/Other/chkupgrade" WithDic:dicctt];
//    NSLog(@"jianchagengxin-dic-%@",dic);
    NSInteger status = [[dic valueForKey:@"status"] intValue];
    
    if (status == 0) {
        
//        NSLog(@"检查结果%@",[dic valueForKey:@"data"]);
        _downUrl = [NSString stringWithFormat:@"%@",[[dic valueForKey:@"data"] valueForKey:@"ver_url"]];
        NSInteger flag = [[[dic valueForKey:@"data"] valueForKey:@"flag"] intValue];
        switch (flag) {
            case 0:
            {
                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已是最新版本，无需更新！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alerView show];
            }
                
                break;
            case 1:
            {
                NSString *str = [NSString stringWithFormat:@"发现新版本，需更新后使用!\n更新内容\n%@",[[dic valueForKey:@"data"] valueForKey:@"content"]];
                _alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [_alert show];
            }
                
                break;
            case 2:
            {
                NSString *str = [NSString stringWithFormat:@"发现新版本，是否更新？\n更新内容\n%@",[[dic valueForKey:@"data"] valueForKey:@"content"]];
                _alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否",nil];
                [_alert show];
            }
                
                break;
                
            default:
                break;
        }
        
    }else if (status == 1){
//        NSLog(@"检查结果%@",[dic valueForKey:@"data"]);
        YBMB([dic valueForKey:@"data"])
    }else if (status == 2){
//        NSLog(@"检查结果%@",[dic valueForKey:@"data"]);
        YBMB([dic valueForKey:@"data"])
    }
}

-(void)doCheckVersion:(NSString *)currentVersion
{
    [[BoolViewController alloc] testOut];
    NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/search?term=熊管家&entity=software"];
//    NSLog(@"url-%@",urlStr);

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:urlStr]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    request.timeoutInterval = 10;
    
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
//    NSLog(@"responseData-%@",responseData);
    
    if (responseData == nil || responseData == NULL) {
        NSLog(@"再次为空");
        } else {
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"再次没空");
//        NSLog(@"dic ---%@",responseJSON);
        NSArray *infoArray = [responseJSON objectForKey:@"results"];
        if ([infoArray count]) {
            NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
            NSString *lastVersion = [releaseInfo objectForKey:@"version"];
            
            if (![lastVersion isEqualToString:currentVersion]) {
                //            trackViewURL = [releaseInfo objectForKey:@"trackVireUrl"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"有新的版本更新，是否前往更新？" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil];
                [alert show];
            }
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( alertView == _alert) {
        if (buttonIndex == 0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_downUrl]];
        }else if (buttonIndex == 1){
            
        }
    }
    
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

@end
