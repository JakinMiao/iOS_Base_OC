//
//  NetWorkAgent.h
//  iOS_Base_OC
//
//  Created by Jakin on 18/1/27.
//
//

#import <Foundation/Foundation.h>
#import "BaseNetWork.h"

@interface NetWorkAgent : NSObject

+ (NetWorkAgent *)shareInstance;

- (void)addRequest:(BaseNetWork *)request;

@end
