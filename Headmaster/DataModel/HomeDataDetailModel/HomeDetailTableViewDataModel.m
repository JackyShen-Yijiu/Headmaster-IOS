//
//  HomeDetailTableViewDataModel.m
//  Headmaster
//
//  Created by 大威 on 15/12/11.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeDetailTableViewDataModel.h"

@implementation HomeDetailTableViewDataModel

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
                
                NSString *xTitleItemString = [self getXTitleItemWithValue:item.coachcount kdateSearchType:searchType];
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
                [tempDict setObject:@1 forKey:goodXTitleArray[i]];
            }
            for (int i = 0; i < generalXTitleArray.count; i++) {
                [tempDict setObject:@1 forKey:generalXTitleArray[i]];
            }
            for (int i = 0; i < badXTitleArray.count; i++) {
                [tempDict setObject:@1 forKey:badXTitleArray[i]];
            }
            for (int i = 0; i < complaintXtitleArray.count; i++) {
                [tempDict setObject:@1 forKey:complaintXtitleArray[i]];
            }
            
//            for (NSString *itemKey in tempDict.allKeys) {
//                NSLog(@"===%@",itemKey);
//            }
            self.evaluateXTitleArray = tempDict.allKeys;
//            self.evaluateXTitleArray = @[ @"ssa", @"df" ];
            self.goodValueArray = goodArray;
            self.generalValueArray = generalArray;
            self.badValueArray = badArray;
            self.complaintValueArray = complaintArray;
        }
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
