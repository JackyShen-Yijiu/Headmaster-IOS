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
 *  教练信息
 */
+ (void)getTeacherListWithSchoolId:(NSString *)schoolId pageIndex:(NSInteger)index
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
 *  首页
 *
 *  @param searchType 查询的类型（昨天、今天、本周）
 */
+ (void)getHomeDataWithSearchType:(NSInteger)searchType
                          success:(NetworkSuccessBlock)success
                          failure:(NetworkFailureBlock)failure;

@end
