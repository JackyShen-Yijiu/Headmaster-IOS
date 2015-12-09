//
//  HomeViewModel.m
//  Headmaster
//
//  Created by 大威 on 15/12/5.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeViewModel.h"
#import "HomeDataModelRootClass.h"
#import "HomeDataModelWeeklyRootClass.h"

@implementation HomeViewModel

- (void)networkRequestRefresh {
    
    [NetworkEntity getHomeDataWithSearchType:_searchType success:^(id responseObject) {
        
        if (_searchType == kDateSearchTypeWeek) {
            
            HomeDataModelWeeklyRootClass *weekData = [[HomeDataModelWeeklyRootClass alloc] initWithDictionary:responseObject];
            
            _evaluateArray = @[ weekData.data.goodcommentcount,
                                    weekData.data.generalcomment,
                                    weekData.data.badcommentcount,
                                    weekData.data.complaintstudentcount ];
            
        } else {
            HomeDataModelRootClass *dailyData = [[HomeDataModelRootClass alloc] initWithDictionary:responseObject];
            
            NSMutableArray *marr = [NSMutableArray array];
            for (NSInteger i = 0; i < dailyData.data.schoolstudentcount.count; i++) {
                for (HomeDataModelSchoolstudentcount *count in dailyData.data.schoolstudentcount) {
                    if (count.subjectid == i+1) {
                        [marr addObject:[NSString stringWithFormat:@"%li",count.studentcount]];
                    }
                }
            }
            _applyCount = dailyData.data.applystudentcount;
            _subjectArray = [marr copy];
            
            _evaluateArray = @[ dailyData.data.commentstudentcount.goodcommnent,
                                dailyData.data.commentstudentcount.generalcomment,
                                dailyData.data.commentstudentcount.badcomment,
                                dailyData.data.complaintstudentcount ];
            
            // 进度数据
            CGFloat value_1 = 0;
            CGFloat value_2 = 0;
            CGFloat value_4 = 0;
            
            if (dailyData.data.coachstotalcoursecount) {
                value_1 = dailyData.data.reservationcoursecountday / dailyData.data.coachstotalcoursecount;
                value_2 = dailyData.data.finishreservationnow / dailyData.data.coachstotalcoursecount;
            }
            if (dailyData.data.coachcoursenow) {
                value_4 = dailyData.data.coursestudentnow / dailyData.data.coachcoursenow;
            }
            _progressArray = @[ @(value_1), @(value_2), @(1), @(value_4) ];
        }
        
        [self successRefreshBlock];
        
    } failure:^(NSError *failure) {
        
        
    }];
}

@end
