//
//  TTProgressView.m
//  TestCricy
//
//  Created by ytzhang on 16/5/4.
//  Copyright © 2016年 ytzhang. All rights reserved.
//

#import "TTProgressView.h"

@interface TTProgressView()
{
    CAShapeLayer *_bottomShapeLayer;
    CAShapeLayer *_upperShapeLayer;
    CGFloat _percent;
    UILabel *_percentLabel;
    UIColor *_bgbgColor;
    UIColor *_resultresultColor;
}
@end
@implementation TTProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
      
        [self drawBottomLayer];
        [self drawUpperLayer];
        [self.layer addSublayer:_bottomShapeLayer ];
        [_bottomShapeLayer addSublayer:_upperShapeLayer];
        // 文本框
        [self drawTextLabel];
        [self addSubview:_percentLabel];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame bgColor:(UIColor *)bgcolor resultColor:(UIColor *)resultColor{
    
    if ((self = [super initWithFrame:frame])) {
        _bgbgColor = bgcolor;
        _resultresultColor = resultColor;
        [self drawBottomLayer];
        [self drawUpperLayer];
        [self.layer addSublayer:_bottomShapeLayer ];
        [_bottomShapeLayer addSublayer:_upperShapeLayer];
        // 文本框
        [self drawTextLabel];
        [self addSubview:_percentLabel];
        _percentLabel.textColor = resultColor;
    }
    return self;
}

- (UILabel *)drawTextLabel
{
    _percentLabel = [[UILabel alloc] init];
    CGFloat centerX = (CGRectGetMaxX(self.frame) - CGRectGetMinX(self.frame)) / 2;
    CGFloat centerY = (CGRectGetMaxY(self.frame) - CGRectGetMinY(self.frame)) / 2;
    CGFloat width = self.frame.size.width / 2;
    CGFloat height = self.frame.size.height / 2;
    _percentLabel.center = CGPointMake(centerX, centerY);
    _percentLabel.bounds = CGRectMake(0, 0, width, height);
    
    _percentLabel.font = [UIFont boldSystemFontOfSize:15];
    if (YBIphone6Plus) {
        _percentLabel.font = [UIFont boldSystemFontOfSize:15*YBRatio];
    }
    _percentLabel.textAlignment = NSTextAlignmentCenter;
    
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(percentChange) userInfo:nil repeats:YES];
    }
    return _percentLabel;
}

- (void)percentChange
{
    _percentLabel.text = [NSString stringWithFormat:@"%.0f%%",_percent * 100];
}

- (CAShapeLayer *)drawBottomLayer
{
    _bottomShapeLayer                 = [[CAShapeLayer alloc] init];
    _bottomShapeLayer.frame           = self.bounds;
    CGFloat width                     = self.bounds.size.width;
    
    UIBezierPath *path                = [UIBezierPath bezierPathWithArcCenter:CGPointMake((CGRectGetMaxX(self.frame) - CGRectGetMinX(self.frame)) / 2, (CGRectGetMaxY(self.frame) - CGRectGetMinY(self.frame)) / 2)  radius:width / 2 startAngle:0 endAngle:6.28 clockwise:YES];
    _bottomShapeLayer.path            = path.CGPath;
    
    //    _bottomShapeLayer.lineCap = kCALineCapButt;
    //    _bottomShapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:5],[NSNumber numberWithInt:5], nil];
    
    _bottomShapeLayer.lineCap = kCALineCapSquare;
    
    _bottomShapeLayer.lineWidth = 7;
    _bottomShapeLayer.strokeColor     = _bgbgColor.CGColor;
    _bottomShapeLayer.fillColor       = [UIColor clearColor].CGColor;
    return _bottomShapeLayer;
}

- (CAShapeLayer *)drawUpperLayer
{
    _upperShapeLayer                 = [[CAShapeLayer alloc] init];
    _upperShapeLayer.frame           = self.bounds;
    CGFloat width                     = self.bounds.size.width;
    
    UIBezierPath *path                = [UIBezierPath bezierPathWithArcCenter:CGPointMake((CGRectGetMaxX(self.frame) - CGRectGetMinX(self.frame)) / 2, (CGRectGetMaxY(self.frame) - CGRectGetMinY(self.frame)) / 2)
                                                                       radius:width / 2   startAngle:-1.57
                                                                     endAngle:4.71
                                                                    clockwise:YES];
    _upperShapeLayer.path            = path.CGPath;
    _upperShapeLayer.strokeStart = 0;
    _upperShapeLayer.strokeEnd =   0;
    [self performSelector:@selector(shapeChange) withObject:nil afterDelay:0.3];
    _upperShapeLayer.lineWidth = 7;
    
    //    _upperShapeLayer.lineCap = kCALineCapButt;
    //    _upperShapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:5],[NSNumber numberWithInt:5], nil];
    
    _upperShapeLayer.lineCap = kCALineCapRound;
    
    _upperShapeLayer.strokeColor     = _resultresultColor.CGColor;
    _upperShapeLayer.fillColor       = [UIColor clearColor].CGColor;
    return _upperShapeLayer;
}

@synthesize percent = _percent;
- (CGFloat )percent
{
    return _percent;
}

- (void)setPercent:(CGFloat)percent
{
    _percent = percent;
    
    if (percent > 1) {
        percent = 1;
    }else if (percent < 0){
        percent = 0;
    }
   
    _upperShapeLayer.strokeEnd = _percent;

    _percentLabel.text = [NSString stringWithFormat:@"%.0f%%",_percent * 100];

    if (percent==1) {// 绿色
        _upperShapeLayer.strokeColor     = [UIColor colorWithHexString:@"7bd65c"].CGColor;
        _percentLabel.textColor = [UIColor colorWithHexString:@"7bd65c"];
    }else if (percent>0.5 && percent <1){// 蓝色ok
        _upperShapeLayer.strokeColor     = JZ_BLUE_COLOR.CGColor;
        _percentLabel.textColor = JZ_BLUE_COLOR;
    }else{// 红色ok
        _upperShapeLayer.strokeColor     = kJZRedColor.CGColor;
        _percentLabel.textColor = kJZRedColor;
    }
    
}

- (void)shapeChange
{
    _upperShapeLayer.strokeEnd = _percent;
}

- (void)setBgColor:(UIColor *)bgColor{
    _bgbgColor = bgColor;
}
- (void)setResultColor:(UIColor *)resultColor{
    _resultresultColor = resultColor;
}
@end