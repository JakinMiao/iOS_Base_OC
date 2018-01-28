//
//  ExampleApi.m
//  iOS_Base_OC
//
//  Created by Jakin on 2018/1/27.
//  Copyright © 2018年 Jakin. All rights reserved.
//

#import "ExampleApi.h"

@implementation TestApi

- (NSString *)requestUrl {
    return @"";
}

- (ReqeuestMethod)requestMethod {
    return RequestMethod_GET;
}

- (id)requestArgument {
    return @{@"name": @"Jakin"};
}

- (void)analystRepsone {
    
}

@end
