//
//  DropListview.h
//  xiongmami
//
//  Created by iMac on 14/11/19.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropListview : UIView <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *_tv;//下拉列表
    NSArray *_tableArray;//下拉列表数据
    UITextField *_textField;//文本输入框
    BOOL showList;//是否弹出下拉列表
    CGFloat tabheight;//table下拉列表的高度
    CGFloat frameHeight;//frame的高度
    BOOL keyboard;//判断不让键盘出来
    
}

@property (nonatomic,strong) UITableView *tv;
@property (nonatomic,strong) NSArray *tableArray;
@property (nonatomic,strong) UITextField *textField;

@end
