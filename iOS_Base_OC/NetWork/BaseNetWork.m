//
//  BaseNetWork.m
//  iOS_Base_OC
//
//  Created by Jakin on 18/1/27.
//
//

#import "BaseNetWork.h"
#import "NetWorkAgent.h"

@implementation BaseNetWork

//- (BOOL)needRepeat {
//    return NO;
//}

- (NSString *)baseUrl {
    return @"";
}

- (NSString *)requestUrl {
    return @"";
}

- (NSTimeInterval)requestTimeoutInterval {
    return 15;
}

- (id)requestArgument {
    return nil;
}

- (ReqeuestMethod)requestMethod {
    return RequestMethod_GET;
}

- (RequestSerializerType)requestSerializerType {
    return RequestSerializerType_JSON;
}

- (void)start {
    [[NetWorkAgent shareInstance] addRequest:self];
}

/*
- (void)stop {
    
}*/

- (void)startWithCompletionBlockWithSuccess:(RequestCompletionBlock)success
                                    failure:(RequestCompletionBlock)failure {
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

- (void)setCompletionBlockWithSuccess:(RequestCompletionBlock)success
                              failure:(RequestCompletionBlock)failure {
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

- (void)clearCompletionBlock {
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}
@end
