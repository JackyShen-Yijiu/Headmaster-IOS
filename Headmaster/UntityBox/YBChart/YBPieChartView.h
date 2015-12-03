//
//  YBXPieChartView.h
//  YBXChart
//
//  Created by 大威 on 15/12/1.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBPieChartView : UIView

// 百分比数组
@property (nonatomic, strong) NSArray *percentageArray;
// 颜色数组(可不设置)
@property (nonatomic, strong) NSArray *colorArray;

// 刷新数据
- (void)reloadData;

@end