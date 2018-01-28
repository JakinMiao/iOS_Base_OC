//
//  NetWorkConfig.m
//  iOS_Base_OC
//
//  Created by Jakin on 18/1/27.
//
//

#import "NetWorkConfig.h"
#import "DefinitionKey.h"

@implementation NetWorkConfig

+ (NetWorkConfig *)shareInstance {
    static id shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    
    return shareInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        _securityPolicy = [AFSecurityPolicy defaultPolicy];
        _securityPolicy.allowInvalidCertificates = YES;
        _securityPolicy.validatesDomainName = NO;
    }
    return self;
}

- (NSString *)osType {
    return @"ios";
}

- (EnvironmentType)environmentType {
    if ([self.baseUrl isEqualToString:k_ProdHost]) {
        return EnvironmentType_RELEASE;
    }
    return EnvironmentType_BETA;
}

- (NSString *)baseUrl {
    return k_ProdHost;
}
@end
