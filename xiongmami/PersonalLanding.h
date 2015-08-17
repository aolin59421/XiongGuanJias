//
//  PersonalLanding.h
//  xiongmami
//
//  Created by iMac on 14/11/22.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"
#import "ZDProgressView.h"


@interface PersonalLanding : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,MBProgressHUDDelegate>
{
    BOOL isFullScreen;
//    AFHTTPRequestOperationManager* manager;
    ZDProgressView *_progressView;
    
    UIAlertView *_imageSetUp;
    
    UIImage* _imagePic;
    
    
    UIView *_userView;
    MBProgressHUD *HUD;
    
    NSString*_HearSex;//性别传值
    
    BOOL isImage;
    BOOL isUrl;
}



@property (nonatomic, strong) UILabel *userName;//用户名
@property (nonatomic, strong) UIImageView *userHeradImage;//用户头像
@property (nonatomic, strong) UILabel *userNumber;//用户余额
@property (nonatomic, strong) UIImageView *userSex;//用户性别
@property (nonatomic, strong) UIImageView *userLv;//用户等级
@property (nonatomic, strong) UILabel *integralStr;//用户积分
@property (nonatomic, strong) UILabel *hongbao;//红包数量
@end
