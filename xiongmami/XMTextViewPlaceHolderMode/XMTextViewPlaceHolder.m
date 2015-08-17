//
//  XMTextViewPlaceHolder.m
//  TextViewPlaceHolder
//
//  Created by Erren on 14-9-11.
//  Copyright (c) 2014年 Erren. All rights reserved.
//

#import "XMTextViewPlaceHolder.h"

@interface XMTextViewPlaceHolder()
{
    BOOL _shouldDrawPlaceholder;
}
@end

@implementation XMTextViewPlaceHolder


#pragma mark - Accessors

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self updateShouldDrawPlaceholder];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    if ([placeholder isEqual:_placeholder])
    {
        return;
    }
    _placeholder = placeholder;
    
    [self updateShouldDrawPlaceholder];
}

#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (_shouldDrawPlaceholder)
    {
        [_placeholderColor set];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] <= 7.0)
        {
            [_placeholder drawInRect:CGRectMake(8.0f, 8.0f, self.frame.size.width - 16.0f, self.frame.size.height - 16.0f) withFont:self.font];   
        } else{
            CGFloat fontC = [_placeholderFont floatValue];
            UIFont *font = [UIFont systemFontOfSize:fontC];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,_placeholderColor,NSForegroundColorAttributeName, nil];
            [_placeholder drawInRect:CGRectMake(8.0f, 8.0f, self.frame.size.width - 16.0f, self.frame.size.height - 16.0f) withAttributes:dic];
        }
    }
}

#pragma mark - Private

- (void)initialize
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:self];
    
    self.placeholderColor = [UIColor colorWithWhite:0.702f alpha:1.0f];
    _shouldDrawPlaceholder = NO;
}


- (void)updateShouldDrawPlaceholder
{
    BOOL prev = _shouldDrawPlaceholder;
    _shouldDrawPlaceholder = self.placeholder && self.placeholderColor && self.text.length == 0;
    if (prev != _shouldDrawPlaceholder)
    {
        [self setNeedsDisplay];
    }
}


- (void)textChanged:(NSNotification *)notificaiton
{
    [self updateShouldDrawPlaceholder];
}


@end
