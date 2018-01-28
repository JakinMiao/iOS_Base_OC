//
//  NetWork.m
//  iOS_Base_OC
//
//  Created by Jakin on 18/1/27.
//
//

#import "NetWork.h"
#import "Reachability.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@implementation NetWork

- (void)startCompletionHandlerWithSuccess:(SuccessCompletionHandler)success
                                  failure:(FailureCompletionHandler)failure {
    
    [self startWithCompletionBlockWithSuccess:^(__kindof BaseNetWork *request) {
        NSInteger flag = [self.responseObject[@"code"] integerValue];
        if (flag == ResponseFlag_SUCCESS) {
            [self analystRepsone];
            if (success) {
                success(flag);
            }
        } else if(flag == ResponseFlag_TOKENINVAIL) {
//            if (failure) {
//                failure(ResponseFlag_TOKENINVAIL, TokenInvailMsg);
//            }
        } else {
            NSString *error = self.responseObject[@"msg"];
            if (failure) {
                failure(flag, error);
            }
        }
    } failure:^(__kindof BaseNetWork *request) {
        if (failure) {
            failure(self.requestErrorCode, @"网络好像不太对劲, 请检查设置");
        }
    }];
    [self clearCompletionHandler];
}

- (void)clearCompletionHandler {
    self.successCompletionHandler = nil;
    self.failureCompletionHandler = nil;
}

- (void)analystRepsone {
}

- (NSString *)osType {
    return [NetWorkConfig shareInstance].osType;
}

- (NSString *)requestUrlWithArgument:(NSString *)baseUrl andNeedSign:(BOOL)needSign {
    return [self requestUrlWithArgument:baseUrl andNeedSign:needSign arguments:nil];
}

- (NSString *)requestUrlWithArgument:(NSString *)baseUrl andNeedSign:(BOOL)needSign arguments:(NSString *)arguments {
//    NSString *deviceId = [Tools getDeviceId];
    
    /** 配合双系统，上线前要去掉 */
    baseUrl = [@"/api/v2" stringByAppendingString:baseUrl];
    
    NSString *url = @"";
    
    if (needSign) {
//        url = [url stringByAppendingString:[NSString stringWithFormat:@"&%@", [Tools GetSignAndTS]]];
    }
    if (arguments.length > 0) {
        url = [url stringByAppendingString:[NSString stringWithFormat:@"&%@", arguments]];
    }
    return url;
}
@end
