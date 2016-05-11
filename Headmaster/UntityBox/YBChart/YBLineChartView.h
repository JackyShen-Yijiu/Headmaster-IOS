//
//  YBXLineChartView.h
//  YBXLineChartView
//
//  Created by 大威 on 15/11/30.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBLineChartView : UIView

@property (nonatomic, assign) kDateSearchType searchType;

// 横纵轴提示字符
@property (nonatomic, copy) NSString *xTitleMarkWordString;
@property (nonatomic, copy) NSString *yTitleMarkWordString;
// 横轴标题
@property (nonatomic, strong) NSArray *xTitleArray;
// 数值数组（多重）
@property (nonatomic, strong) NSArray *valueArray;
// 颜色数组
@property (nonatomic, strong) NSArray *colorArray;
// 默认的高度
@property (nonatomic, readonly, assign)CGFloat defaultHeight;
// 动画的方式加载线性图
- (void)refreshUI;

@end
