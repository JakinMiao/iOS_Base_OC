//
//  NetWorkReachability.h
//  iOS_Base_OC
//
//  Created by kalengo on 17/1/27.
//
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface NetWorkReachability : NSObject

- (void)startMonitor;

+ (NetWorkReachability *)shareInstance;
@end
