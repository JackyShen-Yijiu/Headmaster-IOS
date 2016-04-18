//
//  DataDatilViewModel.m
//  Headmaster
//
//  Created by ytzhang on 15/12/5.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "DataDatilViewModel.h"
#import "HomeDataDatailModelRootClass.h"


#import "ReservationStudentListModel.h"
#import "ApplyStuentListModel.h"
#import "CoachCourseListModel.h"
#import "GoodCommentListModel.h"
#import "BadCommentListModel.h"
#import "GeneralCommentListModel.h"
#import "ComplaintListModel.h"

/*
 #import "InformationViewModel.h"
 #import "InformationDataModelRootClass.h"
 
 @implementation InformationViewModel
 
 - (void)networkRequestRefresh {
 
 [NetworkEntity informationListWithseqindex:0 count:10 success:^(id responseObject) {
 
 InformationDataModelRootClass *rootDataModel = [[InformationDataModelRootClass alloc] initWithJsonDict:responseObject];
 _informationArray = rootDataModel.data;
 
 [self successRefreshBlock];
 
 } failure:^(NSError *failure) {
 
 }];
 }
 
 
 
 InformationDataModelRootClass *rootDataModel = [[InformationDataModelRootClass alloc] initWithJsonDict:responseObject];
 [_informationArray addObjectsFromArray:rootDataModel.data];
 [self successRefreshBlock];
 if (_tableViewNeedReLoad) {
 _tableViewNeedReLoad();
 }
 } failure:^(NSError *failure) {
 if (_showToast) {
 _showToast();
 }
 }];

 
 
 

 */
@implementation DataDatilViewModel
- (void)networkRequestRefreshWith:(NSInteger)searchtype
{
    [NetworkEntity moreDataDatilListWithuserid:@"56582caf1fcf03d813f5fbfc" searchtype:searchtype schoolid:@"562dcc3ccb90f25c3bde40da" success:^(id responseObject) {
        HomeDataDatailModelRootClass *datailRootDataModel = [[HomeDataDatailModelRootClass alloc] initWithJsonDict:responseObject];
        
        
        
        // 招生图表
        NSMutableArray *applyX = [NSMutableArray array];
        NSMutableArray *applyY = [NSMutableArray array];
        for (ApplyStuentListModel *model in datailRootDataModel.applyStudentArray) {
            [applyX addObject:model.hour];
            [applyY addObject:model.applystudentcount];
        }
        _applyStudentX = applyX;
        _applyStudentY = applyY;
        
        // 约课
        NSMutableArray *reservX = [NSMutableArray array];
        NSMutableArray *reservY = [NSMutableArray array];
        for (ReservationStudentListModel *model in datailRootDataModel.reservationStudentCountArray) {
            [reservX addObject:model.hour];
            [reservY addObject:model.studentcount];
        }
        _reservationStudentX = reservX;
        _reservationStudentY = reservY;

        // 教练授课
        NSMutableArray *coachCourseX = [NSMutableArray array];
        NSMutableArray *coachCourseY = [NSMutableArray array];
        for (CoachCourseListModel *model in datailRootDataModel.cocoachCoureArray) {
            NSLog(@"%@",model.coursecount);
            [coachCourseX addObject:model.coursecount]; // 课时数
            [coachCourseY addObject:model.coachcount]; // 教练数
        }
        _coachCoureX = coachCourseX;
        _coachCoureY = coachCourseY;
        
        // 好评
        NSMutableArray *goodCommentX = [NSMutableArray array];
        NSMutableArray *goodCommentY = [NSMutableArray array];
        for (GoodCommentListModel *model in datailRootDataModel.goodCommentArray) {
            [goodCommentX addObject:model.hour];
            [goodCommentY addObject:model.commnetcount];
        }
        _goodCommentX = goodCommentX;
        _goodCommentY = goodCommentY;

        
        // 差评
        NSMutableArray *badCommentX = [NSMutableArray array];
        NSMutableArray *badCommentY = [NSMutableArray array];
        for (BadCommentListModel *model in datailRootDataModel.badCommentArray) {
            [badCommentX addObject:model.hour];
            [badCommentY addObject:model.commnetcount];
        }
        _badCommentX = badCommentX;
        _badCommentY = badCommentY;
        
        // 中评
        NSMutableArray *generalCommentX = [NSMutableArray array];
        NSMutableArray *generalCommentY = [NSMutableArray array];
        
        for (GeneralCommentListModel *model in datailRootDataModel.generalCommentArray) {
            
            [generalCommentX addObject:model.hour];
            [generalCommentY addObject:model.commnetcount];
        }
        _generalCommentX = generalCommentX;
        _generalCommentY = generalCommentY;

        // 投诉
        NSMutableArray *complaintCommentX = [NSMutableArray array];
        NSMutableArray *complaintCommentY = [NSMutableArray array];
        for (ComplaintListModel *model in datailRootDataModel.complaintArray) {
            [complaintCommentX addObject:model.hour];
            [complaintCommentY addObject:model.commnetcount];
        }
        _complaintCommentX = complaintCommentX;
        _complaintCommentY = complaintCommentY;
        
        
        
        // 数据请求成功
        NSLog(@"responeObject = %@",responseObject);
        [self successRefreshBlock];
        if (_tableViewNeedReLoad) {
            _tableViewNeedReLoad();
        }
        
    } failure:^(NSError *failure) {
        NSLog(@" -------------------------failure = %@",failure);
    }];
}



@end
