//
//  YBProgressShow.h
//  RainBowPlan
//
//  Created by user on 12-11-9.
//
//


/*          Example
 YBProgressShow *progressDefault = [YBProgressShow defaultProgress];
 [progressDefault setEnableTouch:NO];
 [progressDefault setTextShow:@"Load"];
 [progressDefault setProgressModel:MBProgressHUDModeText];
 [progressDefault show];
 [progressDefault hideAfterDelay:2];
 */


#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface YBProgressShow : NSObject {
    
}

@property (nonatomic, retain) MBProgressHUD *progressHUD;//显示时间视图
@property (nonatomic, retain) MBProgressHUD *progressHUDCicle;//圈圈视图

//单例
+ (id)defaultProgress;

//是否为静态模态框：YES：原来UI依然接受点击响应，  NO：原来UI不再接受点击响应
- (void)setOriginViewEnableTouch:(BOOL) isAbleTouch;
//设置提示框种类
- (void)setProgressModel:(MBProgressHUDMode) progressMode;
//设置提示框内容
- (void)setTextShow:(NSString *) showText;

//显示提示框
- (void)showYBProgress;
//在指定UI上显示提示框
- (void)showInView:(UIView *) showView;

//隐藏提示框
- (void)hideYBProgress;
//delayTime秒后隐藏提示框
- (void)hideAfterDelay:(CGFloat) delayTime;

//快速显示方法
- (void)showText:(NSString *)showText InMode:(MBProgressHUDMode)progressMode OriginViewEnableTouch:(BOOL)isAbleTouch;

//快速显示方法
- (void)showText:(NSString *)showText InMode:(MBProgressHUDMode)progressMode OriginViewEnableTouch:(BOOL)isAbleTouch HideAfterDelayTime:(CGFloat)delayTime;

@end
