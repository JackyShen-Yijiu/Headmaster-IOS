//
//  DataDatilViewModel.h
//  Headmaster
//
//  Created by ytzhang on 15/12/5.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "YBBaseViewModel.h"

@interface DataDatilViewModel : YBBaseViewModel

@property (nonatomic, strong) NSMutableArray *dataDatailArray;

@property (nonatomic, copy) void (^tableViewNeedReLoad)(void);

@property (nonatomic, copy) void (^showToast)(void);


// 图表的X,Y值的数组

@property (nonatomic,strong) NSArray *applyStudentX;
@property (nonatomic,strong) NSArray *applyStudentY;
@property (nonatomic,strong) NSArray *reservationStudentX;
@property (nonatomic,strong) NSArray *reservationStudentY;
@property (nonatomic,strong) NSArray *coachCoureX;
@property (nonatomic,strong) NSArray *coachCoureY;
@property (nonatomic,strong) NSArray *goodCommentX;
@property (nonatomic,strong) NSArray *goodCommentY;
@property (nonatomic,strong) NSArray *badCommentX;
@property (nonatomic,strong) NSArray *badCommentY;
@property (nonatomic,strong) NSArray *generalCommentX;
@property (nonatomic,strong) NSArray *generalCommentY;
@property (nonatomic,strong) NSArray *complaintCommentX;
@property (nonatomic,strong) NSArray *complaintCommentY;





- (void)networkRequestRefreshWith:(NSInteger)searchtype;

@end
