//
//  HomeWeatherModel.h
//  Headmaster
//
//  Created by ytzhang on 15/12/8.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HomeWeatherModel : NSObject

@property (nonatomic,strong) NSString *temperature; // 温度

@property (nonatomic,strong) NSString *weather_pic; // 天气图标

@property (nonatomic,strong) NSString *weather; // 天气

- (instancetype)initWithDictionary:(id)dictionary;
@end
