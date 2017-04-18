//
//  LXNetworkSingleton.h
//  LXMeituan
//
//  Created by Noki on 2017/4/10.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#define TIMEOUT 30
////请求成功回调block
//typedef void (^requestSuccessBlock)(id responseBody);
//
////请求失败回调block
//typedef void (^requestFailureBlock)(NSError *error);
@interface LXNetworkSingleton : NSObject

//+(instancetype)shareManager;

+(void)GET:(NSString *)URLString
parameters:(id)parameters
   success:(void (^)(id responseObject))success
   failure:(void (^)(NSError *error))failure;

+(void)POST:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)( id responseObject))success
    failure:(void (^)( NSError * error))failure;
@end
