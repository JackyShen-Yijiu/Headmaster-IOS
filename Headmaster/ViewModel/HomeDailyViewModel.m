//
//  HomeDailyViewModel.m
//  Headmaster
//
//  Created by 大威 on 15/12/5.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeDailyViewModel.h"

@implementation HomeDailyViewModel

- (void)networkRequestRefresh {
    
    [NetworkEntity getHomeDataWithSearchType:_searchType success:^(id responseObject) {
        
        if (_searchType == 1) {
            
        }
        NSLog(@"============================%@", responseObject);
        
    } failure:^(NSError *failure) {
        
        
    }];
}

@end
