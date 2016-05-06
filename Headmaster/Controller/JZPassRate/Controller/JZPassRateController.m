//
//  JZPassRateController.m
//  Headmaster
//
//  Created by ytzhang on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZPassRateController.h"
#import "JZPassRateToolBarView.h"
#import "JZPassRateListView.h"

@interface JZPassRateController ()<UIScrollViewDelegate>

@property (nonatomic, strong) JZPassRateToolBarView *toolBarView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) JZPassRateListView *oneSubjexctView;
@property (nonatomic, strong) JZPassRateListView *twoSubjexctView;
@property (nonatomic, strong) JZPassRateListView *threeSubjexctView;
@property (nonatomic, strong) JZPassRateListView *fourSubjexctView;

@property (nonatomic, strong) UIView *bgView;





@end

@implementation JZPassRateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initUI];
//    [self initRefesh];
}
- (void)initUI{
    self.view.backgroundColor = JZ_MAIN_BACKGROUND_COLOR;
    
    

    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
    _bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    _bgView.layer.shadowOffset = CGSizeMake(0, 2);
    _bgView.layer.shadowOpacity = 0.072;
    _bgView.layer.shadowRadius = 2;
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:self.toolBarView];
    
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.bgView];
    
    [_scrollView addSubview:self.oneSubjexctView];
    [_scrollView addSubview:self.twoSubjexctView];
    [_scrollView addSubview:self.threeSubjexctView];
    [_scrollView addSubview:self.fourSubjexctView];


}
- (void)initRefesh{
    self.oneSubjexctView.searchSubjectID = kDateSearchSubjectIDOne;
    [self loadNetworkData];
    __weak typeof (self) ws = self;
    
    
    self.oneSubjexctView.refreshFooter.beginRefreshingBlock = ^(){
        [ws moreLoadData];
    };
    self.twoSubjexctView.refreshFooter.beginRefreshingBlock = ^(){
        [ws moreLoadData];
    };
    self.threeSubjexctView.refreshFooter.beginRefreshingBlock = ^(){
        [ws moreLoadData];
    };
    self.fourSubjexctView.refreshFooter.beginRefreshingBlock = ^(){
        [ws moreLoadData];
    };
}
- (void)loadNetworkData {
    
    CGFloat offSetX = self.scrollView.contentOffset.x;
    CGFloat width = self.scrollView.width;
    
    if (offSetX >= 0 && offSetX < self.scrollView.width) {
        self.oneSubjexctView.searchSubjectID = kDateSearchSubjectIDOne;
        [self.oneSubjexctView networkRequest];
    }else if (offSetX >= width && offSetX < width * 2) {
         self.twoSubjexctView.searchSubjectID = kDateSearchSubjectIDTwo;
        [self.twoSubjexctView networkRequest];
        
    }else if (offSetX >= width * 2 && offSetX < width * 3) {
        self.threeSubjexctView.searchSubjectID = kDateSearchSubjectIDThree;
        [self.threeSubjexctView networkRequest];
        
    }else if (offSetX >= width * 3 && offSetX < width * 4) {
        self.fourSubjexctView.searchSubjectID = kDateSearchSubjectIDFour;
        [self.fourSubjexctView networkRequest];
    }}
- (void)moreLoadData {
    
    CGFloat offSetX = self.scrollView.contentOffset.x;
    CGFloat width = self.scrollView.width;
    
    if (offSetX >= 0 && offSetX < self.scrollView.width) {
        self.oneSubjexctView.searchSubjectID = kDateSearchSubjectIDOne;
        [self.oneSubjexctView moreData];
    }else if (offSetX >= width && offSetX < width * 2) {
        self.twoSubjexctView.searchSubjectID = kDateSearchSubjectIDTwo;
        [self.twoSubjexctView moreData];
        
        
        
    }else if (offSetX >= width * 2 && offSetX < width * 3) {
        self.threeSubjexctView.searchSubjectID = kDateSearchSubjectIDThree;
        [self.threeSubjexctView moreData];
        
    }else if (offSetX >= width * 3 && offSetX < width * 4) {
        self.fourSubjexctView.searchSubjectID = kDateSearchSubjectIDFour;
        [self.fourSubjexctView moreData];
    }
}

#pragma mark 筛选条件
- (void)dvvToolBarViewItemSelectedAction:(NSInteger)index {
    
    NSLog(@"11_scrollView.contentOffset.y:%f",_scrollView.contentOffset.y);
    
    if (0 == index) {
        
        CGFloat contentOffsetX = 0;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
//        self.oneSubjexctView.searchSubjectID = kDateSearchSubjectIDOne;
        [self.scrollView addSubview:self.oneSubjexctView];
        self.oneSubjexctView.parementVC = self;
        
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
//        self.twoSubjexctView.searchSubjectID = kDateSearchSubjectIDTwo;
        [self.scrollView addSubview:self.twoSubjexctView];
        self.twoSubjexctView.parementVC = self;

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
        [self.scrollView addSubview:self.threeSubjexctView];
        self.threeSubjexctView.parementVC = self;

        
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
//        self.fourSubjexctView.searchSubjectID = kDateSearchSubjectIDFour;
        [self.scrollView addSubview:self.fourSubjexctView];
        self.fourSubjexctView.parementVC = self;

        
//        self.retestListView.subjectID = self.subjectID;
//        self.retestListView.studentState = index + 1;
//        
//        [self.retestListView removeFromSuperview];
//        [self.scrollView addSubview:self.retestListView];
//        self.retestListView.frame = CGRectMake(self.view.width * 3, 0, self.view.width, self.scrollView.height);
//        self.retestListView.parementVC = self;
        
    }
    NSLog(@"+++++++_scrollView.contentOffset.y:%f",_scrollView.contentOffset.y);
    
//    [self loadNetworkData];
    
}
#pragma mark --- UIScroller delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat width = self.view.width;
    
    if (0 == scrollView.contentOffset.x) {
        // 全部
        [_toolBarView selectItem:0];
        //         self.allListView.frame = CGRectMake(0, -64, self.view.width, self.scrollView.height);
    }
    if (width == scrollView.contentOffset.x) {
        // 未考
        [_toolBarView selectItem:1];
        //self.noExameListView.frame = CGRectMake(self.view.width, -64, self.view.width, self.scrollView.height);
        
        
    }
    if (2 * width== scrollView.contentOffset.x) {
        // 约考
        [_toolBarView selectItem:2];
        //        self.appointListView.frame = CGRectMake(self.view.width * 2, -64, self.view.width, self.scrollView.height);
        
    }
    if (3 * width == scrollView.contentOffset.x) {
        // 补考
        [_toolBarView selectItem:3];
        //        self.retestListView.frame = CGRectMake(self.view.width * 3, -64, self.view.width, self.scrollView.height);
        
        
        
    }
    if (4 * width == scrollView.contentOffset.x) {
        // 通过
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
        _scrollView.contentSize = CGSizeMake(4 * self.view.width, 0);
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
        _toolBarView.titleArray = @[ @"科目一", @"科目二", @"科目三" , @"科目四"];
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
// 科目一
- (JZPassRateListView *)oneSubjexctView{
    if (_oneSubjexctView == nil) {
        _oneSubjexctView = [[JZPassRateListView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.scrollView.height)];
        _oneSubjexctView.backgroundColor = [UIColor clearColor];
        _oneSubjexctView.searchSubjectID = kDateSearchSubjectIDOne;
        
    }
    return _oneSubjexctView;
}
// 科目二
- (JZPassRateListView *)twoSubjexctView{
    if (_twoSubjexctView == nil) {
        _twoSubjexctView = [[JZPassRateListView alloc] initWithFrame:CGRectMake(self.view.width, 0, self.view.width, self.scrollView.height)];
        _twoSubjexctView.backgroundColor = [UIColor clearColor];
        _twoSubjexctView.searchSubjectID = kDateSearchSubjectIDTwo;
        
    }
    return _twoSubjexctView;
}

// 科目三
- (JZPassRateListView *)threeSubjexctView{
    if (_threeSubjexctView == nil) {
        _threeSubjexctView = [[JZPassRateListView alloc] initWithFrame:CGRectMake(2 * self.view.width, 0, self.view.width, self.scrollView.height)];
        _threeSubjexctView.backgroundColor = [UIColor clearColor];
        _threeSubjexctView.searchSubjectID = kDateSearchSubjectIDThree;
        
    }
    return _threeSubjexctView;
}
// 科目四
- (JZPassRateListView *)fourSubjexctView{
    if (_fourSubjexctView == nil) {
        _fourSubjexctView = [[JZPassRateListView alloc] initWithFrame:CGRectMake(3 * self.view.width, 0, self.view.width, self.scrollView.height)];
        _fourSubjexctView.backgroundColor = [UIColor clearColor];
        _fourSubjexctView.searchSubjectID = kDateSearchSubjectIDFour;
        
    }
    return _fourSubjexctView;
}


@end
