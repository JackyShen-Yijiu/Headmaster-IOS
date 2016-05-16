//
//  HomeDetailTableViewDataModel.m
//  Headmaster
//
//  Created by 大威 on 15/12/11.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeDetailTableViewDataModel.h"

@implementation HomeDetailTableViewDataModel

/**
 *  处理今天和昨天的数据
 *
 *  @param detailRootClass
 *  @param searchType
 *
 *  @return
 */
-(instancetype)initWithHomeDataDetailDMRootClass:(HomeDataDetailDMRootClass *)detailRootClass searchType:(NSInteger)searchType {
    self = [super init];
    if (self) {
        
        self.msg = detailRootClass.msg;
        self.type = detailRootClass.type;
        
        if (detailRootClass.type == 1) {
            
            /// 招生（申请）
            NSInteger applyCount = 0;
            NSMutableArray *applyValueArray = [NSMutableArray array];
            NSMutableArray *applyXTitleArray = [NSMutableArray array];

            for (HomeDataDetailDMApplystuentlist *item in detailRootClass.data.applystuentlist) {
                
                // 计算总数量
                applyCount += item.applystudentcount;
                // 添加值数组
                [applyValueArray addObject:@(item.applystudentcount)];
                
                NSString *xTitleItemString = [self getXTitleItemWithValue:item.hour kdateSearchType:searchType];
                // 添加x轴显示的标题数组
                [applyXTitleArray addObject:xTitleItemString];
            }
            self.appleStudentCount = applyCount;
            self.applyValueArray = applyValueArray;
            self.applyXTitleArray = applyXTitleArray;
            
            /// 约课 （预约）
            NSInteger reservationCount = 0;
            NSMutableArray *reservationValueArray = [NSMutableArray array];
            NSMutableArray *reservationXTitleArray = [NSMutableArray array];
            
            for (HomeDataDetailDMReservationstudentlist *item in detailRootClass.data.reservationstudentlist) {
                
                // 计算总数量
                reservationCount += item.studentcount;
                // 添加值数组
                [reservationValueArray addObject:@(item.studentcount)];
                
                NSString *xTitleItemString = [self getXTitleItemWithValue:item.hour kdateSearchType:searchType];
                // 添加x轴显示的标题数组
                [reservationXTitleArray addObject:xTitleItemString];
            }
            self.reservationStudentCount = reservationCount;
            self.reservationValueArray = reservationValueArray;
            self.reservationXTitleArray = reservationXTitleArray;
            
            /// 教练授课
            NSMutableArray *coachValueArray = [NSMutableArray array];
            NSMutableArray *coachXTitleArray = [NSMutableArray array];
            
            for (HomeDataDetailDMCoachcourselist *item in detailRootClass.data.coachcourselist) {
                
                // 添加值数组
                [coachValueArray addObject:@(item.coursecount)];
                
                NSString *xTitleItemString = [NSString stringWithFormat:@"%li",item.coachcount];
                // 添加x轴显示的标题数组
                [coachXTitleArray addObject:xTitleItemString];
            }
            self.coachCourseValueArray = coachValueArray;
            self.coachCourseXTitleArray = coachXTitleArray;
            
            /// 评价
            // 所有的标题
            NSMutableArray *goodXTitleArray = [NSMutableArray array];
            NSMutableArray *badXTitleArray = [NSMutableArray array];
            NSMutableArray *generalXTitleArray = [NSMutableArray array];
            NSMutableArray *complaintXtitleArray = [NSMutableArray array];
            // 所有的值
            NSMutableArray *goodArray = [NSMutableArray array];
            NSMutableArray *badArray = [NSMutableArray array];
            NSMutableArray *generalArray = [NSMutableArray array];
            NSMutableArray *complaintArray = [NSMutableArray array];
            
//            NSMutableDictionary *goodDic = [NSMutableDictionary dictionary];
//            NSMutableDictionary *badDic = [NSMutableDictionary dictionary];
//            NSMutableDictionary *generalDic = [NSMutableDictionary dictionary];
//            NSMutableDictionary *complaintDic = [NSMutableDictionary dictionary];
            
            // 好评
            for (HomeDataDetailDMBadcommentlist *item in detailRootClass.data.goodcommentlist) {
                [goodXTitleArray addObject:@(item.hour)];
                [goodArray addObject:@(item.commnetcount)];
//                [goodDic setObject:@(item.commnetcount) forKey:@(item.hour)];
            }
            // 中评
            for (HomeDataDetailDMBadcommentlist *item in detailRootClass.data.generalcommentlist) {
                [generalXTitleArray addObject:@(item.hour)];
                [generalArray addObject:@(item.commnetcount)];
//                [generalDic setObject:@(item.commnetcount) forKey:@(item.hour)];
            }
            
            // 差评
            for (HomeDataDetailDMBadcommentlist *item in detailRootClass.data.badcommentlist) {
                [badXTitleArray addObject:@(item.hour)];
                [badArray addObject:@(item.commnetcount)];
//                [badDic setObject:@(item.commnetcount) forKey:@(item.hour)];
            }
            
            // 投诉
            for (HomeDataDetailDMComplaintlist *item in detailRootClass.data.complaintlist) {
                [complaintXtitleArray addObject:@(item.hour)];
                [complaintArray addObject:@(item.complaintcount)];
//                [complaintDic setObject:@(item.commnetcount) forKey:@(item.hour)];
            }
            
            NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
            for (int i = 0; i < goodXTitleArray.count; i++) {
                [tempDict setObject:@1 forKey:[NSString stringWithFormat:@"%@",goodXTitleArray[i]]];
            }
            for (int i = 0; i < generalXTitleArray.count; i++) {
                [tempDict setObject:@1 forKey:[NSString stringWithFormat:@"%@",generalXTitleArray[i]]];
            }
            for (int i = 0; i < badXTitleArray.count; i++) {
                [tempDict setObject:@1 forKey:[NSString stringWithFormat:@"%@",badXTitleArray[i]]];
            }
            for (int i = 0; i < complaintXtitleArray.count; i++) {
                [tempDict setObject:@1 forKey:[NSString stringWithFormat:@"%@",complaintXtitleArray[i]]];
            }
            
            NSMutableArray *marr = [NSMutableArray array];
            for (NSString *item in tempDict.allKeys) {
                [marr addObject:[self getXTitleItemWithValue:[item integerValue] kdateSearchType:searchType]];
            }
            NSArray *tempMArr = [marr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                if ([obj1 integerValue] > [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedDescending;
                }
                return (NSComparisonResult)NSOrderedSame;
            }];
            self.evaluateXTitleArray = tempMArr;
            self.goodValueArray = goodArray;
            self.generalValueArray = generalArray;
            self.badValueArray = badArray;
            self.complaintValueArray = complaintArray;
        }
    }
    return self;
}
/**
 *  处理周数据
 *
 *  @param detailRootClass
 *  @param searchType
 *
 *  @return
 */
- (instancetype)initWithDataDetailDMWeekRootClass:(DataDetailDMWeekRootClass *)detailRootClass searchType:(NSInteger)searchType {
    self = [super init];
    if (self) {
        
        self.msg = detailRootClass.msg;
        self.type = detailRootClass.type;
        
        if (detailRootClass.type == 1) {
            
            NSMutableArray *applyValueArray = [NSMutableArray array];
            NSMutableArray *reservationValueArray = [NSMutableArray array];
            NSMutableArray *coachValueArray = [NSMutableArray array];
            NSMutableArray *goodArray = [NSMutableArray array];
            NSMutableArray *badArray = [NSMutableArray array];
            NSMutableArray *generalArray = [NSMutableArray array];
            NSMutableArray *complaintArray = [NSMutableArray array];
            
            NSMutableArray *applyXTitleArray = [NSMutableArray array];
            NSMutableArray *reservationXTitleArray = [NSMutableArray array];
            NSMutableArray *coachXTitleArray = [NSMutableArray array];
            NSMutableArray *xTitleArray = [NSMutableArray array];
            
            NSInteger applyNum = 0;
            NSInteger reservationNum = 0;
            
            if (detailRootClass.data.datalist.count) {
                for (DataDetailDMWeekDatalist *item in detailRootClass.data.datalist) {
                    [applyValueArray addObject:[NSString stringWithFormat:@"%li",item.applystudentcount]];
                    applyNum += item.applystudentcount;
                    [applyXTitleArray addObject:[self getXTitleItemWithValue:item.day kdateSearchType:searchType]];
                    
                    [reservationValueArray addObject:[NSString stringWithFormat:@"%li",item.reservationcoursecount]];
                    reservationNum += item.reservationcoursecount;
                    [reservationXTitleArray addObject:[self getXTitleItemWithValue:item.day kdateSearchType:searchType]];
                    
                    [goodArray addObject:[NSString stringWithFormat:@"%li",item.goodcommentcount]];
                    [xTitleArray addObject:[self getXTitleItemWithValue:item.day kdateSearchType:searchType]];
                    
                    [generalArray addObject:[NSString stringWithFormat:@"%li",item.generalcomment]];
                    
                    [badArray addObject:[NSString stringWithFormat:@"%li",item.badcommentcount]];
                    
                    [complaintArray addObject:[NSString stringWithFormat:@"%li",item.complaintcount]];
                }
            }
            
            if (detailRootClass.data.coursedata.count) {
                for (DataDetailDMWeekCoursedata *item in detailRootClass.data.coursedata) {
                    [coachValueArray addObject:[NSString stringWithFormat:@"%li",item.coursecount]];
                    [coachXTitleArray addObject:[NSString stringWithFormat:@"%li",item.coachcount]];
                }
            }
            
            self.appleStudentCount = applyNum;
            self.reservationStudentCount = reservationNum;
            
            self.applyXTitleArray = applyXTitleArray;
            self.applyValueArray = applyValueArray;
            
            self.reservationXTitleArray = reservationXTitleArray;
            self.reservationValueArray = reservationValueArray;
            
            self.coachCourseXTitleArray = coachXTitleArray;
            self.coachCourseValueArray = coachValueArray;
            
            self.goodValueArray = goodArray;
            self.generalValueArray = generalArray;
            self.badValueArray = badArray;
            self.complaintValueArray = complaintArray;
            
            self.evaluateXTitleArray = xTitleArray;
        }
    }
    return self;
}
/**
 *  处理月数据
 *
 *  @param detailRootClass
 *  @param searchType
 *
 *  @return
 */
- (instancetype)initWithDataDetailDMMonthRootClass:(DataDetailDMMonthRootClass *)detailRootClass searchType:(NSInteger)searchType {
    self = [super init];
    if (self) {
        
        self.msg = detailRootClass.msg;
        self.type = detailRootClass.type;
        
        if (detailRootClass.type == 1) {
            
            NSMutableArray *applyValueArray = [NSMutableArray array];
            NSMutableArray *reservationValueArray = [NSMutableArray array];
            NSMutableArray *coachValueArray = [NSMutableArray array];
            NSMutableArray *goodArray = [NSMutableArray array];
            NSMutableArray *badArray = [NSMutableArray array];
            NSMutableArray *generalArray = [NSMutableArray array];
            NSMutableArray *complaintArray = [NSMutableArray array];
            
            NSMutableArray *applyXTitleArray = [NSMutableArray array];
            NSMutableArray *reservationXTitleArray = [NSMutableArray array];
            NSMutableArray *coachXTitleArray = [NSMutableArray array];
            NSMutableArray *xTitleArray = [NSMutableArray array];
            
            NSInteger applyNum = 0;
            NSInteger reservationNum = 0;
            
            
//            if (detailRootClass.data.datalist.count) {
            
                NSLog(@"detailRootClass.data.datalist:%@",detailRootClass.data.datalist);
                
//                for (NSNumber *item in detailRootClass.data.datalist) {
//                    [applyValueArray addObject:item];
//                    applyNum += item.applystudentcount;
//                    [applyXTitleArray addObject:[self getXTitleItemWithValue:item.weekindex kdateSearchType:searchType]];
//                    
//                    [reservationValueArray addObject:[NSString stringWithFormat:@"%li",item.reservationcoursecount]];
//                    reservationNum += item.reservationcoursecount;
//                    [reservationXTitleArray addObject:[self getXTitleItemWithValue:item.weekindex kdateSearchType:searchType]];
//                    
//                    [goodArray addObject:[NSString stringWithFormat:@"%li",item.goodcommentcount]];
//                    [xTitleArray addObject:[self getXTitleItemWithValue:item.weekindex kdateSearchType:searchType]];
//                    
//                    [generalArray addObject:[NSString stringWithFormat:@"%li",item.generalcomment]];
//                    
//                    [badArray addObject:[NSString stringWithFormat:@"%li",item.badcommentcount]];
//                    
//                    [complaintArray addObject:[NSString stringWithFormat:@"%li",item.complaintcount]];
//                }
//            }
            
//            if (detailRootClass.data.coursedata.count) {
//                for (DataDetailDMMonthCoursedata *item in detailRootClass.data.coursedata) {
//                    [coachValueArray addObject:[NSString stringWithFormat:@"%li",item.coursecount]];
//                    [coachXTitleArray addObject:[NSString stringWithFormat:@"%li",item.coachcount]];
//                }
//            }
            
//            self.appleStudentCount = applyNum;
//            self.reservationStudentCount = reservationNum;
            
//            self.applyXTitleArray = [NSArray arrayWithObjects:@"上旬",@"中旬",@"下旬",nil];
//            self.applyValueArray = [NSArray arrayWithObjects:@"上旬",@"中旬",@"下旬",nil];
            
            self.reservationValueArray = detailRootClass.data.datalist;
            self.reservationXTitleArray = [NSArray arrayWithObjects:@"上旬",@"中旬",@"下旬",nil];

//            self.coachCourseXTitleArray = coachXTitleArray;
//            self.coachCourseValueArray = coachValueArray;
            
//            self.goodValueArray = goodArray;
//            self.generalValueArray = generalArray;
//            self.badValueArray = badArray;
//            self.complaintValueArray = complaintArray;
//            
//            self.evaluateXTitleArray = xTitleArray;
            
        }
    }
    return self;
}
/**
 *  处理年数据
 *
 *  @param detailRootClass
 *  @param searchType
 *
 *  @return
 */
- (instancetype)initWithDataDetailDMYearRootClass:(DataDetailDMYearRootClass *)detailRootClass searchType:(NSInteger)searchType {
    self = [super init];
    if (self) {
        
        self.msg = detailRootClass.msg;
        self.type = detailRootClass.type;
        
//        if (detailRootClass.type == 1) {
//            
//            NSMutableArray *applyValueArray = [NSMutableArray array];
//            NSMutableArray *reservationValueArray = [NSMutableArray array];
//            NSMutableArray *coachValueArray = [NSMutableArray array];
//            NSMutableArray *goodArray = [NSMutableArray array];
//            NSMutableArray *badArray = [NSMutableArray array];
//            NSMutableArray *generalArray = [NSMutableArray array];
//            NSMutableArray *complaintArray = [NSMutableArray array];
//            
//            NSMutableArray *applyXTitleArray = [NSMutableArray array];
//            NSMutableArray *reservationXTitleArray = [NSMutableArray array];
//            NSMutableArray *coachXTitleArray = [NSMutableArray array];
//            NSMutableArray *xTitleArray = [NSMutableArray array];
//            
//            NSInteger applyNum = 0;
//            NSInteger reservationNum = 0;
//            
//            if (detailRootClass.data.datalist.count) {
//                for (DataDetailDMYearDatalist *item in detailRootClass.data.datalist) {
//                    [applyValueArray addObject:[NSString stringWithFormat:@"%li",item.applystudentcount]];
//                    applyNum += item.applystudentcount;
//                    [applyXTitleArray addObject:[self getXTitleItemWithValue:item.month kdateSearchType:searchType]];
//                    
//                    [reservationValueArray addObject:[NSString stringWithFormat:@"%li",item.reservationcoursecount]];
//                    reservationNum += item.reservationcoursecount;
//                    [reservationXTitleArray addObject:[self getXTitleItemWithValue:item.month kdateSearchType:searchType]];
//                    
//                    [goodArray addObject:[NSString stringWithFormat:@"%li",item.goodcommentcount]];
//                    [xTitleArray addObject:[self getXTitleItemWithValue:item.month kdateSearchType:searchType]];
//                    
//                    [generalArray addObject:[NSString stringWithFormat:@"%li",item.generalcomment]];
//                    
//                    [badArray addObject:[NSString stringWithFormat:@"%li",item.badcommentcount]];
//                    
//                    [complaintArray addObject:[NSString stringWithFormat:@"%li",item.complaintcount]];
//                }
//            }
        
//            if (detailRootClass.data.coursedata.count) {
//                for (DataDetailDMMonthCoursedata *item in detailRootClass.data.coursedata) {
//                    [coachValueArray addObject:[NSString stringWithFormat:@"%li",item.coursecount]];
//                    [coachXTitleArray addObject:[NSString stringWithFormat:@"%li",item.coachcount]];
//                }
//            }
            
//            self.appleStudentCount = applyNum;
//            self.reservationStudentCount = reservationNum;
//            
//            self.applyXTitleArray = applyXTitleArray;
//            self.applyValueArray = applyValueArray;
//            
//            self.reservationXTitleArray = reservationXTitleArray;
//            self.reservationValueArray = reservationValueArray;
//            
//            self.coachCourseXTitleArray = coachXTitleArray;
//            self.coachCourseValueArray = coachValueArray;
//            
//            self.goodValueArray = goodArray;
//            self.generalValueArray = generalArray;
//            self.badValueArray = badArray;
//            self.complaintValueArray = complaintArray;
//            
//            self.evaluateXTitleArray = xTitleArray;
        
        self.reservationValueArray = detailRootClass.data.datalist;
        self.reservationXTitleArray = [NSArray arrayWithObjects:@"第一季度",@"第二季度",@"第三季度",@"第四季度",nil];

//        }
    
    }
    return self;
}

- (NSString *)getXTitleItemWithValue:(NSInteger)value kdateSearchType:(kDateSearchType)searchType {
    
    NSString *xTitleItemString = @"";
    switch (searchType) {
        case kDateSearchTypeToday:
            xTitleItemString = [NSString stringWithFormat:@"%li:00",value];
            break;
        case kDateSearchTypeYesterday:
            xTitleItemString = [NSString stringWithFormat:@"%li:00",value];
            break;
        case kDateSearchTypeWeek:
            xTitleItemString = [self getWeekStringWithValue:value];
            break;
        case kDateSearchTypeMonth:
            xTitleItemString = [NSString stringWithFormat:@"第%li周",value];
            break;
        case kDateSearchTypeYear:
            xTitleItemString = [NSString stringWithFormat:@"第%li月",value];
            break;
        default:
            break;
    }
    return xTitleItemString;
}

- (NSString *)getWeekStringWithValue:(NSUInteger)value {
    switch (value) {
        case 1:
            return @"周一";
            break;
        case 2:
            return @"周二";
            break;
        case 3:
            return @"周三";
            break;
        case 4:
            return @"周四";
            break;
        case 5:
            return @"周五";
            break;
        case 6:
            return @"周六";
            break;
        case 7:
            return @"周日";
            break;
            
        default:
            return @"";
            break;
    }
}

@end
