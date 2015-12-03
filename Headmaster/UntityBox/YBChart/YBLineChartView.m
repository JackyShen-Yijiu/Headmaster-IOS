//
//  YBXLineChartView.m
//  YBXLineChartView
//
//  Created by 大威 on 15/11/30.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import "YBLineChartView.h"
#import "UUChart.h"

@interface YBLineChartView()<UUChartDataSource>
{
    NSIndexPath *path;
    UUChart *chartView;
}
@end

@implementation YBLineChartView

- (void)refreshUI {
    
    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
    }
    
    chartView = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(0, 0, self.bounds.size.width, self.defaultHeight)
                                              withSource:self
                                               withStyle:UUChartLineStyle];
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
    return @[UUGreen,UURed,UUBrown];
}

#pragma mark 折线图专享功能

//判断显示横线条
- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
    return YES;
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
