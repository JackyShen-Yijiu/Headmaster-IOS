//
//  JZPublishController.m
//  Headmaster
//
//  Created by 雷凯 on 16/4/18.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZPublishController.h"
#import "JZPublishHistoryController.h"
#define kLKSize [UIScreen mainScreen].bounds.size
@interface JZPublishController ()
@property (nonatomic, strong) UIBarButtonItem    *pushBtn;
@property (nonatomic, strong) UIBarButtonItem    *publishHistoryBtn;
@end

@implementation JZPublishController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发布公告";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"历史公告" style:UIBarButtonItemStyleDone target:self action:@selector(publishHistoryBtnClick)];
    
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.navigationItem.rightBarButtonItem
     setTitleTextAttributes:[NSDictionary
                             dictionaryWithObjectsAndKeys:[UIFont
                                                           boldSystemFontOfSize:14], NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = self.pushBtn;
    


    self.view.backgroundColor = [UIColor cyanColor];
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
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 顶部右侧跳转到历史公告按钮点击事件
-(void)publishHistoryBtnClick {
    
    JZPublishHistoryController *historyVC = [[JZPublishHistoryController alloc]init];
    
    [self.navigationController pushViewController:historyVC animated:YES];
    
}
@end
