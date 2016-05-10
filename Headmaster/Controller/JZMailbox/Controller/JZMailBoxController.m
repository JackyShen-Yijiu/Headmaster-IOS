//
//  JZMailBoxController.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/10.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZMailBoxController.h"
#import "JZMailBoxView.h"

@interface JZMailBoxController ()
@property (nonatomic, strong) JZMailBoxView *mailboxView;

@end

@implementation JZMailBoxController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.myNavigationItem.title = @"信箱";
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
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.mailboxView = [[JZMailBoxView alloc]initWithFrame:CGRectMake(0, 0, kJZWidth, kJZHeight) style:UITableViewStyleGrouped];
    
    [self.view addSubview:self.mailboxView];
    
   
}






@end
