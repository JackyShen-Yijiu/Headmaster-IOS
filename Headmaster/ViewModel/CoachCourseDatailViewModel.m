//
//  CoachCourseDatailViewModel.m
//  Headmaster
//
//  Created by ytzhang on 15/12/7.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "CoachCourseDatailViewModel.h"
#import "CoachCoureDatailModelRootClass.h"

@implementation CoachCourseDatailViewModel

- (void)networkRequestNeedUpRefreshWithCoachCourseListWithuserid:(NSString *)userid
                                                      searchtype:(NSInteger)searchtype
                                                        schoolid:(NSString *)schoolid
                                                           count:(NSInteger) count
{
    _coachArray = [NSMutableArray array];
   [NetworkEntity getCoachCourseListWithuserid:userid searchtype:searchtype schoolid:schoolid count:10 index:1  success:^(id responseObject) {
       NSLog(@"%@",responseObject);
       CoachCoureDatailModelRootClass *rootCoachDatail = [[CoachCoureDatailModelRootClass alloc]initWithJsonDict:responseObject];
       [_coachArray addObjectsFromArray:rootCoachDatail.data];
       [self successRefreshBlock];
       if (_tableViewNeedReLoad) {
           _tableViewNeedReLoad();
       }
   
   } failure:^(NSError *failure) {
    if (_showToast) {
           _showToast();
       }
   }];
}
@end
