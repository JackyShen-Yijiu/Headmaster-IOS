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
        _informationArray = rootDataModel.data;
        
        [self successRefreshBlock];
        
    } failure:^(NSError *failure) {
        
    }];
}

@end
