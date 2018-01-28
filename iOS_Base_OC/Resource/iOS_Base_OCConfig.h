//
//  iOS_Base_OCConfig.h
//  iOS_Base_OC
//
//  Created by Jakin on 2018/1/17.
//  Copyright © 2018年 Jakin. All rights reserved.
//

#ifndef iOS_Base_OCConfig_h
#define iOS_Base_OCConfig_h

#define UIMainScreen    [[UIScreen mainScreen] bounds]

#define ApplicationDelegate     ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define kNavgationBarHeight 44.0
/** 底部Tabbar 高度 */
#define kTabBarHeight  isIPhoneX ? 83.0 : 49.0
#define kTabBarContentEdgeInsetsBottom isIPhoneX ? (83 - 49) : 0
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kTopHeight (kStatusBarHeight + kNavgationBarHeight)

#define isIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? [[UIScreen mainScreen] currentMode].size.height == 2436 : NO)

#define ApplicationDelegate     ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define ApplicationController    ApplicationDelegate.viewController
#define WEAKSELF        __typeof__(self)__weak weakSelf = self;
#define STRONGSELF      __typeof__(self) strongSelf = weakSelf;

#endif /* iOS_Base_OCConfig_h */
