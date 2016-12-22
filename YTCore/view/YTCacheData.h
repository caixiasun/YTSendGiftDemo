//
//  YTCacheData.h
//  YTSendGiftDemo
//
//  Created by caixiasun on 2016/12/22.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTCacheData : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger oldCount;//记录上次动画结束时的礼物数量
@property (nonatomic, strong) NSString *giftName;

+ (YTCacheData *)createDataWithDate:(NSDate *)date Count:(NSInteger)count GiftName:(NSString *)giftName;

@end
