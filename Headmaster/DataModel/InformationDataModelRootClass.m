//
//  InformationDataModelRootClass.m
//  Headmaster
//
//  Created by 大威 on 15/12/3.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "InformationDataModelRootClass.h"

@implementation InformationDataModelRootClass

- (instancetype)initWithJsonDict:(id)dictionary {
    self = [super init];
    if (self) {
        NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:dictionary];
        NSArray *array = [dict objectArrayForKey:@"data"];
        NSMutableArray *marray = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            InformationDataModel *dataModel = [[InformationDataModel alloc] initWithDictionary:[array objectAtIndex:i]];
            [marray addObject:dataModel];
        }
        _data = marray;
    }
    return self;
}

@end
