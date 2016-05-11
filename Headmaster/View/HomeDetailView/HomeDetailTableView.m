//
//  HomeDetailTableView.m
//  Headmaster
//
//  Created by 大威 on 15/12/9.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeDetailTableView.h"
#import "YBLineChartView.h"
#import "HomeDetailNormalLineChartCell.h"
#import "HomeDetailCanClickLineChartCell.h"
#import "HomeDetailEvaluationCell.h"
#import "HomeDataDetailViewModel.h"
#import "HomeTopView.h"
#import "HomeViewModel.h"
#import "DVVDoubleRowToolBarView.h"

@interface HomeDetailTableView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) ClickBlock coachTeacherBlock;

@property (nonatomic, copy) ClickBlock evaluationBlock;

@property (nonatomic, strong) HomeDataDetailViewModel *viewModel;

@property (nonatomic, assign) BOOL successRequest;

@property (nonatomic,strong) HomeTopView *topView;

@end

@implementation HomeDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        self.viewModel = [HomeDataDetailViewModel new];
        [self.viewModel successRefreshBlock:^{
            [self refreshUI];
            self.successRequest = 1;
        }];
        
    }
    return self;
}

- (void)setCoachTeacherClickBlock:(void (^)(NSInteger))handle {
    _coachTeacherBlock = handle;
}

- (void)setEvaluationClickBlock:(void (^)(NSInteger))handle {
    _evaluationBlock = handle;
}

#pragma mark - 刷新数据
- (void)refreshUI {
    [self reloadData];
}

#pragma mark - 刷新数据
- (void)networkRequest {
    if (self.successRequest) {
        [self refreshUI];
        return;
    }
    [self.viewModel networkRequestRefresh];
}

- (void)setSearchType:(kDateSearchType)searchType {
    _searchType = searchType;
    self.viewModel.searchType = searchType;
}

#pragma mark - tableView data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        
        static NSString *kNormalLineChartCellId = @"lineCell";
        HomeDetailNormalLineChartCell *normalLineChartCell = [tableView dequeueReusableCellWithIdentifier:kNormalLineChartCellId];
        if (!normalLineChartCell) {
            normalLineChartCell = [[HomeDetailNormalLineChartCell alloc] initWithWidth:self.bounds.size.width - 20 Style:UITableViewCellStyleDefault reuseIdentifier:kNormalLineChartCellId];
        }
        //        NSArray *ary_1 = @[@"22",@"44",@"15",@"40",@"42",@"25",@"15",@"30",@"42",@"32",@"40"];
        //
        //        normalLineChartCell.xTitleArray = @[ @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日" ];
        //        normalLineChartCell.valueArray = @[ ary_1 ];
        
        normalLineChartCell.searchType = self.searchType;
        
        normalLineChartCell.titleLabel.text = @"某年某月某日";
        //    normalLineChartCell.xTitleMarkWordString = @"时";
        //    normalLineChartCell.yTitleMarkWordString = @"人";
        
        NSLog(@"self.viewModel.dataModel.reservationXTitleArray:%@",self.viewModel.dataModel.reservationXTitleArray);
        NSLog(@"self.viewModel.dataModel.reservationValueArray:%@",self.viewModel.dataModel.reservationValueArray);
        
        if (self.viewModel.dataModel.reservationXTitleArray.count) {
            normalLineChartCell.markLabel.text = [NSString stringWithFormat:@"共%li人",self.viewModel.dataModel.reservationStudentCount];
            normalLineChartCell.xTitleArray = self.viewModel.dataModel.reservationXTitleArray;
            normalLineChartCell.valueArray = @[self.viewModel.dataModel.reservationValueArray];
        }
        [normalLineChartCell refreshUI];
        
        return normalLineChartCell;
        
    }
    
    static NSString *footerCellID = @"footerCellID";
    
    UITableViewCell *footerCell = [tableView dequeueReusableCellWithIdentifier:footerCellID];
    if (!footerCell) {
        footerCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:footerCellID];
    }
    
    [self.topView removeFromSuperview];
    self.topView = [[HomeTopView alloc] initWithFrame:CGRectMake(0, 0, footerCell.width, 105) withIsHomeDetailsVc:YES];
    [footerCell.contentView addSubview:self.topView];
    [self.topView refreshSubjectData:_homeViewModel.subjectArray sameDay:_homeViewModel.applyCount];
   
    return footerCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        return [HomeDetailNormalLineChartCell new].defaultHeight + 20;
    }else{
        return 105;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
