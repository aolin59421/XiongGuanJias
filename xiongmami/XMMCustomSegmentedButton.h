//
//  XMMCustomSegmentedButton.h
//  xiongmami
//
//  Created by iMac on 14/11/28.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMMCustomSegmentedButton : UIView{
    UIColor *buttonBackgroundColorForStateNormal;
    UIColor *buttonBackgroundColorForStatePressed;
    NSMutableArray *buttons;
    UIButton *_Button;
    UIButton *_Button1;
    UIButton *_Button2;
}
@property (nonatomic, strong) UIButton *Button;
@property (nonatomic, strong) UIButton *Button1;
@property (nonatomic, strong) UIButton *Button2;



@property (nonatomic, copy) void (^buttonPressActionHandler)(int buttonIndex);
- (void)initWithTitles:(NSArray *)buttonTitles buttonTintNormal:(UIColor *)backgroundColorNormal buttonTintPressed:(UIColor *)backgroundColorPressed actionHandler:(void (^)(int buttonIndex))actionHandler;


- (void)setSegmentedDefault:(int)index;

- (void)initWithImages:(NSArray *)buttonImages buttonWithTouChUpInImages:(NSArray *)buttonTouChUpInImages buttonTintNormal:(UIColor *)backgroundColorNormal buttonTintPressed:(UIColor *)backgroundColorPressed actionHandler:(void (^)(int buttonIndex))actionHandler;

//- (void)initWithImages:(NSArray *)buttonImages buttonWithTouChUpInImages:(NSArray *)buttonTouChUpInImages addVCs:(NSArray *)viewControllers  buttonTintNormal:(UIColor *)backgroundColorNormal buttonTintPressed:(UIColor *)backgroundColorPressed actionHandler:(void (^)(int buttonIndex))actionHandler;
@end
