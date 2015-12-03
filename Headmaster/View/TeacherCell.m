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
@property(nonatomic,strong)PortraitView * porView;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)CWStarRateView * rateView;
@property(nonatomic,strong)UIButton * messageButton;
@property(nonatomic,strong)UIView * bottonLineView;
@end

@implementation TeacherCell

+ (CGFloat)cellHigth
{
    return 83.f;
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
    self.porView = [[PortraitView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    [self.contentView addSubview:self.porView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font =[UIFont systemFontOfSize:16.f];
    self.titleLabel.textColor = RGB_Color(0xbf, 0xbf, 0xbf);
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.titleLabel];
    
    self.rateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(0, 0, 146, 23.f) numberOfStars:5];
    [self.rateView setUserInteractionEnabled:NO];
    self.rateView.scorePercent = (2.5 / 5.f);
    [self.contentView addSubview:self.rateView];
    
    self.messageButton = [[UIButton alloc] init];
    [self.messageButton setImage:[UIImage imageNamed:@"imessageButton"] forState:UIControlStateNormal];
    [self.messageButton addTarget:self action:@selector(messageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.messageButton];
    
    self.bottonLineView = [self getOnelineView];
    [self.contentView addSubview:self.bottonLineView];
    
    [self setNeedsUpdateConstraints];
}


- (void)updateConstraints
{
    [super updateConstraints];
    [self.porView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(70.f));
        make.width.equalTo(@(70.f));
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(10.f);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.porView.mas_right).offset(12.f);
        make.top.equalTo(self.contentView).offset(18.f);
        
    }];
    
    [self.rateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-17.f);
        make.left.equalTo(self.titleLabel);
        make.width.equalTo(@(146));
        make.height.equalTo(@(23.f));
    }];
    
    [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-20);
    }];

}

- (void)setModel:(TeacherModel *)model
{
    if (_model == model) {
        return;
    }
    _model = model;
    UIImage * defaultImage = [UIImage imageNamed:@"defoult_por"];
    NSString * imageStr = _model.porInfo.originalpic;
    if(imageStr)
        [self.porView.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:defaultImage];
    
    self.titleLabel.text = _model.userName;
    self.rateView.scorePercent = _model.raring  / 5.f;
    
}

#pragma mark Aciton
- (void)messageButtonClick:(UIButton *)button
{
    if ([_delegate respondsToSelector:@selector(teacherCell:didClickMessageButton:)]) {
        [_delegate teacherCell:self didClickMessageButton:button];
    }
}

#pragma mark - Common
- (UIView *)getOnelineView
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = HM_LINE_COLOR;
    return view;
}

@end
