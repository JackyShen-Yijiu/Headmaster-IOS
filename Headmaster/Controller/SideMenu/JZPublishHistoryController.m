//
//  JZPublishHistoryController.m
//  Headmaster
//
//  Created by 雷凯 on 16/4/18.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZPublishHistoryController.h"

@interface JZPublishHistoryController ()
@property (nonatomic, strong) UIBarButtonItem *pushBtn;

@end

@implementation JZPublishHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationItem.title = @"历史公告";
    
    self.navigationItem.leftBarButtonItem = self.pushBtn;
    
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

#pragma mark - 顶部左侧按钮事件
- (void)pushBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
    
    
     }


@end
