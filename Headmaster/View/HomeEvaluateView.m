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

@property (nonatomic,strong) NSMutableArray *labelArray;

@end

@implementation HomeEvaluateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.labelArray = [NSMutableArray array];
        [self createButtons];
    }
    return self;
}

// 刷新数据
- (void)refreshData:(NSArray *)array {
    
    if (!array.count) {
        return;
    }
    
    for (UILabel *label in self.labelArray) {
        if (label.tag != 0 && ![[array objectAtIndex:label.tag - 1] isKindOfClass:[NSNull class]]) {
            label.text = [array objectAtIndex:label.tag - 1];
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

- (void)createButtons
{
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 50)];
    topLabel.textAlignment = 1;
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.text = @"学员评价";
    topLabel.font = [UIFont boldSystemFontOfSize:14];
    if (YBIphone6Plus) {
        topLabel.font = [UIFont boldSystemFontOfSize:14*YBRatio];
    }
    topLabel.textColor = [UIColor blackColor];
    [self addSubview:topLabel];
    
    NSArray *imageArray = [NSArray arrayWithObjects:@"good",@"well",@"bad", nil];
    NSArray *titleArray = [NSArray arrayWithObjects:@" 好评",@" 中评",@" 差评", nil];

    CGFloat btnWidth = self.width / 3.0;
    CGFloat btnHeight = 75;
    
    for (int i = 0; i < 3; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.frame = CGRectMake(i * btnWidth, 50, btnWidth, btnHeight);
        
        CGFloat labelViewHeight = 16;
        UILabel *label = [UILabel new];
        label.tag = i + 1;
        [self.labelArray addObject:label];
        label.frame = CGRectMake(0, 0, btnWidth, labelViewHeight);
        label.textAlignment = 1;
        label.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:16];
        if (YBIphone6Plus) {
            label.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:16*YBRatio];
        }
        label.text = @" ";
        
        CGFloat imageViewWidth = btnWidth;
        UIButton *stateBtn = [UIButton new];
        stateBtn.tag = i;
        stateBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [stateBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        if (YBIphone6Plus) {
            stateBtn.titleLabel.font = [UIFont systemFontOfSize:13*YBRatio];
        }
        if (i == 3) {
            stateBtn.frame = CGRectMake(btnWidth / 2.0 - imageViewWidth / 2.0, labelViewHeight, imageViewWidth, imageViewWidth/2);
            [stateBtn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
            [stateBtn setTitle:titleArray[i] forState:UIControlStateNormal];
            [button addSubview:stateBtn];
            label.textColor = [UIColor blueColor];
        }else
        {
            stateBtn.frame = CGRectMake(btnWidth / 2.0 - imageViewWidth / 2.0, labelViewHeight, imageViewWidth, imageViewWidth/2);
            [stateBtn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
            [stateBtn setTitle:titleArray[i] forState:UIControlStateNormal];
            [button addSubview:stateBtn];
            label.textColor = JZ_BLUE_COLOR;
        }
        
        [button addSubview:label];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [stateBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:button];
        
        UIView *lineView = [[UIView alloc] init];
        CGFloat lineViewX = btnWidth + btnWidth * i;
        lineView.frame = CGRectMake(lineViewX, 60, 0.5, btnHeight-20);
        lineView.backgroundColor = [UIColor lightGrayColor];
        lineView.alpha = 0.3;
        [self addSubview:lineView];
        
    }
}

@end
