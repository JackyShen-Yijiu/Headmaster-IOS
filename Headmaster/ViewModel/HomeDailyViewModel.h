//
//  HomeDailyViewModel.h
//  Headmaster
//
//  Created by 大威 on 15/12/5.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "YBBaseViewModel.h"

@interface HomeDailyViewModel : YBBaseViewModel

@property (nonatomic, assign) NSInteger searchType;

@property (nonatomic, strong) NSMutableArray *topViewDataArray;

@property (nonatomic, strong) NSMutableArray *evaluateArray;

@end
