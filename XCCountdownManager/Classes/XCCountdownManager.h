//
//  XCCountdownManager.h
//  Pods-XCCountdownManager_Example
//
//  Created by 樊小聪 on 2018/6/29.
//


/*
 *  备注：使用流程 🐾
 *
 *  1、初始化 XCCountdownManager 的实例
        [XCCountdownManager shareManager]
 *
 *  2、添加倒计时源，并绑定倒计时标识
        [mgr addSourceWithIdentifier:@"XXX"]
 *
 *  3、开始计时器
        [mgr start]
 *
 *  4、处理业务逻辑
        ...(略)
 *
 *  5、停止倒计时并消除定时器
        [mgr invalidate]
 */



#import <Foundation/Foundation.h>

/// 倒计时时间改变的通知
extern NSString *const XCCountdownNotification;


@interface XCCountdownManager : NSObject

/**
 *  单例
 */
+ (instancetype)shareManager;

/**
 *  创建定时器并开始倒计时
 */
- (void)start;

/**
 *  停止倒计时并消除定时器
 */
- (void)invalidate;


///  --------------
///  定时源：同一组规则的倒计时，用一个标识来唯一确定，该定时源的所有倒计时的开始时间相同
///  --------------

/**
 *  添加一个倒计时源并绑定唯一标识符
 *
 *  @param identifier 倒计时源的标识符
 */
- (void)addSourceWithIdentifier:(NSString *)identifier;

/**
 *  刷新倒计时源，从新开始倒计时，之前的倒计时清零
 */
- (void)reloadAllSource;
- (void)reloadSourceWithIdentifier:(NSString *)identifier;

/**
 *  移除倒计时源
 */
- (void)removeAllSource;
- (void)removeSourceWithIdentifier:(NSString *)identifier;

/**
 *  获取指定倒计时源已经走过的时间(单位：秒)
 *
 *  @param identifier 倒计时源的标识符
 */
- (NSInteger)timeIntervalWithIdentifier:(NSString *)identifier;


@end
