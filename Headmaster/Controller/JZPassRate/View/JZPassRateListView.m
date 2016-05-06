//
//  JZPassRateListView.m
//  Headmaster
//
//  Created by ytzhang on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZPassRateListView.h"

#import "JZNoDataShowBGView.h"

#import "JZPassRateViewModel.h"

#import "JZPassRateHeaderView.h"

#import "JZPassRateListCell.h"

#import "JZPassRateListModel.h"

@interface JZPassRateListView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) JZPassRateViewModel *viewModel;

@property (nonatomic, assign) BOOL successRequest;

@property (nonatomic, strong) JZNoDataShowBGView *noDataShowBGView;


@end

@implementation JZPassRateListView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
//        self.refreshHeader = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.noDataShowBGView];
        self.viewModel = [JZPassRateViewModel new];
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
    
    self.viewModel.searchSubjectID = self.searchSubjectID;
    [self.viewModel networkRequestRefresh];
}

#pragma mark --- 加载更多
- (void)moreData{
    self.viewModel.searchSubjectID = self.searchSubjectID;    [self.viewModel networkRequestLoadMore];
    
}

- (void)setSearchType:(kDateSearchSubjectID)searchSubjectID {
    _searchSubjectID = searchSubjectID;
    self.viewModel.searchSubjectID = searchSubjectID;
}

#pragma mark ---- UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
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
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 152 - 43;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    JZPassRateHeaderView *headerView = [[JZPassRateHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.width, 44)];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.titleLabel.text = @"2016/04/13";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(isShowClassType)];
    [headerView addGestureRecognizer:tap];
    //        headerView.isShowClassTypeDetail = _isShowClassDetail;
    return headerView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *IDCell = @"cellID";
    JZPassRateListCell *listCell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    if (!listCell) {
        listCell = [[JZPassRateListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCell];
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
    
    
    
    return listCell;
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

@end
