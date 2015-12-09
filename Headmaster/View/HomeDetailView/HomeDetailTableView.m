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

@interface HomeDetailTableView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) ClickBlock coachTeacherBlock;

@property (nonatomic, copy) ClickBlock evaluationBlock;

@end

@implementation HomeDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setCoachTeacherClickBlock:(void (^)(NSInteger))handle {
    _coachTeacherBlock = handle;
}

- (void)setEvaluationClickBlock:(void (^)(NSInteger))handle {
    _evaluationBlock = handle;
}

#pragma mark - tableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        static NSString *kNormalLineChartCellId = @"lineCell";
        HomeDetailNormalLineChartCell *normalLineChartCell = [tableView dequeueReusableCellWithIdentifier:kNormalLineChartCellId];
        if (!normalLineChartCell) {
            normalLineChartCell = [[HomeDetailNormalLineChartCell alloc] initWithWidth:self.bounds.size.width - 30 Style:UITableViewCellStyleDefault reuseIdentifier:kNormalLineChartCellId];
        }
        NSArray *ary_1 = @[@"22",@"44",@"15",@"40",@"42",@"25",@"15",@"30",@"42",@"32",@"40"];
        NSArray *ary_2 = @[@"23",@"42",@"25",@"15",@"30",@"42",@"32",@"40",@"42",@"25",@"33"];
        
        normalLineChartCell.xTitleArray = @[ @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日" ];
        normalLineChartCell.valueArray = @[ ary_1, ary_2 ];
        normalLineChartCell.xTitleMarkWordString = @"周";
        normalLineChartCell.yTitleMarkWordString = @"年";
        if (indexPath.row == 0) {
            normalLineChartCell.titleLabel.text = @"招生";
            normalLineChartCell.markLabel.text = @"共33333人";
        }else
        {
            normalLineChartCell.titleLabel.text = @"约课";
            normalLineChartCell.markLabel.text = @"共33333人";
        }
        
        [normalLineChartCell refreshUI];
        
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
        NSArray *ary_1 = @[@"22",@"44",@"15",@"40",@"42",@"25",@"15",@"30",@"42",@"32",@"40"];
        
        canClickBarChartCell.xTitleArray = @[ @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日" ];
        canClickBarChartCell.valueArray = @[ ary_1 ];
        canClickBarChartCell.xTitleMarkWordString = @"周";
        canClickBarChartCell.yTitleMarkWordString = @"年";
        canClickBarChartCell.titleLabel.text = @"教练授课";
        canClickBarChartCell.markLabel.text = @"详情";
        canClickBarChartCell.markImageView.image = [UIImage imageNamed:@"xq"];
        canClickBarChartCell.tag = indexPath.row;
        [canClickBarChartCell refreshUI];
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
        NSArray *ary_1 = @[@"22",@"44",@"15",@"40",@"42",@"25",@"15",@"30",@"42",@"32",@"40"];
        NSArray *ary_2 = @[@"23",@"42",@"25",@"15",@"30",@"42",@"32",@"40",@"42",@"25",@"33"];
        
        canClickLineChartCell.xTitleArray = @[ @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日" ];
        canClickLineChartCell.valueArray = @[ ary_1, ary_2 ];
        canClickLineChartCell.xTitleMarkWordString = @"周";
        canClickLineChartCell.yTitleMarkWordString = @"年";
        canClickLineChartCell.titleLabel.text = @"评价";
        canClickLineChartCell.markLabel.text = @"详情";
        canClickLineChartCell.markImageView.image = [UIImage imageNamed:@"xq"];
        canClickLineChartCell.tag = indexPath.row;
        [canClickLineChartCell refreshUI];
        return canClickLineChartCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        return [HomeDetailEvaluationCell new].defaultHeight;
    }
    return [HomeDetailNormalLineChartCell new].defaultHeight;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
