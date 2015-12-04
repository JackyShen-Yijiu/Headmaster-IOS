//
//  CoachOfCourse.m
//  SingerDataView
//
//  Created by ytzhang on 15/12/1.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "CoachOfCourse.h"
#import <Masonry/Masonry.h>

#import "YBBarChartView.h"

#define kSystemW [UIScreen mainScreen].bounds.size.width
#define kSystemH [UIScreen mainScreen].bounds.size.height

@interface CoachOfCourse ()
/**
 *
 *  教练授课
 *
 */
@property (nonatomic,strong) UILabel *coachOfCourseLabel;
/**
 *
 *  详情
 *
 */
@property (nonatomic,strong) UIButton *coachOfCourseButton;

/**
 *
 * 教练授课图表
 *
 */
//@property (nonatomic,strong) UIView *coachOfCourseChart;
@property (nonatomic,strong) YBBarChartView *coachOfCourseChart;

@end

@implementation CoachOfCourse

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.coachOfCourseLabel];
        [self addSubview:self.coachOfCourseButton];
        [self addSubview:self.coachOfCourseChart];
        
    }
    return self;
}

- (UILabel *)coachOfCourseLabel
{
    if (_coachOfCourseLabel == nil) {
        _coachOfCourseLabel = [[UILabel alloc]init];
        _coachOfCourseLabel.text = @"教练授课";
        _coachOfCourseLabel.font = [UIFont systemFontOfSize:16.0];
        _coachOfCourseLabel.textColor = [UIColor colorWithHexString:@"01e2b6"];
        
        
    }
    
    return _coachOfCourseLabel;
}
- (UIButton *)coachOfCourseButton
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
    if (_coachOfCourseButton == nil) {
        _coachOfCourseButton = [[UIButton alloc] init];
//        _coachOfCourseButton.backgroundColor = [UIColor redColor];
        [_coachOfCourseButton setTitle:@"详情" forState:UIControlStateNormal];
        _coachOfCourseButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_coachOfCourseButton setTitleColor:[UIColor colorWithHexString:@"047a64"] forState:UIControlStateNormal];
        _coachOfCourseButton.titleEdgeInsets = UIEdgeInsetsMake(5, -17, 5, 1);
        
        [_coachOfCourseButton setImage:[UIImage imageNamed:@"xq.png"] forState:UIControlStateNormal];
        _coachOfCourseButton.imageEdgeInsets = UIEdgeInsetsMake(0,26,0,0);        [_coachOfCourseButton addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _coachOfCourseButton;
}
- (YBBarChartView *)coachOfCourseChart
{
    if (_coachOfCourseChart == nil) {
        _coachOfCourseChart = [[YBBarChartView alloc] init];
        [_coachOfCourseChart refreshUI];
//        _coachOfCourseChart.backgroundColor = [UIColor grayColor];
    }
    return _coachOfCourseChart;
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
    
    [_coachOfCourseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.mas_centerX);
        make.left.mas_equalTo(self.mas_left).with.offset((kSystemW - 60) / 2);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@80);
        make.top.mas_equalTo(self.mas_top).with.offset(0);
    }];
    
    [self.coachOfCourseButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_coachOfCourseLabel.mas_right).with.offset(70);
        make.right.mas_equalTo(self.mas_right).with.offset(-16);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@30);
        make.top.mas_equalTo(self.mas_top).with.offset(10);
    }];
    
    [self.coachOfCourseChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(16);
        make.right.mas_equalTo(self.mas_right).with.offset(-16);
        make.top.mas_equalTo(_coachOfCourseLabel.mas_bottom).with.offset(10);
        make.height.mas_equalTo(150);
    }];
    
}

@end
