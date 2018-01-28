//
//  Tools.h
//  iOS_Base_OC
//
//  Created by Jakin on 2018/1/22.
//  Copyright © 2018年 Jakin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface Tools : NSObject

#pragma mark -UIColor
+ (UIColor *)colorWithHexString:(NSString *)string;
+ (UIColor *)colorWithHexString:(NSString *)string alpha:(CGFloat)alpha;

+ (CGFloat)CGFloatFromPixel:(CGFloat)value;


@end
