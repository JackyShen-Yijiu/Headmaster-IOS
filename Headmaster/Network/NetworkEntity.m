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

+ (void)getPublishListWithUseInfoModel:(UserInfoModel *)uim seqindex:(NSString *)index count:(NSString *)count
                               success:(void (^)(AFHTTPRequestOperation *, id))success
                               failure:(void (^)(AFHTTPRequestOperation *, id))failure {
    NSDictionary *params =@{
                            @"seqindex":index,
                            @"count":count,
                            @"userid":uim.userID,
                            @"schoolid":uim.schoolId
                            };
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],GETPUBLISH];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:uim.token forHTTPHeaderField:@"authorization"];
    [manager GET:urlStr parameters:params success:success failure:failure];
}
+ (void)postPublishMessageWithUseInfoModel:(UserInfoModel *)uim textContent:(NSString *)content type:(NSString *)type
                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                   failure:(void (^)(AFHTTPRequestOperation *operation, id responseObject))failure {
    NSDictionary *params =@{
                            @"content":content,
                            @"bulletobject": type,
                            @"userid":uim.userID,
                            @"schoolid":uim.schoolId
                            };
    NSLog(@"params = %@",params);
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],PUBLISHMESSAGE];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:uim.token forHTTPHeaderField:@"authorization"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlStr parameters:params success:success failure:failure];
}


+ (void)informationListWithseqindex:(NSInteger)seqindex
                              count:(NSInteger)count
                            success:(NetworkSuccessBlock)success
                            failure:(NetworkFailureBlock)failure {
    
    NSDictionary * dict = @{ @"seqindex": [NSString stringWithFormat:@"%li", seqindex],
                            @"count": [NSString stringWithFormat:@"%li", count] };
    [NetworkTool GET:INFORMATION_LIST params:dict success:success failure:failure];
}
/**
 *
 *
 *  天气数据
 *
 *
 */

+ (void)weatherDataListWithcityname:(NSString *)cityname
                            success:(NetworkSuccessBlock)success
                            failure:(NetworkFailureBlock)failure
{
    NSDictionary *dict = @{@"cityname":cityname};
    [NetworkTool GET:WEATHERDATA params:dict success:success failure:failure];
    
}
/**
 *  更多数据
 *  ====================================================================================================================================
 */
+ (void)moreDataDatilListWithuserid:(NSString *)userid
                         searchtype:(NSInteger ) searchtype
                           schoolid:(NSString *)schoolid
                            success:(NetworkSuccessBlock)success
                            failure:(NetworkFailureBlock)failure
{
    NSDictionary *dict = @{@"userid":userid,
                           @"seacrchtype":[NSString stringWithFormat:@"%li",searchtype],
                           @"schoolid":schoolid
                           };
    [NetworkTool GET:MoreData_List params:dict success:success failure:failure];
}


@end
