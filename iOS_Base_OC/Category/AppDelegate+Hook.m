//
//  AppDelegate+Hook.m
//  iOS_Base_OC
//
//  Created by Jakin on 2018/1/15.
//  Copyright © 2018年 Jakin. All rights reserved.
//

#import "AppDelegate+Hook.h"
#import "MethodSwizzling.h"

@implementation AppDelegate (Hook)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self hookAppDelegate];
    });
}

+ (void)hookAppDelegate {
    SwizzlingMethod([AppDelegate class], @selector(application:didFinishLaunchingWithOptions:), @selector(hook_application:didFinishLaunchingWithOptions:));
    SwizzlingMethod([AppDelegate class], @selector(application:handleOpenURL:), @selector(hook_application:handleOpenURL:));
    SwizzlingMethod([AppDelegate class], @selector(application:openURL:sourceApplication:annotation:), @selector(hook_application:openURL:sourceApplication:annotation:));
    SwizzlingMethod([AppDelegate class], @selector(applicationDidReceiveMemoryWarning:), @selector(hook_applicationDidReceiveMemoryWarning:));
    SwizzlingMethod([AppDelegate class], @selector(application:didRegisterForRemoteNotificationsWithDeviceToken:), @selector(hook_application:didRegisterForRemoteNotificationsWithDeviceToken:));
    SwizzlingMethod([AppDelegate class], @selector(application:didFailToRegisterForRemoteNotificationsWithError:), @selector(hook_application:didFailToRegisterForRemoteNotificationsWithError:));
    SwizzlingMethod([AppDelegate class], @selector(application:didReceiveRemoteNotification:fetchCompletionHandler:), @selector(hook_application:didReceiveRemoteNotification:fetchCompletionHandler:));
}

- (BOOL)hook_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [[UITextField appearance] setTintColor:[UIColor orangeColor]];
    });
    
    return [self hook_application:application didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)hook_application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self hook_application:application handleOpenURL:url];
}

- (BOOL)hook_application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [self hook_application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

-  (void)hook_applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    return [self hook_applicationDidReceiveMemoryWarning:application];
}

- (void)hook_application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    return [self hook_application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)hook_application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    
    NSString *str = [NSString stringWithFormat: @"Error: %@",err];
    
    NSLog(@"======> deviceToken获取不到：%@",str);
    return [self hook_application:application didFailToRegisterForRemoteNotificationsWithError:err];
}

#pragma mark - iOS 7以上iOS 10以下系统处理点击推送信息
- (void)hook_application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    return [self hook_application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}
@end
