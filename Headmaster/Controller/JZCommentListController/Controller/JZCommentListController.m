//
//  JZCommentListController.m
//  Headmaster
//
//  Created by ytzhang on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZCommentListController.h"

#import "JZPassRateToolBarView.h"
#import "JZcommentListView.h"

@interface JZCommentListController ()<UIScrollViewDelegate>

@property (nonatomic, strong) JZPassRateToolBarView *toolBarView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) JZcommentListView *lastMonthView;
@property (nonatomic, strong) JZcommentListView *lastWeekView;
@property (nonatomic, strong) JZcommentListView *todayView;
@property (nonatomic, strong) JZcommentListView *thisWeekView;
@property (nonatomic, strong) JZcommentListView *thisMonthView;

@property (nonatomic, strong) UIBarButtonItem *pushBtn;

@property (nonatomic, strong) UIView *bgView;

@end

@implementation JZCommentListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"学员评价";
    [self initUI];
        [self initRefesh];
}
- (void)initUI{
    self.view.backgroundColor = JZ_MAIN_BACKGROUND_COLOR;
    self.navigationItem.leftBarButtonItem = self.pushBtn;
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
    _bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    _bgView.layer.shadowOffset = CGSizeMake(0, 2);
    _bgView.layer.shadowOpacity = 0.072;
    _bgView.layer.shadowRadius = 2;
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:self.toolBarView];
    
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.bgView];
    
    [_scrollView addSubview:self.lastMonthView];
    [_scrollView addSubview:self.lastWeekView];
    [_scrollView addSubview:self.todayView];
    [_scrollView addSubview:self.thisWeekView];
    [_scrollView addSubview:self.thisMonthView];
    
     CGFloat contentOffsetX = 2 * self.view.width;
    _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);

    
    
}
- (void)initRefesh{
    
    self.todayView.commentDateSearchType = kCommentDateSearchTypeToday;
    NSLog(@"%lu",_commentLevel);
    self.todayView.commnetLevel = _commentLevel;
    self.todayView.parementVC  = self;
    [self loadNetworkData];
    __weak typeof (self) ws = self;
    
    
    self.lastMonthView.refreshFooter.beginRefreshingBlock = ^(){
        [ws moreLoadData];
    };
    self.lastWeekView.refreshFooter.beginRefreshingBlock = ^(){
        [ws moreLoadData];
    };
    self.todayView.refreshFooter.beginRefreshingBlock = ^(){
        [ws moreLoadData];
    };
    self.thisWeekView.refreshFooter.beginRefreshingBlock = ^(){
        [ws moreLoadData];
    };
    self.thisMonthView.refreshFooter.beginRefreshingBlock = ^(){
        [ws moreLoadData];
    };
}
- (void)loadNetworkData {
    
    CGFloat offSetX = self.scrollView.contentOffset.x;
    CGFloat width = self.scrollView.width;
    
    if (offSetX >= 0 && offSetX < self.scrollView.width) {
//        self.lastMonthView.commentDateSearchType = kCommentDateSearchTypeLastMonth;
        [self.lastMonthView networkRequest];
    }else if (offSetX >= width && offSetX < width * 2) {
//        self.lastWeekView.commentDateSearchType = kCommentDateSearchTypeLastWeek;
        [self.lastWeekView networkRequest];
    }else if (offSetX >= width * 2 && offSetX < width * 3) {
//        self.todayView.commentDateSearchType = kCommentDateSearchTypeToday;
        [self.todayView networkRequest];
        
    }else if (offSetX >= width * 3 && offSetX < width * 4) {
        
//        self.thisWeekView.commentDateSearchType = kCommentDateSearchTypeThisWeek;
        [self.thisWeekView networkRequest];
    }else if (offSetX >= width * 4 && offSetX < width * 5) {
        
//        self.thisMonthView.commentDateSearchType = kCommentDateSearchTypeThisMonth;
        [self.thisMonthView networkRequest];
    }
}

- (void)moreLoadData {
    
    CGFloat offSetX = self.scrollView.contentOffset.x;
    CGFloat width = self.scrollView.width;
    
    if (offSetX >= 0 && offSetX < self.scrollView.width) {
        self.lastMonthView.commentDateSearchType = kCommentDateSearchTypeLastMonth;
        [self.lastMonthView moreData];
    }else if (offSetX >= width && offSetX < width * 2) {
        self.lastWeekView.commentDateSearchType = kCommentDateSearchTypeLastWeek;
        [self.lastWeekView moreData];
        
    }else if (offSetX >= width * 2 && offSetX < width * 3) {
        self.todayView.commentDateSearchType = kCommentDateSearchTypeToday;
        [self.todayView moreData];
        
    }else if (offSetX >= width * 3 && offSetX < width * 4) {
        self.thisWeekView.commentDateSearchType = kCommentDateSearchTypeThisWeek;
        [self.thisWeekView moreData];
    }else if (offSetX >= width * 4 && offSetX < width *5) {
        self.thisMonthView.commentDateSearchType = kCommentDateSearchTypeThisMonth;
        [self.thisWeekView moreData];
    }
}

#pragma mark 筛选条件
- (void)dvvToolBarViewItemSelectedAction:(NSInteger)index {
    
    NSLog(@"11_scrollView.contentOffset.y:%f",_scrollView.contentOffset.y);
    
    if (0 == index) {
        
        CGFloat contentOffsetX = 0;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        //        self.oneSubjexctView.searchSubjectID = kDateSearchSubjectIDOne;
//        [self.scrollView addSubview:self.lastMonthView];
        self.lastMonthView.commentDateSearchType = kCommentDateSearchTypeLastMonth;
        self.lastMonthView.commnetLevel = self.commentLevel;
        self.lastMonthView.parementVC = self;
        
        //        self.allListView.studentState = index;
        //        self.allListView.subjectID = self.subjectID;
        //        [self.allListView removeFromSuperview];
        //
        //        self.allListView.frame = CGRectMake(0, 0, self.view.width, self.scrollView.height);
        //        [self.scrollView addSubview:self.allListView];
        //        self.allListView.parementVC = self;
        
    }else if (1 == index) {
        CGFloat contentOffsetX = self.view.width;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        self.lastWeekView.commentDateSearchType = kCommentDateSearchTypeLastWeek;
        self.lastWeekView.commnetLevel = self.commentLevel;
        self.lastWeekView.parementVC = self;
        
        //        NSLog(@"22_scrollView.contentOffset.y:%f",_scrollView.contentOffset.y);
        //        [self.noExameListView removeFromSuperview];
        //        self.noExameListView.frame = CGRectMake(self.view.width, 0, self.view.width, self.scrollView.height);
        //        NSLog(@"33_scrollView.contentOffset.y:%f",_scrollView.contentOffset.y);
        //        [self.scrollView addSubview:self.noExameListView];
        //
        //        self.noExameListView.studentState = index + 1;
        //        self.noExameListView.subjectID = self.subjectID;
        //        self.noExameListView.parementVC = self;
        //        NSLog(@"44_scrollView.contentOffset.y:%f",_scrollView.contentOffset.y);
        
    }else if (2 == index) {
        CGFloat contentOffsetX = 2 * self.view.width;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        //        self.threeSubjexctView.searchSubjectID = kDateSearchSubjectIDThree;
//        [self.scrollView addSubview:self.todayView];
        self.todayView.commentDateSearchType = kCommentDateSearchTypeToday;
        self.todayView.commnetLevel = self.commentLevel;
        self.todayView.parementVC = self;
        
        
        //        self.appointListView.subjectID = self.subjectID;
        //        self.appointListView.studentState = index + 1;
        //        self.appointListView.parementVC = self;
        //
        //        [self.noExameListView removeFromSuperview];
        //
        //        [self.scrollView addSubview:self.appointListView];
        //        self.appointListView.frame = CGRectMake(self.view.width * 2, 0, self.view.width, self.scrollView.height);
        //
        
    }
    else if (3 == index) {
        CGFloat contentOffsetX = 3 * self.view.width;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        self.thisWeekView.commentDateSearchType = kCommentDateSearchTypeThisWeek;
        self.thisWeekView.commnetLevel = self.commentLevel;
        self.thisWeekView.parementVC = self;
        
        
        //        self.retestListView.subjectID = self.subjectID;
        //        self.retestListView.studentState = index + 1;
        //
        //        [self.retestListView removeFromSuperview];
        //        [self.scrollView addSubview:self.retestListView];
        //        self.retestListView.frame = CGRectMake(self.view.width * 3, 0, self.view.width, self.scrollView.height);
        //        self.retestListView.parementVC = self;
        
    }
    else if (4 == index) {
        CGFloat contentOffsetX = 4 * self.view.width;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        self.thisMonthView.commentDateSearchType = kCommentDateSearchTypeThisMonth;
        self.thisMonthView.commnetLevel = self.commentLevel;
        self.thisMonthView.parementVC = self;
        
        
        //        self.retestListView.subjectID = self.subjectID;
        //        self.retestListView.studentState = index + 1;
        //
        //        [self.retestListView removeFromSuperview];
        //        [self.scrollView addSubview:self.retestListView];
        //        self.retestListView.frame = CGRectMake(self.view.width * 3, 0, self.view.width, self.scrollView.height);
        //        self.retestListView.parementVC = self;
        
    }

    NSLog(@"+++++++_scrollView.contentOffset.y:%f",_scrollView.contentOffset.y);
    
        [self loadNetworkData];
    
}
#pragma mark --- UIScroller delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat width = self.view.width;
    
    if (0 == scrollView.contentOffset.x) {
        // 上月
        [_toolBarView selectItem:0];
        //         self.allListView.frame = CGRectMake(0, -64, self.view.width, self.scrollView.height);
    }
    if (width == scrollView.contentOffset.x) {
        // 上周
        [_toolBarView selectItem:1];
        //self.noExameListView.frame = CGRectMake(self.view.width, -64, self.view.width, self.scrollView.height);
        
        
    }
    if (2 * width== scrollView.contentOffset.x) {
        // 今日
        [_toolBarView selectItem:2];
        //        self.appointListView.frame = CGRectMake(self.view.width * 2, -64, self.view.width, self.scrollView.height);
        
    }
    if (3 * width == scrollView.contentOffset.x) {
        // 本周
        [_toolBarView selectItem:3];
        //        self.retestListView.frame = CGRectMake(self.view.width * 3, -64, self.view.width, self.scrollView.height);
        
        
        
    }
    if (4 * width == scrollView.contentOffset.x) {
        // 本月
        [_toolBarView selectItem:4];
        //        self.passListView.frame = CGRectMake(self.view.width * 4, -64, self.view.width, self.scrollView.height);
        
        
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (UIScrollView *)scrollView{
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bgView.frame), self.view.width, self.view.height - self.bgView.height - 64)];
        _scrollView.contentSize = CGSizeMake(5 * self.view.width, 0);
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
    }
    return _scrollView;
}
- (JZPassRateToolBarView *)toolBarView {
    if (!_toolBarView) {
        _toolBarView = [JZPassRateToolBarView new];
        _toolBarView.frame = CGRectMake(0, 0, self.view.width, self.bgView.height);
        _toolBarView.titleNormalColor = kJZDarkTextColor;
        _toolBarView.titleSelectColor = [UIColor colorWithHexString:@"3d8bff"];
        _toolBarView.followBarColor = [UIColor colorWithHexString:@"3d8bff"];
        _toolBarView.backgroundColor = [UIColor clearColor];
        _toolBarView.selectButtonInteger = 2;
        _toolBarView.titleArray = @[ @"上月", @"上周", @"今日" , @"本周", @"本月"];
        __weak typeof(self) ws = self;
        [_toolBarView dvvToolBarViewItemSelected:^(UIButton *button) {
            [ws dvvToolBarViewItemSelectedAction:button.tag];
        }];
        
        if (YBIphone6Plus) {
            _toolBarView.titleFont = [UIFont systemFontOfSize:14*1.15];
        }
    }
    return _toolBarView;
}
// 上月
- (JZcommentListView *)lastMonthView{
    if (_lastMonthView == nil) {
        _lastMonthView = [[JZcommentListView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.scrollView.height)];
        _lastMonthView.backgroundColor = [UIColor clearColor];
        _lastMonthView.commentDateSearchType = kCommentDateSearchTypeLastMonth;
        
    }
    return _lastMonthView;
}
// 上周
- (JZcommentListView *)lastWeekView{
    if (_lastWeekView == nil) {
        _lastWeekView = [[JZcommentListView alloc] initWithFrame:CGRectMake(self.view.width, 0, self.view.width, self.scrollView.height)];
        _lastWeekView.backgroundColor = [UIColor clearColor];
        _lastWeekView.commentDateSearchType = kCommentDateSearchTypeLastWeek;
        
    }
    return _lastWeekView;
}

// 今日
- (JZcommentListView *)todayView{
    if (_todayView == nil) {
        _todayView = [[JZcommentListView alloc] initWithFrame:CGRectMake(2 * self.view.width, 0, self.view.width, self.scrollView.height)];
        _todayView.backgroundColor = [UIColor clearColor];
        _todayView.commentDateSearchType = kCommentDateSearchTypeToday;
    }
    return _todayView;
}
// 本周
- (JZcommentListView *)thisWeekView{
    if (_thisWeekView == nil) {
        _thisWeekView = [[JZcommentListView alloc] initWithFrame:CGRectMake(3 * self.view.width, 0, self.view.width, self.scrollView.height)];
        _thisWeekView.backgroundColor = [UIColor clearColor];
        _thisWeekView.commentDateSearchType = kCommentDateSearchTypeThisWeek;
        
    }
    return _thisWeekView;
}

// 本月
- (JZcommentListView *)thisMonthView{
    if (_thisMonthView == nil) {
        _thisMonthView = [[JZcommentListView alloc] initWithFrame:CGRectMake(4 * self.view.width, 0, self.view.width, self.scrollView.height)];
        _thisMonthView.backgroundColor = [UIColor clearColor];
        _thisMonthView.commentDateSearchType = kCommentDateSearchTypeThisMonth;
        
    }
    return _thisMonthView;
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
