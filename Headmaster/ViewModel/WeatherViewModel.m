//
//  WeatherViewModel.m
//  Headmaster
//
//  Created by ytzhang on 15/12/5.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "WeatherViewModel.h"
#import "HomeWeatherModelRootClass.h"

@implementation WeatherViewModel

- (void)networkRequestNeedUpRefreshWithCityName:(NSString *)cityName {
    
    [NetworkEntity weatherDataListWithcityname:cityName success:^(id responseObject) {
        HomeWeatherModelRootClass *rootDataModel = [[HomeWeatherModelRootClass alloc] initWithJsonDict:responseObject];
        _weatherArray = [[NSMutableArray alloc] initWithArray:rootDataModel.data];
         [self successRefreshBlock];
        if (_tableViewNeedReLoad) {
            _tableViewNeedReLoad();
        }
        
    } failure:^(NSError *failure) {
        NSLog(@"%@",failure);
    }];
        
}

@end
