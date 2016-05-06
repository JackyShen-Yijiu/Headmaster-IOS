//
//  NetworkMacro.h
//  Headmaster
//
//  Created by 大威 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#ifndef NetworkMacro_h
#define NetworkMacro_h

/****** 这里定义各个接口 ******/

/* 用户相关 */
// 登录
#define USER_LOGIN                  @"headmaster/userinfo/userlogin"

/* 首页 */
#define HOME @"headmaster/statistics/getmainpagedatav2"

/* 首页更多数据 */
#define HOME_DATA_DETAIL @"headmaster/statistics/getmoredata"

/* 资讯相关 */
#define INFORMATION_LIST            @"headmaster/info/getnews"

/* 教练相关 */
#define SCHOOLCOACH                 @"v1/getschoolcoach"

/* 获取公告 */

#define GETPUBLISH                  @"headmaster/userinfo/getbulletin"

/* 发布公告 */

#define PUBLISHMESSAGE              @"headmaster/userinfo/publishbulletin"

/*  获得天气数据 */
#define WEATHERDATA                 @"headmaster/info/getweather"

/*获取评论*/
#define RECOMENDHMESSAGE            @"headmaster/statistics/commentdetails"

/*投诉*/
#define COMPLAINHMESSAGE            @"headmaster/statistics/complaintlist"
#define DEALDONWHMESSAGE            @"headmaster/statistics/handlecomplaint"


/* 教练授课详情 */
#define COACHCOURSEDATAIL            @"headmaster/statistics/coachcoursedetails"
/*修改个人信息*/

#define PERSONALSETTING             @"headmaster/userinfo/personalsetting"

#define PASSRATELIST            @"headmaster/userinfo/personalsetting"





#endif /* NetworkMacro_h */

/**
 *  制定时间类型
 */
typedef NS_ENUM(NSInteger,kDateSearchType) {
    /**
     *  今天
     */
    kDateSearchTypeToday = 1,
    /**
     *  昨天
     */
    kDateSearchTypeYesterday,
    /**
     *  本周
     */
    kDateSearchTypeWeek,
    /**
     *  本月
     */
    kDateSearchTypeMonth,
    /**
     *  本年
     */
    kDateSearchTypeYear
};



/**
 *  查询科目 科目一,科目二,科目三,科目四
 */
typedef NS_ENUM(NSInteger,kDateSearchSubjectID) {
    /**
     *  科目一
     */
    kDateSearchSubjectIDOne = 1,
    /**
     *  科目二
     */
    kDateSearchSubjectIDTwo,
    /**
     *  科目三
     */
    kDateSearchSubjectIDThree,
    /**
     *  科目四
     */
    kDateSearchSubjectIDFour,

};

typedef NS_ENUM(NSInteger,KCommnetLevel) {
    KCommnetLevelPoorRating = 1,
    KCommnetLevelMidRating,
    KCommnetLevelHighRating
};
