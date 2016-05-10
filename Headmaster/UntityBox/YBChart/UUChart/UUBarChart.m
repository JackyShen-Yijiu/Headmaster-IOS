//
//  UUBarChart.m
//  UUChartDemo
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "UUBarChart.h"
#import "UUChartLabel.h"
#import "UUBar.h"
#import "UIColor+Extension.h"

@interface UUBarChart ()

@property (nonatomic, strong) UIScrollView *myScrollView;

@property (nonatomic, strong) UIView * markView;

@property (nonatomic, strong) UILabel * xTitleMarkLabel;
@property (nonatomic, strong) UILabel * yTitleMarkLabel;

@end

@implementation UUBarChart {
    NSHashTable *_chartLabelsForX;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:self.myScrollView];
        self.backgroundColor = [UIColor clearColor];
        _xLabelWidth = 30;
        [self drawLine];
    }
    return self;
}

-(void)setYValues:(NSArray *)yValues
{
    _yValues = yValues;
    [self setYLabels:yValues];
}

-(void)setYLabels:(NSArray *)yLabels
{
    if (!yLabels.count) {
        return;
    }
    NSInteger max = 0;
    NSInteger min = 1000000000;
    for (NSArray * ary in yLabels) {
        for (NSString *valueString in ary) {
            NSInteger value = [valueString integerValue];
            if (value > max) {
                max = value;
            }
            if (value < min) {
                min = value;
            }
        }
    }
    if (max < 4) {
        max = 4;
    }else {
        NSInteger remainder = max % 4;
        if (remainder) {
            max += 4 - remainder;
        }
    }

    if (self.showRange) {
        _yValueMin = (int)min;
    }else{
        _yValueMin = 0;
    }
    _yValueMax = (int)max;
    
    if (_chooseRange.max!=_chooseRange.min) {
        _yValueMax = _chooseRange.max;
        _yValueMin = _chooseRange.min;
    }

    float level = (_yValueMax-_yValueMin) /4.0;
    CGFloat chartCavanHeight = self.bounds.size.height - UULabelHeight*3;
    CGFloat levelHeight = chartCavanHeight /4.0;
    
    for (int i=0; i<5; i++) {
        if (i == 0) {
            continue;
        }
        UUChartLabel * label = [[UUChartLabel alloc] initWithFrame:CGRectMake(0.0,chartCavanHeight-i*levelHeight+5, UUYLabelwidth, UULabelHeight)];
		label.text = [NSString stringWithFormat:@"%.f",level * i+_yValueMin];
		[self addSubview:label];
    }
	
}

-(void)setXLabels:(NSArray *)xLabels
{
    if (!xLabels.count) {
        return;
    }
    if( !_chartLabelsForX ){
        _chartLabelsForX = [NSHashTable weakObjectsHashTable];
    }
    
    _xLabels = xLabels;
//    CGFloat num = xLabels.count;
//    if (xLabels.count>=8) {
//        num = 8;
//    }else if (xLabels.count<=4){
//        num = 4;
//    }else{
//        num = xLabels.count;
//    }
    
    // xLabel的宽度
    
//    CGFloat newWidth = self.myScrollView.bounds.size.width/num;
//    if (newWidth > _xLabelWidth) {
//        _xLabelWidth = newWidth;
//    }
    
    //画竖线
    for (int i=0; i<xLabels.count + 1; i++) {
        if (i == 0 ) {
            continue;
        }
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(i*_xLabelWidth,UULabelHeight)];
        [path addLineToPoint:CGPointMake(i*_xLabelWidth,self.frame.size.height-2*UULabelHeight)];
        [path closePath];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [[[UIColor colorWithHexString:@"444444"] colorWithAlphaComponent:1] CGColor];
//        shapeLayer.fillColor = [[UIColor grayColor] CGColor];
        shapeLayer.lineWidth = 1;
        [_myScrollView.layer addSublayer:shapeLayer];
    }
    
    CGFloat chartCavanHeight = self.frame.size.height - UULabelHeight*3;
    CGFloat levelHeight = chartCavanHeight /4.0;
    //画横线
    for (int i=0; i<5; i++) {
        
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(0,UULabelHeight+i*levelHeight)];
            [path addLineToPoint:CGPointMake(_xLabelWidth + _xLabelWidth * _xLabels.count,UULabelHeight+i*levelHeight)];
            [path closePath];
            shapeLayer.path = path.CGPath;
            shapeLayer.strokeColor = [[[UIColor colorWithHexString:@"444444"] colorWithAlphaComponent:1] CGColor];
            shapeLayer.fillColor = [[UIColor blackColor] CGColor];
            shapeLayer.lineWidth = 1;
            [_myScrollView.layer addSublayer:shapeLayer];
    }
    
    for (int i=0; i<xLabels.count; i++) {
        UUChartLabel * label = [[UUChartLabel alloc] initWithFrame:CGRectMake((i *  _xLabelWidth ) + _xLabelWidth / 2.f, self.bounds.size.height - UULabelHeight - UULabelHeight / 2.f, _xLabelWidth, UULabelHeight)];
        label.text = xLabels[i];
        [_myScrollView addSubview:label];
        label.backgroundColor = [UIColor clearColor];
        [_chartLabelsForX addObject:label];
    }
    
    float max = (([xLabels count])*_xLabelWidth )+_xLabelWidth;
    if (_myScrollView.frame.size.width < max-10) {
        _myScrollView.contentSize = CGSizeMake(max, self.frame.size.height);
    }
}

-(void)setColors:(NSArray *)colors
{
	_colors = colors;
}

- (void)setChooseRange:(CGRange)chooseRange
{
    _chooseRange = chooseRange;
}

-(void)strokeChart
{
    if (!_xLabels.count) {
        return;
    }
    _markView = [UIView new];
    
    _markView.backgroundColor = [UIColor clearColor];
    _markView.frame = CGRectMake(5, self.bounds.size.height - 20, 25, 20);
    [self addSubview:_markView];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(2.5, 10, 20, 0.5)];
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"047A64"];
    lineLabel.transform = CGAffineTransformMakeRotation(M_PI * 0.75);
    [_markView addSubview:lineLabel];
    
    _xTitleMarkLabel = [UILabel new];
    _xTitleMarkLabel.textColor = [UIColor colorWithHexString:@"047A64"];
    _xTitleMarkLabel.frame = CGRectMake(1, 10, 25, 10);
    _xTitleMarkLabel.textAlignment = 2;
    _xTitleMarkLabel.font = [UIFont systemFontOfSize:12];
    if (YBIphone6Plus) {
        _xTitleMarkLabel.font = [UIFont systemFontOfSize:12*YBRatio];
    }
    [_markView addSubview:_xTitleMarkLabel];
    
    _yTitleMarkLabel = [UILabel new];
    _yTitleMarkLabel.textColor = [UIColor colorWithHexString:@"047A64"];
    _yTitleMarkLabel.frame = CGRectMake(-3, 0, 30, 15);
    _yTitleMarkLabel.textAlignment = 0;
    _yTitleMarkLabel.font = [UIFont systemFontOfSize:12];
    if (YBIphone6Plus) {
        _yTitleMarkLabel.font = [UIFont systemFontOfSize:12*YBRatio];
    }
    [_markView addSubview:_yTitleMarkLabel];
    
    if (_xTitleMarkWordString) {
        _xTitleMarkLabel.text = _xTitleMarkWordString;
    }
    if (_yTitleMarkWordString) {
        _yTitleMarkLabel.text = _yTitleMarkWordString;
    }
    
    CGFloat chartCavanHeight = self.frame.size.height - UULabelHeight*3;
	
    for (int i=0; i<_yValues.count; i++) {
        if (i==2)
            return;
        NSArray *childAry = _yValues[i];
        for (int j=0; j<childAry.count; j++) {
            
            NSString *valueString = childAry[j];
            CGFloat value = [valueString floatValue];
            CGFloat grade = ((CGFloat)value-_yValueMin) / ((CGFloat)_yValueMax-_yValueMin);
            
//            float level = (_yValueMax-_yValueMin) /4.0;
//            CGFloat chartCavanHeight = self.bounds.size.height - UULabelHeight*3;
//            CGFloat levelHeight = chartCavanHeight /4.0;
            
            UUBar * bar = [[UUBar alloc] initWithFrame:CGRectMake((j+(_yValues.count==1?0.25:0.05))*_xLabelWidth +i*_xLabelWidth * 0.47 + _xLabelWidth / 2.f,
                                                                  UULabelHeight,
                                                                  _xLabelWidth * (_yValues.count==1?0.5:0.45),
                                                                  chartCavanHeight)];
            bar.barColor = [_colors objectAtIndex:i];
            bar.grade = grade;
            [_myScrollView addSubview:bar];
            
        }
    }
}

- (void)drawLine {
    
    NSInteger num = self.bounds.size.width / 30;
    //画竖线
    for (int i=0; i<num + 1; i++) {
        if (i == 0 ) {
            continue;
        }
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(i*_xLabelWidth,UULabelHeight)];
        [path addLineToPoint:CGPointMake(i*_xLabelWidth,self.frame.size.height-2*UULabelHeight)];
        [path closePath];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [[[UIColor colorWithHexString:@"444444"] colorWithAlphaComponent:1] CGColor];
        //        shapeLayer.fillColor = [[UIColor grayColor] CGColor];
        shapeLayer.lineWidth = 1;
        [_myScrollView.layer addSublayer:shapeLayer];
    }
    
    CGFloat chartCavanHeight = self.frame.size.height - UULabelHeight*3;
    CGFloat levelHeight = chartCavanHeight /4.0;
    //画横线
    for (int i=0; i<5; i++) {
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0,UULabelHeight+i*levelHeight)];
        [path addLineToPoint:CGPointMake(_xLabelWidth + _xLabelWidth * num,UULabelHeight+i*levelHeight)];
        [path closePath];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [[[UIColor colorWithHexString:@"444444"] colorWithAlphaComponent:1] CGColor];
        shapeLayer.fillColor = [[UIColor blackColor] CGColor];
        shapeLayer.lineWidth = 1;
        [_myScrollView.layer addSublayer:shapeLayer];
    }
}

- (NSArray *)chartLabelsForX
{
    return [_chartLabelsForX allObjects];
}

- (UIScrollView *)myScrollView {
    if (!_myScrollView) {
        _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(UUYLabelwidth, 0, self.bounds.size.width - UUYLabelwidth, self.bounds.size.height)];
        _myScrollView.bounces = NO;
        _myScrollView.backgroundColor = [UIColor clearColor];
    }
    return _myScrollView;
}

@end
