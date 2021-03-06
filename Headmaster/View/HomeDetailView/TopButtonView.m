//
//  TopButtonView.m
//  DataDatiel
//
//  Created by ytzhang on 15/11/29.
//  Copyright © 2015年 ytzhang. All rights reserved.
// 数据详情页

#import "TopButtonView.h"

@interface TopButtonView ()
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) UILabel *followLabel; // 跟随的线条

@end

@implementation TopButtonView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _selectButtonInteger = 101;
        _titleArray = @[@"本周",@"本月",@"本年"];
        [self addTopViewtitle:_titleArray];
        // 设置初始值
    }
    return self;
}
/*
 *
 * 循环添加button
 *
 */
- (void)addTopViewtitle:(NSArray *)titleArray
{
    CGFloat buttonW = self.width / _titleArray.count;
    CGFloat buttonH = 30;
    
    for (int i = 0; i < _titleArray.count; i++) {
        // 设置button的基本属性
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake (i * buttonW , 0, buttonW, buttonH);
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 101 + i;
        if (i==0) {
            [button setBackgroundColor:JZ_BLUE_COLOR];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        [self addSubview:button];
    }
    // 添加跟随的线条
    _followLabel = [[UILabel alloc] init];
    CGFloat followLabelH = 1.f;
    CGFloat followLabel = (_selectButtonInteger - 101) * buttonW;
    _followLabel.frame = CGRectMake(followLabel, buttonH - followLabelH , buttonW, followLabelH);
    _followLabel.backgroundColor = [UIColor colorWithHexString:@"01e2b6"];
    _followLabel.tag = 2000;
//    _selectButtonInteger = 101;
//    [self addSubview:_followLabel];
    
}
/**
 *
 * button的点击事件
 *
 */

- (void)didClickButton:(UIButton *)btn
{
    NSLog(@"%ld",btn.tag);
    // 当点击时设置button的字体颜色
    if (btn.tag != _selectButtonInteger) {
        // 设置按钮恢复状态
        for (UIButton *childButton in btn.superview.subviews) {
            if (childButton.tag == _selectButtonInteger) {
               [childButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                childButton.backgroundColor = [UIColor whiteColor];
            }
        }
        [self selectOneButton:btn.tag];
    }
    if (_didClick) {
        _didClick(btn);
    }
}
/**
 *
 * 设置选中的button
 *
 */
- (void)selectOneButton:(NSInteger)tag
{
    NSArray *array = self.subviews;
    for (int i = 0; i < array.count; i++) {
//        if ([array[i] isKindOfClass:[UIButton class]]) {
            if ([array[i] tag] == tag) {
//                [array[i] setTitleColor:[UIColor colorWithHexString:@"01e2b6"] forState:UIControlStateNormal];
                [array[i] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [array[i] setBackgroundColor:JZ_BLUE_COLOR];
                // 获得button的frame
                CGRect rect = [array[i] frame];
                // 跟随条移动的位置
                CGFloat newRectW = (tag - 101) * rect.size.width;
                CGFloat followLabelX =  _followLabel.frame.origin.x;
                followLabelX = newRectW;
                CGRect followNew = CGRectMake(newRectW, _followLabel.frame.origin.y, _followLabel.frame.size.width, _followLabel.frame.size.height);
                               //动画
                [UIView animateWithDuration:0.3 animations:^{
                    _followLabel.frame= followNew;
                }];

                _selectButtonInteger = tag;

            }
//        }
    }
}

//模拟点击一项的方法
- (void)selectedItem:(NSInteger)tag {
    
    for (UIButton *itemBtn in self.subviews) {
        
        if (itemBtn.tag == tag) {
            
            [self didClickButton:itemBtn];
        }
    }
    _selectButtonInteger = tag;
    NSLog(@"%ld",_selectButtonInteger);
}

@end
