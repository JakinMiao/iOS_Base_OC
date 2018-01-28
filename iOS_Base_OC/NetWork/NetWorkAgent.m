//
//  NetWorkAgent.m
//  iOS_Base_OC
//
//  Created by Jakin on 18/1/27.
//
//

#import "NetWorkAgent.h"
#import "NetWorkConfig.h"
#import <AFHTTPSessionManager.h>

@implementation NetWorkAgent {
    NetWorkConfig *_config;
    AFHTTPSessionManager *_manager;
    NSMutableDictionary *_requestsRecord;
}

+ (NetWorkAgent *)shareInstance {
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
        _config = [NetWorkConfig shareInstance];
        _manager = [AFHTTPSessionManager manager];
        _requestsRecord = [NSMutableDictionary dictionary];
        _manager.operationQueue.maxConcurrentOperationCount = 4;
        _manager.securityPolicy = _config.securityPolicy;
    }
    return self;
}

- (NSString *)buildRequestUrl:(BaseNetWork *)request {
    NSString *detailUrl = [request requestUrl];
    if ([detailUrl hasPrefix:@"http"]) {
        return detailUrl;
    }
    
    NSString *baseUrl;
    if ([request baseUrl].length > 0) {
        baseUrl = [request baseUrl];
    } else {
        baseUrl = [_config baseUrl];
    }
    
    return [NSString stringWithFormat:@"%@%@", baseUrl, detailUrl];
}

- (void)addRequest:(BaseNetWork *)request {
    
    if (request.requestSerializerType == RequestSerializerType_JSON) {
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    } else if (request.requestSerializerType == RequestSerializerType_HTTP) {
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    
    _manager.requestSerializer.timeoutInterval = [request requestTimeoutInterval];
    
    ReqeuestMethod method = [request requestMethod];
    NSString *url = [self buildRequestUrl:request];
    id param = request.requestArgument;
    if (method == RequestMethod_GET) {
        request.sessionDataTask = [_manager GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handleRequestResult:task responseObject:responseObject requestErrorCode:0];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handleRequestResult:task responseObject:nil requestErrorCode:error.code];
        }];
    } else if (method == RequestMethod_POST) {
        request.sessionDataTask = [_manager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handleRequestResult:task responseObject:responseObject requestErrorCode:0];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handleRequestResult:task responseObject:nil requestErrorCode:error.code];
        }];
    } else {
        NSLog(@"没有支持的请求类型");
        return;
    }
    
    [self addTask:request];
}

- (void)handleRequestResult:(NSURLSessionDataTask *)task responseObject:(id)responseObject requestErrorCode:(NSInteger)requestErrorCode {
    NSString *key = [self requestHashKey:task];
    BaseNetWork *request = _requestsRecord[key];
    //记录错误状态码
    request.requestErrorCode = requestErrorCode;
    
    if (request && responseObject) {
        request.responseObject = responseObject;
        if (request.successCompletionBlock) {
            request.successCompletionBlock(request);
        }
    } else {
        
        if (request.needRepeat) {
            request.needRepeat = NO;
            [self addRequest:request];
            return;
        }
        
        if (request.failureCompletionBlock) {
            request.failureCompletionBlock(request);
        }
    }
    [self removeTask:task];
    [request clearCompletionBlock];
}

- (void)addTask:(BaseNetWork *)request {
    if (request.sessionDataTask != nil) {
        NSString *key = [self requestHashKey:request.sessionDataTask];
        @synchronized (self) {
            _requestsRecord[key] = request;
        }
    }
}

- (void)removeTask:(NSURLSessionDataTask *)task {
    NSString *key = [self requestHashKey:task];
    @synchronized (self) {
        [_requestsRecord removeObjectForKey:key];
    }
}

- (NSString *)requestHashKey:(NSURLSessionDataTask *)task {
    NSString *key = [NSString stringWithFormat:@"%lu", (unsigned long)[task hash]];
    return key;
}

@end
