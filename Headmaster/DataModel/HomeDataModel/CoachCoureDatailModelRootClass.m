//
//  CoachCoureDatailModelRootClass.m
//  Headmaster
//
//  Created by ytzhang on 15/12/7.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "CoachCoureDatailModelRootClass.h"
#import "CoachCoureDatilModel.h"

@implementation CoachCoureDatailModelRootClass

- (instancetype)initWithJsonDict:(id)dictionary {
    self = [super init];
    if (self) {
        
        NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:dictionary];
        NSArray *array = [dict objectArrayForKey:@"data"];
        NSMutableArray *marray = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            CoachCoureDatilModel *coachModel = [[CoachCoureDatilModel alloc] initWithDictionary:[array objectAtIndex:i]];
            [marray addObject:coachModel];
        }
        _data = marray;
    }
    return self;
}

@end
