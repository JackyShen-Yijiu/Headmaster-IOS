//
//  NetWorkEntiry.m
//  JewelryApp
//
//  Created by kequ on 15/5/12.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import "NetWorkEntiry.h"
#import "JSONKit.h"
#import "NSString+MD5.h"
#import "NetworkMacro.h"
#define KNETBASEURL

#define  HOST_TEST_DAMIAN  @"http://101.200.204.240:8181/api/v1"

#define  HOST_LINE_DOMAIN  @"http://123.57.63.15:8181/api/v1"

#define QA_TEST


@implementation NetWorkEntiry

/**
 *  登陆模块
 *  ====================================================================================================================================
 */

+ (void)loginWithPhotoNumber:(NSString *)photoNumber password:(NSString *)password success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure {
    
    NSString * md5Pass = [password MD5Digest];
    if (!photoNumber || !md5Pass)  {
        return [self missParagramercallBackFailure:failure];
    };
    NSDictionary * dic = @{@"mobile":photoNumber,
                           @"password":md5Pass,
                           @"usertype":@"2"
                           };
    
    [self POST:urlStr parameters:dic success:success failure:failure];
    NetworkTool postWithPath:INTERFACE_USER_LOGIN params:dic success:^(id responseObject) {
        <#code#>
    } failure:^(NSError *failure) {
        <#code#>
    }
}

+ (void)getTeacherListWithSchoolId:(NSString *)schoolId pageIndex:(NSInteger)index
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (!schoolId)  {
        return [self missParagramercallBackFailure:failure];
    };
    NSString * urlStr = [NSString stringWithFormat:@"%@/getschoolcoach/%@/%ld",[self domain],schoolId,(long)index];
    [self GET:urlStr parameters:nil success:success failure:failure];
}

#pragma mark - Common Method

+ (void)missParagramercallBackFailure:(NetworkFailureBlock)failure
{
    NSError * error = [NSError errorWithDomain:@"Deomin" code:0
                                      userInfo:@{@"error":@"缺少参数"}];
    failure(error);
}

@end
