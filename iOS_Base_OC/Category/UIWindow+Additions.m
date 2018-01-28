//
//  UIWindow+Additions.m
//  iOS_Base_OC
//
//  Created by Jakin on 2018/1/17.
//  Copyright © 2018年 Jakin. All rights reserved.
//

#import "UIWindow+Additions.h"

@implementation UIWindow (Additions)

- (BOOL)setRootViewController: (UIViewController *)rootViewController animated:(BOOL)animated
{
    [self setRootViewController:nil];
    [self setRootViewController:rootViewController];
    [self makeKeyAndVisible];
    return YES;
}

@end
