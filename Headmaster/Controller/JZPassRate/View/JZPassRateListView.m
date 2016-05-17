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

#import "JZCommentTimeModel.h"

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
//        [self addSubview:self.noDataShowBGView];
        self.viewModel = [JZPassRateViewModel new];
        [self.viewModel successRefreshBlock:^{
            [self refreshUI];
            self.successRequest = 1;
            
            return;
        }];
        [self.viewModel successLoadMoreBlock:^{
            [self refreshUI];
//            [self.refreshFooter endRefreshing];
            
            
        }];
        [self.viewModel successLoadMoreBlockAndNoData:^{
            [self.parementVC showTotasViewWithMes:@"已经加载更多"];
//            [self.refreshFooter endRefreshing];
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
    
    // 科目类型
    self.viewModel.searchSubjectID = self.searchSubjectID;
    self.viewModel.year = self.year;
    self.viewModel.month = self.month;
   
    
    [self.viewModel networkRequestRefresh];
}

#pragma mark --- 加载更多
- (void)moreData{
    self.viewModel.searchSubjectID = self.searchSubjectID;
    [self.viewModel networkRequestLoadMore];
    
}

- (void)setSearchType:(kDateSearchSubjectID)searchSubjectID {
    _searchSubjectID = searchSubjectID;
    self.viewModel.searchSubjectID = searchSubjectID;
}

#pragma mark ---- UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _timeDataArray.count;
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
    JZCommentTimeModel *model = _timeDataArray[section];
    if (model.isShowDetail) {
        
        if (_searchSubjectID == kDateSearchSubjectIDOne) {
            return self.viewModel.subjectOneArray.count;
        }
        if (_searchSubjectID == kDateSearchSubjectIDTwo) {
            return self.viewModel.subjectTwoArray.count;
        }
        if (_searchSubjectID == kDateSearchSubjectIDThree) {
            return self.viewModel.subjectThreeArray.count;
        }
        if (_searchSubjectID == kDateSearchSubjectIDFour) {
            return self.viewModel.subjectFourArray.count;
        }

    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 152 - 43;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
     JZCommentTimeModel *model =  _timeDataArray[section];
    
    
    
    
    
    
    JZPassRateHeaderView *headerView = [[JZPassRateHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.width, 44)];
    headerView.backgroundColor = [UIColor whiteColor];
    if (model.isShowDetail) {
        headerView.arrowImgView.image = [UIImage imageNamed:@"more_down"];
    }else{
        headerView.arrowImgView.image = [UIImage imageNamed:@"more_up"];
    }

    headerView.titleLabel.text = model.ID;
    // _timeDataArray 存放是科目中所以时间 2016-5 2016-6 给每个区添加tag 用于区分点击手势
    if (_searchSubjectID == 1) {
        headerView.tag = 500 + section;
    }
    if (_searchSubjectID == 2) {
        headerView.tag = 600 + section;
    }
    if (_searchSubjectID == 3) {
        headerView.tag = 700 + section;
    }
    if (_searchSubjectID == 4) {
        headerView.tag = 800 + section;
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(isShowClassType:)];
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
    JZPassRateListModel *model = [[JZPassRateListModel alloc] init];
    if (_searchSubjectID == kDateSearchSubjectIDOne) {
        model = self.viewModel.subjectOneArray[indexPath.row];
    }
    if (_searchSubjectID == kDateSearchSubjectIDTwo) {
        model = self.viewModel.subjectTwoArray[indexPath.row];
    }
    if (_searchSubjectID == kDateSearchSubjectIDThree) {
        model = self.viewModel.subjectThreeArray[indexPath.row];
    }
    if (_searchSubjectID == kDateSearchSubjectIDFour) {
        model = self.viewModel.subjectFourArray[indexPath.row];
    }
    
    
    listCell.model = model;
    
    
    
    return listCell;
}
#pragma mark ----Action cell头部视图点击 是否显示详情
- (void)isShowClassType:(UITapGestureRecognizer *)tap{
    NSInteger index = tap.view.tag;
    JZCommentTimeModel *model = [[JZCommentTimeModel alloc] init];
   
    
    if (_searchSubjectID == 1) {
        index = index - 500;
        model = _timeDataArray[index];
        
    }
    if (_searchSubjectID == 2) {
        index = index - 600;
        model = _timeDataArray[index];
    }
    if (_searchSubjectID == 3) {
        index = index - 700;
        model = _timeDataArray[index];

    }
    if (_searchSubjectID == 4) {
        index = index - 800;
        model = _timeDataArray[index];
       
    }
    
    model.isShowDetail = !model.isShowDetail;
    
    // 取出时间 年和月传给服务器
     NSArray *timeArray = [model.ID componentsSeparatedByString:@"-"];
    self.year = [timeArray[0] integerValue];
    self.month = [timeArray[1] integerValue];
    
    // 刷新数据
    [self networkRequest];

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
