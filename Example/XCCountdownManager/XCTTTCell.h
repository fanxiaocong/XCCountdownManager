//
//  XCTTTCell.h
//  XCCountdownManager_Example
//
//  Created by 樊小聪 on 2018/6/29.
//  Copyright © 2018年 fanxiaocong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCTTTModel.h"

extern NSString *const XCTTTCellIdentifier;


@interface XCTTTCell : UITableViewCell

@property (strong, nonatomic) XCTTTModel *model;

@property (copy, nonatomic) void(^countdownZeroCallBack)(XCTTTModel *model);

@end
