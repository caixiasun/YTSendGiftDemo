//
//  YTGitCell.m
//  YTSendGiftDemo
//
//  Created by caixiasun on 2016/12/22.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "YTGitCell.h"

@interface YTGitCell()

@property (weak, nonatomic) IBOutlet UILabel *senderNameLab;
@property (weak, nonatomic) IBOutlet UIImageView *deviceImg;
@property (weak, nonatomic) IBOutlet UILabel *giftNameLab;
@property (weak, nonatomic) IBOutlet UIImageView *giftImg;

@end
@implementation YTGitCell

- (void)setContent:(YTGiftData *)data {
    if ([data.deviceType intValue] == 1) {
        self.deviceImg.image = [UIImage imageNamed:@"phone"];
    }else {
        self.deviceImg.image = [UIImage imageNamed:@"computer"];
    }
    self.senderNameLab.text = data.senderName;
    self.giftNameLab.text = [NSString stringWithFormat:@"送出1个 %@",data.giftName];
    self.giftImg.image = [UIImage imageNamed:data.giftIcon];
}

@end
