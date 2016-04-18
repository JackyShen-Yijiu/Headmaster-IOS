//
//  YBXBarChartView.h
//  YBXLineChartView
//
//  Created by 大威 on 15/12/1.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBBarChartView : UIView

// 横轴提示字符
@property (nonatomic, copy) NSString *xTitleMarkWordString;
@property (nonatomic, copy) NSString *yTitleMarkWordString;
// 横轴标题
@property (nonatomic, strong) NSArray *xTitleArray;
// 数值数组
@property (nonatomic, strong) NSArray *valueArray;
// 颜色数组
@property (nonatomic, strong) NSArray *colorArray;
// 默认的高度
@property (nonatomic, readonly, assign)CGFloat defaultHeight;
// 动画的方式加载条形图
- (void)refreshUI;


@end
