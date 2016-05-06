//
//  HomeViewModel.h
//  Headmaster
//
//  Created by 大威 on 15/12/5.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "YBBaseViewModel.h"

@interface HomeViewModel : YBBaseViewModel

@property (nonatomic, assign) NSInteger searchType;

@property (nonatomic, strong) NSArray *subjectArray;

@property (nonatomic, strong) NSString *applyCount;

@property (nonatomic, strong) NSArray *evaluateArray;

//@property (nonatomic, strong) NSArray *progressArray;

// 漏课
@property (nonatomic, strong) NSArray * overstockstudent;

// 通过率
@property (nonatomic, strong) NSArray * passrate;

@end
