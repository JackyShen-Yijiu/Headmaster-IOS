//
//  YBXPieChartView.h
//  YBXChart
//
//  Created by 大威 on 15/12/1.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"

@interface YBPieChartView : UIView

@property (nonatomic, strong) XYPieChart *pieChart;

// 百分比数组
@property (nonatomic, strong) NSArray *percentageArray;
// 颜色数组(可不设置)
@property (nonatomic, strong) NSArray *colorArray;

////手势点击
//@property (nonatomic, assign) BOOL isTap;
//
//@property (nonatomic, assign) CGFloat pieTapIndex;

// 刷新数据
- (void)reloadData;

@end
