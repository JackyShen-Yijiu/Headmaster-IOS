//
//  ViewController.h
//  DVVARCProgress
//
//  Created by 大威 on 15/12/5.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVVProgressView : UIView

// 进度条的宽
@property (nonatomic, assign) CGFloat lineWidth;
// 进度
@property (nonatomic, assign) CGFloat progress;
// 动画时间
@property (nonatomic, assign) CGFloat animationDuration;
// 线条的颜色
@property (nonatomic, strong) UIColor *lineColor;
// 线条的背景
@property (nonatomic, strong) UIImage *lineBackgroundImage;
// 是否显示进度球
@property (nonatomic, assign) BOOL showBall;

@end
