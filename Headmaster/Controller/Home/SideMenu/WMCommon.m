//
//  WMCommon.m
//  Headmaster
//
//  Created by ytzhang on 16/5/23.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "WMCommon.h"

@implementation WMCommon
+ (instancetype)getInstance{
    static WMCommon *common;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        common = [[WMCommon alloc] init];
    });
    return common;
}
@end
