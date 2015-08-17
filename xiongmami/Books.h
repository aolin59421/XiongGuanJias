//
//  Books.h
//  xiongmami
//
//  Created by iMac on 14/11/22.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import "Interface.h"
#import "LZWCustomActionSheet.h"

@interface Books : UIViewController<doneSelect,UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UITableView *_booksTableView;
    
    NSArray *_listArray ;
    NSArray *_rowListArray;
    
    UILabel *_yearLab;
    UIButton *_monthLab;
    UILabel *_payUpLab;
    UILabel *_payInLab;
    
    MBProgressHUD *HUD;
    
    NSMutableArray *_yearListArray;
    NSMutableArray *_mothListArray;
    NSMutableArray *_bigArray;
    
    UIView *_pickerView;
    UIPickerView *_picker;
    
    NSString *_yearTime;
    NSString *_monthTime;
    
    
    UIButton *_picVCButton;//阴影
    
    
    UILabel *_lab;//当信息条数为0时   出现提示文本
    
}
@property (nonatomic, strong) UILabel *yearLab;
@property (nonatomic, strong) UIButton *monthLab;
@property (nonatomic, strong) UILabel *payUpLab;
@property (nonatomic, strong) UILabel *payInLab;

@end
