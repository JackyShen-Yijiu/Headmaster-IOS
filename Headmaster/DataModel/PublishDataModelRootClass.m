//
//  PublishDataModelRootClass.m
//  Headmaster
//
//  Created by 胡东苑 on 15/12/4.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "PublishDataModelRootClass.h"

@implementation PublishDataModelRootClass

- (instancetype)initWithJsonDict:(id)dictionary {
    self = [super init];
    if (self) {
        NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:dictionary];
        NSArray *array = [dict objectArrayForKey:@"data"];
        NSMutableArray *marray = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            PublishDataModel *dataModel = [[PublishDataModel alloc] initWithDictionary:[array objectAtIndex:i]];
            [marray addObject:dataModel];
        }
        _data = marray;
    }
    return self;
}

@end
