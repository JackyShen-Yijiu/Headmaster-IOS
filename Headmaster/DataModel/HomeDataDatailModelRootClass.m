//
//  HomeDataDatailModelRootClass.m
//  Headmaster
//
//  Created by ytzhang on 15/12/6.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeDataDatailModelRootClass.h"

#import "ApplyStuentListModel.h"
#import "ReservationStudentListModel.h"
#import "CoachCourseListModel.h"
#import "GoodCommentListModel.h"
#import "BadCommentListModel.h"
#import "GeneralCommentListModel.h"
#import "ComplaintListModel.h"

@implementation HomeDataDatailModelRootClass
- (instancetype)initWithJsonDict:(id)dictionary
{
    self = [super init];
    if (self)
    {
        NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:dictionary];
        NSDictionary *resultDict = [dict objectForKey:@"data"];
        
        
        _applyStudentArray = [NSMutableArray array];
        _reservationStudentCountArray = [NSMutableArray array];
        _cocoachCoureArray = [NSMutableArray array];
        _goodCommentArray = [NSMutableArray array];
        _badCommentArray = [NSMutableArray array];
        _generalCommentArray = [NSMutableArray array];
        _complaintArray = [NSMutableArray array];
        

        NSArray *keyArray = [resultDict allKeys];
        for (NSString *key in keyArray)
        {
            if ([key isEqualToString:@"applystuentlist"])
            {
                NSArray *array = [resultDict objectForKey:key];
                for (NSDictionary *dic in array)
                {
                    ApplyStuentListModel *applyStuentListModel = [[ApplyStuentListModel alloc] init];
                    [applyStuentListModel setValuesForKeysWithDictionary:dic];
                    [_applyStudentArray addObject:applyStuentListModel];
                }
                
            }else if ([key isEqualToString:@"reservationstudentlist"])
            {
                NSArray *array = [resultDict objectForKey:key];
                for (NSDictionary *dic in array)
                {
                    ReservationStudentListModel *applyStuentListModel = [[ReservationStudentListModel alloc] init];
                    [applyStuentListModel setValuesForKeysWithDictionary:dic];
                    [_reservationStudentCountArray addObject:applyStuentListModel];
                }

            }else if ([key isEqualToString:@"coachcourselist"])
            {
                NSArray *array = [resultDict objectForKey:key];
                for (NSDictionary *dic in array)
                {
                    CoachCourseListModel *applyStuentListModel = [[CoachCourseListModel alloc] init];
                    [applyStuentListModel setValuesForKeysWithDictionary:dic];
                    [_cocoachCoureArray addObject:applyStuentListModel];
                }

            }else if ([key isEqualToString:@"goodcommentlist"])
            {
                NSArray *array = [resultDict objectForKey:key];
                for (NSDictionary *dic in array)
                {
                    GoodCommentListModel *applyStuentListModel = [[GoodCommentListModel alloc] init];
                    [applyStuentListModel setValuesForKeysWithDictionary:dic];
                    [_goodCommentArray addObject:applyStuentListModel];
                }
 
            }else if ([key isEqualToString:@"badcommentlist"])
            {
                NSArray *array = [resultDict objectForKey:key];
                for (NSDictionary *dic in array)
                {
                    BadCommentListModel *applyStuentListModel = [[BadCommentListModel alloc] init];
                    [applyStuentListModel setValuesForKeysWithDictionary:dic];
                    [_badCommentArray addObject:applyStuentListModel];
                }
 
            }else if ([key isEqualToString:@"generalcommentlist"])
            {
                NSArray *array = [resultDict objectForKey:key];
                for (NSDictionary *dic in array)
                {
                    GeneralCommentListModel *applyStuentListModel = [[GeneralCommentListModel alloc] init];
                    [applyStuentListModel setValuesForKeysWithDictionary:dic];
                    [_generalCommentArray addObject:applyStuentListModel];
                }

            }else if ([key isEqualToString:@"complaintlist"])
            {
                NSArray *array = [resultDict objectForKey:key];
                for (NSDictionary *dic in array)
                {
                    ComplaintListModel *applyStuentListModel = [[ComplaintListModel alloc] init];
                    [applyStuentListModel setValuesForKeysWithDictionary:dic];
                    [_complaintArray addObject:applyStuentListModel];
                }

            }
        }
    }
        return self;
}

@end
