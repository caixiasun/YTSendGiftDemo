//
//  YTCacheData.m
//  YTSendGiftDemo
//
//  Created by caixiasun on 2016/12/22.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "YTCacheData.h"

@implementation YTCacheData

+ (YTCacheData *)createDataWithDate:(NSDate *)date Count:(NSInteger)count GiftName:(NSString *)giftName {
    YTCacheData *data = [YTCacheData new];
    data.date = date;
    data.count = count;
    data.giftName = giftName;
    data.oldCount = 0;
    return data;
}

@end
