//
//  YBXPieChartView.m
//  YBXChart
//
//  Created by 大威 on 15/12/1.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import "YBPieChartView.h"

#import "UIColor+Extension.h"

@interface YBPieChartView()<XYPieChartDataSource, XYPieChartDelegate>



@end

@implementation YBPieChartView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initializeProperty];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeProperty];
    }
    return self;
}

- (void)initializeProperty {
    
    self.colorArray = @[ [UIColor colorWithHexString:@"01E2BB"],
                         [UIColor colorWithHexString:@"02AB8A"],
                         [UIColor colorWithHexString:@"047A64"] ];
}

- (void)reloadData {
    
    [self.pieChart reloadData];
}

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart {
    
    return self.percentageArray.count;
}
- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index {
    
    return [self.percentageArray[index] floatValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index {
    
        return self.colorArray[index];
}

- (void)layoutSubviews {
    
    [self addSubview:self.pieChart];
    
    // 添加中间的圆
//    UILabel *label = [UILabel new];
//    [label.layer setMasksToBounds:YES];
//    label.backgroundColor = [UIColor whiteColor];
//    CGFloat labelRadius = (self.bounds.size.width - 10) * 0.5 / 2.f;
//    label.frame = CGRectMake(self.bounds.size.width / 2.f - labelRadius / 2.f, self.bounds.size.width / 2.f - labelRadius / 2.f, labelRadius, labelRadius);
//    
//    [label.layer setCornerRadius:labelRadius / 2.f];
//    [self addSubview:label];
}

- (XYPieChart *)pieChart {
    if (!_pieChart) {
        _pieChart = [[XYPieChart alloc] initWithFrame:self.bounds];
        
        [_pieChart setDelegate:self];
        [_pieChart setDataSource:self];
        [_pieChart setStartPieAngle:M_PI *1.5];	//optional
        [_pieChart setAnimationSpeed:1.0];	//optional
//        [_pieChart setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];	//optional
        [_pieChart setLabelFont:[UIFont systemFontOfSize:24]];
        [_pieChart setLabelColor:[UIColor whiteColor]];	//optional, defaults to white
        [_pieChart setLabelShadowColor:[UIColor whiteColor]];	//optional, defaults to none (nil)
        //        [_pieChart setLabelRadius:160];	//optional
        [_pieChart setShowPercentage:YES];	//optional
        [_pieChart setPieBackgroundColor:[UIColor clearColor]];	//optional
        CGFloat radius = self.bounds.size.width / 2.f;
        [_pieChart setPieCenter:CGPointMake(radius, radius)];	//optional
        
        _pieChart.backgroundColor = [UIColor clearColor];

        [self addSubview:self.pieChart];
    }
    return _pieChart;
}

@end
