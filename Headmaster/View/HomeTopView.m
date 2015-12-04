//
//  HomeTopView.m
//  Principal
//
//  Created by dawei on 15/11/27.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import "HomeTopView.h"
#import "DVVDoubleRowToolBarView.h"

#define rightBtnWidth 60
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
        _doubleRowView.backgroundColor = [UIColor lightGrayColor];
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
        upLabel.font = [UIFont systemFontOfSize:24];
        
        UILabel *downLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, upLabel.height, rightBtnWidth, downLabelHeight)];
        downLabel.textAlignment = 1;
        downLabel.text = @"当天报名";
        downLabel.font = [UIFont systemFontOfSize:14];
        
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
