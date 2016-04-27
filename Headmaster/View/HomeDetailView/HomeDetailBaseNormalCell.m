//
//  HomeDetailBaseNormalCell.m
//  Headmaster
//
//  Created by 大威 on 15/12/8.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeDetailBaseNormalCell.h"

@implementation HomeDetailBaseNormalCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.markLabel];
    
    CGRect rect = self.bounds;
    self.titleLabel.frame = CGRectMake(0, 0, rect.size.width, self.titleDefaultHeight);
    CGFloat markLabelWidth = 100;
    CGFloat rightMargin = 15;
    self.markLabel.frame = CGRectMake(rect.size.width - markLabelWidth - rightMargin, 0, markLabelWidth, self.titleDefaultHeight);
//    self.titleLabel.backgroundColor = [UIColor redColor];
//    self.markLabel.backgroundColor = [UIColor orangeColor];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = 1;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        if (YBIphone6Plus) {
            _titleLabel.font = [UIFont systemFontOfSize:16*YBRatio];
        }
        _titleLabel.textColor = [UIColor colorWithHexString:HIGHLIGHT_COLOR];
    }
    return _titleLabel;
}

- (UILabel *)markLabel {
    if (!_markLabel) {
        _markLabel = [UILabel new];
        _markLabel.textAlignment = 2;
        _markLabel.font = [UIFont systemFontOfSize:16];
        if (YBIphone6Plus) {
            _markLabel.font = [UIFont systemFontOfSize:16*YBRatio];
        }
        _markLabel.textColor = [UIColor colorWithHexString:HIGHLIGHT_COLOR];
    }
    return _markLabel;
}

- (CGFloat)titleDefaultHeight {
    return 40;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
