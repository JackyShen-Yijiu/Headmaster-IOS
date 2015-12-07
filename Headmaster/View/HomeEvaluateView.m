//
//  HomeEvaluateView.m
//  Principal
//
//  Created by dawei on 15/11/27.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import "HomeEvaluateView.h"

@interface HomeEvaluateView()

@property (nonatomic, copy) ButtonClickBlock itemClick;

@end

@implementation HomeEvaluateView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

// 刷新数据
- (void)refreshData:(NSArray *)array {
    
    for (UIButton *itemButton in self.subviews) {
        for (UILabel *label in itemButton.subviews) {
            if (label.tag != 0) {
                label.text = [array objectAtIndex:label.tag - 1];
            }
        }
    }
}

// 按钮点击事件
- (void)buttonAction:(UIButton *)sender {
    
    if (self.itemClick) {
        self.itemClick(sender);
    }
}

- (void)itemClick:(ButtonClickBlock)handle {
    self.itemClick = handle;
}

- (void)layoutSubviews {
    
    [self createButtons];
}

- (void)createButtons {
    
    NSArray *imageArray = [NSArray arrayWithObjects:@"high",@"middle",@"low",@"complain", nil];
    
    CGFloat btnWidth = self.width / 4.0;
    
    for (int i = 0; i < 4; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.frame = CGRectMake(i * btnWidth, 0, btnWidth, btnWidth);
        
        CGFloat labelViewHeight = 30;
        UILabel *label = [UILabel new];
        label.tag = i + 1;
        label.frame = CGRectMake(0, 0, btnWidth, labelViewHeight);
        label.textAlignment = 1;
        label.textColor = [UIColor colorWithHexString:@"19f9cc"];
        label.font = [UIFont italicSystemFontOfSize:14];
        label.text = @"";
        
        CGFloat imageViewWidth = 20;
        UIImageView *imageView = [UIImageView new];
        if (i == 3) {
            imageView.frame = CGRectMake(btnWidth / 2.0 - imageViewWidth / 2.0, labelViewHeight, imageViewWidth, imageViewWidth);
            imageView.image = [UIImage imageNamed:imageArray[i]];
            [button addSubview:imageView];
        }else
        {
            imageView.frame = CGRectMake(btnWidth / 2.0 - imageViewWidth / 2.0, labelViewHeight - 5, imageViewWidth, imageViewWidth);
            imageView.image = [UIImage imageNamed:imageArray[i]];
            [button addSubview:imageView];
        }
        [button addSubview:label];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

@end
