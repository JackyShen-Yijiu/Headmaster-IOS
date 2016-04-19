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
@property (nonatomic, strong) UILabel *teachcontentLabel;
@property (nonatomic, strong) UILabel *passLabel;

@property(nonatomic,strong)CWStarRateView * rateView;

@property(nonatomic,strong)UIButton * messageButton;
@property (nonatomic, strong) UIButton *phoneButton;
@property(nonatomic,strong)UIView * bottonLineView;
@end

@implementation TeacherCell

+ (CGFloat)cellHigth
{
    return 90.f;
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
    self.porView = [[PortraitView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [self.contentView addSubview:self.porView];
    
    // 姓名
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font =[UIFont systemFontOfSize:16.f];
    self.titleLabel.textColor = JZ_FONTCOLOR_WHITE;
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    
    // 教学科目
    self.teachcontentLabel = [[UILabel alloc] init];
   self.teachcontentLabel.text = @"科目二 科目三";
    self.teachcontentLabel.textColor = JZ_FONTCOLOR_LIGHTWHITE;
   self.teachcontentLabel.font = [UIFont systemFontOfSize:12];
    self.teachcontentLabel.backgroundColor =  [UIColor clearColor];
    
    // 通过率
    self.passLabel = [[UILabel alloc] init];
    self.passLabel.text = @"通过率 98%";
    self.passLabel.textColor = JZ_FONTCOLOR_LIGHTWHITE;
    self.passLabel.font = [UIFont systemFontOfSize:12];
    self.passLabel.backgroundColor =  [UIColor clearColor];

    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.teachcontentLabel];
    [self.contentView addSubview:self.passLabel];
    
    self.rateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(0, 0, 90, 14.f) numberOfStars:5];
    [self.rateView setUserInteractionEnabled:NO];
    self.rateView.scorePercent = (2.5 / 5.f);
    [self.contentView addSubview:self.rateView];
    
    // 信息
    self.messageButton = [[UIButton alloc] init];
    [self.messageButton setImage:[UIImage imageNamed:@"chat"] forState:UIControlStateNormal];
    [self.messageButton addTarget:self action:@selector(messageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.messageButton.tag = 600;
    [self.contentView addSubview:self.messageButton];
    
    // 电话
    self.phoneButton = [[UIButton alloc] init];
    [self.phoneButton setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [self.phoneButton addTarget:self action:@selector(messageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.phoneButton];
    self.phoneButton.tag = 601;
    self.bottonLineView = [self getOnelineView];
    [self.contentView addSubview:self.bottonLineView];
    
    [self setNeedsUpdateConstraints];
}


- (void)updateConstraints
{
    [super updateConstraints];
    [self.porView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(44.f));
        make.width.equalTo(@(44.f));
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(16.f);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.porView.mas_right).offset(14.f);
        make.top.equalTo(self.contentView).offset(18.f);
        
    }];
    
    [self.teachcontentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8.f);
        
    }];
    [self.passLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.teachcontentLabel.mas_bottom).offset(8.f);
        
    }];
    
    [self.rateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(21.f);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.width.equalTo(@(90));
        make.height.equalTo(@(14.f));
    }];
    
    [self.phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.rateView.mas_bottom).offset(16.f);
        make.right.equalTo(self.contentView).offset(-16);
        make.width.equalTo(@(20));
        make.height.equalTo(@(20.f));
    }];
    
    [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rateView.mas_bottom).offset(16.f);
        make.right.equalTo(self.phoneButton.mas_left).offset(-16);
        make.width.equalTo(@(20));
        make.height.equalTo(@(20.f));
    }];
    
    [self.bottonLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0.f);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.height.equalTo(@0.5);
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
    self.porView.imageView.image = defaultImage;
    if(imageStr)
        [self.porView.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:defaultImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
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
    view.backgroundColor = RGB_Color(52, 54, 53);
    return view;
}

@end
