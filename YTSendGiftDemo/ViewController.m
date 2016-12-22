//
//  ViewController.m
//  YTSendGiftDemo
//
//  Created by yatou on 2016/12/21.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *drinkImageView;
@property (weak, nonatomic) IBOutlet UIImageView *helmetImageView;
@property (weak, nonatomic) IBOutlet UIImageView *watchImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)tapAction:(UITapGestureRecognizer *)tap {
    
    switch (tap.view.tag) {
        case 1://drink
        {
            break;
        }
        case 2://helmet
        {
            break;
        }
        default://watch
        {
            break;
        }
    }
}

- (void)setBorder {
    CGColorRef cgColor = [UIColor greenColor].CGColor;
    self.drinkImageView.layer.borderColor = cgColor;
    self.drinkImageView.layer.borderWidth = 0.5;
    self.drinkImageView.layer.cornerRadius = 10;
    self.drinkImageView.layer.masksToBounds = YES;
    
    self.helmetImageView.layer.borderColor = cgColor;
    self.helmetImageView.layer.borderWidth = 0.5;
    self.helmetImageView.layer.cornerRadius = 10;
    self.helmetImageView.layer.masksToBounds = YES;
    
    self.watchImageView.layer.borderColor = cgColor;
    self.watchImageView.layer.borderWidth = 0.5;
    self.watchImageView.layer.cornerRadius = 10;
    self.watchImageView.layer.masksToBounds = YES;
}

@end
