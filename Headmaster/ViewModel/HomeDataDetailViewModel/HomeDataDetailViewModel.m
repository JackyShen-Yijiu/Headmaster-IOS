//
//  HomeDataDetailViewModel.m
//  Headmaster
//
//  Created by 大威 on 15/12/12.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeDataDetailViewModel.h"
#import "YYModel.h"

@implementation HomeDataDetailViewModel

- (void)networkRequestRefresh {
    
    [NetworkEntity moreDataDatilListWithuserid:[UserInfoModel defaultUserInfo].userID searchtype:self.searchType schoolid:[UserInfoModel defaultUserInfo].schoolId success:^(id responseObject) {
        
        NSLog(@"--招生统计---%@======%li",responseObject,self.searchType);
        
        if (self.searchType == kDateSearchTypeWeek) {
            
            DataDetailDMWeekRootClass *weekRC = [[DataDetailDMWeekRootClass alloc] initWithDictionary:responseObject];
            if (weekRC.type == 0) {
                return ;
            }
            self.dataModel = [[HomeDetailTableViewDataModel alloc] initWithDataDetailDMWeekRootClass:weekRC searchType:self.searchType];
            
        }else if (self.searchType == kDateSearchTypeMonth) {
            
            DataDetailDMMonthRootClass *monthRC = [DataDetailDMMonthRootClass yy_modelWithJSON:responseObject];
            if (monthRC.type == 0) {
                return ;
            }
            
            NSLog(@"monthRC.data.datalist:%@",monthRC.data.datalist);
            
            self.dataModel = [[HomeDetailTableViewDataModel alloc] initWithDataDetailDMMonthRootClass:monthRC searchType:self.searchType];
            
        }else if (self.searchType == kDateSearchTypeYear) {
            
            DataDetailDMYearRootClass *yearRC = [DataDetailDMYearRootClass yy_modelWithJSON:responseObject];
            if (yearRC.type == 0) {
                return ;
            }
            self.dataModel = [[HomeDetailTableViewDataModel alloc] initWithDataDetailDMYearRootClass:yearRC searchType:self.searchType];
            
        }else {
            
            HomeDataDetailDMRootClass *rootClass = [[HomeDataDetailDMRootClass alloc] initWithDictionary:responseObject];
            if (rootClass.type == 0) {
                return ;
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
