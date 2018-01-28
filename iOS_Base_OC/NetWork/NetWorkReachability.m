//
//  NetWorkReachability.m
//  iOS_Base_OC
//
//  Created by Jakin on 18/1/27.
//
//

#import "NetWorkReachability.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface NetWorkReachability ()

@property (nonatomic, strong) Reachability *reachability;
@end

@implementation NetWorkReachability

+ (NetWorkReachability *)shareInstance {
    static id shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    
    return shareInstance;
}

/**
 *  初始化网络监听
 */
- (void)startMonitor {
    
    /** 添加网络监听通知 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netStatusChange:)
                                                 name:kReachabilityChangedNotification object:nil];
    
    self.reachability = [Reachability reachabilityWithHostName:@"www.qq.com"];
    
    [self.reachability startNotifier];
    
}

/**
 *  网络监听通知回调
 *
 *  @param notification 通知
 */
- (void)netStatusChange:(NSNotification *)notification {
    
}
@end
