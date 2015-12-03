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
 *  资讯列表
 *
 *  @param seqindex  开始的索引
 *  @param count     获取的数量
 */
+ (void)informationListWithseqindex:(NSInteger)seqindex
                              count:(NSInteger) count
                            success:(NetworkSuccessBlock)success
                            failure:(NetworkFailureBlock)failure;

@end
