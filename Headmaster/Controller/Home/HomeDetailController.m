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

@interface HomeDetailController ()<UIScrollViewDelegate>
@property (nonatomic, strong) HomeDetailTableView *todayTableView;
@property (nonatomic, strong) HomeDetailTableView *yesterdayTableView;
@property (nonatomic, strong) HomeDetailTableView *weekTableView;
@property (nonatomic, strong) HomeDetailTableView *monthTableView;
@property (nonatomic, strong) HomeDetailTableView *yearTableView;

@property (nonatomic, strong) UIBarButtonItem *pushBtn;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) TopButtonView *topButtonView;
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
    // Do any additional setup after loading the view.
    [self addBackgroundImage];
    
    self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64);
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.todayTableView];
    [self.scrollView addSubview:self.yesterdayTableView];
    [self.scrollView addSubview:self.weekTableView];
    [self.scrollView addSubview:self.monthTableView];
    [self.scrollView addSubview:self.yearTableView];
    
    // 添加button下面一条线
    UIView *lineDownView = [[UIView alloc] initWithFrame:CGRectMake(7.5, 39, self.view.frame.size.width - 15, 2)];
    lineDownView.backgroundColor = [UIColor colorWithHexString:@"2a2a2a"];
    [self.view addSubview:lineDownView];
    
    [self.view addSubview:self.topButtonView];
    
    // 添加button上面一条线
    UIView *lineTopView = [[UIView alloc] initWithFrame:CGRectMake(7.5,0, self.view.frame.size.width - 15, 2)];
    lineTopView.backgroundColor = [UIColor colorWithHexString:@"2a2a2a"];
    [self.view addSubview:lineTopView];
    
    WS(ws)
    self.topButtonView.didClick = ^(UIButton *btn){
        // 设置title的显示内容
        NSString *titleName = @"";
        CGFloat contentOffsetX;
        CGFloat width = ws.view.bounds.size.width;
        if (btn.tag == 101) {
            titleName = @"今天";
            contentOffsetX = 0;
        }else if(btn.tag == 102){
            titleName = @"昨天";
            contentOffsetX = width;
        }else if(btn.tag == 103){
            titleName = @"本周";
            contentOffsetX = width *2;
        }else if(btn.tag == 104){
            titleName = @"本月";
            contentOffsetX = width *3;
        }else if(btn.tag == 105){
            titleName = @"本年";
            contentOffsetX = width * 4;
        }
        ws.myNavigationItem.title = [NSString stringWithFormat:@"%@数据",titleName];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            ws.scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        }];
    };
    
    // 检查是否需要先显示昨天或本周数据
    [self checkSearchType];
    
    [self setCellCallBack];
//    self.scrollView.backgroundColor = [UIColor redColor];
//    self.todayTableView.backgroundColor = [UIColor orangeColor];
//    self.yesterdayTableView.backgroundColor = [UIColor cyanColor];
//    self.weekTableView.backgroundColor = [UIColor lightGrayColor];
//    self.monthTableView.backgroundColor = [UIColor orangeColor];
//    self.yearTableView.backgroundColor = [UIColor magentaColor];
    
}

//
- (void)pushBtnClick {
   [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 点击进入详情的回调
- (void)setCellCallBack {
    
    WS(ws)
    // 今天
    [self.todayTableView setCoachTeacherClickBlock:^(NSInteger tag) {
        [ws openController:kDateSearchTypeToday isCoachTeacher:YES];
    }];
    
    [self.todayTableView setEvaluationClickBlock:^(NSInteger tag) {
        [ws openController:kDateSearchTypeToday isCoachTeacher:NO];
    }];
    // 昨天
    [self.yesterdayTableView setCoachTeacherClickBlock:^(NSInteger tag) {
        [ws openController:kDateSearchTypeYesterday isCoachTeacher:YES];
    }];
    
    [self.yesterdayTableView setEvaluationClickBlock:^(NSInteger tag) {
        [ws openController:kDateSearchTypeYesterday isCoachTeacher:NO];
    }];
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
    
    NSArray *titleArray = @[ @"今天数据", @"昨天数据", @"本周数据", @"本月数据", @"本年数据" ];
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
    
    if (offSetX >= 0 && offSetX < self.scrollView.width) {
        [self.todayTableView networkRequest];
    }else if (offSetX >= width && offSetX < width * 2) {
        [self.yesterdayTableView networkRequest];
    }else if (offSetX >= width * 2 && offSetX < width * 3) {
        [self.weekTableView networkRequest];
    }else if (offSetX >= width * 3 && offSetX < width * 4) {
        [self.monthTableView networkRequest];
    }else if (offSetX >= width * 4) {
        [self.yearTableView networkRequest];
    }
}

- (void)checkSearchType {
    if (self.searchType == kDateSearchTypeYesterday) {
        [self.topButtonView selectedItem:102];
        self.scrollView.contentOffset = CGPointMake(self.view.bounds.size.width, 0);
        self.myNavigationItem.title = @"昨天数据";
        [self.yesterdayTableView networkRequest];
    }else if(self.searchType == kDateSearchTypeWeek) {
        [self.topButtonView selectedItem:103];
        self.scrollView.contentOffset = CGPointMake(self.view.bounds.size.width * 2, 0);
        self.myNavigationItem.title = @"本周数据";
        [self.weekTableView networkRequest];
    }else if(self.searchType == kDateSearchTypeToday) {
        self.myNavigationItem.title = @"今天数据";
        [self.todayTableView networkRequest];
    }
}

- (HomeDetailTableView *)todayTableView {
    if (!_todayTableView) {
        _todayTableView = [[HomeDetailTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.scrollView.bounds.size.height) style:UITableViewStylePlain];
        _todayTableView.searchType = kDateSearchTypeToday;
    }
    return _todayTableView;
}

- (HomeDetailTableView *)yesterdayTableView {
    if (!_yesterdayTableView) {
        _yesterdayTableView = [[HomeDetailTableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 1, 0, self.view.bounds.size.width, self.scrollView.bounds.size.height) style:UITableViewStylePlain];
        _yesterdayTableView.searchType = kDateSearchTypeYesterday;
    }
    return _yesterdayTableView;
}

- (HomeDetailTableView *)weekTableView {
    if (!_weekTableView) {
        _weekTableView = [[HomeDetailTableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 2, 0, self.view.bounds.size.width, self.scrollView.bounds.size.height) style:UITableViewStylePlain];
        _weekTableView.searchType = kDateSearchTypeWeek;
    }
    return _weekTableView;
}

- (HomeDetailTableView *)monthTableView {
    if (!_monthTableView) {
        _monthTableView = [[HomeDetailTableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 3, 0, self.view.bounds.size.width, self.scrollView.bounds.size.height) style:UITableViewStylePlain];
        _monthTableView.searchType = kDateSearchTypeMonth;
    }
    return _monthTableView;
}

- (HomeDetailTableView *)yearTableView {
    if (!_yearTableView) {
        _yearTableView = [[HomeDetailTableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 4, 0, self.view.bounds.size.width, self.scrollView.bounds.size.height) style:UITableViewStylePlain];
        _yearTableView.searchType = kDateSearchTypeYear;
    }
    return _yearTableView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.frame = CGRectMake(0, self.topButtonView.bounds.size.height + 25, self.view.bounds.size.width, self.view.bounds.size.height - self.topButtonView.bounds.size.height - 25);
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 5, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (TopButtonView *)topButtonView {
    if (!_topButtonView) {
        _topButtonView = [[TopButtonView alloc] init];
        _topButtonView.frame = CGRectMake(25, 0, self.view.bounds.size.width -50, 36);
        _topButtonView.backgroundColor = [UIColor clearColor];
    }
    return _topButtonView;
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
