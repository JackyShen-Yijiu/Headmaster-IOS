//
//  HomeDataDetailViewModel.h
//  Headmaster
//
//  Created by 大威 on 15/12/12.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "YBBaseViewModel.h"
#import "HomeDetailTableViewDataModel.h"

@interface HomeDataDetailViewModel : YBBaseViewModel

@property (nonatomic, assign) kDateSearchType searchType;

@property (atomic, strong) HomeDetailTableViewDataModel *dataModel;

@end
