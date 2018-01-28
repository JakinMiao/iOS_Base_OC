//
//  RootViewControllerHelper.m
//  iOS_Base_OC
//
//  Created by Jakin on 2018/1/16.
//  Copyright © 2018年 Jakin. All rights reserved.
//

#import "RootViewControllerHelper.h"
#import "Controller_Initial.h"
#import "UIWindow+Additions.h"

@implementation RootViewControllerHelper

+ (BOOL)initRootViewController {
    return [self setInitialRootViewControllerWithAnimation:YES];
}

+ (void)setLoginRootViewController {
    
}

+ (BOOL)setInitialRootViewControllerWithAnimation:(BOOL)animation {
    ApplicationDelegate.viewController = [[Controller_Initial alloc] init];
    return [ApplicationDelegate.window setRootViewController:ApplicationDelegate.viewController animated:animation];
}
@end
