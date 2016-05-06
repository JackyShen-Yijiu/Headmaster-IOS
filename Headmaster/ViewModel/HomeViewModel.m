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
#import "YYModel.h"
#import "HomeDataModelData.h"
#import "HomeDataModelCommentstudentcount.h"

@implementation HomeViewModel

- (void)networkRequestRefresh {
    
    [NetworkEntity getHomeDataWithSearchType:_searchType success:^(id responseObject) {
        
        NSLog(@"首页responseObject:%@",responseObject);
        
        if (_searchType == kDateSearchTypeWeek) {
            
            HomeDataModelRootClass *dailyData = [HomeDataModelRootClass yy_modelWithJSON:responseObject];

            if (dailyData.type == 0) {
                return ;
            }
            
//            _evaluateArray = @[ @(dailyData.data.commentstudentcount.goodcommnent),
//                                    @(dailyData.data.commentstudentcount.generalcomment),
//                                    @(dailyData.data.commentstudentcount.badcomment),
//                                    @(dailyData.data.complaintstudentcount)];
            
            _evaluateArray = @[ [NSString stringWithFormat:@"%li",dailyData.data.commentstudentcount.goodcommnent],
                                [NSString stringWithFormat:@"%li",dailyData.data.commentstudentcount.generalcomment],
                                [NSString stringWithFormat:@"%li",dailyData.data.commentstudentcount.badcomment],
                                [NSString stringWithFormat:@"%li",dailyData.data.complaintstudentcount] ];
            
        } else {
            
            HomeDataModelRootClass *dailyData = [HomeDataModelRootClass yy_modelWithJSON:responseObject];
            
            if (dailyData.type == 0) {
                return ;
            }
            
            NSLog(@"科目responseObject:%@",responseObject);
            NSMutableArray *marr = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0", nil];
            
            for (NSInteger i = 0; i < dailyData.data.schoolstudentcount.count; i++) {
                
                for (NSDictionary *countDict in dailyData.data.schoolstudentcount) {
                    
                    HomeDataModelSchoolstudentcount *count = [HomeDataModelSchoolstudentcount yy_modelWithJSON:countDict];
                    
                    NSLog(@"count.studentcount:%ld count.subjectid:%ld",(long)count.studentcount,(long)count.subjectid);
                    
                    if (count.subjectid == i+1) {
                        [marr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%li",count.studentcount]];
                    }
                    
                    NSLog(@"科目数组marr:%@",marr);
                    
                }
                
            }
            
            _applyCount = [NSString stringWithFormat:@"%li",dailyData.data.applystudentcount];
            _subjectArray = [marr copy];
            
            NSLog(@"科目marr:%@ _subjectArray:%@",marr,_subjectArray);
            
            _evaluateArray = @[ [NSString stringWithFormat:@"%li",dailyData.data.commentstudentcount.goodcommnent],
                                [NSString stringWithFormat:@"%li",dailyData.data.commentstudentcount.generalcomment],
                                [NSString stringWithFormat:@"%li",dailyData.data.commentstudentcount.badcomment],
                                [NSString stringWithFormat:@"%li",dailyData.data.complaintstudentcount] ];
            
            // 进度数据
//            CGFloat value_1 = 0;
//            CGFloat value_2 = 0;
//            CGFloat value_4 = 0;
//            
//            if (dailyData.data.coachstotalcoursecount) {           
//                value_1 = dailyData.data.reservationcoursecountday / (CGFloat)(dailyData.data.coachstotalcoursecount);
//                value_2 = dailyData.data.finishreservationnow / (CGFloat)(dailyData.data.coachstotalcoursecount);
//            }
//            if (dailyData.data.coachcoursenow) {
//                value_4 = dailyData.data.coursestudentnow / (CGFloat)(dailyData.data.coachcoursenow);
//            }
//            _progressArray = @[ @(value_1), @(value_2), @(1), @(value_4) ];
            

            NSLog(@"dailyData.data.passrate:%@",dailyData.data.passrate);
            NSLog(@"dailyData.data.overstockstudent:%@",dailyData.data.overstockstudent);

            _passrate = dailyData.data.passrate;
            
            _overstockstudent = dailyData.data.overstockstudent;
            
        }
        
        [self successRefreshBlock];
        
    } failure:^(NSError *failure) {
        
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"网络错误!"];
        [toastView show];
    }];
}

@end
