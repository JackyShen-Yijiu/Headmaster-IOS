//
//  JZcommentListView.m
//  Headmaster
//
//  Created by ytzhang on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZcommentListView.h"

#import "JZNoDataShowBGView.h"

#import "JZCommentListViewModel.h"

#import "JZPassRateHeaderView.h"

#import "JZPassRateListCell.h"

#import "JZPassRateListModel.h"

#import "JZCommentChartCell.h"
#import "JZCommentListCell.h"

#import "XYPieChart.h"


@interface JZcommentListView ()<UITableViewDataSource,UITableViewDelegate,XYPieChartDelegate,TTCommnentViewDeleage>

@property (nonatomic, strong) JZCommentListViewModel *viewModel;

@property (nonatomic, assign) BOOL successRequest;

@property (nonatomic, strong) JZNoDataShowBGView *noDataShowBGView;

@property (nonatomic, assign) NSInteger expandIndex; // 放大下标

@property (nonatomic, assign) NSInteger reductionIndex; // 还原下标

@property (nonatomic, strong) JZCommentChartCell *chartCell;


@end

@implementation JZcommentListView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        //        self.refreshHeader = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.noDataShowBGView];
        self.viewModel = [JZCommentListViewModel new];
        [self.viewModel successRefreshBlock:^{
            [self refreshUI];
            self.successRequest = 1;
            
            return;
        }];
        [self.viewModel successLoadMoreBlock:^{
            [self refreshUI];
            [self.refreshFooter endRefreshing];
            
            
        }];
        [self.viewModel successLoadMoreBlockAndNoData:^{
            [self.parementVC showTotasViewWithMes:@"已经加载更多"];
            [self.refreshFooter endRefreshing];
        }];
    }
    
    return self;
}
#pragma mark - 刷新数据
- (void)refreshUI {
    
    [self reloadData];
}

#pragma mark - 刷新数据
- (void)networkRequest {
    
    self.viewModel.commentDateSearchType = self.commentDateSearchType;
    self.viewModel.commentLevel = _commnetLevel;
    [self.viewModel networkRequestRefresh];
}

#pragma mark --- 加载更多
- (void)moreData{
    self.viewModel.commentDateSearchType = self.commentDateSearchType;
     self.viewModel.commentLevel = _commnetLevel;
    [self.viewModel networkRequestLoadMore];
    
}

// 评价时间段
- (void)setCommentDateSearchType:(kCommentDateSearchType)commentDateSearchType{
    _commentDateSearchType = commentDateSearchType;
    self.viewModel.commentDateSearchType = commentDateSearchType;
}
// 评价等级
- (void)setCommnetLevel:(KCommnetLevel)commnetLevel{
    _commnetLevel = commnetLevel;
    self.viewModel.commentLevel = commnetLevel;
}
#pragma mark ---- UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //    _noDataShowBGView.hidden = YES;
    //    if (_searchSubjectID == kDateSearchSubjectIDOne) {
    //        if (self.viewModel.subjectOneArray.count == 0) {
    //            if ([self.showNodataDelegate respondsToSelector:@selector(initWithDataSearchType:)]) {
    //                [self.showNodataDelegate initWithDataSearchType:kDateSearchSubjectIDOne];
    //            }
    //        }
    //
    //        return self.viewModel.subjectOneArray.count;
    //    }
    //    if (_searchSubjectID == kDateSearchSubjectIDTwo) {
    //        if (self.viewModel.subjectTwoArray.count == 0) {
    //            if ([self.showNodataDelegate respondsToSelector:@selector(initWithDataSearchType:)]) {
    //                [self.showNodataDelegate initWithDataSearchType:kDateSearchSubjectIDTwo];
    //            }
    //        }
    //
    //
    //        return self.viewModel.subjectTwoArray.count;
    //    }
    //    if (_searchSubjectID == kDateSearchSubjectIDThree) {
    //        if (self.viewModel.subjectThreeArray.count == 0) {
    //            if ([self.showNodataDelegate respondsToSelector:@selector(initWithDataSearchType:)]) {
    //                [self.showNodataDelegate initWithDataSearchType:kDateSearchSubjectIDThree];
    //            }
    //        }
    //        return self.viewModel.subjectThreeArray.count;
    //    }
    //    if (_searchSubjectID == kDateSearchSubjectIDFour) {
    //        if (self.viewModel.subjectFourArray.count == 0) {
    //
    //            if ([self.showNodataDelegate respondsToSelector:@selector(initWithDataSearchType:)]) {
    //                [self.showNodataDelegate initWithDataSearchType:kDateSearchSubjectIDFour];
    //            }
    //
    //        }
    //
    //
    //        return self.viewModel.subjectFourArray.count;
    //    }
    //    return 0;
    if (0 == section) {
        return 1;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        return 166;
    }else{
        return 110;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (1 == section) {
        return 44;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (0 == section) {
        return 10;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    JZPassRateHeaderView *headerView = [[JZPassRateHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.width, 44)];
    headerView.arrowImgView.hidden = YES;
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.titleLabel.text = @"好评(147)";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(isShowClassType)];
    [headerView addGestureRecognizer:tap];
    //        headerView.isShowClassTypeDetail = _isShowClassDetail;
    return headerView;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 10)];
    view.backgroundColor = JZ_MAIN_BACKGROUND_COLOR;
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (0 == indexPath.section) {
        static NSString *IDCell = @"cellID";
        _chartCell = [tableView dequeueReusableCellWithIdentifier:IDCell];
        if (!_chartCell) {
            _chartCell = [[JZCommentChartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCell];
            _chartCell.pieChartView.pieChart.delegate = self;
            _chartCell.delegate = self;
        }
        //    JZPassRateListModel *model = [[JZPassRateListModel alloc] init];
        //    if (_searchSubjectID == kDateSearchSubjectIDOne) {
        //        model = self.viewModel.subjectOneArray[indexPath.row];
        //    }
        //    if (_searchSubjectID == kDateSearchSubjectIDTwo) {
        //        model = self.viewModel.subjectTwoArray[indexPath.row];
        //    }
        //    if (_searchSubjectID == kDateSearchSubjectIDThree) {
        //        model = self.viewModel.subjectThreeArray[indexPath.row];
        //    }
        //    if (_searchSubjectID == kDateSearchSubjectIDFour) {
        //        model = self.viewModel.subjectFourArray[indexPath.row];
        //    }
        
        
        //    listCell.model = model;
        
        
        
        return _chartCell;
 
    }else{
        static NSString *listCellID = @"listCellID";
       
        JZCommentListCell *listCell = [tableView dequeueReusableCellWithIdentifier:listCellID];
        if (!listCell) {
            listCell = [[JZCommentListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listCellID];
        }
        return listCell;

    }
    
    }
#pragma mark ----Action cell头部视图点击 是否显示详情
- (void)isShowClassType{
    
}
- (JZNoDataShowBGView *)noDataShowBGView{
    if (_noDataShowBGView == nil) {
        _noDataShowBGView = [[JZNoDataShowBGView alloc] initWithFrame:CGRectMake(self.frame.origin.x, 0,self.frame.size.width,self.frame.size.height)];
        _noDataShowBGView.imgStr = @"people_null";
        _noDataShowBGView.titleStr = @"暂无数据";
        _noDataShowBGView.titleColor  = JZ_FONTCOLOR_LIGHTWHITE;
        _noDataShowBGView.fontSize = 14.f;
        _noDataShowBGView.hidden = NO;
    }
    return _noDataShowBGView;
}
// 饼状图放大
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index{
    NSLog(@"===============================第%lu个饼状图放大",index);

    if (0 == index) {
        // 好评
        self.commnetLevel = KCommnetLevelHighRating;
        
        _chartCell.goodCommentView.expandIndex = index;
        
        _chartCell.goodCommentView.isShowBigView = YES;
        _chartCell.mightCommentView.isShowBigView = NO;
        _chartCell.badCommentView.isShowBigView = NO;
        
    }
    if (1 == index) {
        // 中评
        self.commnetLevel = KCommnetLevelMidRating;
        
        _chartCell.mightCommentView.expandIndex = index;
        
        _chartCell.goodCommentView.isShowBigView = NO;
       _chartCell.mightCommentView.isShowBigView = YES;;
        _chartCell.badCommentView.isShowBigView = NO;
    }
    if (2 == index) {
        // 差评
        self.commnetLevel = KCommnetLevelPoorRating;
        
          _chartCell.badCommentView.expandIndex = index;
        
        _chartCell.goodCommentView.isShowBigView = NO;
        _chartCell.mightCommentView.isShowBigView = NO;
        _chartCell.badCommentView.isShowBigView = YES;
    }
    
    
    // 刷新数据
    [self networkRequest];
}
// 饼状图还原
- (void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index{
    NSLog(@"=================================第%lu个饼状图还原",index);
    _reductionIndex  = index;
    if (0 == index) {
        // 好评
        
    }
    if (1 == index) {
        // 中评
    }
    if (2 == index) {
        // 差评
    }
    
}
// 手势点击事件
- (void)initWithCommentViewIndex:(NSInteger)index{
    if (500 == index) {
        // 好评
        [_chartCell.pieChartView.pieChart setSliceDeselectedAtIndex:0];
    }
    if (501 == index) {
        // 中评
    }
    if (502 == index) {
        // 差评
    }
}
@end
