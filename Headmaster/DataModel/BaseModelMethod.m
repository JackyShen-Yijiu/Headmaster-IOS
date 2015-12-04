//
//  BaseModelMethod.m
//  JewelryApp
//
//  Created by kequ on 15/5/17.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import "BaseModelMethod.h"
#import "TeacherModel.h"
#import "HMRecomendModel.h"
#import "PublishDataModel.h"

@implementation BaseModelMethod

+ (NSArray *)getTeacherListArrayFormDicInfo:(NSArray *)array
{
  
    if (![array isKindOfClass:[NSArray class]] || !array.count) {
        return nil;
    }
    NSMutableArray * oArray = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary * info in array) {
        TeacherModel * courseModel = [TeacherModel converJsonDicToModel:info];
        if (courseModel) {
            [oArray addObject:courseModel];
        }
    }
    return [oArray copy];
}

+ (NSArray *)getRecomendListArrayFormDicInfo:(NSArray *)array
{
    if (![array isKindOfClass:[NSArray class]] || !array.count) {
        return nil;
    }
    NSMutableArray * oArray = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary * info in array) {
        HMRecomendModel * courseModel = [HMRecomendModel converJsonDicToModel:info];
        if (courseModel) {
            [oArray addObject:courseModel];
        }
    }
    return [oArray copy];
}

+ (NSArray *)getPublishListArrayFormDicInfo:(NSArray *)array {
    if (![array isKindOfClass:[NSArray class]] || !array.count) {
        return nil;
    }
    NSMutableArray * oArray = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary * info in array) {
        PublishDataModel * courseModel = [PublishDataModel converJsonDicToModel:info];
        if (courseModel) {
            [oArray addObject:courseModel];
        }
    }
    return [oArray copy];
}

@end
