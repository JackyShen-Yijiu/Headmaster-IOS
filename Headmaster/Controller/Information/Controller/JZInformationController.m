//
//  JZInformationController.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/6.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZInformationController.h"
#import "JZInformationListView.h"
#import "SDCycleScrollView.h"
#import "JZInformationData.h"

#import <YYModel.h>

@interface JZInformationController ()
@property (nonatomic, weak) JZInformationListView *listView;
@property (nonatomic, strong) NSMutableArray *imagesURLStrings;
@property (nonatomic, strong) NSMutableArray *titles;

@end

@implementation JZInformationController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.myNavigationItem.title = @"资讯";
    
    [MobClick beginLogPageView:NSStringFromClass([self class])];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
    [NetworkTool cancelAllRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

    // Do any additional setup after loading the view.

    JZInformationListView *listView = [[JZInformationListView alloc] initWithFrame:CGRectMake(0, 0, kJZWidth, kJZHeight - 64) style:UITableViewStylePlain];
    self.listView = listView;
    [self.view addSubview:listView];
    self.listView.vc = self;

    /*
     block监听点击方式
     
     cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
     NSLog(@">>>>>  %ld", (long)index);
     };
     
     */

    


    
}

@end
