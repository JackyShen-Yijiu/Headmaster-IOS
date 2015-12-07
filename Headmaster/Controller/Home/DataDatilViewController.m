//
//  DataDatilViewController.m
//  DataDatiel
//
//  Created by ytzhang on 15/11/29.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "DataDatilViewController.h"

#import "CoachOfCoureDetailController.h"

#import "TopButtonView.h"

#import "TodayDataView.h"
#import "YearDataView.h"
#import "MonthViewData.h"
#import "YesterdayDataView.h"
#import "WeekDataView.h"

#import "DataDatilViewModel.h"


# define ksystemH [UIScreen mainScreen].bounds.size.height
# define ksystemW [UIScreen mainScreen].bounds.size.width

@interface DataDatilViewController () < UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) TodayDataView *todayDataView;
@property (nonatomic,strong) YesterdayDataView *yesterdayDataView;
@property (nonatomic,strong) WeekDataView *weekDataView;
@property (nonatomic,strong) MonthViewData *monthDataView;
@property (nonatomic,strong) YearDataView *yearDataView;
@property (nonatomic,strong) TopButtonView *topButtonView ;

@property (nonatomic,strong) DataDatilViewModel *dataDatilViewModel;
@end

@implementation DataDatilViewController
- (void)viewWillAppear:(BOOL)animated
{
    
    // 隐藏下面的导航栏
    self.tabBarController.tabBar.hidden = YES;
//    self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *strArray = [NSArray arrayWithObjects:@"今天数据",@"昨天数据",@"本周数据",@"本月数据",@"本年数据", nil];
       self.title = strArray[_tag - 101];
    
    
    // 加载数据
    _dataDatilViewModel = [[DataDatilViewModel alloc] init];
    [_dataDatilViewModel successRefreshBlock:^{
    
        NSLog(@"%@",_dataDatilViewModel.coachCoureX);
    }];
    [_dataDatilViewModel networkRequestRefreshWith:1];
    
    
    _todayDataView = self.todayDataView;
    _topButtonView = [[TopButtonView alloc] init];
    _topButtonView.frame = CGRectMake(25, 0 , self.view.frame.size.width -50, 36);
    _topButtonView.backgroundColor = [UIColor clearColor];
    [_topButtonView selectOneButton:_tag + 101];
    
     // 添加button上面一条线
    UIView *lineTopView = [[UIView alloc] initWithFrame:CGRectMake(7.5,0, self.view.frame.size.width - 15, 2)];
    lineTopView.backgroundColor = [UIColor colorWithHexString:@"2a2a2a"];

    
    // 添加button下面一条线
    UIView *lineDownView = [[UIView alloc] initWithFrame:CGRectMake(7.5, 38, self.view.frame.size.width - 15, 2)];
    lineDownView.backgroundColor = [UIColor colorWithHexString:@"2a2a2a"];
    
    // 添加背景图片
    UIImage *image = [UIImage imageNamed:@"controllerBackground"];
    self.view.layer.contents = (id)image.CGImage;

    
    
    [self.view addSubview:lineTopView];
    [self.view addSubview:lineDownView];
    [self.view addSubview:_topButtonView];
    
    // 点击button的回调
    __block DataDatilViewController *dataVC = self;
    _topButtonView.didClick = ^(UIButton *btn)
    {
        
         // 设置title的显示内容
        dataVC.title = strArray[btn.tag - 101];
        CGFloat contentOffsetX;
        CGFloat width = dataVC.view.frame.size.width;
        if (btn.tag == 101) {
            
            contentOffsetX = 0;
        }else if (btn.tag == 102){
            
            contentOffsetX = width;
        }else if (btn.tag == 103){
            
            contentOffsetX = width *2;
        }else if (btn.tag == 104){
            
            contentOffsetX = width *3;
        }else if (btn.tag == 105){
            
        contentOffsetX = width * 4;
        
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            
            dataVC.scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        }];

        
    
    };
    [self addScrollView];
    
    
    // 点击教练授课详情
    self.todayDataView.coacOfCourse.didClick = ^(UIButton *btn)
    {
        
        NSLog(@"我被回调了!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        CoachOfCoureDetailController *detailVC = [[CoachOfCoureDetailController alloc] init];
        [dataVC.navigationController pushViewController:detailVC animated:YES];
    };
    // 点击教练授课详情
    self.yesterdayDataView.coacOfCourse.didClick = ^(UIButton *btn)
    {
        CoachOfCoureDetailController *detailVC = [[CoachOfCoureDetailController alloc] init];
        [dataVC.navigationController pushViewController:detailVC animated:YES];
    };
    // 点击教练授课详情
    self.weekDataView.coacOfCourse.didClick = ^(UIButton *btn)
    {
        CoachOfCoureDetailController *detailVC = [[CoachOfCoureDetailController alloc] init];
        [dataVC.navigationController pushViewController:detailVC animated:YES];
    };
    // 点击教练授课详情
    self.monthDataView.coacOfCourse.didClick = ^(UIButton *btn)
    {
        CoachOfCoureDetailController *detailVC = [[CoachOfCoureDetailController alloc] init];
        [dataVC.navigationController pushViewController:detailVC animated:YES];
    };
    // 点击教练授课详情
    self.yearDataView.coacOfCourse.didClick = ^(UIButton *btn)
    {
        CoachOfCoureDetailController *detailVC = [[CoachOfCoureDetailController alloc] init];
        [dataVC.navigationController pushViewController:detailVC animated:YES];
    };

    
    // 点击评价详情
    self.todayDataView.judgeView.didClick = ^(UIButton *btn)
    {
        CoachOfCoureDetailController *detailVC = [[CoachOfCoureDetailController alloc] init];
        [dataVC.navigationController pushViewController:detailVC animated:YES];
    };
    self.yesterdayDataView.judgeView.didClick = ^(UIButton *btn)
    {
        CoachOfCoureDetailController *detailVC = [[CoachOfCoureDetailController alloc] init];
        [dataVC.navigationController pushViewController:detailVC animated:YES];
    };
    self.weekDataView.judgeView.didClick = ^(UIButton *btn)
    {
        CoachOfCoureDetailController *detailVC = [[CoachOfCoureDetailController alloc] init];
        [dataVC.navigationController pushViewController:detailVC animated:YES];
    };
    self.monthDataView.judgeView.didClick = ^(UIButton *btn)
    {
        CoachOfCoureDetailController *detailVC = [[CoachOfCoureDetailController alloc] init];
        [dataVC.navigationController pushViewController:detailVC animated:YES];
    };
    self.yearDataView.judgeView.didClick = ^(UIButton *btn)
    {
        CoachOfCoureDetailController *detailVC = [[CoachOfCoureDetailController alloc] init];
        [dataVC.navigationController pushViewController:detailVC animated:YES];
    };

    
}

- (void)addScrollView
{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _scrollView.frame = CGRectMake(0,38, ksystemW, ksystemH - 38);
//    _scrollView.backgroundColor = [UIColor orangeColor];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.contentSize = CGSizeMake(ksystemW * 5, 0);
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    if (_tag == 101) {
        [_scrollView addSubview:self.todayDataView];
    }else if(_tag == 102)
    {
        [_scrollView addSubview:self.yesterdayDataView];

    }else if (_tag == 103)
    
    {
      [_scrollView addSubview:self.weekDataView];
    }
}

#pragma mark - UIScrollViewDelegate method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGSize selfSize = self.view.frame.size;
    
    if (scrollView.contentOffset.x == 0) {
        
        [_topButtonView selectedItem:101];
    }
    if ( 0 < scrollView.contentOffset.x <= selfSize.width) {
        if (!_yesterdayDataView) {
            
            [_scrollView addSubview:self.yesterdayDataView];
        }if (scrollView.contentOffset.x == selfSize.width) {
            [_topButtonView selectedItem:102];
        }
    }
    if (selfSize.width < scrollView.contentOffset.x <= selfSize.width * 2) {
        
        if (!_weekDataView) {
            
            [_scrollView addSubview:self.weekDataView];
        }
        if (scrollView.contentOffset.x == selfSize.width * 2) {
            [_topButtonView selectedItem:103];
        }
    }
    if (selfSize.width * 2 < scrollView.contentOffset.x <= selfSize.width * 3) {
        if (!_monthDataView) {
            
            [_scrollView addSubview:self.monthDataView];
        }
        if (scrollView.contentOffset.x == selfSize.width * 3) {
            [_topButtonView selectedItem:104];
        }
    }
    if (selfSize.width * 3 < scrollView.contentOffset.x <= selfSize.width * 4) {
        if (!_yearDataView) {
            
            [_scrollView addSubview:self.yearDataView];
        }
        if (scrollView.contentOffset.x == selfSize.width * 4) {
             [_topButtonView selectedItem:105];
        }
    }

}

#pragma mark - LazyLoading method

- (TodayDataView *)todayDataView {
    
    if (!_todayDataView) {
        
        CGSize selfSize = self.view.frame.size;
        _todayDataView = [TodayDataView new];
        _todayDataView.frame = CGRectMake(0,0, selfSize.width, selfSize.height - 45);
        _todayDataView.backgroundColor = [UIColor clearColor];
        [_scrollView addSubview:_todayDataView];
    }
    return _todayDataView;
}

- (YesterdayDataView *)yesterdayDataView {
    
    if (!_yesterdayDataView) {
        CGSize selfSize = self.view.frame.size;
        _yesterdayDataView = [YesterdayDataView new];
        _yesterdayDataView.frame = CGRectMake(selfSize.width, 0, selfSize.width, selfSize.height - 45);
        _yesterdayDataView.backgroundColor = [UIColor clearColor];
        [_scrollView addSubview:_yesterdayDataView];
    }
    return _yesterdayDataView;
}

- (WeekDataView *)weekDataView {
    
    if (!_weekDataView) {
        
        CGSize selfSize = self.view.frame.size;
        _weekDataView = [WeekDataView new];
        _weekDataView.frame = CGRectMake(selfSize.width *2, 0, selfSize.width, selfSize.height - 45);
        _weekDataView.backgroundColor = [UIColor clearColor];
        [_scrollView addSubview:_weekDataView];
    }
    return _weekDataView;
}

- (MonthViewData *)monthDataView {
    
    if (!_monthDataView) {
        
        CGSize selfSize = self.view.frame.size;
        _monthDataView = [MonthViewData new];
        _monthDataView.frame = CGRectMake(selfSize.width * 3, 0, selfSize.width, selfSize.height - 38);
        _monthDataView.backgroundColor = [UIColor clearColor];

        [_scrollView addSubview:_monthDataView];
    }
    return _monthDataView;
}
- (YearDataView *)yearDataView {
    
    if (!_yearDataView) {
        // 加载数据
        _dataDatilViewModel = [[DataDatilViewModel alloc] init];
        [_dataDatilViewModel successRefreshBlock:^{
            NSLog(@"我被回调了");
            NSLog(@"%@",_dataDatilViewModel.coachCoureX);
            [_yesterdayDataView reloadData];
        }];
        [_dataDatilViewModel networkRequestRefreshWith:1];
        
        CGSize selfSize = self.view.frame.size;
        _yearDataView = [YearDataView new];
        _yearDataView.frame = CGRectMake(selfSize.width * 4, 0, selfSize.width, selfSize.height - 38);
        _yearDataView.backgroundColor = [UIColor clearColor];

        [_scrollView addSubview:_yearDataView];
    }
    return _yearDataView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
