//
//  JZPublishHistoryView.h
//  Headmaster
//
//  Created by 雷凯 on 16/4/19.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshTableView.h"

@interface JZPublishHistoryView : RefreshTableView
@property (nonatomic, strong) UIViewController *vc;
@property (nonatomic, assign) NSInteger messageCount;
@end
