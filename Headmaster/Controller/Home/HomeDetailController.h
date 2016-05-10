//
//  HomeDetailController.h
//  Headmaster
//
//  Created by 大威 on 15/12/9.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "YBBaseController.h"

@class HomeViewModel;

@interface HomeDetailController : YBBaseController

@property (nonatomic,assign) kDateSearchType searchType;

@property (nonatomic, assign) BOOL isFormSideMenu;

@property (nonatomic, strong) HomeViewModel *viewModel;

@end
