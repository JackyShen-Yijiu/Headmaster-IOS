//
//  UULineChart.m
//  UUChartDemo
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "UULineChart.h"
#import "UUColor.h"
#import "UUChartLabel.h"
#import "UIColor+Extension.h"

@interface UULineChart()

@property (nonatomic, strong) UIView * sideView;

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) UIView * markView;

@property (nonatomic, strong) UILabel * xTitleMarkLabel;
@property (nonatomic, strong) UILabel * yTitleMarkLabel;

@end

@implementation UULineChart {
    NSHashTable *_chartLabelsForX;
}

- (id)initWithFrame:(CGRect)frame with_xLabelWidth:(CGFloat)xLabelWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:self.scrollView];
        self.backgroundColor = RGB_Color(246, 246, 246);
        _xLabelWidth = xLabelWidth;
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
    NSLog(@"yLabels:%@",yLabels);
    
    if (!yLabels.count) {
        return;
    }
    
    NSInteger max = 0;
    NSInteger min = 1000000000;

    for (NSArray * ary in yLabels) {
        for (NSString *valueString in ary) {
            NSLog(@"valueString:%@",valueString);
            
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
        _yValueMin = min;
    }else{
        _yValueMin = 0;
    }
    _yValueMax = (int)max;
    
    if (_chooseRange.max!=_chooseRange.min) {
        _yValueMax = _chooseRange.max;
        _yValueMin = _chooseRange.min;
    }

    float level = (_yValueMax-_yValueMin) / 4.0;
    CGFloat chartCavanHeight = self.frame.size.height - UULabelHeight*3;
    CGFloat levelHeight = chartCavanHeight /4.0;

    NSLog(@"level:%f _yValueMax:%f _yValueMin:%f",level,_yValueMax,_yValueMin);
    
    // 添加侧栏
    _sideView = [UIView new];
    _sideView.frame = CGRectMake(0, 0, UUYLabelwidth, self.bounds.size.height);
    [self addSubview:_sideView];
    
    for (int i=0; i<5; i++) {
        // UULabelHeight+i*levelHeight
        // (self.height-40)/4*i+10
        UUChartLabel * label = [[UUChartLabel alloc] initWithFrame:CGRectMake(0,UULabelHeight+i*levelHeight-UULabelHeight/2, UUYLabelwidth, UULabelHeight)];
		label.text = [NSString stringWithFormat:@"%.0f",_yValueMax - level * i];
        label.textColor = JZ_BLUE_COLOR;
        [_sideView addSubview:label];
    }
    if ([super respondsToSelector:@selector(setMarkRange:)]) {
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(UUYLabelwidth, (1-(_markRange.max-_yValueMin)/(_yValueMax-_yValueMin))*chartCavanHeight+UULabelHeight, self.frame.size.width-UUYLabelwidth, (_markRange.max-_markRange.min)/(_yValueMax-_yValueMin)*chartCavanHeight)];
//        view.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.1];
//        [self addSubview:view];
    }
}

-(void)setXLabels:(NSArray *)xLabels
{
    
    NSLog(@"%s xLabels:%@",__func__,xLabels);
    
    if (!xLabels.count) {
        return;
    }
    if( !_chartLabelsForX ){
        _chartLabelsForX = [NSHashTable weakObjectsHashTable];
    }
    
    _xLabels = xLabels;
    CGFloat num = 0;
    if (xLabels.count>=20) {
        num=20.0;
    }else if (xLabels.count<=1){
        num=1.0;
    }else{
        num = xLabels.count;
    }
    
    // xLabel的宽度
    
//    CGFloat newWidth = self.scrollView.bounds.size.width/num;
//    if (newWidth > _xLabelWidth) {
//        _xLabelWidth = newWidth;
//    }
    
    for (int i=0; i<xLabels.count; i++) {
        NSString *labelText = xLabels[i];
        UUChartLabel * label = [[UUChartLabel alloc] initWithFrame:CGRectMake(i * _xLabelWidth, self.bounds.size.height - UULabelHeight - UULabelHeight /2.f, _xLabelWidth, UULabelHeight)];
        label.text = labelText;
        label.textColor = RGB_Color(140, 140, 140);
        [self.scrollView addSubview:label];
        [_chartLabelsForX addObject:label];
    }
    
    //画竖线
//    for (int i=0; i<xLabels.count + 1; i++) {
//        if (i == 0 ) {
//            continue;
//        }
//        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//        UIBezierPath *path = [UIBezierPath bezierPath];
//        [path moveToPoint:CGPointMake(i*_xLabelWidth,UULabelHeight)];
//        [path addLineToPoint:CGPointMake(i*_xLabelWidth,self.frame.size.height-2*UULabelHeight)];
//        [path closePath];
//        shapeLayer.path = path.CGPath;
//        shapeLayer.strokeColor = [[[UIColor colorWithHexString:@"444444"] colorWithAlphaComponent:1] CGColor];
////        shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
//        shapeLayer.lineWidth = 1;
//        [self.scrollView.layer addSublayer:shapeLayer];
//    }
    
    CGFloat chartCavanHeight = self.bounds.size.height - UULabelHeight*3;
    CGFloat levelHeight = chartCavanHeight/ 4.0;
    //画横线
    for (int i=0; i<5; i++) {
        if ([_ShowHorizonLine[i] integerValue]>0) {
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(0,UULabelHeight+i*levelHeight)];
            [path addLineToPoint:CGPointMake(_xLabelWidth * _xLabels.count,UULabelHeight+i*levelHeight)];
            [path closePath];
            shapeLayer.path = path.CGPath;
            shapeLayer.strokeColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:1] CGColor];
//            shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
            shapeLayer.lineWidth = 0.5;
            [self.scrollView.layer addSublayer:shapeLayer];
        }
    }
    
}

-(void)setColors:(NSArray *)colors
{
	_colors = colors;
}

- (void)setMarkRange:(CGRange)markRange
{
    _markRange = markRange;
}

- (void)setChooseRange:(CGRange)chooseRange
{
    _chooseRange = chooseRange;
}

- (void)setShowHorizonLine:(NSMutableArray *)ShowHorizonLine
{
    _ShowHorizonLine = ShowHorizonLine;
}

-(void)strokeChart
{
    if (!_xLabels.count) {
        return;
    }
    for (int i=0; i<_yValues.count; i++) {
        NSArray *childAry = _yValues[i];
        if (childAry.count==0) {
            continue ;
        }
        //获取最大最小位置
        CGFloat max = [childAry[0] floatValue];
        CGFloat min = [childAry[0] floatValue];
        NSInteger max_i = 0;
        NSInteger min_i = 0;
        
        for (int j=0; j<childAry.count; j++){
            CGFloat num = [childAry[j] floatValue];
            if (max<=num){
                max = num;
                max_i = j;
            }
            if (min>=num){
                min = num;
                min_i = j;
            }
        }
        
        //划线
        CAShapeLayer *_chartLine = [CAShapeLayer layer];
        _chartLine.lineCap = kCALineCapRound;
        _chartLine.lineJoin = kCALineJoinBevel;
        _chartLine.fillColor   = [[UIColor whiteColor] CGColor];
        _chartLine.lineWidth   = 1.0;
        _chartLine.strokeEnd   = 0.0;
        [self.scrollView.layer addSublayer:_chartLine];
        
        UIBezierPath *progressline = [UIBezierPath bezierPath];
        CGFloat firstValue = [[childAry objectAtIndex:0] floatValue];
        CGFloat xPosition = (_xLabelWidth/2.0);
        CGFloat chartCavanHeight = self.frame.size.height - UULabelHeight*3;
        
        float grade = ((float)firstValue-_yValueMin) / ((float)_yValueMax-_yValueMin);
       
        //第一个点
        BOOL isShowMaxAndMinPoint = YES;
        if (self.ShowMaxMinArray) {
            if ([self.ShowMaxMinArray[i] intValue]>0) {
                isShowMaxAndMinPoint = (max_i==0 || min_i==0)?NO:YES;
            }else{
                isShowMaxAndMinPoint = YES;
            }
        }
        [self addPoint:CGPointMake(xPosition, chartCavanHeight - grade * chartCavanHeight+UULabelHeight)
                 index:i
                isShow:isShowMaxAndMinPoint
                 value:firstValue];
        
        [progressline moveToPoint:CGPointMake(xPosition, chartCavanHeight - grade * chartCavanHeight+UULabelHeight)];
        [progressline setLineWidth:2.0];
        [progressline setLineCapStyle:kCGLineCapRound];
        [progressline setLineJoinStyle:kCGLineJoinRound];
        NSInteger index = 0;
        for (NSString * valueString in childAry) {
            
            float grade =([valueString floatValue]-_yValueMin) / ((float)_yValueMax-_yValueMin);
            if (index != 0) {
                
                CGPoint point = CGPointMake(xPosition+index*_xLabelWidth, chartCavanHeight - grade * chartCavanHeight+UULabelHeight);
                [progressline addLineToPoint:point];
                
                BOOL isShowMaxAndMinPoint = YES;
                if (self.ShowMaxMinArray) {
                    if ([self.ShowMaxMinArray[i] intValue]>0) {
                        isShowMaxAndMinPoint = (max_i==index || min_i==index)?NO:YES;
                    }else{
                        isShowMaxAndMinPoint = YES;
                    }
                }
                [progressline moveToPoint:point];
                [self addPoint:point
                         index:i
                        isShow:isShowMaxAndMinPoint
                         value:[valueString floatValue]];
                
//                [progressline stroke];
            }
            index += 1;
        }
        
        _chartLine.path = progressline.CGPath;
        if ([[_colors objectAtIndex:i] CGColor]) {
            _chartLine.strokeColor = [[_colors objectAtIndex:i] CGColor];
        }else{
            _chartLine.strokeColor = [UUGreen CGColor];
        }
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = childAry.count*0.25;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnimation.autoreverses = NO;
        [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        _chartLine.strokeEnd = 1.0;
        
    }
    
    // 重新设置视图的宽度
    CGFloat width = _xLabelWidth * _xLabels.count;
    self.scrollView.contentSize = CGSizeMake(width, 0);
    
//    _markView = [UIView new];
    
//    _markView.backgroundColor = [UIColor clearColor];
//    _markView.frame = CGRectMake(5, self.bounds.size.height - 20, 25, 20);
//    _markView.backgroundColor = [UIColor yellowColor];
//    [self addSubview:_markView];
    
//    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(2.5, 10, 20, 0.5)];
//    lineLabel.backgroundColor = [UIColor colorWithHexString:@"047A64"];
//    lineLabel.transform = CGAffineTransformMakeRotation(M_PI * 0.75);
//    [_markView addSubview:lineLabel];
    
//    _xTitleMarkLabel = [UILabel new];
//    _xTitleMarkLabel.textColor = [UIColor colorWithHexString:@"047A64"];
//    _xTitleMarkLabel.frame = CGRectMake(1, 10, 25, 10);
//    _xTitleMarkLabel.textAlignment = 2;
//    _xTitleMarkLabel.font = [UIFont systemFontOfSize:12];
//    if (YBIphone6Plus) {
//        _xTitleMarkLabel.font = [UIFont systemFontOfSize:12*YBRatio];
//    }
//    [_markView addSubview:_xTitleMarkLabel];
    
//    _yTitleMarkLabel = [UILabel new];
//    _yTitleMarkLabel.textColor = [UIColor colorWithHexString:@"047A64"];
//    _yTitleMarkLabel.frame = CGRectMake(-3, 0, 30, 15);
//    _yTitleMarkLabel.textAlignment = 0;
//    _yTitleMarkLabel.font = [UIFont systemFontOfSize:12];
//    if (YBIphone6Plus) {
//        _yTitleMarkLabel.font = [UIFont systemFontOfSize:12*YBRatio];
//    }
//    [_markView addSubview:_yTitleMarkLabel];
    
//    if (_xTitleMarkWordString) {
//        _xTitleMarkLabel.text = _xTitleMarkWordString;
//    }
//    if (_yTitleMarkWordString) {
//        _yTitleMarkLabel.text = _yTitleMarkWordString;
//    }
//    _xTitleMarkLabel.backgroundColor = [UIColor cyanColor];
//    _yTitleMarkLabel.backgroundColor = [UIColor magentaColor];
}

- (void)addPoint:(CGPoint)point index:(NSInteger)index isShow:(BOOL)isHollow value:(CGFloat)value
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(5, 5, 6, 6)];
    view.center = point;
    view.backgroundColor = [UIColor greenColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 3;
    view.layer.borderWidth = 1.5;
    view.layer.borderColor = [[_colors objectAtIndex:index] CGColor]?[[_colors objectAtIndex:index] CGColor]:UUGreen.CGColor;
    
    if (isHollow) {
        view.backgroundColor = [[_colors objectAtIndex:index] CGColor]?[_colors objectAtIndex:index]:UUGreen;
    }else{
        view.backgroundColor = [_colors objectAtIndex:index]?[_colors objectAtIndex:index]:UUGreen;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(point.x-UUTagLabelwidth/2.0, point.y-UULabelHeight*2, UUTagLabelwidth, UULabelHeight)];
        label.font = [UIFont systemFontOfSize:10];
        if (YBIphone6Plus) {
            label.font = [UIFont systemFontOfSize:10*YBRatio];
        }
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = view.backgroundColor;
        label.text = [NSString stringWithFormat:@"%d",(int)value];
        [self.scrollView addSubview:label];
    }
    
    [self.scrollView addSubview:view];
}

- (void)drawLine {
    NSInteger num = self.bounds.size.width / 30;
    //画竖线
//    for (int i=0; i<num + 1; i++) {
//        if (i == 0 ) {
//            continue;
//        }
//        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//        UIBezierPath *path = [UIBezierPath bezierPath];
//        [path moveToPoint:CGPointMake(i*_xLabelWidth,UULabelHeight)];
//        [path addLineToPoint:CGPointMake(i*_xLabelWidth,self.frame.size.height-2*UULabelHeight)];
//        [path closePath];
//        shapeLayer.path = path.CGPath;
//        shapeLayer.strokeColor = [[[UIColor colorWithHexString:@"444444"] colorWithAlphaComponent:1] CGColor];
//        //        shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
//        shapeLayer.lineWidth = 1;
//        [self.scrollView.layer addSublayer:shapeLayer];
//    }
    
    CGFloat chartCavanHeight = self.bounds.size.height - UULabelHeight*3;
    CGFloat levelHeight = chartCavanHeight/4.0;
    //画横线
    for (int i=0; i<5; i++) {
//        if ([_ShowHorizonLine[i] integerValue]>0) {
        
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(0,UULabelHeight+i*levelHeight)];
            [path addLineToPoint:CGPointMake(_xLabelWidth + _xLabelWidth * num,UULabelHeight+i*levelHeight)];
            [path closePath];
            shapeLayer.path = path.CGPath;
            shapeLayer.strokeColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:1] CGColor];
            //            shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
            shapeLayer.lineWidth = 0.5;
            [self.scrollView.layer addSublayer:shapeLayer];
//        }
    }
}

- (NSArray *)chartLabelsForX
{
    return [_chartLabelsForX allObjects];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.frame = CGRectMake(UUYLabelwidth, 0, self.bounds.size.width - UUYLabelwidth, self.bounds.size.height);
        _scrollView.bounces = NO;
        _scrollView.backgroundColor = [UIColor clearColor];
    }
    return _scrollView;
}

@end
