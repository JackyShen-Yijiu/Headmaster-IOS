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


# define ksystemH [UIScreen mainScreen].bounds.size.height
# define ksystemW [UIScreen mainScreen].bounds.size.width

@interface DataDatilViewController () < UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) TodayDataView *todayDataView;
@property (nonatomic,strong) YesterdayDataView *yesterdayDataView;
@property (nonatomic,strong) WeekDataView *weekDataView;
@property (nonatomic,strong) MonthViewData *monthDataView;
@property (nonatomic,strong) YearDataView *yearDataView;
@property  (nonatomic,strong) TopButtonView *topButtonView ;
@end

@implementation DataDatilViewController
- (void)viewWillAppear:(BOOL)animated
{
    // 隐藏下面的导航栏
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage*img =[UIImage imageNamed:@"bgg.png"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:img]];
    // 隐藏导航栏下面的线
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    self.title = @"改变";
    _topButtonView = [[TopButtonView alloc] init];
    _topButtonView.frame = CGRectMake(25, 66 , self.view.frame.size.width -50, 36);
    // 设置topButtonView的圆角
//    topButtonView.layer.masksToBounds = YES;
//    topButtonView.layer.cornerRadius = 6.0;
//    topButtonView.layer.borderWidth = 1.0;
//    topButtonView.layer.borderColor = [[UIColor grayColor] CGColor];
//    topButtonView.backgroundColor = [UIColor whiteColor];
    
    // 添加button上面一条线
    UIView *lineTopView = [[UIView alloc] initWithFrame:CGRectMake(7.5, 64, self.view.frame.size.width - 15, 2)];
    lineTopView.backgroundColor = [UIColor grayColor];
    // 添加button下面一条线
    UIView *lineDownView = [[UIView alloc] initWithFrame:CGRectMake(7.5, 102, self.view.frame.size.width - 15, 2)];
    lineDownView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:lineTopView];
    [self.view addSubview:lineDownView];
    [self.view addSubview:_topButtonView];
    // 点击button的回调
    _topButtonView.didClick = ^(UIButton *btn)
    {
         // 设置title的显示内容
        if (btn.tag == 101) {
            self.title = @"改变";
        }else
        {
            self.title = @"计划";
            
        }
        
        CGFloat contentOffsetX;
        CGFloat width = self.view.frame.size.width;
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
            
            _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        }];

        
    
    };
    [self addScrollView];
    
    
    // 点击教练授课详情
    self.todayDataView.coacOfCourse.didClick = ^(UIButton *btn)
    {
        CoachOfCoureDetailController *detailVC = [[CoachOfCoureDetailController alloc] init];
        [self.navigationController pushViewController:detailVC animated:YES];
    };
    
    
    // 点击评价详情
    
}

- (void)addScrollView
{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _scrollView.frame = CGRectMake(0, 109, ksystemW, ksystemH - 109);
    _scrollView.backgroundColor = [UIColor orangeColor];
    _scrollView.contentSize = CGSizeMake(ksystemW * 5, 0);
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    [_scrollView addSubview:self.todayDataView];
}

#pragma mark - UIScrollViewDelegate method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGSize selfSize = self.view.frame.size;
    
    if (scrollView.contentOffset.x == 0) {
        
        [_topButtonView selectedItem:101];
    }
    if (scrollView.contentOffset.x == selfSize.width) {
        
        [_topButtonView selectedItem:102];
        if (!_yesterdayDataView) {
            
            [_scrollView addSubview:self.yesterdayDataView];
        }
    }
    if (scrollView.contentOffset.x == selfSize.width * 2) {
        
        [_topButtonView selectedItem:103];
        if (!_weekDataView) {
            
            [_scrollView addSubview:self.weekDataView];
        }
    }
    if (scrollView.contentOffset.x == selfSize.width * 3) {
        
        [_topButtonView selectedItem:104];
        if (!_monthDataView) {
            
            [_scrollView addSubview:self.monthDataView];
        }
    }
    if (scrollView.contentOffset.x == selfSize.width * 4) {
        
        [_topButtonView selectedItem:105];
        if (!_yearDataView) {
            
            [_scrollView addSubview:self.yearDataView];
        }
    }

}

#pragma mark - LazyLoading method

- (TodayDataView *)todayDataView {
    
    if (!_todayDataView) {
        
        CGSize selfSize = self.view.frame.size;
        _todayDataView = [TodayDataView new];
        _todayDataView.frame = CGRectMake(0,0, selfSize.width, selfSize.height - 109);
//        _todayDataView.backgroundColor = [UIColor redColor];
        [_scrollView addSubview:_todayDataView];
    }
    return _todayDataView;
}

- (YesterdayDataView *)yesterdayDataView {
    
    if (!_yesterdayDataView) {
        
        CGSize selfSize = self.view.frame.size;
        _yesterdayDataView = [YesterdayDataView new];
        _yesterdayDataView.frame = CGRectMake(selfSize.width, 0, selfSize.width, selfSize.height - 109);
//        _yesterdayDataView.backgroundColor = [UIColor cyanColor];
        [_scrollView addSubview:_yesterdayDataView];
    }
    return _yesterdayDataView;
}

- (WeekDataView *)weekDataView {
    
    if (!_weekDataView) {
        
        CGSize selfSize = self.view.frame.size;
        _weekDataView = [WeekDataView new];
        _weekDataView.frame = CGRectMake(selfSize.width *2, 0, selfSize.width, selfSize.height - 109);
//        _weekDataView.backgroundColor = [UIColor grayColor];
        [_scrollView addSubview:_weekDataView];
    }
    return _weekDataView;
}

- (MonthViewData *)monthDataView {
    
    if (!_monthDataView) {
        
        CGSize selfSize = self.view.frame.size;
        _monthDataView = [MonthViewData new];
        _monthDataView.frame = CGRectMake(selfSize.width * 3, 0, selfSize.width, selfSize.height - 109);
//        _monthDataView.backgroundColor = [UIColor greenColor];
        [_scrollView addSubview:_monthDataView];
    }
    return _monthDataView;
}
- (YearDataView *)yearDataView {
    
    if (!_yearDataView) {
        
        CGSize selfSize = self.view.frame.size;
        _yearDataView = [YearDataView new];
        _yearDataView.frame = CGRectMake(selfSize.width * 4, 0, selfSize.width, selfSize.height - 109);
//        _yearDataView.backgroundColor = [UIColor greenColor];
        [_scrollView addSubview:_yearDataView];
    }
    return _yearDataView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
