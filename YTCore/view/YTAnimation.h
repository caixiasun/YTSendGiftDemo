//
//  YTAnimation.h
//  YTSendGiftDemo
//
//  Created by caixiasun on 2016/12/22.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTGiftView.h"
#import "YTCacheData.h"

@interface YTAnimation : NSOperation

@property (nonatomic, strong) YTGiftView *giftView;
@property (nonatomic, strong) YTGiftData *data;
@property (nonatomic, strong) UIView *parentView;
@property (nonatomic,copy) NSString *userID; // 新增用户唯一标示，记录礼物信息

// 回调参数增加了结束时礼物累计数
+ (instancetype)animOperationWithUserID:(NSString *)userID Count:(NSInteger)count OldCount:(NSInteger)oldCount InView:(UIView *)inView Data:(YTGiftData *)data finishedBlock:(void(^)(BOOL result,NSInteger finishCount))finishedBlock;

@end
