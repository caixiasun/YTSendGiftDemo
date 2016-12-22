//
//  YTAnimationManager.h
//  YTSendGiftDemo
//
//  Created by caixiasun on 2016/12/22.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTAnimation.h"

@interface YTAnimationManager : NSObject

@property (nonatomic, strong) UIView *parentView;

+ (instancetype)sharedAnimationManager;
/// 取消所有 队列操作
- (void)cancelAllOperations;
/// 动画操作 : 需要UserID和回调
- (void)animWithData:(YTGiftData *)data finishedBlock:(void(^)(BOOL result))finishedBlock;

@end
