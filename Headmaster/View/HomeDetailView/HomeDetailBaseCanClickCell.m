//
//  HomeDetailBaseCanClickCell.m
//  Headmaster
//
//  Created by 大威 on 15/12/8.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeDetailBaseCanClickCell.h"

@interface HomeDetailBaseCanClickCell()

@property (nonatomic, copy) ClickBlock clickBlock;

@property (nonatomic, strong) UIButton *clickButton;

@end

@implementation HomeDetailBaseCanClickCell

- (void)setClickBlock:(ClickBlock)handle {
    _clickBlock = handle;
}

//- (instancetype)initWithWidth:(CGFloat)width Style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        
//        [self.contentView addSubview:self.titleLabel];
//        [self.contentView addSubview:self.markLabel];
//        [self.contentView addSubview:self.markImageView];
//        [self.contentView addSubview:self.clickButton];
//        CGRect rect = self.bounds;
//        self.titleLabel.frame = CGRectMake(0, 0, rect.size.width, self.titleDefaultHeight);
//        CGFloat markLabelWidth = 100;
//        CGFloat markImageWidth = 4;
//        CGFloat markImageHeight = 6;
//        CGFloat rightMargin = 15;
//        self.markLabel.frame = CGRectMake(rect.size.width - markLabelWidth - markImageWidth - rightMargin - 3, 0, markLabelWidth, self.titleDefaultHeight);
//        self.markImageView.frame = CGRectMake(rect.size.width - markImageWidth - rightMargin, self.titleDefaultHeight / 2.f - markImageHeight / 2.f, markImageWidth, markImageHeight);
//        self.clickButton.frame = CGRectMake(rect.size.width - self.titleDefaultHeight - rightMargin, 0, self.titleDefaultHeight, self.titleDefaultHeight);
//        
//    }
//    return self;
//}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.markLabel];
    [self.contentView addSubview:self.markImageView];
    [self.contentView addSubview:self.clickButton];
    CGRect rect = self.bounds;
    self.titleLabel.frame = CGRectMake(0, 0, rect.size.width, self.titleDefaultHeight);
    CGFloat markLabelWidth = 100;
    CGFloat markImageWidth = 4;
    CGFloat markImageHeight = 6;
    CGFloat rightMargin = 15;
    self.markLabel.frame = CGRectMake(rect.size.width - markLabelWidth - markImageWidth - rightMargin - 3, 0, markLabelWidth, self.titleDefaultHeight);
    self.markImageView.frame = CGRectMake(rect.size.width - markImageWidth - rightMargin, self.titleDefaultHeight / 2.f - markImageHeight / 2.f, markImageWidth, markImageHeight);
    self.clickButton.frame = CGRectMake(rect.size.width - self.titleDefaultHeight - rightMargin, 0, self.titleDefaultHeight, self.titleDefaultHeight);
    

    
//    self.titleLabel.backgroundColor = [UIColor redColor];
//    self.markLabel.backgroundColor = [UIColor orangeColor];
//    self.markImageView.backgroundColor = [UIColor redColor];
//    self.clickButton.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.5];
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
        _markLabel.font = [UIFont systemFontOfSize:12];
        if (YBIphone6Plus) {
            _markLabel.font = [UIFont systemFontOfSize:12*YBRatio];
        }
        _markLabel.textAlignment = 2;
        _markLabel.textColor = [UIColor colorWithHexString:HIGHLIGHT_COLOR];
    }
    return _markLabel;
}

- (UIImageView *)markImageView {
    if (!_markImageView) {
        _markImageView = [UIImageView new];
    }
    return _markImageView;
}

- (UIButton *)clickButton {
    if (!_clickButton) {
        _clickButton = [UIButton new];
        [_clickButton addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clickButton;
}
// 按钮的点击事件
- (void)clickAction {
    if (_clickBlock) {
        _clickBlock(self.tag);
    }
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
