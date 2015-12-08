//
//  HomeSeeTimeView.m
//  Principal
//
//  Created by dawei on 15/11/27.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import "HomeSeeTimeView.h"
#define ButtonWidth self.size.height


@interface HomeSeeTimeView()

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *middleButton;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic,strong) UIImageView *leftImageview;

@property (nonatomic,strong) UIImageView *rightImageView;

@property (nonatomic, copy) ButtonClickBlock itemClick;

@end

@implementation HomeSeeTimeView

- (void)itemClick:(ButtonClickBlock)handle {
    
    self.itemClick = handle;
}

- (void)layoutSubviews {
    
    [self addSubview:self.leftButton];
    [self addSubview:self.middleButton];
    [self addSubview:self.rightButton];
    
    [self addSubview:self.leftImageview];
    [self addSubview:self.rightImageView];
}

// 按钮的点击事件
- (void)buttonAction:(UIButton *)sender {
    
    if (self.itemClick) {
        self.itemClick(sender);
    }
    for (UIButton *itemButton in self.subviews) {
        if (itemButton.tag != sender.tag && [itemButton isKindOfClass:[UIButton class]]) {
            itemButton.selected = NO;
            [self buttonNormalState:itemButton];
        }
    }
    sender.selected = YES;
    [self buttonSelectedState:sender];
}

// 按钮的按下状态
- (void)buttonSelectedState:(UIButton *)sender {
    
    [sender.layer setBorderColor:[UIColor colorWithHexString:@"19f9cc"].CGColor];
    if (sender.tag == 1) {
        _leftImageview.image = [UIImage imageNamed:@"x1"];
        _rightImageView.image = [UIImage imageNamed:@"x2"];
    }else if (sender == 0) {
        _leftImageview.image = [UIImage imageNamed:@"x2"];
        _rightImageView.image = [UIImage imageNamed:@"x3"];
    }else if (sender.tag == 2)
    {
        _leftImageview.image = [UIImage imageNamed:@"x3"];
        _rightImageView.image = [UIImage imageNamed:@"x2"];
    }
}

// 按钮的正常状态
- (void)buttonNormalState:(UIButton *)sender {
    
    [sender.layer setBorderColor:[UIColor colorWithHexString:@"009577"].CGColor];
}

// 设置按钮的状态
- (void)setButtonState:(UIButton *)button {
    
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:ButtonWidth / 2.0];
    [button.layer setBorderColor:[UIColor colorWithHexString:@"19f9cc"].CGColor];
    [button.layer setBorderWidth:1];
    button.titleLabel.font = [UIFont italicSystemFontOfSize:20];
    [self buttonNormalState:button];
    
    [button setTitleColor:[UIColor colorWithHexString:@"19f9cc"] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor colorWithHexString:@"009577"] forState:UIControlStateNormal];
}

#pragma mark - lazy load

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton new];
        _leftButton.frame = CGRectMake(0, 0, ButtonWidth, ButtonWidth);
        [self setButtonState:_leftButton];
        [_leftButton setTitle:@"昨天" forState:UIControlStateNormal];
        
        _leftButton.tag = 1;
        [_leftButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)middleButton {
    if (!_middleButton) {
        _middleButton = [UIButton new];
        _middleButton.frame = CGRectMake((self.width - ButtonWidth) / 2.0, 0, ButtonWidth, ButtonWidth);
        [self setButtonState:_middleButton];
        [_middleButton setTitle:@"今天" forState:UIControlStateNormal];
        _middleButton.selected = YES;
        [self buttonSelectedState:_middleButton];
        _middleButton.tag = 0;
        [_middleButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _middleButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton new];
        _rightButton.frame = CGRectMake(self.width - ButtonWidth, 0, ButtonWidth, ButtonWidth);
        [self setButtonState:_rightButton];
        [_rightButton setTitle:@"本周" forState:UIControlStateNormal];
        
        _rightButton.tag = 2;
        [_rightButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}
- (UIImageView *)leftImageview
{
    if (!_leftImageview) {
        _leftImageview = [[UIImageView alloc] init];
        _leftImageview.frame = CGRectMake(ButtonWidth, self.height / 2, (self.width - ButtonWidth) / 2 - ButtonWidth , 1);
//        _leftImageview.backgroundColor = [UIColor redColor];
    }
    return _leftImageview;
}
- (UIImageView *)rightImageView
{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.frame = CGRectMake((self.width - ButtonWidth) / 2 + ButtonWidth, self.height / 2, (self.width - ButtonWidth) / 2 - ButtonWidth , 1);
//        _rightImageView.backgroundColor = [UIColor redColor];
    }

    return _rightImageView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
