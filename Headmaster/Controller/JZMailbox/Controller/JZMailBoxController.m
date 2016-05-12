//
//  JZMailBoxController.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/10.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZMailBoxController.h"
#import "JZMailBoxView.h"
#import "JZMailBoxHeaderView.h"
#import "JZPublishHistoryController.h"

@interface JZMailBoxController ()
@property (nonatomic, strong) JZMailBoxView *mailboxView;
@property (nonatomic, strong) JZMailBoxHeaderView *headerView;

@end

@implementation JZMailBoxController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.myNavigationItem.title = @"信箱";
    [MobClick beginLogPageView:NSStringFromClass([self class])];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = JZ_MAIN_BACKGROUND_COLOR;
    self.headerView = [[JZMailBoxHeaderView alloc]initWithFrame:CGRectMake(0, 0, kJZWidth, 48)];
    
    [self.headerView setBadge:10];
    
    UITapGestureRecognizer *tapGestureTel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerViewClick:)];
    self.headerView.userInteractionEnabled = YES;
    [self.headerView addGestureRecognizer:tapGestureTel];
    
    
    self.mailboxView = [[JZMailBoxView alloc]initWithFrame:CGRectMake(0, 48, kJZWidth, kJZHeight-48-64) style:UITableViewStyleGrouped];
    self.mailboxView.vc = self;
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.mailboxView];

    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
    [NetworkTool cancelAllRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
}
#pragma mark - headerView点击事件
-(void)headerViewClick:(UITapGestureRecognizer *)recognizer {
    
    JZPublishHistoryController *publishVC = [[JZPublishHistoryController alloc]init];
    
    [self.myNavController pushViewController:publishVC animated:YES];
    
    
}






@end
