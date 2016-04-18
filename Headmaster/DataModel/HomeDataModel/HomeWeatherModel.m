//
//  HomeWeatherModel.m
//  Headmaster
//
//  Created by ytzhang on 15/12/8.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeWeatherModel.h"



/*
 
 
 now": {
 "aqi": 267,
 "aqiDetail": {
 "aqi": 267,
 "area": "北京",
 "area_code": "beijing",
 "co": 4.158,
 "no2": 83,
 "o3": 4,
 "o3_8h": 5,
 "pm10": 225,
 "pm2_5": 216,
 "primary_pollutant": "颗粒物(PM2.5)",
 "quality": "重度污染",
 "so2": 20
 },
 "sd": "88%",
 "temperature": "2",
 "temperature_time": "11:00",
 "weather": "雾",
 "weather_code": "18",
 "weather_pic": "http://appimg.showapi.com/images/weather/icon/day/18.png",
 "wind_direction": "东北风",
 "wind_power": "1级"
 },
 "ret_code": 0,
 "time": "20151208073000"
 }
 */


@implementation HomeWeatherModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    
}


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
        _temperature = [dictionary objectForKey:@"temperature"];
        _weather_pic = [dictionary objectForKey:@"weather_pic"];
        _weather = [dictionary objectForKey:@"weather"];
    
    }
    return self;
}

@end
