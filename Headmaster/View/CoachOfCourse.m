//
//  CoachOfCourse.m
//  SingerDataView
//
//  Created by ytzhang on 15/12/1.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "CoachOfCourse.h"
#import <Masonry/Masonry.h>

#define kSystemW [UIScreen mainScreen].bounds.size.width
#define kSystemH [UIScreen mainScreen].bounds.size.height


@implementation CoachOfCourse
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.coachOfCourseLabel];
        [self addSubview:self.coachOfCourseButton];
        [self addSubview:self.coachOfCourseChart];

    }
    return self;
}

- (UILabel *)coachOfCourseLabel
{
    if (_coachOfCourseLabel == nil) {
        _coachOfCourseLabel = [[UILabel alloc]init];
        _coachOfCourseLabel.text = @"教练授课";
        _coachOfCourseLabel.font = [UIFont systemFontOfSize:16.0];
        _coachOfCourseLabel.textColor = [UIColor colorWithHexString:@"01e2b6"];
    }
    
    return _coachOfCourseLabel;
}
- (UIButton *)coachOfCourseButton
{
    if (_coachOfCourseButton == nil) {
        _coachOfCourseButton = [[UIButton alloc] init];
        [_coachOfCourseButton setTitle:@"详情" forState:UIControlStateNormal];
        _coachOfCourseButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_coachOfCourseButton setTitleColor:[UIColor colorWithHexString:@"047a64"] forState:UIControlStateNormal];
        _coachOfCourseButton.titleEdgeInsets = UIEdgeInsetsMake(5, -17, 5, 1);
        
        [_coachOfCourseButton setImage:[UIImage imageNamed:@"xq.png"] forState:UIControlStateNormal];
        _coachOfCourseButton.imageEdgeInsets = UIEdgeInsetsMake(0,26,0,0);
//        [_coachOfCourseButton addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _coachOfCourseButton;
}
- (YBBarChartView *)coachOfCourseChart
{
    if (_coachOfCourseChart == nil) {
        _coachOfCourseChart = [[YBBarChartView alloc] init];
        [_coachOfCourseChart refreshUI];
//        _coachOfCourseChart.backgroundColor = [UIColor redColor];
    }
    return _coachOfCourseChart;
}
//- (void)didClick:(UIButton *)btn
//{
//    if (_didClick) {
//        _didClick(btn);
//    }
//    NSLog(@"----");
//
//}


/**
 *
 *  添加约束
 *
 */
- (void)layoutSubviews{
    
    [_coachOfCourseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.mas_centerX);
        make.left.mas_equalTo(self.mas_left).with.offset((kSystemW - 60) / 2);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@80);
        make.top.mas_equalTo(self.mas_top).with.offset(0);
    }];
    
    [self.coachOfCourseButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_coachOfCourseLabel.mas_right).with.offset(70);
        make.right.mas_equalTo(self.mas_right).with.offset(-16);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@30);
        make.top.mas_equalTo(self.mas_top).with.offset(10);
    }];
    
    [self.coachOfCourseChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(16);
        make.right.mas_equalTo(self.mas_right).with.offset(-16);
        make.top.mas_equalTo(_coachOfCourseLabel.mas_bottom).with.offset(10);
        make.height.mas_equalTo(150);
    }];
//    self.coachOfCourseChart.frame = CGRectMake(0, 0, 200, 200);
    
    
}

@end
