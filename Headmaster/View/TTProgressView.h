//
//  TTProgressView.h
//  TestCricy
//
//  Created by ytzhang on 16/5/4.
//  Copyright © 2016年 ytzhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TTProgressView : UIView

@property (nonatomic,assign) CGFloat percent;

@property (nonatomic,assign) CGFloat  lineWidth;

@property (strong, nonatomic) NSTimer *timer;

/**
 *  @brief  初始化方法
 *
 *  @param frame       视图位置
 *  @param bgcolor     背景颜色
 *  @param resultColor 结果颜色
 *
 *  @return TTProgressView对象
 */

- (instancetype)initWithFrame:(CGRect)frame bgColor:(UIColor *)bgcolor resultColor:(UIColor *)resultColor;

@end
