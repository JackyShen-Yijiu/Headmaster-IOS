//
//  TTCommentView.m
//  Headmaster
//
//  Created by ytzhang on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "TTCommentView.h"


@interface TTCommentView ()

@end

@implementation TTCommentView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.leftSmallView];
    [self addSubview:self.leftBigView];
    [self addSubview:self.rightLabel];
}
- (void)layoutSubviews{
    [self.leftSmallView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left);
        make.height.mas_equalTo(@15);
         make.width.mas_equalTo(@15);
    }];
    [self.leftBigView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left);
        make.height.mas_equalTo(@20);
        make.width.mas_equalTo(@20);
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.leftSmallView.mas_right).offset(16);
        make.height.mas_equalTo(@16);
    }];
    
    
}
- (UIView *)leftSmallView{
    if (_leftSmallView == nil) {
        _leftSmallView = [[UIView alloc] init];
    }
    return _leftSmallView;
}
- (UIView *)leftBigView{
    if (_leftBigView== nil) {
        _leftBigView = [[UIView alloc] init];
        _leftBigView.hidden = NO;
    }
    return _leftBigView;
}
- (UILabel *)rightLabel{
    if (_rightLabel == nil) {
        _rightLabel = [[UILabel alloc] init];
    }
    return _rightLabel;
}

// 图例颜色
- (void)setViewColor:(UIColor *)viewColor{
    _leftBigView.backgroundColor = viewColor;
    _leftSmallView.backgroundColor  = viewColor;
    
}
// 字体大小
- (void)setLabelFont:(UIFont *)labelFont{
    _rightLabel.font = labelFont;
}
// 字体颜色
- (void)setTitileColor:(UIColor *)titileColor{
    _rightLabel.textColor = titileColor;
}
// 图例和字体是否变大
- (void)setIsShowBigView:(BOOL)isShowBigView{
    if (isShowBigView) {
        _rightLabel.font = [UIFont systemFontOfSize:16];
        _leftBigView.hidden = isShowBigView;
    }
}
// 文字内容
- (void)setTitieleStr:(NSString *)titieleStr{
    _rightLabel.text = titieleStr;
}
@end
