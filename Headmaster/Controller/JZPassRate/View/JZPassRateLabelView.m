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

@property (nonatomic, assign) CGFloat fontSmallSize;

@property (nonatomic, assign) CGFloat fontBigSize;

@end

@implementation JZPassRateLabelView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        if (YBIphone6Plus) {
            _fontBigSize = 14 * YBRatio;
            _fontSmallSize = 12 * YBRatio;
        }else{
            _fontBigSize = 14;
            _fontSmallSize = 12;

        }
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.topLabel];
    [self addSubview:self.bottomLabel];
}
- (void)layoutSubviews{
    
    NSNumber *numberBig = [NSNumber numberWithFloat:_fontSmallSize];
    
    CGFloat topH = 8;
    if (YBIphone6Plus) {
        topH = 8 * YBRatio;
    }

    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.top).offset(topH);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(numberBig);
    }];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat H = 23 ;
        if (YBIphone6Plus
            ) {
            H = H * YBRatio;
        }
        make.top.mas_equalTo(self.topLabel.bottom).offset(H);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(numberBig);
    }];

}
- (UILabel *)topLabel{
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.textColor = kJZLightTextColor;
        _topLabel.font = [UIFont systemFontOfSize:_fontSmallSize];
    }
    return _topLabel;
}
- (UILabel *)bottomLabel{
    if (_bottomLabel == nil) {
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.textColor = kJZLightTextColor;
        _bottomLabel.font = [UIFont systemFontOfSize:_fontSmallSize];
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
