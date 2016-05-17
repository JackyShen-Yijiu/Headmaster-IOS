//
//  JZComplaintListView.h
//  Headmaster
//
//  Created by 雷凯 on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshTableView.h"

@interface JZComplaintListView : RefreshTableView
@property (nonatomic, strong) UIViewController *vc;
@property (nonatomic, assign) NSInteger messageCount;
@end
