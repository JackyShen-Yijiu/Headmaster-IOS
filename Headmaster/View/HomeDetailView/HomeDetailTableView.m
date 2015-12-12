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
#import "HomeDetailCanClickBarChartCell.h"
#import "HomeDetailEvaluationCell.h"
#import "HomeDataDetailViewModel.h"

@interface HomeDetailTableView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) ClickBlock coachTeacherBlock;

@property (nonatomic, copy) ClickBlock evaluationBlock;

@property (nonatomic, strong) HomeDataDetailViewModel *viewModel;

@property (nonatomic, assign) BOOL successRequest;

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
    
//    if (self.dataModel.applyXTitleArray.count && self.dataModel.reservationXTitleArray.count && self.dataModel.coachCourseXTitleArray && self.dataModel.evaluateXTitleArray) {
//        return 4;
//    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        static NSString *kNormalLineChartCellId = @"lineCell";
        HomeDetailNormalLineChartCell *normalLineChartCell = [tableView dequeueReusableCellWithIdentifier:kNormalLineChartCellId];
        if (!normalLineChartCell) {
            normalLineChartCell = [[HomeDetailNormalLineChartCell alloc] initWithWidth:self.bounds.size.width - 30 Style:UITableViewCellStyleDefault reuseIdentifier:kNormalLineChartCellId];
        }
//        NSArray *ary_1 = @[@"22",@"44",@"15",@"40",@"42",@"25",@"15",@"30",@"42",@"32",@"40"];
//        
//        normalLineChartCell.xTitleArray = @[ @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日" ];
//        normalLineChartCell.valueArray = @[ ary_1 ];
        
        if (indexPath.row == 0) {
            normalLineChartCell.titleLabel.text = @"招生";
            normalLineChartCell.xTitleMarkWordString = @"天";
            normalLineChartCell.yTitleMarkWordString = @"人";
            
            if (self.viewModel.dataModel.applyXTitleArray.count) {
                normalLineChartCell.markLabel.text = [NSString stringWithFormat:@"共%li人",self.viewModel.dataModel.appleStudentCount];;
                normalLineChartCell.xTitleArray = self.viewModel.dataModel.applyXTitleArray;
                normalLineChartCell.valueArray = @[ self.viewModel.dataModel.applyValueArray ];
                [normalLineChartCell refreshUI];
            }
            
            
        }else {
            normalLineChartCell.titleLabel.text = @"约课";
            normalLineChartCell.xTitleMarkWordString = @"时";
            normalLineChartCell.yTitleMarkWordString = @"人";
            
            if (self.viewModel.dataModel.reservationXTitleArray.count) {
                normalLineChartCell.markLabel.text = [NSString stringWithFormat:@"共%li人",self.viewModel.dataModel.reservationStudentCount];
                normalLineChartCell.xTitleArray = self.viewModel.dataModel.reservationXTitleArray;
                normalLineChartCell.valueArray = @[ self.viewModel.dataModel.reservationValueArray ];
                [normalLineChartCell refreshUI];
            }
            
        }
        return normalLineChartCell;
    } else if(indexPath.row == 2){
        static NSString *kCanClickBarChartCellId = @"lineCanClickCell";
        HomeDetailCanClickBarChartCell *canClickBarChartCell = [tableView dequeueReusableCellWithIdentifier:kCanClickBarChartCellId];
        if (!canClickBarChartCell) {
            canClickBarChartCell = [[HomeDetailCanClickBarChartCell alloc] initWithWidth:self.bounds.size.width - 30 Style:UITableViewCellStyleDefault reuseIdentifier:kCanClickBarChartCellId];
            [canClickBarChartCell setClickBlock:^(NSInteger tag) {
                if (_coachTeacherBlock) {
                    _coachTeacherBlock(tag);
                }
//                NSLog(@"---%li",tag);
            }];
        }
        
        canClickBarChartCell.titleLabel.text = @"教练授课";
        canClickBarChartCell.markLabel.text = @"详情";
        canClickBarChartCell.markImageView.image = [UIImage imageNamed:@"xq"];
        canClickBarChartCell.xTitleMarkWordString = @"人";
        canClickBarChartCell.yTitleMarkWordString = @"课";
        
        if (self.viewModel.dataModel.coachCourseXTitleArray.count) {
            canClickBarChartCell.xTitleArray = self.viewModel.dataModel.coachCourseXTitleArray;
            canClickBarChartCell.valueArray = @[ self.viewModel.dataModel.coachCourseValueArray ];
            [canClickBarChartCell refreshUI];
        }
        canClickBarChartCell.tag = indexPath.row;
        return canClickBarChartCell;
    }else {
        static NSString *kCanClickLineChartCellId = @"lineCanClickCell";
        HomeDetailEvaluationCell *canClickLineChartCell = [tableView dequeueReusableCellWithIdentifier:kCanClickLineChartCellId];
        if (!canClickLineChartCell) {
            canClickLineChartCell = [[HomeDetailEvaluationCell alloc] initWithWidth:self.bounds.size.width - 30 Style:UITableViewCellStyleDefault reuseIdentifier:kCanClickLineChartCellId];
            
            [canClickLineChartCell setClickBlock:^(NSInteger tag) {
                if (_evaluationBlock) {
                    _evaluationBlock(tag);
                }
//                NSLog(@"%li",tag);
            }];
        }
//        NSArray *ary_1 = @[@"22",@"44",@"15",@"40",@"42",@"25",@"15",@"30",@"42",@"32",@"40"];
//        NSArray *ary_2 = @[@"23",@"0",@"5",@"5",@"0",@"4",@"3",@"0",@"4",@"5",@"7"];
//        NSArray *ary_3 = @[@"0",@"0",@"2",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0" ];
////        NSArray *ary_4 = @[@"0",@"5",@"3",@"7",@"2",@"9",@"0",@"15",@"5",@"4"];
//        NSArray *ary_4 = @[@"0",@"0",@"0",@"0",@"0",@"1",@"0",@"0",@"0",@"0"];
        
//        canClickLineChartCell.xTitleArray = @[ @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日" ];
//        canClickLineChartCell.valueArray = @[ ary_1, ary_2, ary_3, ary_4 ];
        
        canClickLineChartCell.titleLabel.text = @"评价";
        canClickLineChartCell.markLabel.text = @"详情";
        canClickLineChartCell.markImageView.image = [UIImage imageNamed:@"xq"];
        
        canClickLineChartCell.xTitleMarkWordString = @"周";
        canClickLineChartCell.yTitleMarkWordString = @"个";
        
        if (self.viewModel.dataModel.evaluateXTitleArray.count) {
            
//            canClickLineChartCell.xTitleArray = self.viewModel.dataModel.evaluateXTitleArray;
            canClickLineChartCell.xTitleArray = @[ @"16",@"2" ];

            canClickLineChartCell.valueArray = @[ self.viewModel.dataModel.goodValueArray,
                                                  self.viewModel.dataModel.generalValueArray,
                                                  self.viewModel.dataModel.badValueArray,
                                                  self.viewModel.dataModel.complaintValueArray ];
//            canClickLineChartCell.valueArray = @[ @[@"1"],@[@"6"],@[@"3"]];
            [canClickLineChartCell refreshUI];
        }
        
        canClickLineChartCell.tag = indexPath.row;
        return canClickLineChartCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        return [HomeDetailEvaluationCell new].defaultHeight + 20;
    }
    return [HomeDetailNormalLineChartCell new].defaultHeight + 20;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
