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
 *  @param type     查询时间类型：1 今天 2昨天 3 一周 4 本月 5 本年
 *  @param level    评论等级 1：差评 2中评 3 好评
 */
+ (void)getRecommendListWithUserid:(NSString *)userId
                          SchoolId:(NSString *)schoolId
                         pageIndex:(NSInteger)index
                        searchType:(kDateSearchType)type
                      commentLevle:(KCommnetLevel)level
                           success:(NetworkSuccessBlock)success
                           failure:(NetworkFailureBlock)failure;

/**
 *  获取发布
 */
+ (void)getPublishListWithUseInfoModel:(UserInfoModel *)uim seqindex:(NSString *)index count:(NSString *)count
                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                               failure:(void (^)(AFHTTPRequestOperation *operation, id responseObject))failure;

/**
 *  发布公告
 */

+ (void)postPublishMessageWithUseInfoModel:(UserInfoModel *)uim textContent:(NSString *)content type:(NSString *)type
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
 *    更多数据
 *     @param   userid
 *     @param   searchtype
 *     @param  schoolid
 *     @param  authorization
 *
 */
+ (void)moreDataDatilListWithuserid:(NSString *)userid
                         searchtype:(NSInteger ) searchtype
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


@end
