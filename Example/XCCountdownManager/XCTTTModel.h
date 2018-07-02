//
//  XCTTTModel.h
//  XCCountdownManager_Example
//
//  Created by 樊小聪 on 2018/6/29.
//  Copyright © 2018年 fanxiaocong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCTTTModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger count;

/// 表示时间已经到了
@property (nonatomic, assign) BOOL timeOut;

/// 倒计时源
@property (nonatomic, copy) NSString *countDownSource;

@end
