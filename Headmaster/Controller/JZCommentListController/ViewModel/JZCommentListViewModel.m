//
//  JZCommentListViewModel.m
//  Headmaster
//
//  Created by ytzhang on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZCommentListViewModel.h"
#import <YYModel.h>
#import "JZCommentListModel.h"
@implementation JZCommentListViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _lastMonthArray = [NSMutableArray array];
        _lastWeekArray = [NSMutableArray array];
        _todayArray = [NSMutableArray array];
        _thisWeekArray = [NSMutableArray array];
        _thisMonthArray = [NSMutableArray array];
        
        _lastMonthIndex = 1;
        _lastWeekIndex = 1;
        _todayIndex = 1;
        _thisWeekIndex = 1;
        _thisMonthIndex = 1;
        
        
    }
    return self;
}
- (void)networkRequestRefresh {
    _lastMonthIndex = 1;
    _lastWeekIndex = 1;
    _todayIndex = 1;
    _thisWeekIndex = 1;
    _thisMonthIndex = 1;
    
    NSInteger index = 0;
    if (_commentDateSearchType == kCommentDateSearchTypeLastMonth) {
        index = _lastMonthIndex;
    }
    if (_commentDateSearchType == kCommentDateSearchTypeLastWeek) {
        index = _lastWeekIndex;
    }
    
    if (_commentDateSearchType == kCommentDateSearchTypeToday) {
        index = _todayIndex;
    }
    
    if (_commentDateSearchType == kCommentDateSearchTypeThisWeek) {
        index = _thisWeekIndex;
    }
    if (_commentDateSearchType == kCommentDateSearchTypeThisMonth) {
        index = _thisMonthIndex;
    }
    
    [NetworkEntity getRecommendListWithUserid:[UserInfoModel defaultUserInfo].userID SchoolId:[UserInfoModel defaultUserInfo].schoolId pageIndex:index count:10 searchType:_commentDateSearchType commentLevle:_commentLevel success:^(id responseObject) {
        NSLog(@"responseObject=%@ subjectID=%@",responseObject, (NSString *)@(self.commentDateSearchType));
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        NSArray *data = [responseObject objectArrayForKey:@"data"];
        if (type == 1) {
            
            [self.lastMonthArray removeAllObjects];
            [self.lastWeekArray removeAllObjects];
            [self.todayArray removeAllObjects];
            [self.thisWeekArray removeAllObjects];
            [self.thisMonthArray removeAllObjects];
            
            
            if (data.count == 0) {
                
            }
            
            for (NSDictionary *dic in data) {
                
                JZCommentListModel *model = [JZCommentListModel yy_modelWithDictionary:dic];
                if (_commentDateSearchType == kCommentDateSearchTypeLastMonth) {
                    [_lastMonthArray addObject:model];
                }
                if (_commentDateSearchType == kCommentDateSearchTypeLastWeek) {
                    [_lastWeekArray addObject:model];
                }
                
                if (_commentDateSearchType == kCommentDateSearchTypeToday) {
                    [_todayArray addObject:model];
                }
                
                if (_commentDateSearchType == kCommentDateSearchTypeThisWeek) {
                    [_thisWeekArray addObject:model];
                }
                if (_commentDateSearchType == kCommentDateSearchTypeThisMonth) {
                    [_thisMonthArray addObject:model];
                }
            }
        }
        
        [self successRefreshBlock];

    } failure:^(NSError *failure) {
        ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误!"];
        [alertView show];
    }];
    
    
}
- (void)networkRequestLoadMore{
    
    NSInteger index = 0;
    
    
    if (_commentDateSearchType == kDateSearchSubjectIDOne) {
        index = ++_lastMonthIndex;
    }
    if (_commentDateSearchType == kDateSearchSubjectIDTwo) {
        index = ++_lastWeekIndex;
    }
    
    if (_commentDateSearchType == kDateSearchSubjectIDThree) {
        index = ++_todayIndex;
    }
    
    if (_commentDateSearchType == kDateSearchSubjectIDFour) {
        index = ++_thisWeekIndex;
    }
    
    if (_commentDateSearchType == kDateSearchSubjectIDFour) {
        index = ++_thisMonthIndex;
    }
    
    
    // 加载更多
    [NetworkEntity getRecommendListWithUserid:[UserInfoModel defaultUserInfo].userID SchoolId:[UserInfoModel defaultUserInfo].schoolId pageIndex:index count:10 searchType:_commentDateSearchType commentLevle:_commentLevel success:^(id responseObject) {
        NSLog(@"responseObject=%@ subjectID=%@",responseObject, (NSString *)@(self.commentDateSearchType));
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        NSArray *data = [responseObject objectArrayForKey:@"data"];
        if (type == 1) {
            
            
            if (data.count == 0) {
                [self successLoadMoreBlockAndNoData];
            }
            
            for (NSDictionary *dic in data) {
                
                JZCommentListModel *model = [JZCommentListModel yy_modelWithDictionary:dic];
                if (_commentDateSearchType == kCommentDateSearchTypeLastMonth) {
                    [_lastMonthArray addObject:model];
                }
                if (_commentDateSearchType == kCommentDateSearchTypeLastWeek) {
                    [_lastWeekArray addObject:model];
                }
                
                if (_commentDateSearchType == kCommentDateSearchTypeToday) {
                    [_todayArray addObject:model];
                }
                
                if (_commentDateSearchType == kCommentDateSearchTypeThisWeek) {
                    [_thisWeekArray addObject:model];
                }
                if (_commentDateSearchType == kCommentDateSearchTypeThisMonth) {
                    [_thisMonthArray addObject:model];
                }
            }
        }
        
        [self successRefreshBlock];
        

    } failure:^(NSError *failure) {
        ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误!"];
        [alertView show];
    }];
    
}




- (void)showAlert:(NSString *)title {
    ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:title];
    [alertView show];
}

@end
