//
//  PersonalLanding.m
//  xiongmami
//
//  Created by iMac on 14/11/22.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "PersonalLanding.h"
#import "JfViewController.h"
#import "Books.h"
#import "VIPInterests.h"
#import "ManagementAddress.h"
#import "SetUpViewController.h"
#import "TopUp.h"
#import "HeaderViewController.h"
#import "LeveyTabBarController.h"
#import "HexadecimalConversionUICOLOR.h"
#import "ZDProgressView.h"
#import "ViewController.h"
#import "HeaderViewController.h"
#import "GiftsViewController.h"

@implementation PersonalLanding

- (void)viewWillAppear:(BOOL)animated
{
//    NSLog(@"willApper");
    if (isImage == YES) {
        isImage = NO;
//        NSLog(@"1tupian");
    }else if (isImage == NO){
//        NSLog(@"2user");
        [NSThread detachNewThreadSelector:@selector(getUserInformation) toTarget:self withObject:nil];
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = @"加载中···";
        [HUD show:YES];
    }
    [self.leveyTabBarController hidesTabBar:NO animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.view.backgroundColor = [UIColor colorWithRed:246/255.0f green:240/255.0f blue:236/255.0f alpha:1];
    [self addCustonmView];
    [self zaXiang];
    [self addSetUp];
    [NSThread detachNewThreadSelector:@selector(withGetImage) toTarget:self withObject:nil];
//    NSLog(@"时间戳%@",[self getOrderDate]);
//    [self getUserInformation];
    
    
    
    
//    [self getUserJF];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
}

- (void)addCustonmView
{
    _userView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, VIEW_FRAME_SIZE_WIDTH, 90)];
    [_userView setBackgroundColor:[UIColor whiteColor]];
    _userView.layer.borderColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#edecec"].CGColor;
    _userView.layer.borderWidth = 1;
    [self.view addSubview:_userView];
    
    //头像
    _userHeradImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 80, 80)];
    [_userHeradImage setBackgroundColor:[UIColor clearColor]];
    _userHeradImage.layer.masksToBounds = YES;
    _userHeradImage.layer.cornerRadius = _userHeradImage.frame.size.width/2;
    _userHeradImage.clipsToBounds = YES;
    [_userHeradImage setImage:[UIImage imageNamed:@"icon.png"]];
    
    [_userView addSubview:_userHeradImage];
    
    if (iPhone6Plus) {
        _userHeradImage.frame = CGRectMake(10, 5, 80, 80);
        _userHeradImage.layer.cornerRadius = _userHeradImage.frame.size.width/2;
    }
    
    //昵称
    NSString *nameStr = @"熊管家";
//    NSLog(@"--%luu",nameStr.length);
    
    _userName = [[UILabel alloc] initWithFrame:CGRectMake((_userHeradImage.frame.size.width+10)+(VIEW_FRAME_SIZE_WIDTH/20), 15, nameStr.length*20, 30)];
    [_userName setText:nameStr];
    [_userName setFont:[UIFont systemFontOfSize:20]];
    [_userName setTextAlignment:NSTextAlignmentLeft];
    [_userName setTextColor:[UIColor blackColor]];
    [_userView addSubview:_userName];
    
    //等级
    _userLv = [[UIImageView alloc] init];//WithFrame:CGRectMake((_userHeradImage.frame.size.width+10)+(VIEW_FRAME_SIZE_WIDTH/20)+_userName.frame.size.width, 25, 42, 15)];
//    int LV = 0;
//
//    NSString *lvStr = [NSString stringWithFormat:@"Star%d",LV];
//    [_userLv setImage:[UIImage imageNamed:lvStr]];
    _userLv.alpha = 0;
//    [_userView addSubview:_userLv];
    
    //性别
    _userSex = [[UIImageView alloc] init];//WithFrame:CGRectMake((_userHeradImage.frame.size.width+10)+(VIEW_FRAME_SIZE_WIDTH/20)+_userName.frame.size.width+47, 20, 18, 20)];
//    int sex = 1;
//    
//    if (sex == 1) {
//        [_userSex setImage:[UIImage imageNamed:@"男.png"]];
//    } else {
//        [_userSex setImage:[UIImage imageNamed:@"女.png"]];
//    }
//    [_userView addSubview:_userSex];
    
    //经验条
     _progressView= [[ZDProgressView alloc] initWithFrame:CGRectMake((_userHeradImage.frame.size.width+10)+(VIEW_FRAME_SIZE_WIDTH/20), 60, 180, 20)];
    _progressView.progress = 399.0f/1000.0f;
    _progressView.transform = CGAffineTransformMakeScale(1.0f,1.0f);
    _progressView.backgroundColor = [UIColor colorWithRed:215/255.0f green:208/255.0f blue:206/255.0f alpha:1];
    _progressView.text = @"0/0";
    _progressView.prsColor = [UIColor colorWithRed:253/255.0f green:163/255.0f blue:37/255.0f alpha:1];

//    [_userView addSubview:_progressView];
    
    UIImageView *buttonImage = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 40, 10, 20)];
    [buttonImage setImage:[UIImage imageNamed:@"箭头@3x.png"]];
    [_userView addSubview:buttonImage];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20+80, 0, VIEW_FRAME_SIZE_WIDTH/3*2+10, _userView.frame.size.height)];
    button.backgroundColor =[UIColor clearColor];
    [button addTarget:self action:@selector(pushUserName) forControlEvents:UIControlEventTouchUpInside];
    [_userView addSubview:button];
    //头像选择
    UIButton *heardButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH/20+80, _userView.frame.size.height)];
    [heardButton addTarget:self action:@selector(chooseImage:) forControlEvents:UIControlEventTouchUpInside];
    [heardButton setBackgroundColor:[UIColor clearColor]];
    [_userView addSubview:heardButton];
    
    if (iPhone6Plus) {
        [_progressView setFrame:CGRectMake((_userHeradImage.frame.size.width+10)+(VIEW_FRAME_SIZE_WIDTH/20), 60, 260, 20)];
    }
    
}

#pragma  mark - 头像
- (void)addHearf
{
    HeaderViewController *header = [[HeaderViewController alloc] init];
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    [self.navigationController pushViewController:header animated:YES];
}
#pragma  mark - 昵称
- (void)pushUserName
{
    HeaderViewController *header = [[HeaderViewController alloc] init];
    header.NickName = _userName.text;
    header.Sex = _HearSex;
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    [self.navigationController pushViewController:header animated:YES];
}

#pragma  mrak - 杂项
- (void)zaXiang
{
    UIView *zaXiangView = [[UIView alloc] initWithFrame:CGRectMake(0, 170, VIEW_FRAME_SIZE_WIDTH, 44*4)];
    zaXiangView.layer.borderWidth = 1;
    zaXiangView.layer.borderColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#edecec"].CGColor;
    if (iPhone6Plus) {
        
    }
    zaXiangView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:zaXiangView];
    
    //余额
    UILabel * numberLab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 0, 100, 44)];
    numberLab.text = @"余额";
    [numberLab setTextAlignment:NSTextAlignmentLeft];
    [zaXiangView addSubview:numberLab];
    
    _userNumber = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 235, 0, 200, 44)];
//    _userNumber.text =@"￥0.0";
    [_userNumber setTextColor:[UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9]];
    [_userNumber setTextAlignment:NSTextAlignmentRight];
    [_userNumber setFont:[UIFont systemFontOfSize:20]];
    [zaXiangView addSubview:_userNumber];
    
    UIImageView * buttonImage = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 15, 10, 20)];
    [buttonImage setImage:[UIImage imageNamed:@"箭头@3x.png"]];
    [zaXiangView addSubview:buttonImage];
    
    //积分
//    UILabel * integralLab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 45, 100, 30)];
//    integralLab.text = @"积分";
//    [integralLab setTextAlignment:NSTextAlignmentLeft];
//    [zaXiangView addSubview:integralLab];
//    
//    _integralStr = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 135, 45, 100, 30)];
////    _integralStr.text =@"0";
//    [_integralStr setTextColor:[UIColor orangeColor]];
//    [_integralStr setTextAlignment:NSTextAlignmentRight];
//    [_integralStr setFont:[UIFont systemFontOfSize:20]];
//    [zaXiangView addSubview:_integralStr];
    
//    UIImageView * integralButtonImage = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 30, 50, 15, 20)];
//    [integralButtonImage setImage:[UIImage imageNamed:@"箭头.png"]];
//    [zaXiangView addSubview:integralButtonImage];
    
    //记账本
    UILabel * jzbLab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 44, 100, 44)];//85
    jzbLab.text = @"红包";
    [jzbLab setTextAlignment:NSTextAlignmentLeft];
    [zaXiangView addSubview:jzbLab];
    
    _hongbao = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH-95, 44, 60, 44)];
    [_hongbao setText:@"0"];
    [_hongbao setFont:[UIFont systemFontOfSize:20]];
    [_hongbao setTextColor:[UIColor colorWithRed:230/255.0f green:85/255.0f blue:53/255.0f alpha:0.9]];
    [_hongbao setTextAlignment:NSTextAlignmentRight];
    [zaXiangView addSubview:_hongbao];
    
    UIImageView * jzbButtonImage = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 59, 10, 20)];//90
    [jzbButtonImage setImage:[UIImage imageNamed:@"箭头@3x.png"]];
    [zaXiangView addSubview:jzbButtonImage];
    
    //管理地址
    UILabel * gldzLab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 88, 100, 44)];//125
    gldzLab.text = @"记账本";
    [gldzLab setTextAlignment:NSTextAlignmentLeft];
    [zaXiangView addSubview:gldzLab];
    
    UIImageView * gldzButtonImage = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 100, 10, 20)];//130
    [gldzButtonImage setImage:[UIImage imageNamed:@"箭头@3x.png"]];
    [zaXiangView addSubview:gldzButtonImage];
    
    //VIP权益
    UILabel * VIPLab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 132, 100, 44)];//165
    VIPLab.text = @"管理地址";
    [VIPLab setTextAlignment:NSTextAlignmentLeft];
    [zaXiangView addSubview:VIPLab];
    
    UIImageView * VIPButtonImage = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 143,10, 20)];//170
    [VIPButtonImage setImage:[UIImage imageNamed:@"箭头@3x.png"]];
    [zaXiangView addSubview:VIPButtonImage];
    
    for (int i = 0; i < 4; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, i*44, VIEW_FRAME_SIZE_WIDTH*0.9, 1)];
        labe.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#f0f3f5"];
        [zaXiangView addSubview:labe];
        button.frame = CGRectMake(0, i*44, VIEW_FRAME_SIZE_WIDTH, 44);
        [button setAlpha:0.5];
        [button setBackgroundImage:[UIImage imageNamed:@"dianji@3x.png"] forState:UIControlStateHighlighted];
        if (iPhone6Plus) {
            button.frame = CGRectMake(0, i * 55, VIEW_FRAME_SIZE_WIDTH, 55);
            labe.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, i*55, VIEW_FRAME_SIZE_WIDTH*0.9, 1);
        }else if (iPhone6){
            button.frame = CGRectMake(0, i * 50, VIEW_FRAME_SIZE_WIDTH, 50);
            labe.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, i*50, VIEW_FRAME_SIZE_WIDTH*0.9, 1);
        }
        
        switch (i) {
            case 0:
                
                [button addTarget:self action:@selector(zaxiangButton:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 1:
                
                [button addTarget:self action:@selector(zaxiangButton:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 2:
                
                [button addTarget:self action:@selector(zaxiangButton:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 3:
                
                [button addTarget:self action:@selector(zaxiangButton:) forControlEvents:UIControlEventTouchUpInside];
                break;
//            case 4:
//                [button setBackgroundColor:[UIColor clearColor]];
//                [button addTarget:self action:@selector(zaxiangButton:) forControlEvents:UIControlEventTouchUpInside];
//                break;

            default:
                break;
        }
        [zaXiangView addSubview:button];
    }
    
    if (iPhone6Plus) {
        
        zaXiangView.frame = CGRectMake(0, 170, VIEW_FRAME_SIZE_WIDTH, 55*4);
        _userNumber.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 235, 15, 200, 30);
        
        numberLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 10, 100, 40);
        buttonImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 20, 10, 20);
        
        jzbLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 65, 100, 40);
        _hongbao.frame =CGRectMake(VIEW_FRAME_SIZE_WIDTH-135, 65, 100, 40);
        jzbButtonImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 75, 10, 20);
        
        gldzLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 120, 100, 40);
        gldzButtonImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 130, 10, 20);
        
        VIPLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 175, 100, 40);
        VIPButtonImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 185,10, 20);
    }else if (iPhone6){
        
        zaXiangView.frame = CGRectMake(0, 170, VIEW_FRAME_SIZE_WIDTH, 50*4);
        _userNumber.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 235, 12, 200, 30);
        
        numberLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 8, 100, 40);
        buttonImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 16, 10, 20);
        
        jzbLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 55, 100, 40);
        _hongbao.frame =CGRectMake(VIEW_FRAME_SIZE_WIDTH-135, 55, 100, 40);
        jzbButtonImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 65, 10, 20);
        
        gldzLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 105, 100, 40);
        gldzButtonImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 115, 10, 20);
        
        VIPLab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 154, 100, 40);
        VIPButtonImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 164,10, 20);
    }
}

#pragma  mark - 杂项Button
- (void)zaxiangButton:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {
            TopUp *topUp = [[TopUp alloc] init];
            [self.leveyTabBarController hidesTabBar:YES animated:YES];
            [self.navigationController pushViewController:topUp animated:YES];
        }
            break;
//        case 1:
//        {
//            JfViewController *jf = [[JfViewController alloc] init];
//            [self.leveyTabBarController hidesTabBar:YES animated:YES];
//            [self.navigationController pushViewController:jf animated:YES];
//            break;
//        }
        case 2:
        {
            Books *books = [[Books alloc] init];
            [self.leveyTabBarController hidesTabBar:YES animated:YES];
            [self.navigationController pushViewController:books animated:YES];
        }
            
            break;
        case 3:
        {
            ManagementAddress *management = [[ManagementAddress alloc] init];
            [self.leveyTabBarController hidesTabBar:YES animated:YES];
            [self.navigationController pushViewController:management animated:YES];
        }
            break;
        case 1:
        {
            GiftsViewController *vip =[[GiftsViewController alloc] init];
            [self.leveyTabBarController hidesTabBar:YES animated:YES];
            [self.navigationController pushViewController:vip animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma  mark - 设置
- (void)addSetUp
{
    UIView *setUpView =[[UIView alloc] initWithFrame:CGRectMake(0, 375, VIEW_FRAME_SIZE_WIDTH, 44)];//385
    setUpView.backgroundColor = [UIColor whiteColor];
    setUpView.layer.borderWidth = 1.0f;
    setUpView.layer.borderColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#edecec"].CGColor;
    [self.view addSubview:setUpView];
    
    UILabel * setUpab = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 0, 100, 44)];
    setUpab.text = @"设置";
    [setUpab setTextAlignment:NSTextAlignmentLeft];
    [setUpView addSubview:setUpab];
    
    UIImageView * setUpButtonImage = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 12, 10, 20)];
    [setUpButtonImage setImage:[UIImage imageNamed:@"箭头@3x.png"]];
    [setUpView addSubview:setUpButtonImage];
    
    UIButton *setUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    setUpButton.frame = CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 44);
    [setUpButton addTarget:self action:@selector(pushSetUp) forControlEvents:UIControlEventTouchUpInside];
    [setUpView addSubview:setUpButton];
    [setUpButton setAlpha:0.5];
    [setUpButton setBackgroundImage:[UIImage imageNamed:@"dianji@3x.png"] forState:UIControlStateHighlighted];
    
    if (iPhone6Plus) {
        setUpView.frame = CGRectMake(0, 425, VIEW_FRAME_SIZE_WIDTH, 55);
        
        setUpab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 7, 100, 40);
        
        setUpButtonImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 20, 10, 20);
        
        setUpButton.frame = CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 55);
    }if (iPhone6) {
        setUpView.frame = CGRectMake(0, 405, VIEW_FRAME_SIZE_WIDTH, 50);
        
        setUpab.frame = CGRectMake(VIEW_FRAME_SIZE_WIDTH/20, 5, 100, 40);
        
        setUpButtonImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 16, 10, 20);
        
        setUpButton.frame = CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 50);
    }
    
}

- (void)pushSetUp
{
    SetUpViewController *setUp = [[SetUpViewController alloc] init];
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    [self.navigationController pushViewController:setUp animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
//    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    currentImage = [self imageWithImageSimple:currentImage scaledToSize:CGSizeMake(1024, 685)];

    currentImage = [self circleImage:currentImage withParam:CGSizeMake(1024/685, 1)];
    
    isFullScreen = NO;
    [_userHeradImage setImage:currentImage];
    _imagePic = currentImage;
    _userHeradImage.tag = 100;
    
    _imageSetUp = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否上传？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [_imageSetUp show];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self saveImage:image withName:@"currentImage.png"];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}


#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 2:
                    // 取消
                    return;
                case 0:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 1:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 2) {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                
            } else {
                return;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        [self.leveyTabBarController hidesTabBar:YES animated:NO];
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        isImage = YES;
    }
}
- (void)chooseImage:(id)sender {
    
    UIActionSheet *sheet;
//    NSLog(@"0000%@",_userHeradImage.image);
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择",nil];
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
    
}

#pragma mark - 时间戳
- (NSString *)getOrderDate {
    //获取系统当前的时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];//转为字符型
    
    return timeString;
    
}

#pragma  mark - 获取用户信息
- (void)getUserInformation
{
    [[BoolViewController alloc] testOut];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *userID = [userDefault objectForKey:@"user_id"];
    if ([userID isEqualToString:nil]) {
        
    }else{
    
    NSMutableDictionary *informationDic = [[NSMutableDictionary alloc] init];

    [informationDic setValue:userID forKey:@"user_id"];
    
//    NSLog(@"yonghuDIC-%@",informationDic);
    
    NSDictionary *dic = [PersonalRequest withAllUrll:@"/index.php?s=/Api/User/getinfo" WithDic:informationDic];
    
    int status = [[dic valueForKey:@"status"] intValue];
//    NSLog(@"yonghuxinxi--%d",status);
    if (status == 0) {
        
        NSDictionary *data = [dic valueForKey:@"data"];
//        NSLog(@"--%@",data);
//        Nickname：昵称|Sex：性别|Area：地区|Sign：签名|avatar：头像
        NSString *nickName = [data valueForKey:@"nickname"];
        NSString *sex = [data valueForKey:@"sex"];
//        NSString *area = [data valueForKey:@"area"];
//        NSString *sign = [data valueForKey:@"sign"];
//        NSString *avatar = [data valueForKey:@"avatar"];
//        NSString *score = [data valueForKey:@"score"];
        NSString *blance = [data valueForKey:@"balance"];
        NSString *grade = [data valueForKey:@"grade"];
        NSString *level = [data valueForKey:@"level"];
        //昵称
        if (nickName == nil || nickName == NULL || nickName.length == 0) {
            _userName.text = @"熊管佳";
        }else{
            _userName.text = nickName;
        }
        
        //等级
        if (level == nil || level == NULL) {
            
        }else{
            
            NSString *lvStr = [NSString stringWithFormat:@"Star%@",level];
            [_userLv setImage:[UIImage imageNamed:lvStr]];
        }
       
        
        //坐标
        
        //积分
//        _integralStr.text =score;
        //性别
        if ([[NSString stringWithFormat:@"%@",sex] rangeOfString:@"1"].location !=NSNotFound) {
             [_userSex setImage:[UIImage imageNamed:@"男.png"]];
        }else if ([[NSString stringWithFormat:@"%@",sex] rangeOfString:@"0"].location !=NSNotFound) {
            [_userSex setImage:[UIImage imageNamed:@"女.png"]];
        }else{
            
        }
        //余额
        if (blance == nil || blance == NULL) {
            blance = @"￥0.0";
        }else{
        _userNumber.text = [NSString stringWithFormat:@"￥%@",blance];
        }
        //经验值
        [self Leve:grade];
        
//        NSLog(@"Nickname：昵称%@|Sex：性别%@|Area：地区%@|Sign：签名%@|avatar：头像%@",nickName,sex,area,sign,avatar);
        _HearSex = sex;
        //红包数量
        
        if ([[NSString stringWithFormat:@"%@",[data valueForKey:@"count"] ] rangeOfString:@"0"].location != NSNotFound || [data valueForKey:@"count"] == nil) {
            _hongbao.text = @"0";
        }else{
            _hongbao.text = [data valueForKey:@"count"];
        }
        
//        NSLog(@"_HearSex%@",_HearSex);
        
        _userName.frame = CGRectMake((_userHeradImage.frame.size.width+10)+(VIEW_FRAME_SIZE_WIDTH/20), 15, _userName.text.length*20, 30);
        _userLv.frame = CGRectMake((_userHeradImage.frame.size.width+10)+(VIEW_FRAME_SIZE_WIDTH/20)+_userName.frame.size.width, 25, 42, 15);
        _userSex.frame = CGRectMake((_userHeradImage.frame.size.width+10)+(VIEW_FRAME_SIZE_WIDTH/20)+_userName.frame.size.width+47, 20, 18, 20);
        _userName.alpha =1;
        _userLv.alpha = 1;
        _userSex.alpha = 1;
        [HUD removeFromSuperview];
        
    } else if (status == 1) {
        [HUD removeFromSuperview];
        [[YBProgressShow defaultProgress] showText:@"请设置用户信息" InMode:MBProgressHUDModeDeterminate OriginViewEnableTouch:YES HideAfterDelayTime:2];
    }
    }
    
}
#pragma  mark - 设置用户信息

//等级&经验条
- (void)Leve:(NSString *)str
{
    int lv = [str intValue];
    if ( lv == 0) {
        _progressView.text = [NSString stringWithFormat:@"%@/0",str];
        _progressView.progress = lv/1000;
        NSString *lvStr = [NSString stringWithFormat:@"Star0"];
        [_userLv setImage:[UIImage imageNamed:lvStr]];
        
    }else if ( 1 <= lv <1000) {
        _progressView.text = [NSString stringWithFormat:@"%@/1000",str];
        _progressView.progress = lv/1000;
        NSString *lvStr = [NSString stringWithFormat:@"Star1"];
        [_userLv setImage:[UIImage imageNamed:lvStr]];
        
    } else if (1000 >= lv <5000){
        _progressView.text = [NSString stringWithFormat:@"%@/5000",str];
        _progressView.progress = lv/5000;
        NSString *lvStr = [NSString stringWithFormat:@"Star2"];
        [_userLv setImage:[UIImage imageNamed:lvStr]];
        
    } else if (5000 >= lv <10000) {
        _progressView.text = [NSString stringWithFormat:@"%@/10000",str];
        _progressView.progress = lv/10000;
        NSString *lvStr = [NSString stringWithFormat:@"Star3"];
        [_userLv setImage:[UIImage imageNamed:lvStr]];
    } else if (10000 <=lv < 15000)
    {
        _progressView.text = [NSString stringWithFormat:@"%@/15000",str];
        _progressView.progress = lv/15000;
        NSString *lvStr = [NSString stringWithFormat:@"Star4"];
        [_userLv setImage:[UIImage imageNamed:lvStr]];

    } else if (15000 <=lv < 20000)
    {
        _progressView.text = [NSString stringWithFormat:@"%@/20000",str];
        _progressView.progress = lv/20000;
        NSString *lvStr = [NSString stringWithFormat:@"Star5"];
        [_userLv setImage:[UIImage imageNamed:lvStr]];

    } else{
        _progressView.text = [NSString stringWithFormat:@"%@/0",str];
        _progressView.progress = lv/1000;
        NSString *lvStr = [NSString stringWithFormat:@"Star0"];
        [_userLv setImage:[UIImage imageNamed:lvStr]];
    }
    
}

- (void)viewDidDisappear:(BOOL)animated
{
//    NSLog(@"我的");
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    NSLog(@"-%ld",(long)buttonIndex);
    if (alertView == _imageSetUp) {
        if (buttonIndex == 0) {
            [[BoolViewController alloc] testOut];
            
            [_imageSetUp removeFromSuperview];
            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            HUD.delegate = self;
            HUD.mode = MBProgressHUDModeText;
            HUD.labelText = @"上传中···";
            [HUD showWhileExecuting:@selector(withImagePost) onTarget:self withObject:nil animated:YES];
            [HUD show:YES];
            
        }else if (buttonIndex == 1){
            [self withGetImage];
        }
    }
}

- (void)withImagePost
{
    
    [[BoolViewController alloc] testOut];
    
    NSData* data = [GTMBase64 encodeData:[self reduceImage:_imagePic percent:0.2]];
    
    NSString *imageStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableDictionary *asd = [[NSMutableDictionary alloc] init];
    [asd setValue:imageStr forKey:@"avatar"];
    
    NSMutableDictionary *dicttt = [[NSMutableDictionary alloc] init];
    [dicttt setValue:USER_ID(QQQQ) forKey:@"user_id"];
    [dicttt setValue:asd forKey:@"field"];
    
    NSInteger status;
    
    NSDictionary *dic = [PersonalRequest withAllUrll:@"/index.php?s=/Api/User/setinfo" WithDic:dicttt];
    NSLog(@"图片上传%@",_imagePic);
    if (dic == nil || dic == NULL || [dic isEqual:@"NULL"] == YES) {
        status = 1;
    }else{
        status = [[dic valueForKey:@"status"] intValue];
    }
    
    NSLog(@"%lu-=-%@",(unsigned long)data.length,dic);
    if (status == 0) {
        NSLog(@"上传图片");
        [HUD removeFromSuperview];
        YBMB(@"上传成功")
    }else if (status == 1){
        [HUD removeFromSuperview];
        [self withGetImage];
        NSLog(@"%@",[dic valueForKey:@"data"]);
        YBMB(@"上传失败,请检查网络！")
    }
}

//压缩图片质量
-(NSData *)reduceImage:(UIImage *)image percent:(CGFloat)percent
{
    NSData *imageData = UIImageJPEGRepresentation(image, percent);
//    UIImage *newImage = [UIImage imageWithData:imageData];
    
    return imageData;
}

//图片截圆
-(UIImage*) circleImage:(UIImage*) image withParam:(CGSize) inset {
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGRect rect = CGRectMake(inset.width, inset.height, image.size.width - inset.width * 2.0f, image.size.height - inset.height * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

//压缩图片尺寸
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}
//2.保持原来的长宽比，生成一个缩略图
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}
- (void)withGetImage
{
    [[BoolViewController alloc] testOut];
    
    NSMutableDictionary *dicccc = [[NSMutableDictionary alloc] init];
    [dicccc setValue:USER_ID(QQQQ) forKey:@"user_id"];
    
    NSDictionary *dic = [PersonalRequest withAllUrll:@"/index.php?s=/Api/User/getinfo" WithDic:dicccc];
    int status = [[dic valueForKey:@"status"] intValue];
//    NSLog(@"===!%@",dic);
    if (status == 0) {
        NSDictionary *data = [dic valueForKey:@"data"];
        NSURL *image = [data valueForKey:@"avatar"];
//        NSLog(@"image==%@",data);
        [_userHeradImage setImage:[UIImage imageNamed:@"icon.png"]];
        if ([BoolViewController isNOTNull:image] == NO){

            [_userHeradImage setImage:[UIImage imageNamed:@"icon.png"]];
        }else{
            NSLog(@"有图片");
            [_userHeradImage setImageWithURL:image];
//            [_userHeradImage setImage:[UIImage imageNamed:@"icon.png"]];
        }
        
        [HUD removeFromSuperview];
        
    }else if (status == 1){
        [_userHeradImage setImage:[UIImage imageNamed:@"icon.png"]];
        [HUD removeFromSuperview];
        YBMB([dic valueForKey:@"data"])
    }
}
@end
