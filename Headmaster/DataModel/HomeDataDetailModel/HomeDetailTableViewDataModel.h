//
//  HomeDetailTableViewDataModel.h
//  Headmaster
//
//  Created by 大威 on 15/12/11.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeDataDetailDMRootClass.h"
#import "DataDetailDMWeekRootClass.h"
#import "DataDetailDMMonthRootClass.h"
#import "DataDetailDMYearRootClass.h"

@interface HomeDetailTableViewDataModel : NSObject

@property (nonatomic, strong) NSString * msg;
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSUInteger appleStudentCount;
@property (nonatomic, strong) NSArray *applyXTitleArray;
@property (nonatomic, strong) NSArray *applyValueArray;

@property (nonatomic, assign) NSUInteger reservationStudentCount;
@property (nonatomic, strong) NSArray *reservationXTitleArray;// X轴
@property (nonatomic, strong) NSArray *reservationValueArray;// values 点

@property (nonatomic, strong) NSArray *coachCourseXTitleArray;
@property (nonatomic, strong) NSArray *coachCourseValueArray;

@property (nonatomic, strong) NSArray *evaluateXTitleArray;
@property (nonatomic, strong) NSArray *goodValueArray;
@property (nonatomic, strong) NSArray *badValueArray;
@property (nonatomic, strong) NSArray *generalValueArray;
@property (nonatomic, strong) NSArray *complaintValueArray;

- (instancetype)initWithHomeDataDetailDMRootClass:(HomeDataDetailDMRootClass *)detailRootClass
                                      searchType:(NSInteger)searchType;

- (instancetype)initWithDataDetailDMWeekRootClass:(DataDetailDMWeekRootClass *)detailRootClass
                                       searchType:(NSInteger)searchType;

- (instancetype)initWithDataDetailDMMonthRootClass:(DataDetailDMMonthRootClass *)detailRootClass
                                       searchType:(NSInteger)searchType;

- (instancetype)initWithDataDetailDMYearRootClass:(DataDetailDMYearRootClass *)detailRootClass
                                       searchType:(NSInteger)searchType;

@end
