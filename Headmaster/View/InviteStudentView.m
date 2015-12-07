//
//  InviteStudentView.m
//  SingerDataView
//
//  Created by ytzhang on 15/11/30.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "InviteStudentView.h"
#import <Masonry/Masonry.h>
#import "UILabel+LabelAdjustBig.h"

#define kSystemW [UIScreen mainScreen].bounds.size.width
#define kSystemH [UIScreen mainScreen].bounds.size.height

@interface InviteStudentView ()

@end

@implementation InviteStudentView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview: self.inviteStudentLabel];
        [self addSubview:self.inviteStudentNumberLabel];
        [self addSubview:self.chartView];
        // 添加约束
        [self addAutoLayout];
        
    }
    return self;
}
// *
// * UIlabel共同属性
// *
// */
- (void)addTitleWith:(NSString *)title titleLabel:(UILabel *)titleLabel
{
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:16.f];
    titleLabel.textColor = [UIColor colorWithHexString:@"01e2b6"];
//    [titleLabel setTextColor:[UIColor grayColor]];
    
}

/**
 *
 * 创建每一个UILabel
 *
 */
- (UILabel *)inviteStudentLabel
{
    if (_inviteStudentLabel == nil) {
        _inviteStudentLabel = [[UILabel alloc]init];
        [self addTitleWith:@"招生" titleLabel:_inviteStudentLabel];
    
    }
    return _inviteStudentLabel;
    
}
- (UILabel *)inviteStudentNumberLabel
{
    if (_inviteStudentNumberLabel == nil) {
        _inviteStudentNumberLabel = [[UILabel alloc]init];
        NSString *str = [NSString stringWithFormat:@"共%d人",44];
        // 自适应宽高
        _resuleW  = [UILabel initWithUILabel:str font:16.f].size.width;
        [self addTitleWith:str titleLabel:_inviteStudentNumberLabel];
        
    }
    return _inviteStudentNumberLabel;
    
}
- (YBLineChartView *)chartView
{
    if (_chartView == nil) {
        _chartView = [[YBLineChartView alloc] init];
        [_chartView refreshUI];
//        _chartView.backgroundColor = [UIColor redColor];
    }
    
    
    return _chartView;
}
- (void)addAutoLayout
{
   [self.inviteStudentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(self.mas_left).with.offset((kSystemW - 30) / 2);
       make.top.mas_equalTo(self.mas_top).with.offset(51);
       make.width.mas_equalTo(@40);
       make.height.mas_equalTo(@30);
   }];
    
    [self.inviteStudentNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_inviteStudentLabel.mas_right).with.offset(100);
        
        make.right.mas_equalTo(self.mas_right).with.offset(-16);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(_resuleW);
        make.top.mas_equalTo(self.mas_top).with.offset(51);
    }];
    
    [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(16);
        make.right.mas_equalTo(self.mas_right).with.offset(-16);
        make.top.mas_equalTo(_inviteStudentLabel.mas_bottom).with.offset(10);
        make.height.mas_equalTo(150);
    }];

    
//    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_inviteStudentLabel.mas_bottom).with.offset(2);
//        make.width.mas_equalTo(kSystemW);
//        make.height.mas_equalTo(@1);
//    }];
//    
//    [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(kSystemW);
//        make.height.mas_equalTo(@200);
//        make.top.mas_equalTo(_topView.mas_bottom).with.offset(5);
//        
//    }];
//    [self.upView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_chartView.mas_bottom).with.offset(5);
//        make.width.mas_equalTo(kSystemW);
//        make.height.mas_equalTo(@1);
//    }];
//    [self.anticipateView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.mas_left).with.offset(20);
//        make.top.mas_equalTo(_upView.mas_bottom).with.offset(20);
//        make.width.mas_equalTo(@15);
//        make.height.mas_equalTo(@0.9);
//        
//    }];
//    [self.anticipateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(_anticipateView.mas_centerX);
//        make.height.mas_equalTo(@150);
//        make.width.mas_equalTo(@150);
////        make.top.mas_equalTo(_upView.mas_bottom).with.offset(5);
//        make.left.mas_equalTo(_anticipateView.mas_right).with.offset(5);
//    }];
//
//    [self.signInStudentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(_anticipateLabel.mas_centerX);
//        make.width.mas_equalTo(@10);
//        make.height.mas_equalTo(@1);
//        make.right.mas_equalTo(_anticipateLabel.mas_left).with.offset(5);
//
//    }];
//    [self.signInLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(_signInStudentView.mas_centerX);
//        make.right.mas_equalTo(self.mas_right).with.offset(10);
//    }];
    
}
@end
