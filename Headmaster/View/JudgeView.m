//
//  JudgeView.m
//  SingerDataView
//
//  Created by ytzhang on 15/12/1.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "JudgeView.h"

#import <Masonry/Masonry.h>


# define ksystemH [UIScreen mainScreen].bounds.size.height
# define ksystemW [UIScreen mainScreen].bounds.size.width
@interface JudgeView()

@end

@implementation JudgeView



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.judgeLabel];
        [self addSubview:self.judgeButton];
        [self addSubview:self.judgeChart];
        [self addSubview:self.signView];

    }
    return self;
}
- (UILabel *)judgeLabel
{
    if (_judgeLabel == nil) {
        _judgeLabel = [[UILabel alloc]init];
        _judgeLabel.text = @"评价";
        _judgeLabel.font = [UIFont systemFontOfSize:16.0];
        _judgeLabel.textColor = [UIColor colorWithHexString:@"01e2b6"];
        
        
    }
    
    return _judgeLabel;
}
- (UIButton *)judgeButton
{
    if (_judgeButton == nil) {
        _judgeButton = [[UIButton alloc] init];
        [_judgeButton setTitle:@"详情" forState:UIControlStateNormal];
        
        _judgeButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        
        [_judgeButton setTitleColor:[UIColor colorWithHexString:@"047a64"] forState:UIControlStateNormal];
        _judgeButton.titleEdgeInsets = UIEdgeInsetsMake(5, -17, 5, 1);
        
        [_judgeButton setImage:[UIImage imageNamed:@"xq.png"] forState:UIControlStateNormal];
        _judgeButton.imageEdgeInsets = UIEdgeInsetsMake(0,26,0,0);
    }
    
    return _judgeButton;
}
- (YBLineChartView *)judgeChart
{
    if (_judgeChart == nil) {
        _judgeChart = [[YBLineChartView alloc] init];
    }
    return _judgeChart;
}
- (ZTJudgeBottonSign *)signView
{
    if (_signView == nil) {
        _signView = [[ZTJudgeBottonSign alloc] init];
        
    }
    
    
    return _signView;
}

/**
 *
 *  添加约束
 *
 */
- (void)layoutSubviews{
    
    [_judgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo((ksystemW - 40) / 2);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@40);
        make.top.mas_equalTo(self.mas_top).with.offset(0);
    }];
    
    [self.judgeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).with.offset(-16);
        make.height.mas_equalTo(@10);
         make.width.mas_equalTo(@30);
        make.top.mas_equalTo(self.mas_top).with.offset(10);
    }];
    
    [self.judgeChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(16);
        make.right.mas_equalTo(self.mas_right).with.offset(-16);
        make.top.mas_equalTo(_judgeLabel.mas_bottom).with.offset(10);
        make.height.mas_equalTo(150);
    }];
    [self.signView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(40);
        make.right.mas_equalTo(self.mas_right).with.offset(-40);
        make.top.mas_equalTo(_judgeChart.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@50);
    }];

    
}


@end
