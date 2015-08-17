//
//  XMMCustomSegmentedButton.m
//  xiongmami
//
//  Created by iMac on 14/11/28.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "XMMCustomSegmentedButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation XMMCustomSegmentedButton
@synthesize buttonPressActionHandler;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //nothing
    }
    return self;
}

- (void)initWithTitles:(NSArray *)buttonTitles buttonTintNormal:(UIColor *)backgroundColorNormal buttonTintPressed:(UIColor *)backgroundColorPressed actionHandler:(void (^)(int buttonIndex))actionHandler {
    
}


- (void)initWithImages:(NSArray *)buttonImages buttonWithTouChUpInImages:(NSArray *)buttonTouChUpInImages buttonTintNormal:(UIColor *)backgroundColorNormal buttonTintPressed:(UIColor *)backgroundColorPressed actionHandler:(void (^)(int buttonIndex))actionHandler
{
    buttons = [[NSMutableArray alloc] init];
    int numberOfButtons = [buttonImages count];
    _Button = [UIButton buttonWithType:UIButtonTypeCustom];
    _Button.tag = 0;
    _Button.frame = CGRectMake(0, 0, self.frame.size.width/numberOfButtons, self.frame.size.height);
    _Button.layer.bounds = CGRectMake(0, 0, self.frame.size.width/numberOfButtons, self.frame.size.height);
//    _Button.layer.borderWidth = .5;
//    _Button.layer.borderColor = [UIColor colorWithWhite:.6 alpha:1].CGColor;
//    _Button.backgroundColor = backgroundColorNormal;
    _Button.clipsToBounds = YES;
    _Button.layer.masksToBounds = YES;

    
    CAGradientLayer *shineLayer = [CAGradientLayer layer];
    shineLayer.frame = _Button.layer.bounds;
    shineLayer.colors = [NSArray arrayWithObjects:
                         (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.75f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.4f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                         nil];
    shineLayer.locations = [NSArray arrayWithObjects:
                            [NSNumber numberWithFloat:0.0f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.8f],
                            [NSNumber numberWithFloat:1.0f],
                            nil];
//    [_Button.layer addSublayer:shineLayer];
    
    [_Button addTarget:self action:@selector(buttonUp:event:) forControlEvents:(UIControlEventTouchUpOutside|UIControlEventTouchUpInside|UIControlEventTouchCancel|UIControlEventTouchDragExit)];
    [_Button addTarget:self action:@selector(buttonDown:event:) forControlEvents:UIControlEventTouchDown|UIControlEventTouchDragEnter];
    [_Button addTarget:self action:@selector(buttonPressed:event:) forControlEvents:UIControlEventTouchUpInside];
    
    [_Button setImage:[buttonImages objectAtIndex:0] forState:UIControlStateNormal];
    [_Button setImage:[buttonTouChUpInImages objectAtIndex:0] forState:UIControlStateHighlighted];
    [_Button setImage:[buttonTouChUpInImages objectAtIndex:0] forState:UIControlStateSelected];
    
//    [_Button addTarget:self action:@selector(newButton:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:_Button];
    [buttons addObject:_Button];
    buttonBackgroundColorForStateNormal = backgroundColorNormal;
    buttonBackgroundColorForStatePressed = backgroundColorPressed;
    
    _Button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _Button1.frame = CGRectMake((self.frame.size.width/numberOfButtons), 0, self.frame.size.width/numberOfButtons, self.frame.size.height);
    _Button1.tag =1;
    _Button1.layer.bounds = CGRectMake(0, 0, self.frame.size.width/numberOfButtons, self.frame.size.height);
//    _Button1.layer.borderWidth = .5;
//    _Button1.layer.borderColor = [UIColor colorWithWhite:.6 alpha:1].CGColor;
//    _newButton1.backgroundColor = backgroundColorNormal;
    _Button1.clipsToBounds = YES;
    _Button1.layer.masksToBounds = YES;
    
    CAGradientLayer *shineLayer1 = [CAGradientLayer layer];
    shineLayer1.frame = _Button1.layer.bounds;
    shineLayer1.colors = [NSArray arrayWithObjects:
                          (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                          (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                          (id)[UIColor colorWithWhite:0.75f alpha:0.2f].CGColor,
                          (id)[UIColor colorWithWhite:0.4f alpha:0.2f].CGColor,
                          (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                          nil];
    shineLayer1.locations = [NSArray arrayWithObjects:
                             [NSNumber numberWithFloat:0.0f],
                             [NSNumber numberWithFloat:0.5f],
                             [NSNumber numberWithFloat:0.5f],
                             [NSNumber numberWithFloat:0.8f],
                             [NSNumber numberWithFloat:1.0f],
                             nil];
//    [_Button1.layer addSublayer:shineLayer1];
    
    [_Button1 addTarget:self action:@selector(buttonUp:event:) forControlEvents:(UIControlEventTouchUpOutside|UIControlEventTouchUpInside|UIControlEventTouchCancel|UIControlEventTouchDragExit)];
    [_Button1 addTarget:self action:@selector(buttonDown:event:) forControlEvents:UIControlEventTouchDown|UIControlEventTouchDragEnter];
    [_Button1 addTarget:self action:@selector(buttonPressed:event:) forControlEvents:UIControlEventTouchUpInside];
    [_Button1 setImage:[buttonImages objectAtIndex:1] forState:UIControlStateNormal];
    [_Button1 setImage:[buttonTouChUpInImages objectAtIndex:1] forState:UIControlStateHighlighted];
    [_Button1 setImage:[buttonTouChUpInImages objectAtIndex:1] forState:UIControlStateSelected];
    
//    [_Button1 addTarget:self action:@selector(newButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_Button1];
    [buttons addObject:_Button1];
    
    _Button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _Button2.frame = CGRectMake((self.frame.size.width/numberOfButtons)*2, 0, self.frame.size.width/numberOfButtons, self.frame.size.height);
    _Button2.tag = 2;
    _Button2.layer.bounds = CGRectMake(0, 0, self.frame.size.width/numberOfButtons, self.frame.size.height);
//    _Button2.layer.borderWidth = .5;
//    _Button2.layer.borderColor = [UIColor colorWithWhite:.6 alpha:1].CGColor;
//    _Button2.backgroundColor = backgroundColorNormal;
    _Button2.clipsToBounds = YES;
    _Button2.layer.masksToBounds = YES;
    
    CAGradientLayer *shineLayer2 = [CAGradientLayer layer];
    shineLayer2.frame = _Button2.layer.bounds;
    shineLayer2.colors = [NSArray arrayWithObjects:
                          (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                          (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                          (id)[UIColor colorWithWhite:0.75f alpha:0.2f].CGColor,
                          (id)[UIColor colorWithWhite:0.4f alpha:0.2f].CGColor,
                          (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                          nil];
    shineLayer2.locations = [NSArray arrayWithObjects:
                             [NSNumber numberWithFloat:0.0f],
                             [NSNumber numberWithFloat:0.5f],
                             [NSNumber numberWithFloat:0.5f],
                             [NSNumber numberWithFloat:0.8f],
                             [NSNumber numberWithFloat:1.0f],
                             nil];
//    [_Button2.layer addSublayer:shineLayer2];
    
    [_Button2 addTarget:self action:@selector(buttonUp:event:) forControlEvents:(UIControlEventTouchUpOutside|UIControlEventTouchUpInside|UIControlEventTouchCancel|UIControlEventTouchDragExit)];
    [_Button2 addTarget:self action:@selector(buttonDown:event:) forControlEvents:UIControlEventTouchDown|UIControlEventTouchDragEnter];
    [_Button2 addTarget:self action:@selector(buttonPressed:event:) forControlEvents:UIControlEventTouchUpInside];
    [_Button2 setImage:[buttonImages objectAtIndex:2] forState:UIControlStateNormal];
    [_Button2 setImage:[buttonTouChUpInImages objectAtIndex:2] forState:UIControlStateHighlighted];
    [_Button2 setImage:[buttonTouChUpInImages objectAtIndex:2] forState:UIControlStateSelected];
//    [_Button2 addTarget:self action:@selector(newButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_Button2];
    [buttons addObject:_Button2];
    
    self.layer.borderColor = [UIColor colorWithWhite:.6 alpha:1].CGColor;
    self.layer.borderWidth = 0.3;
    self.clipsToBounds = YES;
    buttonPressActionHandler = [actionHandler copy];
    
    [self setSegmentedDefault:0];
}

- (void)newButton:(UIButton*)sender
{
    switch (sender.tag) {
        case 0:
        {
            [_Button setHighlighted:YES];
            [_Button1 setHighlighted:NO];
            [_Button2 setHighlighted:NO];
            [_Button setSelected:YES];
            [_Button1 setSelected:NO];
            [_Button2 setSelected:NO];
        }
            break;
        case 1:
        {
            [_Button setHighlighted:NO];
            [_Button1 setHighlighted:YES];
            [_Button2 setHighlighted:NO];
            [_Button setSelected:NO];
            [_Button1 setSelected:YES];
            [_Button2 setSelected:NO];
        }
            break;
        case 2:
        {
            [_Button setHighlighted:NO];
            [_Button1 setHighlighted:NO];
            [_Button2 setHighlighted:YES];
            [_Button setSelected:NO];
            [_Button1 setSelected:NO];
            [_Button2 setSelected:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)setSegmentedDefault:(int)index;
{
//    if (index == 0) {
//        NSLog(@"-=-");
//        [_Button setHighlighted:YES];
//        [_Button1 setHighlighted:NO];
//        [_Button2 setHighlighted:NO];
//        [_Button setSelected:YES];
//        [_Button1 setSelected:NO];
//        [_Button2 setSelected:NO];
//    }else if (index == 1) {
//        [_Button setHighlighted:NO];
//        [_Button1 setHighlighted:YES];
//        [_Button2 setHighlighted:NO];
//        [_Button setSelected:NO];
//        [_Button1 setSelected:YES];
//        [_Button2 setSelected:NO];
//    } else if (index == 2 ) {
//        [_Button setHighlighted:NO];
//        [_Button1 setHighlighted:NO];
//        [_Button2 setHighlighted:YES];
//        [_Button setSelected:NO];
//        [_Button1 setSelected:NO];
//        [_Button2 setSelected:YES];
//    }


}



- (void)buttonUp:(id)aButton event:(id)event {
    UIButton *button = (UIButton *)aButton;
    [button setBackgroundColor:buttonBackgroundColorForStateNormal];
}

- (void)buttonPressed:(id)aButton event:(id)event {
    if (buttonPressActionHandler) {
        for (int i = 0; i < [buttons count]; i++) {
            if (aButton == [buttons objectAtIndex:i]) {
                buttonPressActionHandler(i);
            }
        }
    }
}


- (void)buttonDown:(id)aButton event:(id)event {
    UIButton *button = (UIButton *)aButton;
    [button setBackgroundColor:buttonBackgroundColorForStatePressed];
}

- (void)setButtonPressActionHandler:(void (^)(int buttonIndex))actionHandler {
    buttonPressActionHandler = [actionHandler copy];
}
@end
