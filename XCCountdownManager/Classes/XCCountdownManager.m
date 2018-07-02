//
//  XCCountdownManager.m
//  Pods-XCCountdownManager_Example
//
//  Created by 樊小聪 on 2018/6/29.
//

#import "XCCountdownManager.h"
#import "XCTimeInterval.h"
#import <UIKit/UIKit.h>


NSString *const XCCountdownNotification = @"XCCountdownNotification";


@interface XCCountdownManager ()

@property (nonatomic, strong) NSTimer *timer;

/// 时间差字典(单位:秒)(使用字典来存放, 支持多列表或多页面使用)
@property (nonatomic, strong) NSMutableDictionary<NSString *, XCTimeInterval *> *timeIntervalInfo;

/// 后台模式使用, 记录进入后台的绝对时间
@property (nonatomic, assign) BOOL backgroudRecord;
@property (nonatomic, assign) CFAbsoluteTime lastTime;

@end


@implementation XCCountdownManager

#pragma mark - ⏳ 👀 LifeCycle Method 👀

+ (instancetype)shareManager
{
    static XCCountdownManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XCCountdownManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 监听进入前台与进入后台的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForegroundNotification) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    return self;
}

#pragma mark - 💤 👀 LazyLoad Method 👀

- (NSTimer *)timer
{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeDidChangeAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (NSMutableDictionary *)timeIntervalInfo
{
    if (!_timeIntervalInfo) {
        _timeIntervalInfo = [NSMutableDictionary dictionary];
    }
    return _timeIntervalInfo;
}

#pragma mark - 🔓 👀 Public Method 👀

- (void)start
{
    // 启动定时器
    [self timer];
}


- (void)invalidate
{
    [self.timer invalidate];
    self.timer = nil;
}


- (void)addSourceWithIdentifier:(NSString *)identifier
{
    XCTimeInterval *timeInterval = self.timeIntervalInfo[identifier];
    if (timeInterval) {
        timeInterval.timeInterval = 0;
    } else {
        timeInterval = [[XCTimeInterval alloc] init];
        [self.timeIntervalInfo setObject:timeInterval forKey:identifier];
    }
}


- (void)reloadAllSource
{
    [self.timeIntervalInfo enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, XCTimeInterval * _Nonnull obj, BOOL * _Nonnull stop) {
        obj.timeInterval = 0;
    }];
}

- (void)reloadSourceWithIdentifier:(NSString *)identifier
{
    self.timeIntervalInfo[identifier].timeInterval = 0;
}


- (void)removeAllSource
{
    [self.timeIntervalInfo removeAllObjects];
}

- (void)removeSourceWithIdentifier:(NSString *)identifier
{
    [self.timeIntervalInfo removeObjectForKey:identifier];
}


- (NSInteger)timeIntervalWithIdentifier:(NSString *)identifier
{
    return self.timeIntervalInfo[identifier].timeInterval;
}


#pragma mark - 🎬 👀 Action Method 👀

/**
 *  App 进入后台
 */
- (void)applicationDidEnterBackgroundNotification
{
    self.backgroudRecord = (_timer != nil);
    if (self.backgroudRecord) {
        self.lastTime = CFAbsoluteTimeGetCurrent();
        [self invalidate];
    }
}

/**
 *  App 进入前台
 */
- (void)applicationWillEnterForegroundNotification
{
    if (self.backgroudRecord) {
        CFAbsoluteTime timeInterval = CFAbsoluteTimeGetCurrent() - self.lastTime;
        // 取整
        [self updateTimeInterval:timeInterval];
        [self start];
    }
}

/**
 *  时间发生改变的回调
 */
- (void)timeDidChangeAction
{
    // 更新时间
    [self updateTimeInterval:1];
}

#pragma mark - 🔒 👀 Privite Method 👀

/**
 *  更新时间
 */
- (void)updateTimeInterval:(NSTimeInterval)timeInterval
{
    [self.timeIntervalInfo enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, XCTimeInterval * _Nonnull obj, BOOL * _Nonnull stop) {
        obj.timeInterval += timeInterval;
    }];
    
    /// 回调通知
    [[NSNotificationCenter defaultCenter] postNotificationName:XCCountdownNotification object:nil userInfo:nil];
}


@end
