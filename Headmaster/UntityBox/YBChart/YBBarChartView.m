//
//  YBXBarChartView.m
//  YBXLineChartView
//
//  Created by 大威 on 15/12/1.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import "YBBarChartView.h"
#import "UUChart.h"
#import "UIColor+Extension.h"

@interface YBBarChartView()<UUChartDataSource>
{
    NSIndexPath *path;
    UUChart *chartView;
}
@end

@implementation YBBarChartView

- (void)refreshUI {
    
    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
    }
    
    chartView = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(0, 0, self.bounds.size.width, self.defaultHeight)
                                              withSource:self
                                               withStyle:UUChartBarStyle];
    if (_xTitleMarkWordString) {
        chartView.xTitleMarkWordString = _xTitleMarkWordString;
    }
    if (_yTitleMarkWordString) {
        chartView.yTitleMarkWordString = _yTitleMarkWordString;
    }
    [chartView showInView:self];
    self.backgroundColor = [UIColor clearColor];
    
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)UUChart_xLableArray:(UUChart *)chart
{
    return _xTitleArray;
}
//数值多重数组
- (NSArray *)UUChart_yValueArray:(UUChart *)chart
{
    return _valueArray;
}

#pragma mark - @optional
//颜色数组
- (NSArray *)UUChart_ColorArray:(UUChart *)chart
{
    if (_colorArray) {
        return _colorArray;
    }
    return @[[UIColor colorWithHexString: @"01E2B6"],UURed,UUBrown];
}

- (CGFloat)defaultHeight {
    
    return 120;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
