//
//  Tools.m
//  iOS_Base_OC
//
//  Created by Jakin on 2018/1/22.
//  Copyright © 2018年 Jakin. All rights reserved.
//

#import "Tools.h"

#import "UIColor+Hex.h"

@implementation Tools

+ (UIColor *)colorWithHexString:(NSString *)string {
    return [UIColor colorWithHexString:string];
}

+ (UIColor *)colorWithHexString:(NSString *)string alpha:(CGFloat)alpha {
    return [UIColor colorWithHexString:string alpha:alpha];
}

+ (CGFloat)mainScale {
    static CGFloat scale;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scale = [UIScreen mainScreen].scale;
    });
    return scale;
}

+ (CGFloat)CGFloatFromPixel:(CGFloat)value {
    return value/ [self mainScale];
}

@end
