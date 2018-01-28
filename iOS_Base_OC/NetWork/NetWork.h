//
//  NetWork.h
//  iOS_Base_OC
//
//  Created by Jakin on 18/1/27.
//
//

#import "BaseNetWork.h"

typedef NS_ENUM(NSInteger, ResponseFlag){
    ResponseFlag_SUCCESS      = 0,                     //请求成功
    ResponseFlag_FAILURE      = 1,                     //请求失败
    ResponseFlag_TOKENINVAIL  = 3,                     //Token过期
    ResponseFlag_NotConnectedToInternet = -1009,       //网络完全不能连接
    ResponseFlag_TimedOut     = -1001,                //网络请求超时
    ResponseFlag_PAYAPISTAY   = 4000
};

typedef void (^SuccessCompletionHandler)(NSInteger flag);
typedef void (^FailureCompletionHandler)(NSInteger flag, NSString *errorMessage);

@interface NetWork : BaseNetWork

@property (nonatomic, copy) SuccessCompletionHandler successCompletionHandler;
@property (nonatomic, copy) FailureCompletionHandler failureCompletionHandler;

- (NSString *)osType;

- (void)analystRepsone;

- (NSString *)requestUrlWithArgument:(NSString *)baseUrl andNeedSign:(BOOL)needSign;

- (NSString *)requestUrlWithArgument:(NSString *)baseUrl andNeedSign:(BOOL)needSign arguments:(NSString *)arguments;

- (void)startCompletionHandlerWithSuccess:(SuccessCompletionHandler)success
                              failure:(FailureCompletionHandler)failure;
@end
