//
//  DataDatilViewModel.m
//  Headmaster
//
//  Created by ytzhang on 15/12/5.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "DataDatilViewModel.h"


/*
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

 */
@implementation DataDatilViewModel
- (void)networkRequestRefresh
{
    [NetworkEntity moreDataDatilListWithuserid:nil searchtype:0 schoolid:nil success:^(id responseObject) {
        // 数据请求成功
        NSLog(@"responeObject = %@",responseObject);
        
        
    } failure:^(NSError *failure) {
        NSLog(@" failure = %@",failure);
    }];
}



@end
