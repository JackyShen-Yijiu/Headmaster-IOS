//
//  NetworkTool.m
//  Headmaster
//
//  Created by 大威 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "NetworkTool.h"
#import "AFNetworking.h"

#define  HOST_TEST_DAMIAN  @"http://101.200.204.240:8181/api"

#define  HOST_LINE_DOMAIN  @"http://123.57.63.15:8181/api/v1"

#define QA_TEST

@implementation AFHttpClient

+ (instancetype)sharedClient {
    
    static AFHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFHttpClient alloc] initWithBaseURL:[NSURL URLWithString:[NetworkTool domain]]];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"application/x-javascript",@"text/plain",@"image/gif", nil];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];

        [_sharedClient.requestSerializer setValue:@"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOiI1NjU4MmNhZjFmY2YwM2Q4MTNmNWZiZmMiLCJ0aW1lc3RhbXAiOiIyMDE1LTExLTI5VDA1OjI2OjM3LjAxNFoiLCJhdWQiOiJibGFja2NhdGUiLCJpYXQiOjE0NDg3NzQ3OTd9.FkiYdCgKMWFpYV2Bymbg8hAGrmutMTEHpfcOsAMnT-8" forHTTPHeaderField:@"authorization"];
        
//        [_sharedClient.requestSerializer setValue:[[UserInfoModel defaultUserInfo] token] forHTTPHeaderField:@"authorization"];
    });
    
    return _sharedClient;
}

+ (void)addCommonValueInHead:(AFHTTPRequestOperationManager *)manager
{
    NSString *   token = [[UserInfoModel defaultUserInfo] token];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"authorization"];
}


@end

@implementation NetworkTool

+ (NSString *)domain
{
#ifdef QA_TEST
    return HOST_TEST_DAMIAN;
#else
    return HOST_LINE_DOMAIN;
#endif
}

#pragma mark - AFN网络请求
#pragma mark POST请求
+ (void)POST:(NSString *)path
      params:(NSDictionary *)params
     success:(NetworkSuccessBlock)success
     failure:(NetworkFailureBlock)failure {
    
    AFHttpClient *manager = [AFHttpClient sharedClient];
    
    [manager POST:path parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
        
        if (success == nil) return;
        success(JSON);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure == nil) return;
        failure(error);
        
    }];
}

#pragma mark GET请求
+ (void)GET:(NSString *)path
     params:(NSDictionary *)params
    success:(NetworkSuccessBlock)success
    failure:(NetworkFailureBlock)failure {
    
    AFHttpClient *manager = [AFHttpClient sharedClient];
    
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
        
        if (success == nil) return;
        success(JSON);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (failure == nil) return;
        failure(error);
        
    }];
}

#pragma mark POST上传图片
+ (void)postWithImagePath:(NSString *)path
                 params:(NSDictionary *)params
                 images:(NSArray *)images
                success:(NetworkSuccessBlock)success
                failure:(NetworkFailureBlock)failure {
    NSString *basePath  = [NSString stringWithFormat:@"%@%@", self , path];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:basePath parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSUInteger idx = 0; idx < images.count; idx ++) {
            
            NSDate *date = [NSDate new];
            NSDateFormatter *df = [[NSDateFormatter alloc]init];
            [df setDateFormat:@"yyyyMMddHHmmss"];
            [df setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
            
            [formData appendPartWithFileData:images[idx] name:[NSString stringWithFormat:@"header%zi", idx + 1 ] fileName:[NSString stringWithFormat:@"%@%zi.jpg", [df stringFromDate:date], idx + 1 ] mimeType:@"image/jpg"];
        }
    } error:nil];
    
    AFHTTPRequestOperation *opration = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    opration.responseSerializer = [AFJSONResponseSerializer serializer];
    opration.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success == nil) return;
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure == nil) return;
        failure(error);
    }];
    
    [opration start];
}

+ (void)missParagramerCallBackFailure:(NetworkFailureBlock)failure
{
    NSError * error = [NSError errorWithDomain:@"Deomin" code:0
                                      userInfo:@{@"error":@"缺少参数"}];
    failure(error);
}

#pragma mark -
#pragma mark 取消网络请求
+ (void)cancelAllRequest {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.operationQueue cancelAllOperations];
}

@end
