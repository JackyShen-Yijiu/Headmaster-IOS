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
#import "UserInfoModel.h"

@implementation NetworkEntity
/**
 *  获取用户信息
 */
+ (void)getUserInfoWithUserInfoWithUserId:(NSString *)userId
                                  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure
{
    if (!userId) {
        return [NetworkTool missParagramerCallBackFailure:failure];
    }
     NSString * urlStr = [NSString stringWithFormat:@"%@/userinfo/getimuserinfo?userid=%@",[NetworkTool domain],userId];
    [NetworkTool GET:urlStr params:nil success:success failure:failure];
}

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

+ (void)getTeacherListWithSchoolId:(NSString *)schoolId
                        searchName:(NSString *)name
                         pageIndex:(NSInteger)index
                           success:(NetworkSuccessBlock)success
                           failure:(NetworkFailureBlock)failure
{
    if (!schoolId)  {
        return [NetworkTool missParagramerCallBackFailure:failure];
    };
    NSString * urlStr = [NSString stringWithFormat:@"%@/%@/%ld",SCHOOLCOACH,schoolId,(long)index];
    NSDictionary * dic = nil;
    if (name) {
        dic = @{
                @"name":name
                };
    }
    [NetworkTool GET:urlStr params:dic success:success failure:failure];
}

+ (void)getRecommendListWithUserid:(NSString *)userId
                          SchoolId:(NSString *)schoolId
                         pageIndex:(NSInteger)index
                             count:(NSInteger)count
                        searchType:(kCommentDateSearchType)type
                      commentLevle:(KCommnetLevel)level
                           success:(NetworkSuccessBlock)success
                           failure:(NetworkFailureBlock)failure
{
    if (!userId || !schoolId) {
        return [NetworkTool missParagramerCallBackFailure:failure];
    };
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],RECOMENDHMESSAGE];
    NSDictionary * dic = @{
                           @"userid":userId,
                           @"schoolid":schoolId,
                           @"index":@(index),
                           @"count":@(count),
                           @"searchtype":@(type),
                           @"commentlevel":@(level)
                           };
    [NetworkTool GET:urlStr params:dic success:success failure:failure];
}


+ (void)getComplainListWithUserid:(NSString *)userId
                         SchoolId:(NSString *)schoolId
                        pageIndex:(NSInteger)index
                          success:(NetworkSuccessBlock)success
                          failure:(NetworkFailureBlock)failure
{
    if (!userId || !schoolId) {
        return [NetworkTool missParagramerCallBackFailure:failure];
    };
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],COMPLAINHMESSAGE];
    NSDictionary * dic = @{
                           @"userid":userId,
                           @"schoolid":schoolId,
                           @"index":@(index)
                           };
    [NetworkTool GET:urlStr params:dic success:success failure:failure];
}

+(void)getComplainListWithUserid:(NSString *)userId SchoolId:(NSString *)schoolId Index:(NSInteger)index Count:(NSInteger)count success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure {
    
    if (!userId || !schoolId) {
        return [NetworkTool missParagramerCallBackFailure:failure];
    };
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],COMPLAINHMESSAGE];
    NSDictionary * dic = @{
                           @"userid":userId,
                           @"schoolid":schoolId,
                           @"index":@(index),
                           @"count":@(count)
                           };
    [NetworkTool GET:urlStr params:dic success:success failure:failure];
    
}




+ (void)markDealComplainWithComplainId:(NSString *)complainId
                                 useID:(NSString *)userId
                               Success:(NetworkSuccessBlock)success
                               failure:(NetworkFailureBlock)failure
{
    if (!userId || !complainId) {
        return [NetworkTool missParagramerCallBackFailure:failure];
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],DEALDONWHMESSAGE];
    NSDictionary * dic  = @{
                            @"userid":userId,
                            @"reservationid":complainId
                            };
    [NetworkTool POST:urlStr params:dic success:success failure:failure];
}

+ (void)getPublishListWithUseInfoModel:(UserInfoModel *)uim seqindex:(NSInteger)index count:(NSInteger)count
                               success:(void (^)(AFHTTPRequestOperation *, id))success
                               failure:(void (^)(AFHTTPRequestOperation *, id))failure {
    NSDictionary *params =@{
                            @"seqindex":[NSString stringWithFormat:@"%zd",index],
                            @"count":[NSString stringWithFormat:@"%zd",count],
                            @"userid":uim.userID,
                            @"schoolid":uim.schoolId
                            };
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],GETPUBLISH];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:uim.token forHTTPHeaderField:@"authorization"];
    [manager GET:urlStr parameters:params success:success failure:failure];
}

+ (void)postPublishMessageWithUseInfoModel:(UserInfoModel *)uim textContent:(NSString *)content mainTitle:(NSString *)mainTitle
                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                   failure:(void (^)(AFHTTPRequestOperation *operation, id responseObject))failure {
    NSDictionary *params =@{
                            @"content":content,
                            @"userid":uim.userID,
                            @"schoolid":uim.schoolId,
                            @"title":mainTitle,
                            @"bulletobject":@1
                            };
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
    
    NSDictionary * dict = @{ @"seqindex": [NSString stringWithFormat:@"%zd", seqindex],
                            @"count": [NSString stringWithFormat:@"%zd", count] };
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
                         searchtype:(kDateSearchType ) searchtype
                           schoolid:(NSString *)schoolid
                            success:(NetworkSuccessBlock)success
                            failure:(NetworkFailureBlock)failure
{
    NSDictionary *dict = @{@"userid":userid,
                           @"searchtype":[NSString stringWithFormat:@"%li",searchtype],
                           @"schoolid":schoolid
                           };
    [NetworkTool GET:HOME_DATA_DETAIL params:dict success:success failure:failure];
}

/***
 *
 *  获得教练授课详情
 *
 */
+ (void)getCoachCourseListWithuserid:(NSString *)userid
                          searchtype:(NSInteger)searchtype
                            schoolid:(NSString *)schoolid
                               count:(NSInteger) count
                               index:(NSInteger) index
                             success:(NetworkSuccessBlock)success
                             failure:(NetworkFailureBlock)failure
{
    NSDictionary *params = @{@"userid":userid,
                             @"searchtype":[NSString stringWithFormat:@"%li",searchtype],
                             @"schoolid":schoolid,
                             @"count":[NSString stringWithFormat:@"%li",count],
                             @"index":[NSString stringWithFormat:@"%li",index]};
    [NetworkTool GET:COACHCOURSEDATAIL params:params success:success failure:failure];
    
    
}




/**
 *   修改个人信息
 */

+ (void)changeUserMessageWithUseInfoModel:(UserInfoModel *)uim complaintReminder:(NSString *)complaintreminder applyreminder:(NSString *)applyreminder newmessagereminder:(NSString *)newmessagereminder success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, id))failure {
    NSDictionary *params =@{
                            @"userid":uim.userID,
                            @"complaintreminder":complaintreminder,
                            @"applyreminder":applyreminder,
                            @"newmessagereminder":newmessagereminder
                            };
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],PERSONALSETTING];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:uim.token forHTTPHeaderField:@"authorization"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlStr parameters:params success:success failure:failure];
}


+ (void)getHomeDataWithSearchType:(NSInteger)searchType
                          success:(NetworkSuccessBlock)success
                          failure:(NetworkFailureBlock)failure {
    
//    NSDictionary *params = @{ @"userid": [UserInfoModel defaultUserInfo].userID,
//                              @"searchtype": [NSString stringWithFormat:@"%li",searchType],
//                              @"schoolid": [UserInfoModel defaultUserInfo].schoolId };
    
//    [[AFHttpClient sharedClient].requestSerializer setValue:[UserInfoModel defaultUserInfo].token forHTTPHeaderField:@"authorization"];
    
    NSDictionary *params = @{ @"userid": [[UserInfoModel defaultUserInfo] userID],
                              @"searchtype": [NSString stringWithFormat:@"%li",searchType],
                              @"schoolid": [[UserInfoModel defaultUserInfo] schoolId] };
    
    // http://127.0.0.1:8183/api/headmaster/statistics/getmainpagedata?userid=56582caf1fcf03d813f5fbfc&searchtype=1&schoolid=562dcc3ccb90f25c3bde40da

    [NetworkTool GET:HOME params:params success:success failure:failure];
}

+ (void)postFeedbackWithparams:(NSDictionary *)params
                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                   failure:(void (^)(AFHTTPRequestOperation *operation, id responseObject))failure {
    NSString *urlStr = @"http://101.200.204.240:8181/api/v1/userfeedback";
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlStr parameters:params success:success failure:failure];
}

/**
 *  V 2.0 合格学员信息列表
 */
+ (void)getPassRateListWithuserid:(NSString *)userid
                  searchSubjectID:(NSInteger)SubjectID
                            count:(NSInteger) count
                            index:(NSInteger) index
                          success:(NetworkSuccessBlock)success
                          failure:(NetworkFailureBlock)failure{
    NSDictionary *params = @{@"userid":userid,
                             @"searchtype":[NSString stringWithFormat:@"%li",SubjectID],
                             
                             @"count":[NSString stringWithFormat:@"%li",count],
                             @"index":[NSString stringWithFormat:@"%li",index]};
    [NetworkTool GET:PASSRATELIST params:params success:success failure:failure];
}


@end
