//
//  YTGiftView.h
//  YTSendGiftDemo
//
//  Created by yatou on 2016/12/22.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTGiftData.h"

typedef void(^ShakeLabelCompleteBlock)(void);

@interface YTGiftViewShakeLabel : UILabel

// 动画时间
@property (nonatomic,assign) NSTimeInterval duration;
// 描边颜色
@property (nonatomic,strong) UIColor *borderColor;
//label上显示的number
@property (nonatomic, assign) NSInteger number;

- (void)startAnimWithDuration:(NSTimeInterval)duration CompleteBlock:(ShakeLabelCompleteBlock)completed;

@end

typedef void(^CompleteBlock)(BOOL finished, NSInteger finishCount);

@interface YTGiftView : UIView

@property (nonatomic, strong) UIImageView *deviceImgView;//终端设备图标
@property (nonatomic, strong) UIImageView *headImgView;
@property (nonatomic, strong) UIImageView *giftImgView;
@property (nonatomic, strong) UILabel *senderNameLabel; // 送礼物者
@property (nonatomic, strong) UILabel *giftNameLabel; // 礼物名称

@property (nonatomic,strong) YTGiftViewShakeLabel *shakeLabel;
@property (nonatomic,assign) NSInteger animCount; // 动画执行到了第几次
@property (nonatomic, assign) NSInteger oldAnimCount; // 上次动画执行到了第几次
@property (nonatomic,assign) CGRect originFrame; // 记录原始坐标
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) YTGiftData *data;

+ (YTGiftView *)createInView:(UIView *)inView Count:(NSInteger)count OldCount:(NSInteger)oldCount Identifier:(NSString *)identifier;
- (void)animateWithCompleteBlock:(CompleteBlock)completed Index:(NSInteger)index;//index为1：第一个视图  index为2：第二视图，动画位置不同

@end
