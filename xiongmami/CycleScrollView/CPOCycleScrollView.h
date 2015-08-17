//
//  CPOCycleScrollView.h
//  App
//
//  Created by 王剑飞 on 14-8-19.
//  Copyright (c) 2014年 Zhejiang China Plastics Online Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CPOCycleScrollViewDelegate <NSObject>

- (void)page:(NSInteger)page;

@end

@interface CPOCycleScrollView : UIView

@property (nonatomic ,weak) id<CPOCycleScrollViewDelegate>delegate;
@property (nonatomic , readonly) UIScrollView *scrollView;

- (id)initWithFrame:(CGRect)frame pageContol:(NSInteger)page animationDuration:(NSTimeInterval)animationDuration;

/**
 数据源：获取总的page个数
 **/
@property (nonatomic , copy) NSInteger (^totalPagesCount)(void);
/**
 数据源：获取第pageIndex个位置的contentView
 **/
@property (nonatomic , copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);
/**
 当点击的时候，执行的block
 **/
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);

@end

@interface NSTimer (Addition)
- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end
