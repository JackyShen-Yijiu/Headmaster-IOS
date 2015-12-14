//
//  HomeDataDetailViewModel.m
//  Headmaster
//
//  Created by 大威 on 15/12/12.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeDataDetailViewModel.h"

@implementation HomeDataDetailViewModel

- (void)networkRequestRefresh {
    
    [NetworkEntity moreDataDatilListWithuserid:[UserInfoModel defaultUserInfo].userID searchtype:self.searchType schoolid:[UserInfoModel defaultUserInfo].schoolId success:^(id responseObject) {
        
        NSLog(@"-----%@======%li",responseObject,self.searchType);
        
        if (self.searchType == kDateSearchTypeWeek) {
            DataDetailDMWeekRootClass *weekRC = [[DataDetailDMWeekRootClass alloc] initWithDictionary:responseObject];
            
            self.dataModel = [[HomeDetailTableViewDataModel alloc] initWithDataDetailDMWeekRootClass:weekRC searchType:self.searchType];
        }else if (self.searchType == kDateSearchTypeMonth) {
            DataDetailDMMonthRootClass *monthRC = [[DataDetailDMMonthRootClass alloc] initWithDictionary:responseObject];
            
            self.dataModel = [[HomeDetailTableViewDataModel alloc] initWithDataDetailDMMonthRootClass:monthRC searchType:self.searchType];
        }else if (self.searchType == kDateSearchTypeYear) {
            DataDetailDMYearRootClass *yearRC = [[DataDetailDMYearRootClass alloc] initWithDictionary:responseObject];
            
            self.dataModel = [[HomeDetailTableViewDataModel alloc] initWithDataDetailDMYearRootClass:yearRC searchType:self.searchType];
        }else {
            HomeDataDetailDMRootClass *rootClass = [[HomeDataDetailDMRootClass alloc] initWithDictionary:responseObject];
            if (rootClass.type == 0) {
                return ;
            }
            if (!rootClass.data.applystuentlist.count) {
                [self showAlert:@"没有招生学员！"];
            }
            if (!rootClass.data.reservationstudentlist.count) {
                [self showAlert:@"没有约课学员！"];
            }
            if (!rootClass.data.coachcourselist.count) {
                [self showAlert:@"没有教练授课！"];
            }
            if (!rootClass.data.goodcommentlist.count) {
                [self showAlert:@"没有好评！"];
            }
            if (!rootClass.data.generalcommentlist.count) {
                [self showAlert:@"没有中评！"];
            }
            if (!rootClass.data.badcommentlist.count) {
                [self showAlert:@"没有差评！"];
            }
            if (!rootClass.data.complaintlist.count) {
                [self showAlert:@"没有投诉！"];
            }
            self.dataModel = [[HomeDetailTableViewDataModel alloc] initWithHomeDataDetailDMRootClass:rootClass searchType:self.searchType];
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
