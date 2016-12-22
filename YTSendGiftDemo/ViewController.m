//
//  ViewController.m
//  YTSendGiftDemo
//
//  Created by yatou on 2016/12/21.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "ViewController.h"
#import "YTAnimationManager.h"
#import "YTGitCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *drinkImageView;
@property (weak, nonatomic) IBOutlet UIImageView *helmetImageView;
@property (weak, nonatomic) IBOutlet UIImageView *watchImageView;
@property (weak, nonatomic) IBOutlet UIView *giftView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

static NSString *cellIdentifier = @"YTGitCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBorder];
    
    [self.tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
    self.dataSource = [NSMutableArray new];
    
}
- (IBAction)tapAction:(UITapGestureRecognizer *)tap {
    
    YTGiftData *data = [YTGiftData new];
    data.senderName = [NSString stringWithFormat:@"用户%d",arc4random()%2];//模拟两个用户在送礼物
    data.deviceType = [NSString stringWithFormat:@"%d",arc4random()%2+1];//模拟用户设备
    switch (tap.view.tag) {
        case 1://drink
        {
            data.giftName = @"饮料";
            data.giftIcon = @"drink";
            break;
        }
        case 2://helmet
        {
            data.giftName = @"头盔";
            data.giftIcon = @"helmet";
            break;
        }
        default://watch
        {
            data.giftName = @"手环";
            data.giftIcon = @"watch";
            break;
        }
    }
    YTAnimationManager *manager = [YTAnimationManager sharedAnimationManager];
    manager.parentView = self.giftView;
    [manager animWithData:data finishedBlock:^(BOOL result) {
        DLog(@"completed....");
    }];
    
    [self.dataSource addObject:data];
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.dataSource.count-1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YTGitCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell setContent:[self.dataSource objectAtIndex:indexPath.section]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 25;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor clearColor];
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
    
    self.tableView.layer.borderColor = cgColor;
    self.tableView.layer.borderWidth = 0.5;
    self.tableView.layer.cornerRadius = 10;
    self.tableView.layer.masksToBounds = YES;
}

@end
