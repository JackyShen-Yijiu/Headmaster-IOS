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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview: self.inviteStudentLabel];
        [self addSubview:self.inviteStudentNumberLabel];
        [self addSubview:self.chartView];
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

- (void)layoutSubviews{
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

}
@end
