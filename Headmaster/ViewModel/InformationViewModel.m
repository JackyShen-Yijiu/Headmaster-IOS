//
//  InformationViewModel.m
//  Headmaster
//
//  Created by 大威 on 15/12/3.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "InformationViewModel.h"
#import "InformationDataModelRootClass.h"

@implementation InformationViewModel

- (void)networkRequestRefresh {
    
    [NetworkEntity informationListWithseqindex:0 count:10 success:^(id responseObject) {
        
        InformationDataModelRootClass *rootDataModel = [[InformationDataModelRootClass alloc] initWithJsonDict:responseObject];
        _informationArray = [[NSMutableArray alloc] initWithArray:rootDataModel.data];
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

- (void)networkRequestNeedUpRefreshWithSeqindex:(NSInteger)seqindex {
    [NetworkEntity informationListWithseqindex:seqindex count:10 success:^(id responseObject) {
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
}

@end
