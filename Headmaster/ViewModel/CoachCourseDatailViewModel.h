//
//  CoachCourseDatailViewModel.h
//  Headmaster
//
//  Created by ytzhang on 15/12/7.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "YBBaseViewModel.h"

@interface CoachCourseDatailViewModel : YBBaseViewModel

@property (nonatomic, strong) NSMutableArray *coachArray;

@property (nonatomic, copy) void (^tableViewNeedReLoad)(void);

@property (nonatomic, copy) void (^showToast)(void);

@property (nonatomic,  assign) int index;

- (void)networkRequestNeedUpRefreshWithCoachCourseListWithuserid:(NSString *)userid
                                     searchtype:(NSInteger)searchtype
                                       schoolid:(NSString *)schoolid
                                          count:(NSInteger) count
;


@end
