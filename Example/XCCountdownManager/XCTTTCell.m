//
//  XCTTTCell.m
//  XCCountdownManager_Example
//
//  Created by 樊小聪 on 2018/6/29.
//  Copyright © 2018年 fanxiaocong. All rights reserved.
//

#import "XCTTTCell.h"

#import <XCCountdownManager/XCCountdownManager.h>


NSString *const XCTTTCellIdentifier = @"XCTTTCell";

@implementation XCTTTCell

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:XCCountdownNotification object:nil];
}

// 代码创建
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        
        /// 添加通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTime) name:XCCountdownNotification object:nil];
        
    }
    return self;
}

/**
 *  更新时间
 */
- (void)updateTime
{
    XCTTTModel *model = self.model;
    NSInteger timeInterval = [[XCCountdownManager shareManager] timeIntervalWithIdentifier:model.countDownSource];
    NSInteger countdown = model.count - timeInterval;
    
    if (countdown <= 0) {
        self.detailTextLabel.text = @"活动开始";
        if (self.countdownZeroCallBack) {
            self.countdownZeroCallBack(model);
        }
        return;
    }

    NSInteger timeCount = (NSInteger)countdown;
    self.detailTextLabel.text = [NSString stringWithFormat:@"倒计时%02zd:%02zd:%02zd", timeCount/3600, (timeCount/60)%60, timeCount%60];
}

- (void)setModel:(XCTTTModel *)model
{
    _model = model;
    
    self.textLabel.text = model.title;
    [self updateTime];
}

@end
