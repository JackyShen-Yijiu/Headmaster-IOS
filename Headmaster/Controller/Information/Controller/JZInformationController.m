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
#import "JZInformationData.h"
#import <YYModel.h>

@interface JZInformationController ()
@property (nonatomic, weak) JZInformationListView *listView;
@property (nonatomic, weak) JZInformationTopView *topView;
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
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor cyanColor];
    
    JZInformationTopView *topView = [[JZInformationTopView alloc]initWithFrame:CGRectMake(0, 0, kJZWidth, 160)];
    
    
    
    self.topView = topView;
    
    [self.view addSubview:topView];
    
    JZInformationListView *listView = [[JZInformationListView alloc] initWithFrame:CGRectMake(0, 160, kJZWidth, kJZHeight - 160) style:UITableViewStylePlain];
    
    
    self.listView = listView;
    
    [self.view addSubview:listView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
