//
//  JudgeView.m
//  SingerDataView
//
//  Created by ytzhang on 15/12/1.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "JudgeView.h"

#import <Masonry/Masonry.h>


# define ksystemH [UIScreen mainScreen].bounds.size.height
# define ksystemW [UIScreen mainScreen].bounds.size.width
@interface JudgeView()

@end

@implementation JudgeView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.judgeLabel];
        [self addSubview:self.judgeButton];
        [self addSubview:self.judgeChart];
        [self addSubview:self.signView];
    }
    return self;
}

- (UILabel *)judgeLabel
{
    if (_judgeLabel == nil) {
        _judgeLabel = [[UILabel alloc]init];
        _judgeLabel.text = @"评价";
        _judgeLabel.font = [UIFont systemFontOfSize:16.0];
        _judgeLabel.textColor = [UIColor colorWithHexString:@"01e2b6"];
        
        
    }
    
    return _judgeLabel;
}
- (UIButton *)judgeButton
{
    /*
     UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//button的类型
     button.frame = CGRectMake(100, 100,90, 90);//button的frame
     button.backgroundColor = [UIColor cyanColor];//button的背景颜色
     
     //    [button setBackgroundImage:[UIImage imageNamed:@"man_64.png"] forState:UIControlStateNormal];
     
     //    在UIButton中有三个对EdgeInsets的设置：ContentEdgeInsets、titleEdgeInsets、imageEdgeInsets
     [button setImage:[UIImage imageNamed:@"IconHome@2x.png"] forState:UIControlStateNormal];//给button添加image
     button.imageEdgeInsets = UIEdgeInsetsMake(5,13,21,button.titleLabel.bounds.size.width);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
     
     [button setTitle:@"首页" forState:UIControlStateNormal];//设置button的title
     button.titleLabel.font = [UIFont systemFontOfSize:16];//title字体大小
     button.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
     [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//设置title在一般情况下为白色字体
     [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];//设置title在button被选中情况下为灰色字体
     button.titleEdgeInsets = UIEdgeInsetsMake(71, -button.titleLabel.bounds.size.width-50, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
     
     //    [button setContentEdgeInsets:UIEdgeInsetsMake(70, 0, 0, 0)];//
     
     
     //   button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//设置button的内容横向居中。。设置content是title和image一起变化
     
     
     [button addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
     
     
     
     
     
     [self.view addSubview:button];
     */
    if (_judgeButton == nil) {
        _judgeButton = [[UIButton alloc] init];
//        _judgeButton.backgroundColor = [UIColor redColor];
        
        [_judgeButton setTitle:@"详情" forState:UIControlStateNormal];
        
        _judgeButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        
        [_judgeButton setTitleColor:[UIColor colorWithHexString:@"047a64"] forState:UIControlStateNormal];
        _judgeButton.titleEdgeInsets = UIEdgeInsetsMake(5, -17, 5, 1);
        
        [_judgeButton setImage:[UIImage imageNamed:@"xq.png"] forState:UIControlStateNormal];
        _judgeButton.imageEdgeInsets = UIEdgeInsetsMake(0,26,0,0);           [_judgeButton addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _judgeButton;
}
- (YBLineChartView *)judgeChart
{
    if (_judgeChart == nil) {
        _judgeChart = [[YBLineChartView alloc] init];
        [_judgeChart refreshUI];
//        _judgeChart.backgroundColor = [UIColor grayColor];
    }
    return _judgeChart;
}
- (ZTJudgeBottonSign *)signView
{
    if (_signView == nil) {
        _signView = [[ZTJudgeBottonSign alloc] init];
//        _signView.frame = CGRectMake(0, self.frame.size.height + 20, ksystemW - 20, 20);
        
    }
    
    
    return _signView;
}

- (void)didClick:(UIButton *)btn
{
    if (_didClick) {
        _didClick(btn);
    }
    NSLog(@"----");
    
}

/**
 *
 *  添加约束
 *
 */
- (void)layoutSubviews{
    
    [_judgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo((ksystemW - 40) / 2);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@40);
        make.top.mas_equalTo(self.mas_top).with.offset(0);
    }];
    
    [self.judgeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_judgeLabel.mas_right).with.offset(90);
        make.right.mas_equalTo(self.mas_right).with.offset(-16);
        make.height.mas_equalTo(@10);
         make.width.mas_equalTo(@30);
        make.top.mas_equalTo(self.mas_top).with.offset(10);
    }];
    
    [self.judgeChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(16);
        make.right.mas_equalTo(self.mas_right).with.offset(-16);
        make.top.mas_equalTo(_judgeLabel.mas_bottom).with.offset(10);
        make.height.mas_equalTo(120);
    }];
    [self.signView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(40);
        make.right.mas_equalTo(self.mas_right).with.offset(-40);
        make.top.mas_equalTo(_judgeChart.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@50);
    }];

    
}


@end
