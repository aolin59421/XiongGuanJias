//
//  NTViewController.m
//  tabbarDemo
//
//  Created by MD101 on 14-10-8.
//  Copyright (c) 2014年 TabBarDemo. All rights reserved.
//

#import "NTViewController.h"
#import "NTButton.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

@interface NTViewController (){

    UIImageView *_tabBarView;//自定义的覆盖原先的tarbar的控件
    
    NTButton * _previousBtn;//记录前一次选中的按钮

}

@end

@implementation NTViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.view.backgroundColor = [UIColor grayColor];
        self.title = @"视图";
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    CGFloat tabBarViewY = self.view.frame.size.height - 49;
    
    _tabBarView = [[UIImageView alloc]initWithFrame:CGRectMake(0, tabBarViewY, 320, 49)];
    _tabBarView.userInteractionEnabled = YES;
//    _tabBarView.image = [UIImage imageNamed:@"title_background.png"];
    _tabBarView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_tabBarView];
    
    FirstViewController * first = [[FirstViewController alloc]init];
    first.delegate = self;
    UINavigationController * navi1 = [[UINavigationController alloc]initWithRootViewController:first];
    SecondViewController * second = [[SecondViewController alloc]init];
    UINavigationController * navi2 = [[UINavigationController alloc]initWithRootViewController:second];
    ThirdViewController * third = [[ThirdViewController alloc]init];
    UINavigationController * navi3 = [[UINavigationController alloc]initWithRootViewController:third];
    FourthViewController * fourth = [[FourthViewController alloc]init];
    UINavigationController * navi4 = [[UINavigationController alloc]initWithRootViewController:fourth];
    
    self.viewControllers = [NSArray arrayWithObjects:navi1,navi2,navi3,navi4, nil];
    
    [self creatButtonWithNormalName:@"tabbar_client.png" andSelectName:@"tabbar_client_selected.png" andTitle:@"联系人" andIndex:0];
    [self creatButtonWithNormalName:@"tabbar_product" andSelectName:@"tabbar_product_selected" andTitle:@"产品" andIndex:1];
    [self creatButtonWithNormalName:@"tabbar_info" andSelectName:@"tabbar_info_selected" andTitle:@"信息" andIndex:2];
    [self creatButtonWithNormalName:@"tabbar_more" andSelectName:@"tabbar_more_selected" andTitle:@"设置" andIndex:3];
    NTButton * button = _tabBarView.subviews[0];
    [self changeViewController:button];
    
    // Do any additional setup after loading the view.
}

#pragma mark 创建一个按钮

- (void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index{
    
    NTButton * customButton = [NTButton buttonWithType:UIButtonTypeCustom];
    customButton.tag = index;
    
    CGFloat buttonW = _tabBarView.frame.size.width / 4;
    CGFloat buttonH = _tabBarView.frame.size.height;
    
    customButton.frame = CGRectMake(80 * index, 0, buttonW, buttonH);
    [customButton setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [customButton setImage:[UIImage imageNamed:selected] forState:UIControlStateDisabled];
    [customButton setTitle:title forState:UIControlStateNormal];
    
    [customButton addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchDown];
    
    customButton.imageView.contentMode = UIViewContentModeCenter;
    customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    customButton.titleLabel.font = [UIFont systemFontOfSize:10];
   
    [_tabBarView addSubview:customButton];

}

#pragma mark 按钮被点击时调用
- (void)changeViewController:(NTButton *)sender
 {
        self.selectedIndex = sender.tag; //切换不同控制器的界面
  
        sender.enabled = NO;
   
        if (_previousBtn != sender) {
       
                 _previousBtn.enabled = YES;
       
             }
     
         _previousBtn = sender;
     
     self.selectedViewController = self.viewControllers[sender.tag];
}

#pragma mark 是否隐藏tabBar

-(void)isHiddenCustomTabBarByBoolean:(BOOL)boolean{
    
    _tabBarView.hidden=boolean;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
