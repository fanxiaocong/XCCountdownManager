//
//  XCTTTViewController.m
//  XCCountdownManager_Example
//
//  Created by 樊小聪 on 2018/6/29.
//  Copyright © 2018年 fanxiaocong. All rights reserved.
//

#import "XCTTTViewController.h"
#import "XCTTTModel.h"
#import "XCTTTCell.h"

#import <XCCountdownManager/XCCountdownManager.h>


@interface XCTTTViewController ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation XCTTTViewController
{
    BOOL _isMillonSecond;
}

- (void)dealloc
{
    // 废除定时器
    [[XCCountdownManager shareManager] invalidate];
    
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = 50;
    [self.tableView registerClass:NSClassFromString(XCTTTCellIdentifier) forCellReuseIdentifier:XCTTTCellIdentifier];
}

- (NSArray *)dataSource
{
    if (_dataSource == nil) {
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSInteger i=0; i<50; i++) {
            // 模拟从服务器取得数据 -- 例如:服务器返回的数据为剩余时间数
            NSInteger count = arc4random_uniform(100); //生成0-100之间的随机正整数
            XCTTTModel *model = [[XCTTTModel alloc] init];
            model.count = count;
            model.title = [NSString stringWithFormat:@"第%zd条数据", i];
            model.countDownSource = @"xxx---xxx";
            [arrM addObject:model];
        }
        /// 绑定定时源并开启定时器
        [[XCCountdownManager shareManager] addSourceWithIdentifier:@"xxx---xxx"];
        [[XCCountdownManager shareManager] start];
        _dataSource = arrM.copy;
    }
    return _dataSource;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XCTTTCell *cell = [tableView dequeueReusableCellWithIdentifier:XCTTTCellIdentifier forIndexPath:indexPath];
    // 传递模型
    XCTTTModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    [cell setCountdownZeroCallBack:^(XCTTTModel *timeOutModel){
        // 回调
        if (!timeOutModel.timeOut) {
            NSLog(@"SingleTableVC--%@--时间到了", timeOutModel.title);
        }
        // 标志
        timeOutModel.timeOut = YES;
    }];
    return cell;
}

@end
