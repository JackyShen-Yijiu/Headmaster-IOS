//
//  RecomendCell.m
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "RecomendCell.h"
#import "PortraitView.h"
#import "CWStarRateView.h"
#import "HMSwitch.h"

@interface RecomendCell()

@property(nonatomic,assign)KRecomendCellType  cellType;

@property(nonatomic,strong)CWStarRateView * rateView;
@property(nonatomic,strong)HMSwitch * switchButton;
@property(nonatomic,strong)UILabel * courseType;
@property(nonatomic,strong)UILabel * courseName;
@property(nonatomic,strong)UILabel * recomendContent;
@property(nonatomic,strong)UILabel * recomendTime;

@property(nonatomic,strong)UILabel * coaName;
@property(nonatomic,strong)PortraitView * coaPorView;
@property(nonatomic,strong)UIButton * coaButton;

@property(nonatomic,strong)UILabel * stuName;
@property(nonatomic,strong)PortraitView * stuPorView;
@property(nonatomic,strong)UIButton * stuMessButton;

@property(nonatomic,strong)UIView * lineView;
@end

@implementation RecomendCell

+ (CGFloat)cellHigthWithModel:(HMRecomendModel *)model
{
    CGFloat heigth = 0;
    heigth += 19.f + 39 + 14.f;
    heigth += 12.f;
    heigth += 14.f;
    
    if (model.recomendContent) {
        
        heigth += 14.f;
        UILabel * label = [self reconedContentLabel];
        [label setAttributedText:[self addLineSpacing:model.recomendContent]];
        CGSize size = [label sizeThatFits:CGSizeMake([[UIScreen mainScreen] bounds].size.width - 30, 10000)];
        
//        CGRect bounds = [model.recomendContent boundingRectWithSize:
//                       CGSizeMake([[UIScreen mainScreen] bounds].size.width - 30, 10000) options:
//                       NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} context:nil];
        heigth += size.height;
    }
    heigth += 20.f;
    heigth += 14.f;
    heigth += 12.f;
    
    return heigth;
}

+ (UILabel *)reconedContentLabel
{
    UILabel * label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14.f];
    if (YBIphone6Plus) {
        label.font = [UIFont systemFontOfSize:14.f*YBRatio];
    }
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.textColor = RGB_Color(0xbf, 0xbf, 0xbf);
    return label;

}

+ (NSAttributedString *)addLineSpacing:(NSString *)str
{
    NSMutableAttributedString * attr = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:4];
    [attr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [attr length])];
    return attr;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(KRecomendCellType )type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellType = type;
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    
    
    self.stuPorView = [[PortraitView alloc] initWithFrame:CGRectMake(0, 0, 39, 39)];
    self.stuPorView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.stuPorView];
    
    self.stuMessButton = [[UIButton alloc] init];
    [self.stuMessButton setImage:[UIImage imageNamed:@"imessageButton"] forState:UIControlStateNormal];
    [self.stuMessButton addTarget:self action:@selector(messageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.stuMessButton];

    
    self.stuName = [self getOnePropertyLabel];
    [self.contentView addSubview:self.stuName];
    
    self.coaPorView = [[PortraitView alloc] initWithFrame:CGRectMake(0, 0, 39, 39)];
    self.coaPorView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.coaPorView];
    
    self.coaButton = [[UIButton alloc] init];
    [self.coaButton setImage:[UIImage imageNamed:@"imessageButton"] forState:UIControlStateNormal];
    [self.coaButton addTarget:self action:@selector(messageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.coaButton];

    self.coaName = [self getOnePropertyLabel];
    [self.contentView addSubview:self.coaName];
    
    if (self.cellType == KRecomendCellTypeDefoult ) {
        self.rateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(0, 0, 146, 23.f) numberOfStars:5];
        [self.rateView setUserInteractionEnabled:NO];
        [self.contentView addSubview:self.rateView];
    }else{
        self.switchButton = [[HMSwitch alloc] init];
        self.switchButton.backgroundColor = [UIColor clearColor];
        [self.switchButton setOn:NO];
        [self.switchButton addTarget:self action:@selector(switchButtonDidValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:self.switchButton];
        
    }
 
    self.courseType = [self getOnePropertyLabel];
    self.courseType.font = [UIFont systemFontOfSize:12.f];
    if (YBIphone6Plus) {
        self.courseType.font = [UIFont systemFontOfSize:12.f*YBRatio];
    }
    [self.contentView addSubview:self.courseType];
    
    self.courseName = [self getOnePropertyLabel];
    self.courseName.font = [UIFont systemFontOfSize:12.f];
    if (YBIphone6Plus) {
        self.courseName.font = [UIFont systemFontOfSize:12.f*YBRatio];
    }
    [self.contentView addSubview:self.courseName];
    
    self.recomendContent = [[self class] reconedContentLabel];
    [self.contentView addSubview:self.recomendContent];
    
    
    
    self.recomendTime = [self getOnePropertyLabel];
//    self.recomendTime.textColor = RGB_Color(0x99, 0x99, 0x99);
    self.recomendTime.textColor = RGB_Color(0xbf, 0xbf, 0xbf);
    [self.contentView addSubview:self.recomendTime];
    
    [self updateConstraints];
}

#pragma mark Layout
- (void)updateConstraints
{
    
    [super updateConstraints];

    [self.stuPorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(19.f);
        make.left.equalTo(self).offset(15.f);
        make.width.equalTo(@(39));
        make.height.equalTo(@(39));
    }];

    [self.stuMessButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.stuPorView.mas_right).offset(-14);
        make.top.equalTo(self.stuPorView.mas_bottom).offset(-14);
        make.width.height.equalTo(@(28.f));
    }];

    [self.coaPorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.stuPorView);
        make.right.equalTo(self).offset(-19.f);
        make.top.equalTo(self.stuPorView);
    }];

    [self.coaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.stuMessButton);
        make.top.equalTo(self.stuMessButton.mas_top);
        make.right.equalTo(self.coaPorView.mas_left).offset(14.f);
    }];
    
    if (self.cellType == KRecomendCellTypeDefoult ) {
        [self.rateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(146));
            make.height.equalTo(@(23.f));
            make.centerX.equalTo(self);
            make.top.equalTo(self.stuPorView);
        }];
    }else{
        [self.switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.stuPorView);
            make.size.mas_equalTo(CGSizeMake(35, 22));
        }];
    }

//    [self.courseType mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.coaButton);
//        make.right.equalTo(self.courseName.mas_left).offset(-30);
//    }];
//
//    [self.courseName mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.courseName.mas_left).offset(-30);
//        make.centerY.equalTo(self.coaButton);
//    }];
    
    [self.stuName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.stuPorView);
        make.top.equalTo(self.stuMessButton.mas_bottom).offset(6.f);
        make.height.equalTo(@(14.f));
    }];

    
    [self.coaName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.coaPorView);
        make.top.equalTo(self.stuName);
        make.height.equalTo(@(14.f));
    }];
        
    [self.recomendContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stuName.mas_bottom).offset(14.f);
        make.left.equalTo(self.stuName);
        make.right.equalTo(self.coaPorView);
    }];
    
    
    [self.recomendTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.recomendContent.mas_bottom).offset(20);
        make.right.equalTo(self.coaPorView);
        make.height.equalTo(@(14.f));
    }];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.courseName sizeToFit];
    [self.courseType sizeToFit];
    CGFloat spacing = 10.f;
    CGFloat offsetX =( self.width - (self.courseType.width + self.courseName.width + spacing))/2.f;
    self.courseType.left = offsetX;
//    self.courseType.centerY = self.coaButton.centerY;
    self.courseType.top = 50;
    self.courseName.left = self.courseType.right + spacing;
//    self.courseName.centerY = self.coaButton.centerY;
    self.courseName.top = 50
    ;
}

#pragma mark - Data
- (void)setModel:(HMRecomendModel *)model
{
    if (_model == model) {
        return;
    }
    _model = model;
    UIImage * defaultImage = [UIImage imageNamed:@"defoult_por"];
    self.stuPorView.imageView.image = defaultImage;
    self.coaPorView.imageView.image = defaultImage;
    if(_model.stuPortrait.originalpic)
        [self.stuPorView.imageView sd_setImageWithURL:[NSURL URLWithString:_model.stuPortrait.originalpic] placeholderImage:defaultImage];
    if(_model.coaPortrait.originalpic)
        [self.coaPorView.imageView sd_setImageWithURL:[NSURL URLWithString:_model.coaPortrait.originalpic] placeholderImage:defaultImage];
    
    
    self.stuName.text = _model.studendName;
    self.coaName.text = _model.coaName;
    
    self.courseType.text = _model.courseType;
    self.courseName.text = _model.courseName;
    
    self.recomendContent.attributedText = [[self class] addLineSpacing:_model.recomendContent];
    
    
    NSArray *array = [_model.recomendDate componentsSeparatedByString:@"T"];
    self.recomendTime.text = array[0];    
//    self.recomendTime.text = _model.recomendDate;

    [self.rateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(146));
        make.height.equalTo(@(23.f));
        make.centerX.equalTo(self);
        make.top.equalTo(self.stuPorView);
    }];

    if ([model isKindOfClass:[HMRecomendModel class]]) {
        self.rateView.scorePercent = (_model.rating / 5.f);
    }else{
        [self.switchButton setOn:![(HMComplainModel *)self.model isDealDone]];
    }
}

#pragma mark - HightStatu
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
}

#pragma mark - CommonUI
- (UILabel *)getOnePropertyLabel
{
    UILabel * label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14.f];
    if (YBIphone6Plus) {
        label.font = [UIFont systemFontOfSize:14.f*YBRatio];
    }
    label.backgroundColor = [UIColor clearColor];
    label.textColor = RGB_Color(0xbf, 0xbf, 0xbf);
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 1;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    return label;
}

- (UIView *)getOnelineView
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = HM_LINE_COLOR;
    return view;
}

#pragma mark - Action
- (void)messageButtonClick:(UIButton *)button
{
    if (button == self.coaButton) {
        if ([_delegate respondsToSelector:@selector(recomendCell:DidCoaImessageButton:)]) {
            [_delegate recomendCell:self DidCoaImessageButton:button];
        }
    }else{
        if ([_delegate respondsToSelector:@selector(recomendCell:DidStuImessageButton:)]) {
            [_delegate recomendCell:self DidStuImessageButton:button];
        }
    }
}
- (void)switchButtonDidValueChanged:(UISwitch *)switchbutton
{
    
    if ([self.model isKindOfClass:[HMComplainModel class]]) {
        HMComplainModel * model = (HMComplainModel *)self.model;
        if (model.isDealDone == NO) {
            if ([_delegate respondsToSelector:@selector(complainCell:DidSwithcButttonValueChanged:)]) {
                [_delegate complainCell:self DidSwithcButttonValueChanged:switchbutton];
            }
        }
    }
}

@end
