//
//  JZComplaintListController.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZComplaintListController.h"
#import "JZComplaintListView.h"

@interface JZComplaintListController ()
@property (nonatomic, weak) JZComplaintListView *listView;
@property (nonatomic, strong) UIBarButtonItem *pushBtn;



@end

@implementation JZComplaintListController

- (void)viewDidLoad {
    [super viewDidLoad];
    JZComplaintListView *listView = [[JZComplaintListView alloc]initWithFrame:CGRectMake(0, 0, kJZWidth, kJZHeight-64)];
    
    listView.vc = self;
    self.listView = listView;
    
    self.listView.vc = self;
    
    [self.view addSubview:listView];


    CGRect backframe= CGRectMake(0, 0, 16, 16);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pushBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
}

- (void)pushBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIBarButtonItem *)pushBtn {
    if (!_pushBtn) {
        CGRect backframe= CGRectMake(0, 0, 16, 16);
        UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = backframe;
        [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(pushBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _pushBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    return _pushBtn;
}

@end
