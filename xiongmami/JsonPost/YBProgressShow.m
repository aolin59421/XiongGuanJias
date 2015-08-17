//
//  YBProgressShow.m
//  RainBowPlan
//
//  Created by user on 12-11-9.
//
//

#import "YBProgressShow.h"
static YBProgressShow *_default;

@implementation YBProgressShow
@synthesize progressHUD,progressHUDCicle;

#pragma mark - single
+ (id)defaultProgress {
    if (_default == nil) {
        _default = [[YBProgressShow alloc] init];
        MBProgressHUD *progress = [[MBProgressHUD alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        MBProgressHUD *proCicle = [[MBProgressHUD alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [_default setProgressHUD:progress];
        [_default setProgressHUDCicle:proCicle];
        [progress release];
    }
    return _default;
}

+ (id)alloc {
    if (_default == nil) {
        _default = [super alloc];
    }
    return _default;
}

- (void)dealloc {
    [_default release];
    _default = nil;
    [_default setProgressHUD:nil];
    [super dealloc];
}

#pragma mark - public
- (void)showText:(NSString *)showText InMode:(MBProgressHUDMode)progressMode OriginViewEnableTouch:(BOOL)isAbleTouch HideAfterDelayTime:(CGFloat)delayTime
{
    if(showText)
    {
        NSArray *params = [NSArray arrayWithObjects:showText,
                           [NSNumber numberWithInt:progressMode],
                           [NSNumber numberWithBool:isAbleTouch],
                           [NSNumber numberWithFloat:delayTime],
                           nil];
        //转到主线程
        [self performSelectorOnMainThread:@selector(showTextInMainThreadType1:)
                               withObject:params
                            waitUntilDone:YES];
    }
}

- (void)showTextInMainThreadType1:(NSArray *)params
{
    NSString *showText = [params objectAtIndex:0];
    MBProgressHUDMode progressMode = [[params objectAtIndex:1] intValue];
    BOOL isAbleTouch = [[params objectAtIndex:2] boolValue];
    CGFloat delayTime = [[params objectAtIndex:3] floatValue];
    
    [self.progressHUD setLabelText:showText];
    [self.progressHUD setLabelFont:[UIFont systemFontOfSize:13.5]];
    [self.progressHUD setMode:progressMode];
    [self.progressHUD setUserInteractionEnabled:!isAbleTouch];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self.progressHUD];
    [self.progressHUD show:YES];
    [self.progressHUD hide:YES afterDelay:delayTime];
    [self hideYBProgress];
}

- (void)showText:(NSString *)showText InMode:(MBProgressHUDMode)progressMode OriginViewEnableTouch:(BOOL)isAbleTouch
{
    if(showText)
    {
        NSArray *params = [NSArray arrayWithObjects:showText,
                           [NSNumber numberWithInt:progressMode],
                           [NSNumber numberWithBool:isAbleTouch],
                           nil];
        //转到主线程
        [self performSelectorOnMainThread:@selector(showTextInMainThreadType2:)
                               withObject:params
                            waitUntilDone:YES];
    }
}

- (void)showTextInMainThreadType2:(NSArray *)params
{
    NSString *showText = [params objectAtIndex:0];
    MBProgressHUDMode progressMode = [[params objectAtIndex:1] intValue];
    BOOL isAbleTouch = [[params objectAtIndex:2] boolValue];
    
    [self.progressHUD setLabelText:showText];
    [self.progressHUD setMode:progressMode];
    [self.progressHUD setUserInteractionEnabled:!isAbleTouch];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self.progressHUD];
    [self.progressHUD show:YES];
}

- (void)setProgressModel:(MBProgressHUDMode) progressMode {
    [self.progressHUD setMode:progressMode];
}

- (void)setTextShow:(NSString *) showText {
    [self.progressHUD setLabelText:showText];
}

- (void)setOriginViewEnableTouch:(BOOL) isAbleTouch {
    [self.progressHUD setUserInteractionEnabled:!isAbleTouch];
}

- (void)showYBProgress {
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self.progressHUDCicle];
    [self.progressHUDCicle show:YES];
}

- (void)showInView:(UIView *) showView {
    [showView addSubview:self.progressHUD];
    [self.progressHUD show:YES];
}

- (void)hideYBProgress {
    [self.progressHUDCicle hide:YES];
}

- (void)hideAfterDelay:(CGFloat) delayTime {
    [self.progressHUD hide:YES afterDelay:delayTime];
}


@end
