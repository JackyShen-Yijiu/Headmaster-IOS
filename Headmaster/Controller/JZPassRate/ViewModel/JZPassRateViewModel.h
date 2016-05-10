//
//  JZPassRateViewModel.h
//  Headmaster
//
//  Created by ytzhang on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBBaseViewModel.h"

@interface JZPassRateViewModel : YBBaseViewModel


@property (nonatomic, assign) kDateSearchSubjectID searchSubjectID;

@property (nonatomic, strong) NSMutableArray *subjectOneArray;

@property (nonatomic, strong) NSMutableArray *subjectTwoArray;

@property (nonatomic, strong) NSMutableArray *subjectThreeArray;

@property (nonatomic, strong) NSMutableArray *subjectFourArray;

@property (nonatomic, assign) NSInteger month;

@property (nonatomic, assign) NSInteger year;

@property (nonatomic, assign) NSInteger subjectOneIndex;
@property (nonatomic, assign) NSInteger subjectTwoIndex;
@property (nonatomic, assign) NSInteger subjectThreeIndex;
@property (nonatomic, assign) NSInteger subjectFourIndex;


@end

