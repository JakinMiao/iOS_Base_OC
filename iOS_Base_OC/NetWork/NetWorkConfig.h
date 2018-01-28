//
//  NetWorkConfig.h
//  iOS_Base_OC
//
//  Created by Jakin on 18/1/27.
//
//

#import <Foundation/Foundation.h>
#import "BaseNetWork.h"

typedef NS_ENUM(NSInteger, EnvironmentType) {
    EnvironmentType_RELEASE = 0,
    EnvironmentType_BETA
};

@interface NetWorkConfig : NSObject

/**
 *  默认baseUrl
 */
@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, copy) NSString *osType;
@property (nonatomic, strong) AFSecurityPolicy *securityPolicy;

+ (NetWorkConfig *)shareInstance;

- (EnvironmentType)environmentType;
@end
