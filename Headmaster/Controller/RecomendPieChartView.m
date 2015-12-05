//
//  RecomendPieChartView.m
//  Headmaster
//
//  Created by kequ on 15/12/3.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "RecomendPieChartView.h"

#import "YBPieChartView.h"

@interface IconLabel : UIView
@property(nonatomic,strong)UILabel * label;
@property(nonatomic,strong)UIImageView * icon;

@end
@implementation IconLabel

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.label sizeToFit];
    CGFloat iconWidth = 24.f;
    CGFloat offset = (self.width - 14 - iconWidth - self.label.width)/2.f;
    self.icon.frame = CGRectMake(offset, self.height /2.f - 23.f/2.f, 24.f, 23.f);
    self.label.frame = CGRectMake(self.icon.right + 14.f, 0, self.label.width, self.height);
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:16.f];
        _label.textColor = RGB_Color(191, 191, 191);
        [self addSubview:_label];
    }
    return _label;
}


- (UIImageView *)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.backgroundColor = [UIColor clearColor];
        [self addSubview:_icon];
    }
    return _icon;
}
@end

@interface RecomendPieChartView()
@property(nonatomic,strong)YBPieChartView * charView;
@property(nonatomic,strong)UILabel * titleLabel;

@property(nonatomic,strong)IconLabel * poorRecomend;
@property(nonatomic,strong)IconLabel * midRecomend;
@property(nonatomic,strong)IconLabel * higRecomend;
@property(nonatomic,strong)UIImageView * lineImageView;
@end

@implementation RecomendPieChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self updateConstraints];
    }
    return self;
}

- (void)initUI
{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:16.f];
    self.titleLabel.textColor = RGB_Color(1, 226, 182);
    self.titleLabel.text = @"评价比例";
    [self addSubview:self.titleLabel];
    
    self.charView = [[YBPieChartView alloc] initWithFrame:CGRectMake(0, 0, 128, 128)];
    self.charView.percentageArray = @[ @"0.4", @"0.4", @"0.2" ];
    [self.charView reloadData];
    [self addSubview:self.charView];
    
    self.expandButton = [[UIButton alloc] init];
    [self addSubview:self.expandButton];
    
    self.higRecomend = [[IconLabel alloc] init];
    self.higRecomend.label.text = @"好评";
    self.higRecomend.icon.image = [UIImage imageNamed:@"hig_recomend"];
    [self addSubview:self.higRecomend];
    
    self.midRecomend = [[IconLabel alloc] init];
    self.midRecomend.label.text = @"中评";
    self.midRecomend.icon.image = [UIImage imageNamed:@"midRecomend"];

    [self addSubview:self.midRecomend];
    
    self.poorRecomend = [[IconLabel alloc] init];
    self.poorRecomend.label.text = @"差评";
    self.poorRecomend.icon.image = [UIImage imageNamed:@"poorRecomend"];
    [self addSubview:self.poorRecomend];
    
}

- (void)updateConstraints
{
    [super updateConstraints];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(32.f));
        make.centerX.equalTo(self);
    }];
    
    [self.expandButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(25.f);
        make.top.equalTo(self).offset(32);
    }];
    
    
    [self.charView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(47);
        make.top.equalTo(self).offset(66);
        make.size.mas_equalTo(CGSizeMake(128, 128));
    }];
    
    [self.midRecomend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-70.f);
        make.size.mas_equalTo(CGSizeMake(75, 23.f));
        make.centerY.equalTo(self.charView);
    }];
    
    [self.higRecomend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-70.f);
        make.size.equalTo(self.midRecomend);
        make.bottom.equalTo(self.midRecomend.mas_top).offset(-18.f);
    }];
    
    [self.poorRecomend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.midRecomend);
        make.size.equalTo(self.midRecomend);
        make.top.equalTo(self.midRecomend.mas_bottom).offset(18.f);
    }];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self addSubview:self.lineImageView];
    CGRect rect = self.bounds;
    CGFloat margin = 10;
    CGFloat height = 1;
    self.lineImageView.frame = CGRectMake(margin, rect.size.height - height, rect.size.width - margin * 2, height);
}

- (UIImageView *)lineImageView {
    if (!_lineImageView) {
        _lineImageView = [UIImageView new];
        _lineImageView.backgroundColor = [UIColor blackColor];
        _lineImageView.layer.shadowColor = [UIColor whiteColor].CGColor;
        _lineImageView.layer.shadowOffset = CGSizeMake(0, 1);
        _lineImageView.layer.shadowOpacity = 0.3;
        _lineImageView.layer.shadowRadius = 1;
    }
    return _lineImageView;
}

#pragma mark - 
- (void)updateUIWithCountInfo:(NSDictionary *)countInfo
{
    NSArray * array = [self percentageArrayWithGoodsRemcondCount:[[countInfo objectForKey:@"goodcommnent"] integerValue]
                                                      mediaCount:[[countInfo objectForKey:@"generalcomment"] integerValue]
                                                       poorCount:[[countInfo objectForKey:@"badcomment"] integerValue]];
    self.charView.percentageArray = array;
    [self.charView reloadData];
}


#pragma mark - GetMethod

- (NSArray *)percentageArrayWithGoodsRemcondCount:(NSInteger)goodsRemcondCount mediaCount:(NSInteger)mediaRemcondCount poorCount:(NSInteger)poorRemcondCount
{
    CGFloat totalCount = goodsRemcondCount + mediaRemcondCount + poorRemcondCount;
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:0];
    if (goodsRemcondCount) {
        [array addObject:[NSNumber numberWithFloat:(goodsRemcondCount / totalCount)]];
    }
    if (mediaRemcondCount) {
        [array addObject:[NSNumber numberWithFloat:(mediaRemcondCount / totalCount)]];
    }
    if (poorRemcondCount) {
        [array addObject:[NSNumber numberWithFloat:(poorRemcondCount / totalCount)]];
    }
    return array;
}


#pragma mark - Action

@end
