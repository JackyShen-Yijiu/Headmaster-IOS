//
//  NetworkEntity.m
//  Headmaster
//
//  Created by 大威 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "NetworkEntity.h"
#import "JSONKit.h"
#import "NSString+MD5.h"
#import "NetworkInterface.h"

@implementation NetworkEntity

/**
 *  登陆模块
 *  ====================================================================================================================================
 */

+ (void)loginWithPhotoNumber:(NSString *)photoNumber password:(NSString *)password success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure {
    
    NSString * md5Pass = [password MD5Digest];
    if (!photoNumber || !md5Pass)  {
        return [NetworkTool missParagramerCallBackFailure:failure];
    };
    NSDictionary * dic = @{@"mobile":photoNumber,
                           @"password":md5Pass,
                           @"usertype":@"2"
                           };
    
    [NetworkTool POST:USER_LOGIN params:dic success:success failure:failure];
}

+ (void)getTeacherListWithSchoolId:(NSString *)schoolId pageIndex:(NSInteger)index
                           success:(NetworkSuccessBlock)success
                           failure:(NetworkFailureBlock)failure
{
    if (!schoolId)  {
        return [NetworkTool missParagramerCallBackFailure:failure];
    };
    NSString * urlStr = [NSString stringWithFormat:@"%@/%@/%ld",SCHOOLCOACH,schoolId,(long)index];
    [NetworkTool GET:urlStr params:nil success:success failure:failure];
}

@end
