//
//  PublishViewModel.m
//  Headmaster
//
//  Created by 胡东苑 on 15/12/4.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "PublishViewModel.h"
#import "PublishDataModelRootClass.h"

@implementation PublishViewModel

- (void)networkRequestRefresh {
    [NetworkEntity getPublishListWithUseInfoModel:[UserInfoModel defaultUserInfo] seqindex:[NSString stringWithFormat:@"%d",0] count:[NSString stringWithFormat:@"%d",10] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        PublishDataModelRootClass *rootDataModel = [[PublishDataModelRootClass alloc] initWithJsonDict:dataDic];
        _publishData = [[NSMutableArray alloc] initWithArray:rootDataModel.data];
        
        [self successRefreshBlock];
    } failure:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self errorRefreshBlock];
    }];
}

- (void)needPublishMessageWithContentStr:(NSString *)str WithType:(NSString *)type {
    [NetworkEntity postPublishMessageWithUseInfoModel:[UserInfoModel defaultUserInfo] textContent:str type:type success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"发表成功"];
        [alertView show];
    } failure:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:[dataDic objectForKey:@"msg"]];
        [alertView show];
    }];
    
}

@end
