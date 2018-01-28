//
//  BaseNetWork.h
//  iOS_Base_OC
//
//  Created by Jakin on 18/1/27.
//
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef NS_ENUM(NSInteger, ReqeuestMethod) {
    RequestMethod_GET = 0,
    RequestMethod_POST
};

typedef NS_ENUM(NSInteger, RequestSerializerType) {
    RequestSerializerType_JSON = 0,
    RequestSerializerType_HTTP
};

@class BaseNetWork;
typedef void(^RequestCompletionBlock) (__kindof BaseNetWork *request);

@interface BaseNetWork : NSObject

@property (nonatomic, assign) BOOL needRepeat;

@property (nonatomic, copy  ) NSString *baseUrl;

@property (nonatomic, copy  ) NSString *requestUrl;

//网络错误的状态码
@property (nonatomic, assign) NSInteger requestErrorCode;

@property (nonatomic, strong) id responseObject;

@property (nonatomic, strong) NSURLSessionDataTask *sessionDataTask;

@property (nonatomic, copy) RequestCompletionBlock successCompletionBlock;

@property (nonatomic, copy) RequestCompletionBlock failureCompletionBlock;

- (void)setCompletionBlockWithSuccess:(RequestCompletionBlock)success
                              failure:(RequestCompletionBlock)failure;

- (void)startWithCompletionBlockWithSuccess:(RequestCompletionBlock)success
                                    failure:(RequestCompletionBlock)failure;

- (void)clearCompletionBlock;

- (NSTimeInterval)requestTimeoutInterval;

- (id)requestArgument;

- (ReqeuestMethod)requestMethod;

- (RequestSerializerType)requestSerializerType;

@end
