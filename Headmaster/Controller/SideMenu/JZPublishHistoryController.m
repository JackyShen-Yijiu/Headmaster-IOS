//
//  JZPublishHistoryController.m
//  Headmaster
//
//  Created by 雷凯 on 16/4/18.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZPublishHistoryController.h"
#import "JZPublishHistoryView.h"
#define kLKSize [UIScreen mainScreen].bounds.size

@interface JZPublishHistoryController ()
@property (nonatomic, strong) UIBarButtonItem *pushBtn;
@property (nonatomic, weak) JZPublishHistoryView *historyView;
@end

@implementation JZPublishHistoryController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    [self addBackgroundImage];
    self.navigationItem.title = @"历史公告";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    self.navigationItem.leftBarButtonItem = self.pushBtn;
    
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kLKSize.width, 1)];
    topLine.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:topLine];
    
    
    JZPublishHistoryView *historyView = [[JZPublishHistoryView alloc]initWithFrame:CGRectMake(0, 1, kLKSize.width, kLKSize.height-65)];
    
    historyView.vc = self;
    self.historyView = historyView;
    
    [self.view addSubview:historyView];
    
    
    

    
    
    
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


#pragma mark - 背景图片
- (void)addBackgroundImage {
    
    UIImage *image = [UIImage imageNamed:@"controllerBackground"];
    self.view.layer.contents = (id)image.CGImage;
}
@end
