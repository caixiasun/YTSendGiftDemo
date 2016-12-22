//
//  YTGiftData.h
//  PlaySendGiftDemo
//
//  Created by yatou on 2016/12/21.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTGiftData : NSObject

@property (nonatomic, strong) NSString *deviceType;//1 手机 2 电脑
@property (nonatomic, strong) NSString *senderName;
@property (nonatomic, strong) NSString *giftName;
@property (nonatomic, strong) NSString *giftIcon;

@end
