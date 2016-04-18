//
//  YBBaseTableController.h
//  Headmaster
//
//  Created by 大威 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "YBBaseController.h"

@interface YBBaseTableController : YBBaseController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end
