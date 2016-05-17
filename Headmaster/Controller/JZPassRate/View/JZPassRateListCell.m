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

@property (nonatomic, assign) CGFloat fontSmallSize;

@property (nonatomic, assign) CGFloat fontBigSize;

@property (nonatomic, assign) CGFloat headerH;

@end

@implementation JZPassRateListCell

- (void)awakeFromNib {
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        if (YBIphone6Plus) {
            _fontBigSize = 14 * YBRatio;
            _fontSmallSize = 12 * YBRatio;
            _headerH = 44 * YBRatio;
        }else{
            _fontBigSize = 14;
            _fontSmallSize = 12;
            _headerH = 44 ;
            
        }

        [self initUI];
    }
    return self;
}
- (void)initUI{
    self.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
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
    
    
    NSNumber *numberSmall = [NSNumber numberWithFloat:_fontSmallSize];
    NSNumber *numberBig = [NSNumber numberWithFloat:_fontBigSize];
    NSNumber *numberheadeH = [NSNumber numberWithFloat:_headerH];
    
    
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(14);
        make.left.mas_equalTo(self.contentView.mas_left).offset(16);
        make.height.mas_equalTo(numberBig);
        
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(12);
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.height.mas_equalTo(numberSmall);
        
    }];
    
    [self.passRateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_top);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
        make.height.mas_equalTo(numberBig);
        
    }];

       [self.passRateResultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passRateTitleLabel.mas_bottom).offset(12);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
        make.height.mas_equalTo(numberSmall);
        
        
    }];
    
    
    [self.examNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(14);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.height.mas_equalTo(numberheadeH);
    }];
    
    
}
#pragma mark --- Lazy 加载

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kJZDarkTextColor;
        _titleLabel.font = [UIFont systemFontOfSize:_fontBigSize];
        _titleLabel.text = @"考试三";
    }
    return _titleLabel;
}
- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = kJZLightTextColor;
        _timeLabel.font = [UIFont systemFontOfSize:_fontSmallSize];
        _timeLabel.text = @"2016/04/12";
    }
    return _timeLabel;
}

- (UILabel *)passRateTitleLabel{
    if (_passRateTitleLabel == nil) {
        _passRateTitleLabel = [[UILabel alloc] init];
        _passRateTitleLabel.textColor = kJZDarkTextColor;
        _passRateTitleLabel.font = [UIFont systemFontOfSize:_fontSmallSize];
        _passRateTitleLabel.text = @"通过率";
    }
    return _passRateTitleLabel;
}

- (UILabel *)passRateResultLabel{
    if (_passRateResultLabel == nil) {
        _passRateResultLabel = [[UILabel alloc] init];
        _passRateResultLabel.textColor = [UIColor colorWithHexString:@"e80031"];
        _passRateResultLabel.font = [UIFont systemFontOfSize:_fontBigSize];
        _passRateResultLabel.text = @"100%";
    }
    return _passRateResultLabel;
}
- (JZPassRateListExamNumberView *)examNumberView{
    if (_examNumberView == nil) {
        _examNumberView = [[JZPassRateListExamNumberView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.timeLabel.frame) + 14, self.width, _headerH)];
    }
    return _examNumberView;
}
#pragma mark --- 数据
- (void)setModel:(JZPassRateListModel *)model{
    /*
     data =     (
     {
     examdate = "2016-5-16";
     missexamstudent = 0;
     nopassstudent = 0;
     passrate = 1;
     passstudent = 1;
     studentcount = 1;
     subject = 1;
     }
     );

     */
    self.titleLabel.text = @"";
    self.timeLabel.text = model.examdate;
    self.passRateResultLabel.text = [NSString stringWithFormat:@"%lu%%",model.passrate];
    self.examNumberView.examLabel.resultStr = [NSString stringWithFormat:@"%lu人",model.studentcount];
    self.examNumberView.noexamLabel.resultStr = [NSString stringWithFormat:@"%lu人",model.missexamstudent];
    self.examNumberView.nopassLabel.resultStr = [NSString stringWithFormat:@"%lu人",model.missexamstudent];

    
    
    
}
@end
