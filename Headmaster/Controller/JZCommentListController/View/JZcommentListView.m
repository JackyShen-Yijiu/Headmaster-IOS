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

#import "JZCommentData.h"

#import "JZCommentChartCell.h"
#import "JZCommentListCell.h"

#import "XYPieChart.h"

#import "JZCommentCommentlist.h"
#import "JZCommentListController.h"




@interface JZcommentListView ()<UITableViewDataSource,UITableViewDelegate,XYPieChartDelegate>

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
//        self.commnetLevel = KCommnetLevelHighRating;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
//        [self addSubview:self.noDataShowBGView];
        
        self.viewModel = [JZCommentListViewModel new];
        [self.viewModel successRefreshBlock:^{
            [self refreshUI];
//            NSInteger index = _commnetLevel - 1;
//            [self expandTitleIndex:index];
//            [self expandPieIndex:index];
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
    }else{
        if (_commentDateSearchType == kCommentDateSearchTypeLastMonth) {
                    NSLog(@"1 ==== %lu",self.viewModel.lastMonthArray.count);
                    return  self.viewModel.lastMonthArray.count;
        }
        if (_commentDateSearchType == kCommentDateSearchTypeLastWeek) {
                        NSLog(@"2 ====== %lu",self.viewModel.lastWeekArray.count);
           return  self.viewModel.lastWeekArray.count;
        }
        if (_commentDateSearchType == kCommentDateSearchTypeToday) {
                        NSLog(@"3 ======%lu",self.viewModel.todayArray.count);
            return  self.viewModel.todayArray.count;
        }
        if (_commentDateSearchType == kCommentDateSearchTypeThisWeek) {
                        NSLog(@"4 ======%lu",self.viewModel.thisWeekArray.count);
            return  self.viewModel.thisWeekArray.count;
        }
        if (_commentDateSearchType == kCommentDateSearchTypeThisMonth) {
                        NSLog(@"5 ======%lu",self.viewModel.thisMonthArray.count);
           return  self.viewModel.thisMonthArray.count;
        }

    }
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        return 166;
    }else{
        
        JZCommentCommentlist *model = [[JZCommentCommentlist alloc] init];
        
        if (_commentDateSearchType == kCommentDateSearchTypeLastMonth) {
            model = self.viewModel.lastMonthArray[indexPath.row];
        }
        if (_commentDateSearchType == kCommentDateSearchTypeLastWeek) {
            model = self.viewModel.lastWeekArray[indexPath.row];
        }
        if (_commentDateSearchType == kCommentDateSearchTypeToday) {
            model = self.viewModel.todayArray[indexPath.row];
        }
        if (_commentDateSearchType == kCommentDateSearchTypeThisWeek) {
            model = self.viewModel.thisWeekArray[indexPath.row];
        }
        if (_commentDateSearchType == kCommentDateSearchTypeThisMonth) {
            model = self.viewModel.thisMonthArray[indexPath.row];
        }

        return [JZCommentListCell heightCellForList:model];
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
    // 如果好评数,中评数,差评数都为0 则不显示 header
    if ([[_viewModel.lastMonthDic objectForKey:@"goodcommnent"] integerValue] == 0 && [[_viewModel.lastMonthDic objectForKey:@"generalcomment"] integerValue] == 0 && [[_viewModel.lastMonthDic objectForKey:@"badcomment"] integerValue] == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 40)];
        view.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40 - 14, 100, 14)];
        label.textColor = kJZLightTextColor;
        label.text = @"暂无数据";
        label.font = [UIFont systemFontOfSize:14];
        label.centerX = view.centerX;
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        return view;
    }
    JZPassRateHeaderView *headerView = [[JZPassRateHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.width, 44)];
    headerView.arrowImgView.hidden = YES;
    headerView.backgroundColor = [UIColor whiteColor];
    if (_commnetLevel == KCommnetLevelHighRating) {
        headerView.titleLabel.text = [NSString stringWithFormat:@"好评(%lu)", [[_viewModel.lastMonthDic objectForKey:@"goodcommnent"] integerValue]];
    }
    if (_commnetLevel == KCommnetLevelMidRating) {
        headerView.titleLabel.text = [NSString stringWithFormat:@"中评(%lu)", [[_viewModel.lastMonthDic objectForKey:@"generalcomment"] integerValue]];
    }
    if (_commnetLevel == KCommnetLevelPoorRating) {
        headerView.titleLabel.text = [NSString stringWithFormat:@"差评(%lu)", [[_viewModel.lastMonthDic objectForKey:@"badcomment"] integerValue]];
    }
    
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
        }
        _chartCell.pieChartView.pieChart.delegate = self;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didCommentView:)];
        [_chartCell.badCommentView addGestureRecognizer:tap];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didCommentView:)];
        [_chartCell.mightCommentView addGestureRecognizer:tap1];
        
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didCommentView:)];
        [_chartCell.goodCommentView addGestureRecognizer:tap2];
        
        
        
            if (_commentDateSearchType == kCommentDateSearchTypeLastMonth) {
                _chartCell.commentDataNumberDic = self.viewModel.lastMonthDic;
            }
            if (_commentDateSearchType == kCommentDateSearchTypeLastWeek) {
                _chartCell.commentDataNumberDic = self.viewModel.lastWeekDic;
            }
            if (_commentDateSearchType == kCommentDateSearchTypeToday) {
                NSLog(@"self.viewModel.todayDic = %@",self.viewModel.todayDic);
                _chartCell.commentDataNumberDic = self.viewModel.todayDic;
            }
            if (_commentDateSearchType == kCommentDateSearchTypeThisWeek) {
                _chartCell.commentDataNumberDic = self.viewModel.thisWeekDic;
            }
        if (_commentDateSearchType == kCommentDateSearchTypeThisMonth) {
            _chartCell.commentDataNumberDic = self.viewModel.thisMonthDic;
        }
        

        return _chartCell;
 
    }else{
        static NSString *listCellID = @"listCellID";
       
        JZCommentListCell *listCell = [tableView dequeueReusableCellWithIdentifier:listCellID];
        if (!listCell) {
            listCell = [[JZCommentListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listCellID];
        }
        JZCommentCommentlist *model = [[JZCommentCommentlist alloc] init];
        
        if (_commentDateSearchType == kCommentDateSearchTypeLastMonth) {
            model = self.viewModel.lastMonthArray[indexPath.row];
        }
        if (_commentDateSearchType == kCommentDateSearchTypeLastWeek) {
            model = self.viewModel.lastWeekArray[indexPath.row];
        }
        if (_commentDateSearchType == kCommentDateSearchTypeToday) {
            model = self.viewModel.todayArray[indexPath.row];
        }
        if (_commentDateSearchType == kCommentDateSearchTypeThisWeek) {
            model = self.viewModel.thisWeekArray[indexPath.row];
        }
        if (_commentDateSearchType == kCommentDateSearchTypeThisMonth) {
            model = self.viewModel.thisMonthArray[indexPath.row];
        }
        
        listCell.model = model;

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
        _noDataShowBGView.hidden = YES;
    }
    return _noDataShowBGView;
}
// 饼状图放大
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index{
    NSLog(@"===============================第%lu个饼状图放大",index);
    [self expandTitleIndex:index];
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
- (void)didCommentView:(UITapGestureRecognizer *)tap{
    NSInteger index = tap.view.tag - 500;
    
    [self expandTitleIndex:index];
    [self expandPieIndex:index];
}
#pragma maek ----- 用于点击字体是饼状图放大
- (void)expandPieIndex:(NSInteger )index{
    JZCommentListController *vc = (JZCommentListController *)self.parementVC;
    if (index == 0) {
         vc.commentLevel = KCommnetLevelHighRating;
        [_chartCell.pieChartView.pieChart setSliceSelectedAtIndex:0];
        [_chartCell.pieChartView.pieChart setSliceDeselectedAtIndex:1];
        [_chartCell.pieChartView.pieChart setSliceDeselectedAtIndex:2];
    }
    if (index == 1) {
        vc.commentLevel = KCommnetLevelMidRating;
        [_chartCell.pieChartView.pieChart setSliceDeselectedAtIndex:0];
        [_chartCell.pieChartView.pieChart setSliceSelectedAtIndex:1];
        [_chartCell.pieChartView.pieChart setSliceDeselectedAtIndex:2];
    }
    if (index == 2) {
         vc.commentLevel = KCommnetLevelMidRating;
        [_chartCell.pieChartView.pieChart setSliceDeselectedAtIndex:0];
        [_chartCell.pieChartView.pieChart setSliceDeselectedAtIndex:1];
        [_chartCell.pieChartView.pieChart setSliceSelectedAtIndex:2];
    }
    // 刷新数据
    [self networkRequest];
    
}
#pragma mark ---- 用于字体颜色放大
- (void)expandTitleIndex:(NSInteger)index{
    
    JZCommentListController *vc = (JZCommentListController *)self.parementVC;
    if (0 == index) {
        // 好评
        self.commnetLevel = KCommnetLevelHighRating;
        
        vc.commentLevel = KCommnetLevelHighRating;
        
        _chartCell.goodCommentView.expandIndex = index;
        
        _chartCell.goodCommentView.isShowBigView = YES;
        _chartCell.mightCommentView.isShowBigView = NO;
        _chartCell.badCommentView.isShowBigView = NO;
        
    }
    if (1 == index) {
        // 中评
        self.commnetLevel = KCommnetLevelMidRating;
         vc.commentLevel = KCommnetLevelMidRating;
        _chartCell.mightCommentView.expandIndex = index;
        
        _chartCell.goodCommentView.isShowBigView = NO;
        _chartCell.mightCommentView.isShowBigView = YES;;
        _chartCell.badCommentView.isShowBigView = NO;
    }
    if (2 == index) {
        // 差评
        self.commnetLevel = KCommnetLevelPoorRating;
         vc.commentLevel = KCommnetLevelPoorRating;
        _chartCell.badCommentView.expandIndex = index;
        
        _chartCell.goodCommentView.isShowBigView = NO;
        _chartCell.mightCommentView.isShowBigView = NO;
        _chartCell.badCommentView.isShowBigView = YES;
    }
    
    
    // 刷新数据
    [self networkRequest];

}
@end
