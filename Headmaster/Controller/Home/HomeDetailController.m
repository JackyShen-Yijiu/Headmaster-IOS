//
//  HomeDetailController.m
//  Headmaster
//
//  Created by 大威 on 15/12/9.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeDetailController.h"
#import "HomeDetailTableView.h"
#import "TopButtonView.h"
#import "CoachOfCoureDetailController.h"
#import "RecommendViewController.h"
#import "DataDatilViewModel.h"
#import "HomeViewModel.h"

#define topLabelH 40

#define topButtonH 30

@interface HomeDetailController ()<UIScrollViewDelegate>

@property (nonatomic, strong) HomeDetailTableView *weekTableView;
@property (nonatomic, strong) HomeDetailTableView *monthTableView;
@property (nonatomic, strong) HomeDetailTableView *yearTableView;

@property (nonatomic, strong) UIBarButtonItem *pushBtn;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) TopButtonView *topButtonView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HomeDetailController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
    if (_isFormSideMenu) {
        self.navigationItem.leftBarButtonItem = self.pushBtn;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBackgroundImage];
    self.view.backgroundColor = RGB_Color(247, 247, 247);
    
    [self.view addSubview:self.titleLabel];
    
    [self.view addSubview:self.topButtonView];

    [self.view addSubview:self.scrollView];

    [self.scrollView addSubview:self.weekTableView];
    [self.scrollView addSubview:self.monthTableView];
    [self.scrollView addSubview:self.yearTableView];
    
    WS(ws)
    self.topButtonView.didClick = ^(UIButton *btn){
        // 设置title的显示内容
        NSString *titleName = @"";
        CGFloat contentOffsetX;
        CGFloat width = ws.view.bounds.size.width;
       
        if(btn.tag == 101){
            titleName = @"本周";
            contentOffsetX = 0;
        }else if(btn.tag == 102){
            titleName = @"本月";
            contentOffsetX = width;
        }else if(btn.tag == 103){
            titleName = @"本年";
            contentOffsetX = width * 2;
        }
        ws.myNavigationItem.title = [NSString stringWithFormat:@"%@数据",titleName];
        
        [UIView animateWithDuration:0.5 animations:^{
            ws.scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        }];

//        [ws loadNetworkData];

    };
    
    // 检查是否需要先显示昨天或本周数据
    [self checkSearchType];
    
    [self setCellCallBack];

}

- (void)pushBtnClick {
   [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 点击进入详情的回调
- (void)setCellCallBack {
    
    WS(ws)
    // 周
    [self.weekTableView setCoachTeacherClickBlock:^(NSInteger tag) {
        [ws openController:kDateSearchTypeWeek isCoachTeacher:YES];
    }];
    [self.weekTableView setEvaluationClickBlock:^(NSInteger tag) {
        [ws openController:kDateSearchTypeWeek isCoachTeacher:NO];
    }];
    // 月
    [self.monthTableView setCoachTeacherClickBlock:^(NSInteger tag) {
        [ws openController:kDateSearchTypeMonth isCoachTeacher:YES];
    }];
    [self.monthTableView setEvaluationClickBlock:^(NSInteger tag) {
        [ws openController:kDateSearchTypeMonth isCoachTeacher:NO];
    }];
    // 年
    [self.yearTableView setCoachTeacherClickBlock:^(NSInteger tag) {
        [ws openController:kDateSearchTypeYear isCoachTeacher:YES];
    }];
    [self.yearTableView setEvaluationClickBlock:^(NSInteger tag) {
        [ws openController:kDateSearchTypeYear isCoachTeacher:NO];
    }];
}

- (void)openController:(kDateSearchType)searchType isCoachTeacher:(BOOL)isCoachTeacher {
    if (isCoachTeacher) {
        CoachOfCoureDetailController *coachDetailVC = [CoachOfCoureDetailController new];
        coachDetailVC.searchType = searchType;
        coachDetailVC.isFormMenu = _isFormSideMenu;
        [self.navigationController pushViewController:coachDetailVC animated:YES];
    }else {
        RecommendViewController *recommendVC = [RecommendViewController new];
        recommendVC.searchType = searchType;
        recommendVC.isFormSideMenu = _isFormSideMenu;
        [self.navigationController pushViewController:recommendVC animated:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSArray *titleArray = @[@"本周数据", @"本月数据", @"本年数据" ];
    NSInteger showIndex = scrollView.contentOffset.x / self.view.bounds.size.width;
    self.myNavigationItem.title = titleArray[showIndex];
    [self.topButtonView selectedItem:[[NSString stringWithFormat:@"10%li",showIndex] integerValue] + 1];
    
    [self loadNetworkData];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self loadNetworkData];
}

- (void)loadNetworkData {
    
    CGFloat offSetX = self.scrollView.contentOffset.x;
    CGFloat width = self.scrollView.width;
    
    NSInteger page = offSetX / width;
    
    if (page==0) {
        [self.weekTableView networkRequest];
    }else if (page==1) {
        [self.monthTableView networkRequest];
    }else if (page==2) {
        [self.yearTableView networkRequest];
    }
    
}

- (void)checkSearchType {
  
    if(self.searchType == kDateSearchTypeWeek) {
        [self.topButtonView selectedItem:101];
        self.scrollView.contentOffset = CGPointMake(0, 0);
        self.myNavigationItem.title = @"本周数据";
        [self.weekTableView networkRequest];
    }
    if(self.searchType == kDateSearchTypeMonth) {
        [self.topButtonView selectedItem:102];
        self.scrollView.contentOffset = CGPointMake(self.view.bounds.size.width, 0);
        self.myNavigationItem.title = @"本月数据";
        [self.monthTableView networkRequest];
    }
    if(self.searchType == kDateSearchTypeYear) {
        [self.topButtonView selectedItem:103];
        self.scrollView.contentOffset = CGPointMake(self.view.bounds.size.width * 2, 0);
        self.myNavigationItem.title = @"本年数据";
        [self.yearTableView networkRequest];
    }
    
}

- (HomeDetailTableView *)weekTableView {
    if (!_weekTableView) {
        _weekTableView = [[HomeDetailTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.scrollView.bounds.size.height) style:UITableViewStylePlain];
        _weekTableView.searchType = kDateSearchTypeWeek;
        _weekTableView.contentSize = CGSizeMake(self.view.bounds.size.width, self.scrollView.bounds.size.height);
        _weekTableView.contentInset = UIEdgeInsetsMake(0, 0, 105, 0);
        _weekTableView.homeViewModel = _viewModel;
    }
    return _weekTableView;
}

- (HomeDetailTableView *)monthTableView {
    if (!_monthTableView) {
        _monthTableView = [[HomeDetailTableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.scrollView.bounds.size.height) style:UITableViewStylePlain];
        _monthTableView.searchType = kDateSearchTypeMonth;
        _monthTableView.contentSize = CGSizeMake(self.view.bounds.size.width, self.scrollView.bounds.size.height);
        _monthTableView.contentInset = UIEdgeInsetsMake(0, 0, 105, 0);
        _monthTableView.homeViewModel = _viewModel;
    }
    return _monthTableView;
}

- (HomeDetailTableView *)yearTableView {
    if (!_yearTableView) {
        _yearTableView = [[HomeDetailTableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 2, 0, self.view.bounds.size.width, self.scrollView.bounds.size.height) style:UITableViewStylePlain];
        _yearTableView.searchType = kDateSearchTypeYear;
        _yearTableView.contentSize = CGSizeMake(self.view.bounds.size.width, self.scrollView.bounds.size.height);
        _yearTableView.contentInset = UIEdgeInsetsMake(0, 0, 105, 0);
        _yearTableView.homeViewModel = _viewModel;
    }
    return _yearTableView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.frame = CGRectMake(0, topLabelH + topButtonH + 10, self.view.bounds.size.width, self.view.bounds.size.height - self.topButtonView.bounds.size.height - self.titleLabel.frame.size.height - 10);
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = RGB_Color(247, 247, 247);
    }
    return _scrollView;
}

- (TopButtonView *)topButtonView {
    if (!_topButtonView) {
        _topButtonView = [[TopButtonView alloc] initWithFrame:CGRectMake(80, topLabelH + 10, self.view.bounds.size.width - 160, topButtonH)];
        _topButtonView.layer.masksToBounds = YES;
        _topButtonView.layer.cornerRadius = 3;
    }
    return _topButtonView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, topLabelH)];
        _titleLabel.textAlignment = 1;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        if (YBIphone6Plus) {
            _titleLabel.font = [UIFont systemFontOfSize:14*YBRatio];
        }
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = [NSString stringWithFormat:@"今日报名%@人",_viewModel.applyCount];
    }
    return _titleLabel;
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
