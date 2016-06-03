//
//  InformationDetailController.m
//  Headmaster
//
//  Created by 胡东苑 on 15/12/3.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "InformationDetailController.h"
#import "YBBaseViewModel.h"

#define h_size [UIScreen mainScreen].bounds.size

@interface InformationDetailController () <UIWebViewDelegate> {
    UIWebView *_webView;
}
@property (nonatomic, strong) UIBarButtonItem *pushBtn;

@end

@implementation InformationDetailController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
    self.title = _navTitle;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
    [NetworkTool cancelAllRequest];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.pushBtn;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, h_size.width, h_size.height -64)];
    _webView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[YBBaseViewModel new] errorLoadMoreBlock:^{
        NSLog(@"加载失败");
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[YBBaseViewModel new] successLoadMoreBlock:^{
        NSLog(@"加载成功");
    }];
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
- (void)pushBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
