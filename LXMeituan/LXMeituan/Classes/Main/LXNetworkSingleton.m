//
//  LXNetworkSingleton.m
//  LXMeituan
//
//  Created by Noki on 2017/4/10.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import "LXNetworkSingleton.h"

@implementation LXNetworkSingleton
//+(instancetype)shareManager{
//    static LXNetworkSingleton * shareNetWorkSingleton=nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        shareNetWorkSingleton=[[self alloc]initWithBaseURL:[NSURL URLWithString:@"http://httpbin.org/"]];
//    });
//    return shareNetWorkSingleton;
//}
//
//-(instancetype)initWithBaseURL:(NSURL *)url{
//    self =[super initWithBaseURL:url];
//    self.requestSerializer.timeoutInterval=TIMEOUT;
//    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
//    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
//    return self;
//}
+(void)GET:(NSString *)URLString
                            parameters:(id)parameters
                               success:(void (^)(id responseObject))success
   failure:(void (^)(NSError *error))failure{
    AFHTTPSessionManager * manger=[[AFHTTPSessionManager alloc]init];
 [manger GET:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
     if (success) {
         success(responseObject);
     }
 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     if (failure) {
         failure(error);
     }
 }];
}

+(void)POST:(NSString *)URLString
                    parameters:(id)parameters
                            success:(void (^)( id responseObject))success
                                        failure:(void (^)( NSError * error))failure{
        AFHTTPSessionManager * manger=[[AFHTTPSessionManager alloc]init];
[manger POST:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
    if (success) {
        success(responseObject);
    }
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    if (failure) {
        failure(error);
    }
}];
}
@end
