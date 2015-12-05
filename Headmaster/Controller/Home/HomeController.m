//
//  HomeController.m
//  Headmaster
//
//  Created by 大威 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeController.h"
#import "HomeTopView.h"
#import "HomeEvaluateView.h"
#import "HomeSeeTimeView.h"
#import "HomeDataListController.h"
#import "DataDatilViewController.h"
#import "HomeViewModel.h"
#import "RESideMenu.h"

@interface HomeController ()

@property (nonatomic, strong) HomeTopView *topView;

@property (nonatomic, strong) UIButton *moreButton;

@property (nonatomic, strong) HomeEvaluateView *evaluateView;

@property (nonatomic, strong) HomeSeeTimeView *seeTimeView;

@property (nonatomic, strong) HomeViewModel *viewModel;

@end

@implementation HomeController

- (void)viewWillAppear:(BOOL)animated
{
    // 显示下面的导航栏
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = CGRectMake(0, 0, self.view.width, self.view.height - 64 - 49);
    
    [self.view addSubview:self.topView];
    
    // 添加button上面一条线
    UIView *lineTopView = [[UIView alloc] initWithFrame:CGRectMake(7.5, 0, self.view.bounds.size.width - 15, 2)];
    lineTopView.backgroundColor = [UIColor colorWithHexString:@"2a2a2a"];
    // 添加button下面一条线
    UIView *lineDownView = [[UIView alloc] initWithFrame:CGRectMake(7.5, 62, self.view.bounds.size.width - 15, 2)];
    lineDownView.backgroundColor = [UIColor colorWithHexString:@"2a2a2a"];
    
    [self.view addSubview:lineTopView];
    [self.view addSubview:lineDownView];
    [self.view addSubview:lineDownView];
    [self.view addSubview:lineTopView];

    // Do any additional setup after loading the view.
    [self addBackgroundImage];
    
    [self.view addSubview:self.moreButton];
    [self.view addSubview:self.evaluateView];
    [self.view addSubview:self.seeTimeView];
    
    [self.evaluateView itemClick:^(UIButton *button) {
        
        NSLog(@"seeTimeView == %li",button.tag);
    }];
    
    [self.seeTimeView itemClick:^(UIButton *button) {
        
        self.tag = button.tag;
        if (button.tag == 2) {
            _viewModel.searchType = kDateSearchTypeWeek;
            [_viewModel networkRequestRefresh];
            
        }else {
            if(button.tag == 1) {
                _viewModel.searchType = kDateSearchTypeToday;
            }else if(button.tag == 2) {
                _viewModel.searchType = kDateSearchTypeYesterday;
            }
            [_viewModel networkRequestRefresh];
        }
    }];
    
    _viewModel = [HomeViewModel new];
    // 刷新数据
    [_viewModel successRefreshBlock:^{
        
        if (_viewModel.searchType == kDateSearchTypeWeek) {
            
            [self.evaluateView refreshData:_viewModel.evaluateArray];
        }else {
            [self.topView refreshSubjectData:_viewModel.subjectArray sameDay:_viewModel.applyCount];
            [self.evaluateView refreshData:_viewModel.evaluateArray];
        }
    }];
    _viewModel.searchType = 1;
    [_viewModel networkRequestRefresh];
}

#pragma mark - action
#pragma mark 更多按钮
- (void)moreButtonAction {
    
    DataDatilViewController *dataListVC = [[DataDatilViewController alloc] init];
    
        dataListVC.tag = _tag;
    
    [self.navigationController pushViewController:dataListVC animated:YES];
}

#pragma mark 打开侧栏
- (void)openSideMenu {
    
    [self.sideMenuViewController presentLeftMenuViewController];
}

#pragma mark - lazy load

- (HomeTopView *)topView {
    if (!_topView) {
        _topView = [HomeTopView new];
        _topView.frame = CGRectMake(0, 0, self.view.width, 60);
//        _topView.backgroundColor = [UIColor redColor];
    }
    return _topView;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [UIButton new];
        _moreButton.frame = CGRectMake(0, 0, 150, 150);
        [_moreButton.layer setMasksToBounds:YES];
        [_moreButton.layer setCornerRadius:75];
        _moreButton.center = CGPointMake(self.view.centerX, self.view.centerY);
        _moreButton.backgroundColor = [UIColor redColor];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:64];
        [_moreButton setTitle:@"69%" forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(moreButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

- (HomeEvaluateView *)evaluateView {
    if (!_evaluateView) {
        _evaluateView = [HomeEvaluateView new];
//        _evaluateView.backgroundColor = [UIColor redColor];
        _evaluateView.frame = CGRectMake(40,
                                         self.seeTimeView.top - self.seeTimeView.height - 20,
                                         self.view.width - 80,
                                         60);
    }
    return _evaluateView;
}

- (HomeSeeTimeView *)seeTimeView {
    if (!_seeTimeView) {
        _seeTimeView = [HomeSeeTimeView new];
        _seeTimeView.frame = CGRectMake(40,
                                        self.view.height - 70,
                                        self.view.width - 80,
                                        50);
//        _seeTimeView.backgroundColor = [UIColor orangeColor];
    }
    return _seeTimeView;
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
