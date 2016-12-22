//
//  YTGiftView.m
//  YTSendGiftDemo
//
//  Created by caixiasun on 2016/12/22.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "YTGiftView.h"

#pragma mark - 送礼物累计数字 抖动动画
@implementation YTGiftViewShakeLabel

- (void)startAnimWithDuration:(NSTimeInterval)duration CompleteBlock:(ShakeLabelCompleteBlock)completed {
    [UIView animateKeyframesWithDuration:duration-0.2 delay:0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1/2.0 animations:^{
            
            self.transform = CGAffineTransformMakeScale(4, 4);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/2.0 relativeDuration:1/2.0 animations:^{
            
            self.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            if (completed) {
                completed();
            }
        }];
    }];
}

//  重写 drawTextInRect 文字描边效果
- (void)drawTextInRect:(CGRect)rect {
    
    CGSize shadowOffset = self.shadowOffset;
    UIColor *textColor = self.textColor;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 2);
    CGContextSetLineJoin(c, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    self.textColor = _borderColor;
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    self.shadowOffset = CGSizeMake(0, 0);
    [super drawTextInRect:rect];
    
    self.shadowOffset = shadowOffset;
    
}

@end

#pragma mark - PlayCustomGiftView  送礼物动画 view
@interface YTGiftView()

@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,copy) void(^completeBlock)(BOOL finished,NSInteger finishCount); // 新增了回调参数 finishCount， 用来记录动画结束时累加数量，将来在3秒内，还能继续累加
@property (nonatomic, assign) NSInteger queueIndex;//区分在哪个队列中，动画位置不同。
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) NSTimeInterval hideDuration;

@end
@implementation YTGiftView

+ (YTGiftView *)createInView:(UIView *)inView Count:(NSInteger)count OldCount:(NSInteger)oldCount Identifier:(NSString *)identifier {
    YTGiftView *customV = [YTGiftView new];
    customV.oldAnimCount = oldCount;
    customV.identifier = identifier;
    customV.animCount = count;
    customV.alpha = 0;
    customV.duration = 0.5;
    customV.hideDuration = 1.0;
    customV.frame = CGRectMake(0, inView.height, inView.width*0.5, inView.height*0.3);
    [inView addSubview:customV];
    [customV setUI];
    
    return customV;
}

/****************** 初始化 UI ****************/
- (void)layoutSubviews {
    
    [super layoutSubviews];
    _headImgView.layer.cornerRadius = _headImgView.frame.size.height / 2;
    _headImgView.layer.masksToBounds = YES;
    
}
- (void)setUI {
    
    _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]];
    _deviceImgView = [[UIImageView alloc] init];
    _headImgView = [[UIImageView alloc] init];
    _giftImgView = [[UIImageView alloc] init];
    _senderNameLabel = [[UILabel alloc] init];
    _senderNameLabel.textColor = [UIColor redColor];
    _senderNameLabel.font = [UIFont boldSystemFontOfSize:12];
    
    _giftNameLabel = [[UILabel alloc] init];
    _giftNameLabel.textColor = [UIColor whiteColor];
    _giftNameLabel.font = [UIFont boldSystemFontOfSize:12];
    
    // 初始化动画label
    _shakeLabel =  [[YTGiftViewShakeLabel alloc] init];
    _shakeLabel.font = [UIFont boldSystemFontOfSize:20];
    _shakeLabel.borderColor = [UIColor blackColor];
    _shakeLabel.textColor = [UIColor purpleColor];
    _shakeLabel.textAlignment = NSTextAlignmentCenter;
    _shakeLabel.number = 0;
    
    [self addSubview:_bgImageView];
    [self addSubview:_headImgView];
    [self addSubview:_giftImgView];
    [self addSubview:_senderNameLabel];
    [self addSubview:_giftNameLabel];
    [self addSubview:_shakeLabel];
    [self addSubview:_deviceImgView];
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self);
        make.center.equalTo(self);
    }];
    CGFloat margin = 2;
    [_deviceImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 5;
        make.centerY.equalTo(self);
    }];
    [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(self.mas_height).multipliedBy(0.8);
        make.centerY.equalTo(self);
        make.left.equalTo(_deviceImgView.mas_right).offset = margin;
    }];
    [_senderNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImgView.mas_right).offset = margin;
        make.centerY.equalTo(self);
    }];
    [_giftNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_senderNameLabel.mas_right).offset = margin;
        make.centerY.equalTo(self);
    }];
    [_giftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_giftNameLabel.mas_right).offset = margin;
        make.centerY.equalTo(self);
        make.height.equalTo(self.mas_height).multipliedBy(1.3);
        make.width.equalTo(_giftImgView.mas_height);
    }];
    [_shakeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_giftImgView.mas_right).offset = margin;
        make.centerY.equalTo(self);
        make.height.equalTo(self.mas_height).multipliedBy(0.8);
        make.width.equalTo(_shakeLabel.mas_height).multipliedBy(3);
    }];
}
/********************** 刷新礼物数据 ***************************/
- (void)setData:(YTGiftData *)data {
    _data = data;
    //设备图标
    if ([data.deviceType integerValue] == 1) {//手机
        _deviceImgView.image = [UIImage imageNamed:@"phone"];
    }else {//电脑
        _deviceImgView.image = [UIImage imageNamed:@"computer"];
    }
    _headImgView.image = [UIImage imageNamed:@"head.png"];
    _senderNameLabel.text = data.senderName;
    _giftNameLabel.text = [NSString stringWithFormat:@"送出%@",data.giftName];
    _giftImgView.image = [UIImage imageNamed:data.giftIcon];
}

/*************************动画模块****************************/
- (void)animateWithCompleteBlock:(CompleteBlock)completed Index:(NSInteger)index  {
    self.queueIndex = index;
    CGFloat yPosition = 0;
    if (index == 1) {
        yPosition = self.frame.size.height+5;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 1;
            self.frame = CGRectMake(0, yPosition, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            [self callbackShakeLabel];
        }];
    });
    
    self.completeBlock = completed;
}

//使用回调块实现不断抖动
- (void)callbackShakeLabel {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideGiftView) object:nil];
    if (_oldAnimCount < _animCount) {
        _oldAnimCount ++;
        self.shakeLabel.number = _oldAnimCount;
        @weakify(self)
        dispatch_async(dispatch_get_main_queue(), ^{
            weak_self.shakeLabel.text = [NSString stringWithFormat:@"X %ld",(long)_oldAnimCount];
            [weak_self.shakeLabel startAnimWithDuration:weak_self.duration CompleteBlock:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.5*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [weak_self callbackShakeLabel];
                });
            }];
        });
    }else {
        [self performSelector:@selector(hideGiftView) withObject:nil afterDelay:self.hideDuration];
    }
}

//隐藏礼物view，在2.0S后销毁该view
- (void)hideGiftView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.frame = CGRectMake(0, self.frame.origin.y - 20, self.frame.size.width, self.frame.size.height);
            self.alpha = 0;
        } completion:^(BOOL finished) {
            NSInteger tempCount = 0;//该变量的作用：避免在hide期间，_animCount增加但还没有抖动。
            if (_oldAnimCount > 0) {
                tempCount = _oldAnimCount;
            }else {
                tempCount = _animCount;
            }
            if (self.completeBlock) {
                self.completeBlock(YES,tempCount);
            }
            [self destroyed];
        }];
    });
}

//销毁该view，并重置所有状态
- (void)destroyed {
    [self reset];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}

// 重置所有状态
- (void)reset {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.frame = _originFrame;
        self.shakeLabel.text = @"";
    });
    
    self.animCount = 1;
    self.completeBlock = nil;
}

@end
