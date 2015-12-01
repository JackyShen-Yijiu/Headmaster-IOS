//
//  CWStarRateView.m
//  StarRateDemo
//
//  Created by WANGCHAO on 14/11/4.
//  Copyright (c) 2014年 wangchao. All rights reserved.
//

#import "CWStarRateView.h"

@interface CWStarRateView ()

@property (nonatomic, strong) UIImageView *foregroundStarView;
@property (nonatomic, strong) UIImageView *backgroundStarView;

@end

@implementation CWStarRateView


#pragma mark - Private Methods

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundStarView.frame = self.bounds;
    self.foregroundStarView.frame = [self forgeRect];
    
}

- (UIImageView *)foregroundStarView
{
    if (!_foregroundStarView) {
        _foregroundStarView = [[UIImageView alloc] init];
        _foregroundStarView.image = [UIImage imageNamed:@"foregroundStar"];
        [self addSubview:_foregroundStarView];
        [self sendSubviewToBack:self.backgroundStarView];
    }
    return _foregroundStarView;
}

- (UIImageView *)backgroundStarView
{
    if (!_backgroundStarView) {
        _backgroundStarView = [[UIImageView alloc] init];
        _backgroundStarView.image = [UIImage imageNamed:@"backgroundStar"];
        [self addSubview:_backgroundStarView];
    }
    return _backgroundStarView;

}

#pragma mark - Get and Set Methods

- (void)setScorePercent:(CGFloat)scroePercent {
    if (_scorePercent == scroePercent) {
        return;
    }
    
    if (scroePercent < 0) {
        _scorePercent = 0;
    } else if (scroePercent > 1) {
        _scorePercent = 1;
    } else {
        _scorePercent = scroePercent;
    }
    [self setNeedsLayout];
}

- (CGRect)forgeRect
{
    CGRect rect = self.bounds;
    CGFloat width = self.width * _scorePercent;
    rect.size.width = width;
    return rect;
}

@end
