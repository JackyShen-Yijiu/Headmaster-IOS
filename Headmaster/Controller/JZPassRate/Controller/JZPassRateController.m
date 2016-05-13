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
#import "JZCommentTimeModel.h"
#import <YYModel.h>

@interface JZPassRateController ()<UIScrollViewDelegate>

@property (nonatomic, strong) JZPassRateToolBarView *toolBarView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) JZPassRateListView *oneSubjexctView;
@property (nonatomic, strong) JZPassRateListView *twoSubjexctView;
@property (nonatomic, strong) JZPassRateListView *threeSubjexctView;
@property (nonatomic, strong) JZPassRateListView *fourSubjexctView;

@property (nonatomic, strong) NSMutableArray *timeDataArrayOne;
@property (nonatomic, strong) NSMutableArray *timeDataArrayTwo;
@property (nonatomic, strong) NSMutableArray *timeDataArrayThree;
@property (nonatomic, strong) NSMutableArray *timeDataArrayFour;

@property (nonatomic, strong) UIView *bgView;





@end

@implementation JZPassRateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.timeDataArrayOne = [NSMutableArray array];
     self.timeDataArrayTwo = [NSMutableArray array];
     self.timeDataArrayThree = [NSMutableArray array];
    self.timeDataArrayFour = [NSMutableArray array];
    [self initUI];
    [self initRefesh];
}
- (void)initUI{
    self.view.backgroundColor = JZ_MAIN_BACKGROUND_COLOR;
    
    self.title = @"考试合格率";

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
    
//  传过来的subjectID 为 1,2,3,4,
    CGFloat contentOffsetX = (_subjectID - 1) * self.view.width;
    _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
    
}
- (void)initRefesh{
//    self.oneSubjexctView.searchSubjectID = _subjectID;
    [self getTimeData];
//    __weak typeof (self) ws = self;
    
    
//    self.oneSubjexctView.refreshFooter.beginRefreshingBlock = ^(){
//        [ws moreLoadData];
//    };
//    self.twoSubjexctView.refreshFooter.beginRefreshingBlock = ^(){
//        [ws moreLoadData];
//    };
//    self.threeSubjexctView.refreshFooter.beginRefreshingBlock = ^(){
//        [ws moreLoadData];
//    };
//    self.fourSubjexctView.refreshFooter.beginRefreshingBlock = ^(){
//        [ws moreLoadData];
//    };
}
- (void)loadNetworkData {
    
    CGFloat offSetX = self.scrollView.contentOffset.x;
    CGFloat width = self.scrollView.width;
    
    if (offSetX >= 0 && offSetX < self.scrollView.width) {
        _subjectID = kDateSearchSubjectIDOne;
        self.oneSubjexctView.searchSubjectID = kDateSearchSubjectIDOne;
        [self.oneSubjexctView networkRequest];
    }else if (offSetX >= width && offSetX < width * 2) {
        _subjectID = kDateSearchSubjectIDTwo;
         self.twoSubjexctView.searchSubjectID = kDateSearchSubjectIDTwo;
        [self.twoSubjexctView networkRequest];
        
    }else if (offSetX >= width * 2 && offSetX < width * 3) {
        _subjectID = kDateSearchSubjectIDThree;
        self.threeSubjexctView.searchSubjectID = kDateSearchSubjectIDThree;
        [self.threeSubjexctView networkRequest];
        
    }else if (offSetX >= width * 3 && offSetX < width * 4) {
        _subjectID = kDateSearchSubjectIDFour;
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
        [self.scrollView addSubview:self.oneSubjexctView];
        self.oneSubjexctView.parementVC = self;
        self.oneSubjexctView.searchSubjectID = 1;
        
    }else if (1 == index) {
        CGFloat contentOffsetX = self.view.width;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        [self.scrollView addSubview:self.twoSubjexctView];
        self.twoSubjexctView.parementVC = self;
         self.twoSubjexctView.searchSubjectID = 2;
        
    }else if (2 == index) {
        CGFloat contentOffsetX = 2 * self.view.width;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        [self.scrollView addSubview:self.threeSubjexctView];
        self.threeSubjexctView.parementVC = self;
         self.threeSubjexctView.searchSubjectID = 3;

        
    }
    else if (3 == index) {
        CGFloat contentOffsetX = 3 * self.view.width;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        [self.scrollView addSubview:self.fourSubjexctView];
        self.fourSubjexctView.parementVC = self;
         self.fourSubjexctView.searchSubjectID = 4;

        
    }
    NSLog(@"+++++++_scrollView.contentOffset.y:%f",_scrollView.contentOffset.y);
    
    [self getTimeData];
    
}
#pragma mark --- UIScroller delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat width = self.view.width;
    
    if (0 == scrollView.contentOffset.x) {
        // 科目一
        _subjectID = 1;
        [_toolBarView selectItem:0];
        
        //         self.allListView.frame = CGRectMake(0, -64, self.view.width, self.scrollView.height);
    }
    if (width == scrollView.contentOffset.x) {
        // 科目二
        _subjectID = 2;
        [_toolBarView selectItem:1];
        
        //self.noExameListView.frame = CGRectMake(self.view.width, -64, self.view.width, self.scrollView.height);
        
        
    }
    if (2 * width== scrollView.contentOffset.x) {
        // 科目三
         _subjectID = 3;
        [_toolBarView selectItem:2];
        
        //        self.appointListView.frame = CGRectMake(self.view.width * 2, -64, self.view.width, self.scrollView.height);
        
    }
    if (3 * width == scrollView.contentOffset.x) {
        // 科目四
        _subjectID = 4;
        [_toolBarView selectItem:3];
        
        //        self.retestListView.frame = CGRectMake(self.view.width * 3, -64, self.view.width, self.scrollView.height);
        
        
        
    }
    
    
    
}
// 月份数据请求
- (void)getTimeData{

    [NetworkEntity getPassRateTimeWithUserid:[UserInfoModel defaultUserInfo].userID SchoolId:[UserInfoModel defaultUserInfo].schoolId SubjectID:_subjectID success:^(id responseObject) {
        if (1 == [responseObject[@"type"] integerValue]) {
            NSLog(@"response ======= ========== ================== ========  %@ %lu",responseObject,_subjectID);
            NSArray *array = responseObject[@"data"];
            if (array.count) {
                [self.timeDataArrayOne removeAllObjects];
                 [self.timeDataArrayTwo removeAllObjects];
                 [self.timeDataArrayThree removeAllObjects];
                 [self.timeDataArrayFour removeAllObjects];
                for (NSDictionary *dic in array) {
                    
                    // 数据封装
                    JZCommentTimeModel *timeModel = [JZCommentTimeModel yy_modelWithDictionary:dic];
                    // 科目一
                    if (_subjectID == 1) {
                        [self.timeDataArrayOne addObject:timeModel];
                        [self.oneSubjexctView reloadData];
                    }
                    // 科目二
                    if (_subjectID == 2) {
                        [self.timeDataArrayTwo addObject:timeModel];
                        [self.twoSubjexctView reloadData];
                    }

                    // 科目三
                    if (_subjectID == 3) {
                        [self.timeDataArrayThree addObject:timeModel];
                        [self.threeSubjexctView reloadData];
                    }
                    // 科目四
                    if (_subjectID == 4) {
                        [self.timeDataArrayFour addObject:timeModel];
                        [self.fourSubjexctView reloadData];
                    }

                    
                    
                    // 请求考试详情
//                    [self loadNetworkData];
                }
                
                
                // 数据刷新
                // 科目一
                if (_subjectID == kDateSearchSubjectIDOne) {
                    self.oneSubjexctView.timeDataArray = _timeDataArrayOne;
                    [self.oneSubjexctView reloadData];
                }
                // 科目二
                if (_subjectID == kDateSearchSubjectIDTwo) {
                    self.twoSubjexctView.timeDataArray = _timeDataArrayTwo;
                    [self.twoSubjexctView reloadData];
                }
                
                // 科目三
                if (_subjectID == kDateSearchSubjectIDThree) {
                    self.threeSubjexctView.timeDataArray = _timeDataArrayThree;
                    
                    NSLog(@"self.threeSubjexctView.timeDataArray = %lu",self.threeSubjexctView.timeDataArray.count);
                    [self.threeSubjexctView reloadData];
                }
                // 科目四
                if (_subjectID == kDateSearchSubjectIDFour) {
                    self.fourSubjexctView.timeDataArray = _timeDataArrayFour;
                    [self.fourSubjexctView reloadData];
                }

                
                
            }
        }else{
            [self showPopAlerViewWithMes:@"网络错误"];
        }
    } failure:^(NSError *failure) {
        [self showPopAlerViewWithMes:@"网络错误"];
    }];
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
        _toolBarView.selectButtonInteger = _subjectID - 1;
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
