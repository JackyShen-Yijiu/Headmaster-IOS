//
//  HomeWeatherModelRootClass.m
//  Headmaster
//
//  Created by ytzhang on 15/12/8.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeWeatherModelRootClass.h"
#import "HomeWeatherModel.h"

@implementation HomeWeatherModelRootClass

- (instancetype)initWithJsonDict:(id)dictionary
{
    self = [super init];
    if (self)
    {
        
        NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:dictionary];
        NSDictionary *dic  = [dict objectForKey:@"data"];
        if ([dic count] == 0 ) {
            return nil;
        }
        NSArray *keyArray = [dic allKeys];
        NSMutableArray *marray = [NSMutableArray array];
        for (NSString *key  in keyArray)
        {
            if ([key isEqualToString:@"now"])
            {
                NSDictionary *resultDic = [dic objectForKey:key];
                HomeWeatherModel *weatherModel = [[HomeWeatherModel alloc] initWithDictionary:resultDic];
                [marray addObject:weatherModel];
            }
        }
        _data = marray;
    }
    return self;
}
@end
