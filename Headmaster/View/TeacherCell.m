//
//  TeacherCell.m
//  Headmaster
//
//  Created by kequ on 15/12/1.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "TeacherCell.h"
#import "CWStarRateView.h"

@interface TeacherCell()
@property(nonatomic,strong)UIImageView * iconView;
@property(nonatomic,strong)UILabel * titleLabel;
@property (nonatomic, strong) UILabel *teachcontentLabel;
@property (nonatomic, strong) UIView *flagView;
@property (nonatomic, strong) UILabel *teachStateLabel;
@property (nonatomic, strong) UILabel *todeyTimeLabel;
@property(nonatomic,strong)CWStarRateView * rateView;
@property (nonatomic, strong) UILabel *passLabel;



@property (nonatomic, strong) UIButton *phoneButton;
@property(nonatomic,strong)UIView * bottonLineView;
@end

@implementation TeacherCell

+ (CGFloat)cellHigth
{
    return 96.f;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
        
    }
    return self;
}

- (void)initUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.iconView];
    
    // 姓名
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font =[UIFont systemFontOfSize:16.f];
    if (YBIphone6Plus) {
        self.titleLabel.font =[UIFont systemFontOfSize:16.f*YBRatio];
    }
    self.titleLabel.textColor = kJZDarkTextColor;
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    
    // 教学科目
    self.teachcontentLabel = [[UILabel alloc] init];
//   self.teachcontentLabel.text = @"科目二 科目三";
    self.teachcontentLabel.textColor = kJZLightTextColor;
   self.teachcontentLabel.font = [UIFont systemFontOfSize:12];
    if (YBIphone6Plus) {
        self.teachcontentLabel.font = [UIFont systemFontOfSize:12*YBRatio];
    }
    self.teachcontentLabel.backgroundColor =  [UIColor clearColor];
    
    // 通过率
    self.passLabel = [[UILabel alloc] init];
    self.passLabel.text = @"通过率 98%";
    self.passLabel.textColor = kJZLightTextColor;
    self.passLabel.font = [UIFont systemFontOfSize:12];
    if (YBIphone6Plus) {
        self.passLabel.font = [UIFont systemFontOfSize:12*YBRatio];
    }
    self.passLabel.backgroundColor =  [UIColor clearColor];

    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.teachcontentLabel];
    [self.contentView addSubview:self.passLabel];
    
    [self.contentView addSubview:self.flagView];
    [self.contentView addSubview:self.teachStateLabel];
    [self.contentView addSubview:self.todeyTimeLabel];
    
    self.rateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(0, 0, 90, 14.f) numberOfStars:5];
    [self.rateView setUserInteractionEnabled:NO];
    self.rateView.scorePercent = (2.5 / 5.f);
    [self.contentView addSubview:self.rateView];
    
    // 电话
    self.phoneButton = [[UIButton alloc] init];
    [self.phoneButton setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [self.phoneButton addTarget:self action:@selector(messageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.phoneButton];
    self.phoneButton.tag = 601;
    self.bottonLineView = [self getOnelineView];
    self.phoneButton.imageEdgeInsets = UIEdgeInsetsMake(16, 8, 0, 0);
//    self.phoneButton.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:self.bottonLineView];
    
//    [self setNeedsUpdateConstraints];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(16);
        make.left.equalTo(self.contentView).offset(16.f);
        make.height.equalTo(@36.f);
        make.width.equalTo(@36.f);
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(14.f);
        make.top.equalTo(self.iconView.mas_top);
        make.height.equalTo(@14);
        
    }];
    
    [self.teachcontentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10.f);
        make.height.equalTo(@12);
        
    }];
    
    [self.flagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.iconView.mas_centerX);
        make.top.equalTo(self.iconView.mas_bottom).offset(14);
        make.height.equalTo(@14);
        make.width.equalTo(@14);
        
    }];
    
    
    [self.teachStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.flagView.mas_top);
        make.height.equalTo(@14);
        
    }];
    [self.todeyTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.teachStateLabel.mas_right).offset(4);
        make.top.equalTo(self.flagView.mas_top);
        make.height.equalTo(@14);
        
    }];
    
    [self.rateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(16.f);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.width.equalTo(@(90));
        make.height.equalTo(@(14.f));
    }];
    [self.passLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rateView.mas_bottom).offset(12.f);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.height.equalTo(@(12.f));
    }];
    
    
    [self.phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passLabel.mas_bottom).offset(-5);
        make.right.equalTo(self.contentView).offset(-16);
        make.width.equalTo(@(28));
        make.height.equalTo(@(36.f));
    }];
    
    [self.bottonLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0.f);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.height.equalTo(@0.5);
    }];

}

//- (void)updateConstraints
//{
//    [super updateConstraints];
//    
//
//}

- (void)setModel:(TeacherModel *)model
{
    if (_model == model) {
        return;
    }
    _model = model;
    UIImage * defaultImage = [UIImage imageNamed:@"defoult_por"];
    NSString * imageStr = _model.porInfo.originalpic;
    self.iconView.image = defaultImage;
    if(imageStr)
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:defaultImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];

    self.titleLabel.text = _model.userName;
    
    // 可授科目
    NSMutableString *subStr = [NSMutableString string];
    for (int i = 0; i < model.subjectArray.count; i++) {
        NSDictionary *dict = model.subjectArray[i];
        [subStr appendFormat:@"%@ ",dict[@"name"]];
    }
    self.teachcontentLabel.text = subStr;
    self.passLabel.text = [NSString stringWithFormat:@"通过率 %lu%%",model.passrate];
    self.rateView.scorePercent = _model.raring  / 5.f;
    
    // 是否在授课  0 是休息, 1 正在授课
    if (model.isonline) {
        // 正在授课
        self.flagView.backgroundColor = JZ_BLUE_COLOR;
        self.teachStateLabel.text = @"正在授课";
        self.todeyTimeLabel.text = [NSString stringWithFormat:@"今日%lu课时",model.coursecountr];
    }else{
        // 休息
        self.flagView.backgroundColor = kJZLightTextColor;
        self.teachStateLabel.text = @"休息";
        self.todeyTimeLabel.text = [NSString stringWithFormat:@"今日%lu课时",model.coursecountr];
    }
    
}

#pragma mark Aciton
// 信息
- (void)messageButtonClick:(UIButton *)button
{
    if ([_delegate respondsToSelector:@selector(teacherCell:didClickMessageButton:)]) {
        [_delegate teacherCell:self didClickMessageButton:button];
    }
}


#pragma mark - HightStatu
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
}

#pragma mark - Common
- (UIView *)getOnelineView
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = HM_LINE_COLOR;
    return view;
}
-(UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.layer.masksToBounds = YES;
       _iconView.layer.cornerRadius = 18;

    }
    return _iconView;
}
- (UIView *)flagView{
    if (_flagView == nil) {
        _flagView = [[UIView alloc] init];
        _flagView.backgroundColor = JZ_BLUE_COLOR;
        _flagView.layer.masksToBounds = YES;
        _flagView.layer.cornerRadius = 7;
    }
    return _flagView;
}
- (UILabel *)teachStateLabel{
    if (_teachStateLabel == nil) {
        _teachStateLabel = [[UILabel alloc] init];
        _teachStateLabel.textColor = JZ_BLUE_COLOR;
        _teachStateLabel.font = [UIFont systemFontOfSize:12];
        _teachStateLabel.text = @"正在授课";
    }
    return _teachStateLabel;
}
- (UILabel *)todeyTimeLabel{
    if (_todeyTimeLabel == nil) {
        _todeyTimeLabel = [[UILabel alloc] init];
        _todeyTimeLabel.textColor = kJZDarkTextColor;
        _todeyTimeLabel.font = [UIFont systemFontOfSize:12];
        _todeyTimeLabel.text = @"今日8课时";
    }
    return _todeyTimeLabel;
}

@end
