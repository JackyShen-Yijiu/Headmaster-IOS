//
//  JZCommentListViewModel.h
//  Headmaster
//
//  Created by ytzhang on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBBaseViewModel.h"

@interface JZCommentListViewModel : YBBaseViewModel

@property (nonatomic, assign) kCommentDateSearchType commentDateSearchType;

@property (nonatomic, strong) NSMutableArray *lastMonthArray;
@property (nonatomic, strong) NSMutableArray *lastWeekArray;
@property (nonatomic, strong) NSMutableArray *todayArray;
@property (nonatomic, strong) NSMutableArray *thisWeekArray;
@property (nonatomic, strong) NSMutableArray *thisMonthArray;

@property (nonatomic, assign) NSInteger lastMonthIndex;
@property (nonatomic, assign) NSInteger lastWeekIndex;
@property (nonatomic, assign) NSInteger todayIndex;
@property (nonatomic, assign) NSInteger thisWeekIndex;
@property (nonatomic, assign) NSInteger thisMonthIndex;

@end
