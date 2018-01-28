//
//  RootViewControllerHelper.h
//  iOS_Base_OC
//
//  Created by Jakin on 2018/1/16.
//  Copyright © 2018年 Jakin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RootViewControllerHelper : NSObject

+ (BOOL)initRootViewController;

+ (void)setLoginRootViewController;

+ (BOOL)setInitialRootViewControllerWithAnimation:(BOOL)animation;

@end
