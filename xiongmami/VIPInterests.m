//
//  VIPInterests.m
//  xiongmami
//
//  Created by iMac on 14/11/22.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "VIPInterests.h"
#import "HexadecimalConversionUICOLOR.h"

@implementation VIPInterests

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"VIP权益";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addText];

    
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
- (void)addText
{
    UILabel *vipLabTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, 60)];
    vipLabTitle.text = @"VIP阶梯价";
    [vipLabTitle setFont:[UIFont systemFontOfSize:20]];
    [vipLabTitle setTextAlignment:NSTextAlignmentCenter];
    [vipLabTitle setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:vipLabTitle];
    
    UILabel *lalalab = [[UILabel alloc] initWithFrame:CGRectMake(0, 124, VIEW_FRAME_SIZE_WIDTH, 0.5)];
    lalalab.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#9f9f9e"];
    [self.view addSubview:lalalab];
    
    UILabel *teQuan = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 150, 200, 30)];
    teQuan.text = @"特权介绍";
    [teQuan setFont:[UIFont systemFontOfSize:20]];
    [teQuan setTextAlignment:NSTextAlignmentLeft];
    [teQuan setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:teQuan];
    
    UILabel *teQunaJieShao = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 185, VIEW_FRAME_SIZE_WIDTH*0.9, 40)];
    teQunaJieShao.text = @"针对不同洗衣客会员等级，额外享受折上折的特权优惠、月高等级，享受的折扣越大。";
    teQunaJieShao.numberOfLines = 0;
    [teQunaJieShao setBackgroundColor:[UIColor whiteColor]];
    [teQunaJieShao setTextAlignment:NSTextAlignmentLeft];
    [teQunaJieShao setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:teQunaJieShao];
    
    UILabel *teQuanSM = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 245, 200, 30)];
    teQuanSM.text = @"特权说明";
    [teQuanSM setFont:[UIFont systemFontOfSize:20]];
    [teQuanSM setTextAlignment:NSTextAlignmentLeft];
    [teQuanSM setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:teQuanSM];
    
    UILabel *teQuanSMLabFL = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 280, VIEW_FRAME_SIZE_WIDTH*0.9, 20)];
    teQuanSMLabFL.text = @"购物特权可以通过2种方式实现：";
    teQuanSMLabFL.numberOfLines = 0;
    [teQuanSMLabFL setBackgroundColor:[UIColor whiteColor]];
    [teQuanSMLabFL setTextAlignment:NSTextAlignmentLeft];
    [teQuanSMLabFL setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:teQuanSMLabFL];
    
    UILabel *teQuanSMLabOne = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 300, VIEW_FRAME_SIZE_WIDTH*0.9, 40)];
    teQuanSMLabOne.text = @"1.一次性预充值1000元以上，可以达到VIP申请特权";
    teQuanSMLabOne.numberOfLines = 0;
    [teQuanSMLabOne setTextColor:[UIColor lightGrayColor]];
    [teQuanSMLabOne setBackgroundColor:[UIColor whiteColor]];
    [teQuanSMLabOne setTextAlignment:NSTextAlignmentLeft];
    [teQuanSMLabOne setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:teQuanSMLabOne];
    
    UILabel *teQuanSMLabTwo = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 340, VIEW_FRAME_SIZE_WIDTH*0.9, 40)];
    teQuanSMLabTwo.text = @"2.用户累计洗衣金额达到1000元以上，可以获得VIP特权";
    teQuanSMLabTwo.numberOfLines = 0;
    [teQuanSMLabTwo setTextColor:[UIColor lightGrayColor]];
    [teQuanSMLabTwo setBackgroundColor:[UIColor whiteColor]];
    [teQuanSMLabTwo setTextAlignment:NSTextAlignmentLeft];
    [teQuanSMLabTwo setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:teQuanSMLabTwo];
    
    UILabel *huiYuanChengZhangJieShao = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 400, 200, 30)];
    huiYuanChengZhangJieShao.text = @"会员成长介绍";
    [huiYuanChengZhangJieShao setFont:[UIFont systemFontOfSize:20]];
    [huiYuanChengZhangJieShao setTextAlignment:NSTextAlignmentLeft];
    [huiYuanChengZhangJieShao setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:huiYuanChengZhangJieShao];
    
    UIImageView *huiYuan = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 440, VIEW_FRAME_SIZE_WIDTH*0.9, 40)];
    [huiYuan setImage:[UIImage imageNamed:@"cz.png"]];
    [self.view addSubview:huiYuan];
}

@end
