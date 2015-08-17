//
//  OtherPay.m
//  xiongmami
//
//  Created by iMac on 14/11/21.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "OtherPay.h"
#import "HexadecimalConversionUICOLOR.h"

@implementation OtherPay

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"支付方式";
    [self addButton];

    
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
- (void)addButton
{
    
}

- (void)zhifufangshi:(UIButton *)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:sender.tag forKey:@"支付"];
    [userDefaults synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"支付选择" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
