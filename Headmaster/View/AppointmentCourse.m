//
//  AppointmentCourse.m
//  SingerDataView
//
//  Created by ytzhang on 15/11/30.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "AppointmentCourse.h"
#import <Masonry/Masonry.h>
#import "UILabel+LabelAdjustBig.h"

#import "YBLineChartView.h"

#define kSystemW [UIScreen mainScreen].bounds.size.width
#define kSystemH [UIScreen mainScreen].bounds.size.height
@interface AppointmentCourse()
@property (nonatomic,assign) CGFloat resuleW;
/**
 *
 * 约课
 *
 */
@property(nonatomic,strong) UILabel *appintmentCoureLabel;
/**
 *
 * 预课总人数
 *
 */
@property (nonatomic,strong) UILabel *allPeopelNumberLabel;
/**
 *
 *  约课的表格视图
 *
 */
//@property (nonatomic,strong) UIView *appintmentChartView;
@property (nonatomic,strong) YBLineChartView *appintmentChartView;

@end

@implementation AppointmentCourse

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.appintmentCoureLabel];
        [self addSubview:self.allPeopelNumberLabel];
        [self addSubview:self.appintmentChartView];
    }
    return self;
}

- (UILabel *)appintmentCoureLabel
{
    if (_appintmentCoureLabel == nil) {
        _appintmentCoureLabel = [[UILabel alloc] init];
        _appintmentCoureLabel.text = @"约课";
        _appintmentCoureLabel.font = [UIFont systemFontOfSize:16.f];
        _appintmentCoureLabel.textColor = [UIColor colorWithHexString:@"01e2b6"];
        
        
    }
    return _appintmentCoureLabel;
}
- (UILabel *)allPeopelNumberLabel
{
    if (_allPeopelNumberLabel == nil) {
        
        _allPeopelNumberLabel = [[UILabel alloc] init];
        NSString *str = [NSString stringWithFormat:@"共%d人",3333];
         _allPeopelNumberLabel.text = str;
        // 自适应宽高
        _resuleW  = [UILabel initWithUILabel:str font:16.f].size.width;
        _allPeopelNumberLabel.font = [UIFont systemFontOfSize:16.f];
        _allPeopelNumberLabel.textColor = [UIColor colorWithHexString:@"01e2b6"];
    }
    return _allPeopelNumberLabel;
}
- (YBLineChartView *)appintmentChartView
{
    if (_appintmentChartView == nil) {
        _appintmentChartView = [[YBLineChartView alloc]init];
        [_appintmentChartView refreshUI];
//        _appintmentChartView.backgroundColor = [UIColor grayColor];
        
    }
    return _appintmentChartView;
}
- (void)layoutSubviews
{
    
    [self.appintmentCoureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).with.offset(0);
        make.left.mas_equalTo(self.mas_left).with.offset((kSystemW - 30) / 2);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@40);
    }];
    
    [self.allPeopelNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.mas_equalTo(_appintmentCoureLabel.mas_right).with.offset(100);
        make.top.mas_equalTo(self.mas_top).with.offset(0);
        make.right.mas_equalTo(self.mas_right).with.offset(-16);
        make.width.mas_equalTo(_resuleW);
        make.height.mas_equalTo(@30);
    }];
    
    [self.appintmentChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(16);
        make.right.mas_equalTo(self.mas_right).with.offset(-16);
        make.top.mas_equalTo(_appintmentCoureLabel.mas_bottom).with.offset(10);
        make.height.mas_equalTo(150);
    }];

}
@end
