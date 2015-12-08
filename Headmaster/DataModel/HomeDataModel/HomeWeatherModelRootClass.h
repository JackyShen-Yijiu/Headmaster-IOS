//
//  HomeWeatherModelRootClass.h
//  Headmaster
//
//  Created by ytzhang on 15/12/8.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeWeatherModelRootClass : NSObject

@property (nonatomic,strong) NSArray *data;
- (instancetype)initWithJsonDict:(id)dictionary;

@end
