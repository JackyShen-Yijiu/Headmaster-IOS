//
//  HomeTopView.m
//  Principal
//
//  Created by dawei on 15/11/27.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import "HomeTopView.h"
#import "DVVDoubleRowToolBarView.h"

@interface HomeTopView()

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) DVVDoubleRowToolBarView *doubleRowView;

@property (nonatomic,strong) UILabel *topLabel;

@end

@implementation HomeTopView

- (instancetype)initWithFrame:(CGRect)frame withIsHomeDetailsVc:(BOOL)isHomeDetailsVc
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.isHomeDetailsVc = isHomeDetailsVc;
        
        [self addSubview:self.doubleRowView];
        
        [self addSubview:self.topView];
        
    }
    return self;
}

- (void)refreshSubjectData:(NSArray *)array
                   sameDay:(NSString *)sameDay {
    if (!array.count) {
        return;
    }
    
    [self.doubleRowView refreshUpTitle:array];
    
    self.topLabel.text = [NSString stringWithFormat:@"今日报名 %@ 人",sameDay];
    if (self.isHomeDetailsVc) {
        self.topLabel.text = @"当前在学人数";
    }
    
}

- (void)layoutSubviews {
    
    _topView.frame = CGRectMake(0, 0, self.width, 38);
    
    _doubleRowView.frame = CGRectMake(0, 38, self.width, self.height-38);
    
}

// 创建左侧的一排按钮
- (DVVDoubleRowToolBarView *)doubleRowView {
    
    if (!_doubleRowView) {
       
        NSArray *downTitleArray = @[ @"科一在学", @"科二在学", @"科三在学", @"科四在学" ];
        if (self.isHomeDetailsVc) {
            downTitleArray = @[ @"科目一", @"科目二", @"科目三", @"科目四" ];
        }
        
        _doubleRowView = [[DVVDoubleRowToolBarView alloc] initWithFrame:CGRectMake(0, 38, self.width, self.height-38) isHomeDetailsVc:self.isHomeDetailsVc upTitleArray:@[ @"", @"", @"", @"" ] downTitleArray:downTitleArray upTitleFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:20] downTitleFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:13]];
        _doubleRowView.followBarHidden = 1;
        _doubleRowView.upTitleOffSetY = 7;
        
    }
    return _doubleRowView;
}

// 右侧的单个按钮
- (UIView *)topView {
    
    if (!_topView) {
        
        _topView = [UIView new];
    
        self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 38)];
        self.topLabel.textAlignment = 1;
        self.topLabel.textAlignment = NSTextAlignmentCenter;
        self.topLabel.text = @"今日报名人数";
        self.topLabel.font = [UIFont boldSystemFontOfSize:14];
        if (YBIphone6Plus) {
            self.topLabel.font = [UIFont boldSystemFontOfSize:14*YBRatio];
        }
        self.topLabel.textColor = [UIColor whiteColor];
        if (self.isHomeDetailsVc) {
            self.topLabel.textColor = [UIColor blackColor];
            self.topLabel.font = [UIFont systemFontOfSize:14];
            if (YBIphone6Plus) {
                self.topLabel.font = [UIFont systemFontOfSize:14*YBRatio];
            }
        }
        // 添加分割线
//        UIView *lineView = [[UIView alloc] init];
//        lineView.frame = CGRectMake(10, 38, self.width-20, 0.5);
//        lineView.backgroundColor = [UIColor whiteColor];
        
        [_topView addSubview:self.topLabel];
        
//        [_topView addSubview:lineView];
        
    }
    
    return _topView;
}

@end
