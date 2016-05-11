//
//  NetworkEntity.h
//  Headmaster
//
//  Created by 大威 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkTool.h"
#import "AFNetworking.h"
#import "NetworkInterface.h"

@class UserInfoModel;

@interface NetworkEntity : NSObject
/**
 *  获取用户信息
 */
+ (void)getUserInfoWithUserInfoWithUserId:(NSString *)userId
                                  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

/**
 *  登陆模块
 *  ====================================================================================================================================
 */

/**
 *  用户登录 返回信息描述见 获取用户详情
 *
 *  @param photoNumber （req）  手机号
 *  @param password     (req)  密码 MD5加密后
 */

+ (void)loginWithPhotoNumber:(NSString *)photoNumber password:(NSString *)password success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

/**
 *  获取教练列表
 */
+ (void)getTeacherListWithSchoolId:(NSString *)schoolId
                        searchName:(NSString *)name
                         pageIndex:(NSInteger)index
                           success:(NetworkSuccessBlock)success
                           failure:(NetworkFailureBlock)failure;

/**
 *  获取评论列表
 *
 *  @param userId   校长id
 *  @param schoolId 学校id
 *  @param index    起始页面（从1开始）
 *  @param type     查询时间类型：1 今天 2昨天 3 一周 4 本月 5 本年 6 上周 7 上月
 *  @param level    评论等级 1：差评 2中评 3 好评
 */
+ (void)getRecommendListWithUserid:(NSString *)userId
                          SchoolId:(NSString *)schoolId
                         pageIndex:(NSInteger)index
                             count:(NSInteger)count
                        searchType:(kCommentDateSearchType)type
                      commentLevle:(KCommnetLevel)level
                           success:(NetworkSuccessBlock)success
                           failure:(NetworkFailureBlock)failure;
///**
// *  投诉
// *  ====================================================================================================================================
// */
//
+ (void)getComplainListWithUserid:(NSString *)userId
                         SchoolId:(NSString *)schoolId
                        pageIndex:(NSInteger)index
                          success:(NetworkSuccessBlock)success
                          failure:(NetworkFailureBlock)failure;

///  v1.2投诉列表的网络请求
+ (void)getComplainListWithUserid:(NSString *)userId
                         SchoolId:(NSString *)schoolId
                            Index:(NSInteger)index Count:(NSInteger)count
                          success:(NetworkSuccessBlock)success
                          failure:(NetworkFailureBlock)failure;




/**
 *  标示处理完成投诉
 *
 */
+ (void)markDealComplainWithComplainId:(NSString *)complainId
                                 useID:(NSString *)userId
                               Success:(NetworkSuccessBlock)success
                               failure:(NetworkFailureBlock)failure;

/**
 *  获取发布
 */
+ (void)getPublishListWithUseInfoModel:(UserInfoModel *)uim seqindex:(NSInteger)index count:(NSInteger)count
                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                               failure:(void (^)(AFHTTPRequestOperation *operation, id responseObject))failure;

/**
 *  发布公告
 */

//+ (void)postPublishMessageWithUseInfoModel:(UserInfoModel *)uim textContent:(NSString *)content type:(NSString *)type
//                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                                   failure:(void (^)(AFHTTPRequestOperation *operation, id responseObject))failure;

+ (void)postPublishMessageWithUseInfoModel:(UserInfoModel *)uim textContent:(NSString *)content mainTitle:(NSString *)mainTitle
                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                   failure:(void (^)(AFHTTPRequestOperation *operation, id responseObject))failure;





/**
 *  资讯列表
 *
 *  @param seqindex  开始的索引
 *  @param count     获取的数量
 */
+ (void)informationListWithseqindex:(NSInteger)seqindex
                              count:(NSInteger) count
                            success:(NetworkSuccessBlock)success
                            failure:(NetworkFailureBlock)failure;
/**
 *  首页
 *
 *  @param searchType 查询的类型（昨天、今天、本周）
 */
+ (void)getHomeDataWithSearchType:(NSInteger)searchType
                          success:(NetworkSuccessBlock)success
                          failure:(NetworkFailureBlock)failure;
/**
 *    更多数据
 *     @param   userid
 *     @param   searchtype
 *     @param  schoolid
 *     @param  authorization
 *
*/
+ (void)moreDataDatilListWithuserid:(NSString *)userid
                         searchtype:(kDateSearchType ) searchtype
                           schoolid:(NSString *)schoolid
                            success:(NetworkSuccessBlock)success
                            failure:(NetworkFailureBlock)failure;


/**
 *   天气情况
 *     @param   cityname
  *
 */
+ (void)weatherDataListWithcityname:(NSString *)cityname
                            success:(NetworkSuccessBlock)success
                            failure:(NetworkFailureBlock)failure;

/*
 *
 *  教练授课详情
 *
 */
+ (void)getCoachCourseListWithuserid:(NSString *)userid
                          searchtype:(NSInteger)searchtype
                            schoolid:(NSString *)schoolid
                               count:(NSInteger) count
                               index:(NSInteger) index
                             success:(NetworkSuccessBlock)success
                             failure:(NetworkFailureBlock)failure;

/**
 * 修改个人信息设置
 */

+ (void)changeUserMessageWithUseInfoModel:(UserInfoModel *)uim complaintReminder:(NSString *)complaintreminder applyreminder:(NSString *)applyreminder newmessagereminder:(NSString *)newmessagereminder
                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                  failure:(void (^)(AFHTTPRequestOperation *operation, id responseObject))failure;

/**
 * 提交反馈信息
 */
+ (void)postFeedbackWithparams:(NSDictionary *)params
success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
failure:(void (^)(AFHTTPRequestOperation *operation, id responseObject))failure;


+ (void)postCoachFeedbackWithparams:(UserInfoModel *)uim ReplyContent:(NSString *)replyContent feedbackID:(NSString *)feedbackid
                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, id responseObject))failure ;


/**
 *  V 2.0 合格学员信息列表
 */
+ (void)getPassRateListWithuserid:(NSString *)userid
                       searchSubjectID:(NSInteger)SubjectID
                            count:(NSInteger) count
                            index:(NSInteger) index
                          success:(NetworkSuccessBlock)success
                          failure:(NetworkFailureBlock)failure;
/**
 *  V 2.0 考试月份
 */
+ (void)getPassRateTimeWithUserid:(NSString *)userId
                         SchoolId:(NSString *)schoolId
                            SubjectID:(NSInteger)subjectID
                          success:(NetworkSuccessBlock)success
                          failure:(NetworkFailureBlock)failure;
/**
 *  V 2.0 根据考试月份获取考试信息
 */
+ (void)getTestDetailWithUserid:(NSString *)userId
                         SchoolId:(NSString *)schoolId
                        SubjectID:(NSInteger)subjectID
                           Year:(NSInteger)year
                          Month:(NSInteger)month
                          success:(NetworkSuccessBlock)success
                          failure:(NetworkFailureBlock)failure;
///  获取教练反馈
+ (void)getCoachFeedbackWithUserid:(NSString *)userId
                       SchoolId:(NSString *)schoolId
                             count:(NSInteger) count
                             index:(NSInteger) index
                        success:(NetworkSuccessBlock)success
                        failure:(NetworkFailureBlock)failure;

@end
