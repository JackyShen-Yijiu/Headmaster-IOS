//
//  JZPassRateViewModel.m
//  Headmaster
//
//  Created by ytzhang on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZPassRateViewModel.h"
#import <YYModel.h>
#import "JZPassRateListModel.h"
@implementation JZPassRateViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _subjectOneArray = [NSMutableArray array];
        _subjectTwoArray = [NSMutableArray array];
        _subjectThreeArray = [NSMutableArray array];
        _subjectFourArray = [NSMutableArray array];
        
        _subjectOneIndex = 1;
        _subjectTwoIndex = 1;
        _subjectThreeIndex = 1;
        _subjectFourIndex = 1;
      
        
    }
    return self;
}
- (void)networkRequestRefresh {
    _subjectOneIndex = 1;
    _subjectTwoIndex = 1;
    _subjectThreeIndex = 1;
    _subjectFourIndex = 1;

    
    NSInteger index = 0;
    if (_searchSubjectID == kDateSearchSubjectIDOne) {
        index = _subjectOneIndex;
    }
    if (_searchSubjectID == kDateSearchSubjectIDTwo) {
        index = _subjectTwoIndex;
    }
    
    if (_searchSubjectID == kDateSearchSubjectIDThree) {
        index = _subjectThreeIndex;
    }
    
    if (_searchSubjectID == kDateSearchSubjectIDFour) {
        index = _subjectFourIndex;
    }
    
    // 首次加载
    [NetworkEntity getTestDetailWithUserid:[UserInfoModel defaultUserInfo].userID SchoolId:[UserInfoModel defaultUserInfo].schoolId SubjectID:_searchSubjectID Year:_year Month:_month success:^(id responseObject) {
        NSLog(@"??????????????? responseObject=%@ subjectID=%@",responseObject, (NSString *)@(self.searchSubjectID));
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        NSArray *data = [responseObject objectArrayForKey:@"data"];
        if (type == 1) {
            
            [self.subjectOneArray removeAllObjects];
            [self.subjectTwoArray removeAllObjects];
            [self.subjectThreeArray removeAllObjects];
            [self.subjectFourArray removeAllObjects];
            
            if (data.count == 0) {
                
            }
            
            for (NSDictionary *dic in data) {
                
                JZPassRateListModel *model = [JZPassRateListModel yy_modelWithDictionary:dic];
                if (_searchSubjectID == kDateSearchSubjectIDOne) {
                    [_subjectOneArray addObject:model];
                }
                if (_searchSubjectID == kDateSearchSubjectIDTwo) {
                    [_subjectTwoArray addObject:model];
                }
                
                if (_searchSubjectID == kDateSearchSubjectIDThree) {
                    [_subjectThreeArray addObject:model];
                }
                
                if (_searchSubjectID == kDateSearchSubjectIDFour) {
                    [_subjectFourArray addObject:model];
                }
                
            }
            
            [self successRefreshBlock];
            
            
        }else{
            
        }

    } failure:^(NSError *failure) {
        
        ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误!"];
        [alertView show];

    }];
}
//- (void)networkRequestLoadMore{
//    
//    NSInteger index = 0;
//    
//    
//    if (_searchSubjectID == kDateSearchSubjectIDOne) {
//        index = ++_subjectOneIndex;
//    }
//    if (_searchSubjectID == kDateSearchSubjectIDTwo) {
//        index = ++_subjectTwoIndex;
//    }
//    
//    if (_searchSubjectID == kDateSearchSubjectIDThree) {
//        index = ++_subjectThreeIndex;
//    }
//    
//    if (_searchSubjectID == kDateSearchSubjectIDFour) {
//        index = ++_subjectFourIndex;
//    }
//    // 首次加载
//    [NetworkEntity getPassRateListWithuserid:[UserInfoModel defaultUserInfo].userID searchSubjectID:_searchSubjectID count:10 index:index success:^(id responseObject) {
//        
//        NSLog(@"responseObject=%@ subjectID=%@",responseObject, (NSString *)@(self.searchSubjectID));
//        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
//        NSArray *data = [responseObject objectArrayForKey:@"data"];
//        if (type == 1) {
//            
//            
//            if (data.count == 0) {
//                
//                [self successLoadMoreBlockAndNoData];
//            }
//            
//            for (NSDictionary *dic in data) {
//                
//                JZPassRateListModel *model = [JZPassRateListModel yy_modelWithDictionary:dic];
//                if (_searchSubjectID == kDateSearchSubjectIDOne) {
//                    [_subjectOneArray addObject:model];
//                }
//                if (_searchSubjectID == kDateSearchSubjectIDTwo) {
//                    [_subjectTwoArray addObject:model];
//                }
//                
//                if (_searchSubjectID == kDateSearchSubjectIDThree) {
//                    [_subjectThreeArray addObject:model];
//                }
//                
//                if (_searchSubjectID == kDateSearchSubjectIDFour) {
//                    [_subjectFourArray addObject:model];
//                }
//                
//            }
//            
//            [self successRefreshBlock];
//            
//            
//        }else{
//            
//        }
//        
//    } failure:^(NSError *failure) {
//        
//        ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误!"];
//        [alertView show];
//    }];
//
//}
//



- (void)showAlert:(NSString *)title {
    ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:title];
    [alertView show];
}

@end
