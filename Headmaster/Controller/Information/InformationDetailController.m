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

@end

@implementation InformationDetailController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
    self.myNavigationItem.title = _navTitle;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
