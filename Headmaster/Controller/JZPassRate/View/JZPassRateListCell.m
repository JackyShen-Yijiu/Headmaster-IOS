//
//  JZPassRateListCell.m
//  Headmaster
//
//  Created by ytzhang on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZPassRateListCell.h"

#import "JZPassRateListExamNumberView.h"
@interface JZPassRateListCell ()


@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *passRateTitleLabel; // 通过率

@property (nonatomic, strong) UILabel *passRateResultLabel;

@property (nonatomic, strong) JZPassRateListExamNumberView *examNumberView;


@end

@implementation JZPassRateListCell

- (void)awakeFromNib {
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];

    [self.contentView addSubview:self.passRateTitleLabel];
     [self.contentView addSubview:self.passRateResultLabel];
    
    [self.contentView addSubview:self.examNumberView];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
- (void)layoutSubviews{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(14);
        make.left.mas_equalTo(self.contentView.mas_left).offset(12);
        make.height.mas_equalTo(@14);
        
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(12);
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.height.mas_equalTo(@12);
        
    }];
    
    [self.passRateResultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_top);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-12);
        make.height.mas_equalTo(@14);
        
    }];

       [self.passRateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passRateResultLabel.mas_bottom).offset(12);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-12);
        make.height.mas_equalTo(@12);
        
        
    }];
    
    
    [self.examNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(14);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.height.mas_equalTo(@44);
    }];
    
    
}
#pragma mark --- Lazy 加载

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = JZ_FONTCOLOR_LIGHTWHITE;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.text = @"考试三";
    }
    return _titleLabel;
}
- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = JZ_FONTCOLOR_LIGHTWHITE;
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.text = @"2016/04/12";
    }
    return _timeLabel;
}

- (UILabel *)passRateTitleLabel{
    if (_passRateTitleLabel == nil) {
        _passRateTitleLabel = [[UILabel alloc] init];
        _passRateTitleLabel.textColor = JZ_FONTCOLOR_LIGHTWHITE;
        _passRateTitleLabel.font = [UIFont systemFontOfSize:12];
        _passRateTitleLabel.text = @"通过率";
    }
    return _passRateTitleLabel;
}

- (UILabel *)passRateResultLabel{
    if (_passRateResultLabel == nil) {
        _passRateResultLabel = [[UILabel alloc] init];
        _passRateResultLabel.textColor = JZ_FONTCOLOR_LIGHTWHITE;
        _passRateResultLabel.font = [UIFont systemFontOfSize:12];
        _passRateResultLabel.text = @"100%";
    }
    return _passRateResultLabel;
}
- (JZPassRateListExamNumberView *)examNumberView{
    if (_examNumberView == nil) {
        _examNumberView = [[JZPassRateListExamNumberView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.timeLabel.frame) + 14, self.width, 44)];
    }
    return _examNumberView;
}
#pragma mark --- 数据
- (void)setModel:(JZPassRateListModel *)model{
    
}
@end
