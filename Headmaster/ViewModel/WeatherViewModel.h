//
//  WeatherViewModel.h
//  Headmaster
//
//  Created by ytzhang on 15/12/5.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "YBBaseViewModel.h"

@interface WeatherViewModel : YBBaseViewModel



@property (nonatomic, strong) NSMutableArray *weatherArray;

@property (nonatomic, copy) void (^tableViewNeedReLoad)(void);

@property (nonatomic, copy) void (^showToast)(void);

- (void)networkRequestNeedUpRefreshWithCityName:(NSString *)cityName;

@end
