//
//  JZPassRateLabelView.m
//  Headmaster
//
//  Created by ytzhang on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZPassRateLabelView.h"

@interface JZPassRateLabelView ()

@property (nonatomic, strong) UILabel *topLabel;

@property (nonatomic, strong) UILabel *bottomLabel;

@end

@implementation JZPassRateLabelView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.topLabel];
    [self addSubview:self.bottomLabel];
}
- (void)layoutSubviews{
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.top).offset(8);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(@12);
    }];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topLabel.bottom).offset(23);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(@12);
    }];

}
- (UILabel *)topLabel{
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.textColor = kJZLightTextColor;
        _topLabel.font = [UIFont systemFontOfSize:12];
    }
    return _topLabel;
}
- (UILabel *)bottomLabel{
    if (_bottomLabel == nil) {
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.textColor = kJZLightTextColor;
        _bottomLabel.font = [UIFont systemFontOfSize:12];
    }
    return _bottomLabel;
}
- (void)setTitleStr:(NSString *)titleStr{
    self.topLabel.text = titleStr;
}
- (void)setResultStr:(NSString *)resultStr{
    self.bottomLabel.text = resultStr;
}
@end
