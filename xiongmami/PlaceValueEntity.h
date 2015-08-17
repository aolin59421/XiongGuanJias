//
//  PlaceValueEntity.h
//  xiongmami
//
//  Created by iMac on 14/11/22.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface PlaceValueEntity : NSObject

{
    NSString *_nameStr;//姓名
    NSString *_cityStr;//城市
//    NSString *_areaStr;//区域
    NSString *_numeberStr;//手机号码
    NSString *_detailedStr;//详细地址
    NSString *_userId;//用户编号
    NSString *_addrId;//区域id
    NSString *_getDate;//取件日期
    NSString *_getTime;//取件时间
    NSString *_sendDate;//送件日期
    NSString *_sendTime;//送件时间段
    NSString *_flag;//是否加急
    NSString *_mark;//备注
    NSString *_sendType;//送货类型
}

@property (nonatomic, strong) NSString *nameStr;
@property (nonatomic, strong) NSString *cityStr;
//@property (nonatomic, strong) NSString *areaStr;
@property (nonatomic, strong) NSString *numberSte;
@property (nonatomic, strong) NSString *detailedStr;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *addrId;
@property (nonatomic, strong) NSString *getDate;
@property (nonatomic, strong) NSString *getTime;
@property (nonatomic, strong) NSString *sendDate;
@property (nonatomic, strong) NSString *sendTime;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *mark;
@property (nonatomic, strong) NSString *sendType;

@end
