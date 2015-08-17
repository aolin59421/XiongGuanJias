//
//  CustomActionSheet.m
//  LZWCustomActionSheet
//
//  Created by hbh  on 14-9-26.
//  Copyright (c) 2014年 lizhiwei. All rights reserved.
//

#import "LZWCustomActionSheet.h"

#define WINDOW_COLOR [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]
#define ANIMATE_DURATION                        0.25f
#define ACTIONSHEET_BACKGROUNDCOLOR             [UIColor colorWithRed:106/255.00f green:106/255.00f blue:106/255.00f alpha:0.8]



@implementation LZWCustomActionSheet

-(id)initWithView:(UIView *)view AndHeight:(CGFloat)height{
    self = [super init];
    if (self) {
        //初始化背景视图，添加手势
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = WINDOW_COLOR;
//        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [self addGestureRecognizer:tapGesture];
        
        //生成LZWActionSheetView
        self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, ([UIScreen mainScreen].bounds.size.height - 200), VIEW_FRAME_SIZE_WIDTH, height)];
        self.backGroundView.backgroundColor = [HexadecimalConversionUICOLOR colorWithHexString:@"#dbd6d4"];
        
//        toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, VIEW_FRAME_SIZE_WIDTH, 44)];
//        toolBar.barStyle = UIBarStyleDefault;
//        
//        
//        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style: UIBarButtonItemStyleDone target: self action: @selector(done)];
//        UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithTitle:@"取消" style: UIBarButtonItemStylePlain target: self action: @selector(docancel)];
//        UIBarButtonItem *fixedButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target: nil action: nil];
//        NSArray *array = [[NSArray alloc] initWithObjects: leftButton,fixedButton,rightButton, nil];
//        [toolBar setItems: array];		
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100, 0, 100, 44)];
        [rightButton setTitle:@"完成" forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
        [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.backGroundView addSubview:rightButton];
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setFrame:CGRectMake(0, 0, 100, 44)];
        [leftButton setTitle:@"取消" forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(docancel) forControlEvents:UIControlEventTouchUpInside];
        [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.backGroundView addSubview:leftButton];
        
        //给LZWActionSheetView添加响应事件(如果不加响应事件则传过来的view不显示)
        UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedBackGroundView)];
        [self.backGroundView addGestureRecognizer:tapGesture1];
        
        
        [self addSubview:self.backGroundView];
//        [self.backGroundView addSubview:toolBar];
        [self.backGroundView addSubview:view];
        
        [UIView animateWithDuration:ANIMATE_DURATION animations:^{
            [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-height, [UIScreen mainScreen].bounds.size.width, height)];
            
        } completion:^(BOOL finished) {
            
        }];


    }
    
    return self;
}

- (void)tappedCancel
{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

-(void)showInView:(UIView *)view{
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    
}

- (void)tappedBackGroundView
{
    //
}

-(void)done{
    [self.doneDelegate done];
    [self tappedCancel];
}

-(void)docancel
{
    [self tappedCancel];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
