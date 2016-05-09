//
//  JZInformationController.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/6.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZInformationController.h"
#import "JZInformationListView.h"
#import "JZInformationTopView.h"
@interface JZInformationController ()
@property (nonatomic, weak) JZInformationListView *listView;
@property (nonatomic, strong) NSMutableArray *listDataArray;


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

    
    
    JZInformationListView *listView = [[JZInformationListView alloc] initWithFrame:CGRectMake(0, 0, kJZWidth, kJZHeight -  64) style:UITableViewStylePlain];
    
    
    self.listView = listView;
    
    self.listView.tableHeaderView = [[JZInformationTopView alloc]initWithFrame:CGRectMake(0, 0,kJZWidth, 160)];

    
    [self.view addSubview:listView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
