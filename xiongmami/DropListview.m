//
//  DropListview.m
//  xiongmami
//
//  Created by iMac on 14/11/19.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "DropListview.h"

@implementation DropListview

-(id)initWithFrame:(CGRect)frame
{
    if (frame.size.height<200) {
        frameHeight = 200;
    }else{
        frameHeight = frame.size.height;
    }
    tabheight = frameHeight-30;
    
    frame.size.height = 30.0f;
    
    self=[super initWithFrame:frame];
    
    if(self){
        showList = NO; //默认不显示下拉框
        
        _tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, frame.size.width, 0)];
        _tv.delegate = self;
        _tv.dataSource = self;
        _tv.backgroundColor = [UIColor clearColor];
        _tv.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tv.hidden = YES;
        [self addSubview:_tv];
        keyboard = NO;
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
        _textField.borderStyle=UITextBorderStyleRoundedRect;//设置文本框的边框风格
        [_textField addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventAllTouchEvents];
        [self addSubview:_textField];
        
    }
    return self;
}
-(void)dropdown{
    keyboard = YES;
    [_textField resignFirstResponder];
    if (keyboard == YES) {
        _textField.userInteractionEnabled = NO;
    }
    if (showList) {//如果下拉框已显示，什么都不做
        return;
    }else {//如果下拉框尚未显示，则进行显示
        
        CGRect sf = self.frame;
        sf.size.height = frameHeight;
        
        //把dropdownList放到前面，防止下拉框被别的控件遮住
        [self.superview bringSubviewToFront:self];
        _tv.hidden = NO;
        showList = YES;//显示下拉框
        
        CGRect frame = _tv.frame;
        frame.size.height = 0;
        _tv.frame = frame;
        frame.size.height = tabheight;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        self.frame = sf;
        _tv.frame = frame;
        [UIView commitAnimations];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [_tableArray objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _textField.text = [_tableArray objectAtIndex:[indexPath row]];
    showList = NO;
    _tv.hidden = YES;
    
    CGRect sf = self.frame;
    sf.size.height = 30;
    self.frame = sf;
    CGRect frame = _tv.frame;
    frame.size.height = 0;
    _tv.frame = frame;
    _textField.userInteractionEnabled = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textField resignFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
