//
//  HomeTopView.m
//  Principal
//
//  Created by dawei on 15/11/27.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import "HomeTopView.h"
#import "DVVDoubleRowToolBarView.h"

#define rightBtnWidth 100
#define rightBtnHeight 60
#define downLabelHeight 30

@interface HomeTopView()

@property (nonatomic, strong) DVVDoubleRowToolBarView *doubleRowView;

@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation HomeTopView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.doubleRowView];
        [self addSubview:self.rightButton];
    }
    return self;
}

- (void)refreshSubjectData:(NSArray *)array
                   sameDay:(NSString *)sameDay {
    
    [self.doubleRowView refreshUpTitle:array];
    
    for (UILabel *label in self.rightButton.subviews) {
        if (label.tag != 0) {
            label.text = sameDay;
        }
    }
}

- (void)layoutSubviews {
    
    _doubleRowView.frame = CGRectMake(0, 0, self.width - rightBtnWidth, rightBtnHeight);
    _rightButton.frame = CGRectMake(_doubleRowView.width, 0, rightBtnWidth, rightBtnHeight);
}

// 创建左侧的一排按钮
- (DVVDoubleRowToolBarView *)doubleRowView {
    if (!_doubleRowView) {
        _doubleRowView = [DVVDoubleRowToolBarView new];
//        _doubleRowView.backgroundColor = [UIColor lightGrayColor];
        
        _doubleRowView.upTitleFont = [UIFont italicSystemFontOfSize:18];
        
        _doubleRowView.downTitleFont = [UIFont italicSystemFontOfSize:12];
        _doubleRowView.followBarHidden = 0;
        _doubleRowView.downTitleFont = [UIFont systemFontOfSize:14];
        _doubleRowView.followBarHidden = 1;
        _doubleRowView.upTitleOffSetY = 5;
        _doubleRowView.upTitleArray = @[ @"44", @"25", @"5", @"46" ];
        _doubleRowView.downTitleArray = @[ @"科一", @"科二", @"科三", @"科四" ];
    }
    return _doubleRowView;
}

// 右侧的单个按钮
- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton new];

        UILabel *upLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, rightBtnWidth, rightBtnHeight - downLabelHeight)];
        upLabel.tag = 1;
        upLabel.textAlignment = 1;
        upLabel.text = @"34";
        upLabel.font = [UIFont italicSystemFontOfSize:22];
        upLabel.textColor = [UIColor colorWithHexString:@"19f9cc"];
        UILabel *downLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, upLabel.height, rightBtnWidth, downLabelHeight)];
        downLabel.textAlignment = 1;
        downLabel.text = @"当天报名";
        downLabel.font = [UIFont italicSystemFontOfSize:12];
        downLabel.textColor = [UIColor colorWithHexString:@"009577"];
        
            UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(8, 10, 2, rightBtnWidth - 55);
        lineView.backgroundColor = [UIColor grayColor];
        [_rightButton addSubview:lineView];
       
        [_rightButton addSubview:upLabel];
        [_rightButton addSubview:downLabel];
    }
    return _rightButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
