//
//  BaseModelMethod.h
//  JewelryApp
//
//  Created by kequ on 15/5/17.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModelMethod : NSObject
+ (NSArray *)getTeacherListArrayFormDicInfo:(NSArray *)array;
+ (NSArray *)getRecomendListArrayFormDicInfo:(NSArray *)array;
+ (NSArray *)getComplainListArrayFormDicInfo:(NSArray *)array;
+ (NSArray *)getPublishListArrayFormDicInfo:(NSArray *)array;

@end
