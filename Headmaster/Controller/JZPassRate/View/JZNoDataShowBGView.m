//
//  JZNoDataShowBGView.m
//  HeiMao_B
//
//  Created by ytzhang on 16/4/7.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZNoDataShowBGView.h"

@interface JZNoDataShowBGView ()


@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation JZNoDataShowBGView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor = [UIColor clearColor];
        NSLog(@"self.height  = %f",self.height);
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.imgView];
    [self.bgView addSubview:self.titleLabel];
    
}
- (void)layoutSubviews{
    
    NSNumber *mainW = [NSNumber numberWithFloat:self.width];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).offset(-64);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(@155);
        make.width.mas_equalTo(mainW);
    }];

    
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.height.mas_equalTo(@120);
        make.width.mas_equalTo(@120);
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.imgView.mas_centerX);
        make.height.mas_equalTo(@14);
        make.left.mas_equalTo(self.bgView.mas_left).offset(0);
         make.right.mas_equalTo(self.bgView.mas_right).offset(0);
        make.bottom.mas_equalTo(self.imgView.mas_bottom).offset(15);
    }];
}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor clearColor];
    }
    return _bgView;
}
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        _imgView.image = [UIImage imageNamed:@"people_null"];
        _imgView.backgroundColor = [UIColor clearColor];
        
        
    }
    return _imgView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"暂无数据";
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

// 图片赋值
- (void)setImgStr:(NSString *)imgStr{
    self.imgView.image = [UIImage imageNamed:imgStr];
}
// 文字赋值
- (void)setTitleStr:(NSString *)titleStr{
    self.titleLabel.text = titleStr;
}
// 字体大小
- (void)setFontSize:(CGFloat)fontSize{
    self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
}
// 字体颜色
- (void)setTitleColor:(UIColor *)titleColor{
    self.titleLabel.textColor = titleColor;
}

@end
