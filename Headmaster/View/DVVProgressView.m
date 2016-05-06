//
//  ViewController.h
//  DVVARCProgress
//
//  Created by 大威 on 15/12/5.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import "DVVProgressView.h"
#import "UIColor+Extension.h"

@interface DVVProgressView()

@property (nonatomic, strong) CAShapeLayer * shapeLayer;

@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;

@property (nonatomic, strong) UIView * rotateView;
@property (nonatomic, strong) UIButton * rotateButton;

@property (nonatomic, strong) UIView *contentView;

@end

@implementation DVVProgressView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _lineWidth = 10;
        _animationDuration = 3;
        
        _startAngle = 0;
        _endAngle = 1.0;
        
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor = [[UIColor clearColor]CGColor];
        _shapeLayer.strokeColor = [[UIColor whiteColor
                                    ] CGColor];
        _shapeLayer.backgroundColor = [[UIColor clearColor] CGColor];
        _shapeLayer.lineJoin = kCALineJoinRound;
        _shapeLayer.lineCap = kCALineCapRound;
        
        [self addSubview:self.contentView];
//        [self addSubview:self.rotateView];
//        [self.rotateView addSubview:self.rotateButton];
        
        [self addSubview:self.rotateButton];
        
//        _contentView.backgroundColor = [UIColor redColor];
//        _rotateView.backgroundColor = [UIColor grayColor];
        _rotateButton.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

// 根据进度设置结束的角度
- (void)setProgress:(CGFloat)progress {
    
    // 设置动画的时长
    
    // 获得角度的增加量
    CGFloat angleIncrement = 1.4 * progress;
    // 判断是否到达起始点
    _endAngle = _startAngle + angleIncrement;
    if (_endAngle >= 2) {
        _endAngle -= 2;
    }
    
}

- (void)drawRect:(CGRect)rect {
    
    _rotateView.frame = CGRectMake(0, 0, self.bounds.size.width, _lineWidth);
    _rotateView.center = CGPointMake(self.bounds.size.width / 2.f, self.bounds.size.height / 2.f);
    _rotateButton.frame = CGRectMake(0, 0, _lineWidth, _lineWidth);
    
    // 旋转
//    _rotateView.transform = CGAffineTransformMakeRotation(M_PI * 1.8);
    
    _contentView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    
    // 半径
    CGFloat radius = (self.bounds.size.width - _lineWidth) / 2.f;
    // 设置中心点
    CGFloat viewRadius = rect.size.width / 2.f;
    CGPoint center = CGPointMake(viewRadius, viewRadius);
    // 绘制路径
    UIBezierPath* aPath = [UIBezierPath bezierPathWithArcCenter:center
                                                         radius:radius
                                                     startAngle:0
                                                       endAngle:2 * M_PI
                                                      clockwise:YES];
    // 路径的宽度
    aPath.lineWidth = _lineWidth;
    // 线条拐角
    aPath.lineCapStyle = kCGLineCapRound;
    // 终点处理
    aPath.lineJoinStyle = kCGLineCapRound;
    
    _shapeLayer.lineWidth = _lineWidth;
    _shapeLayer.path = aPath.CGPath;
    
    // 设置遮罩
    [_contentView.layer setMask:_shapeLayer];
    
    // 添加动画
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = _animationDuration;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    [_shapeLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
//    [_shapeLayer addObserver:self forKeyPath:@"strokeStart" options:NSKeyValueObservingOptionNew context:NULL];
    
    if (!_showBall) {
        [self.rotateButton removeFromSuperview];
        return;
    }
    // 圆球的动画
    //创建核心动画
    CAKeyframeAnimation *keyAnima=[CAKeyframeAnimation animation];
    //平移
    keyAnima.keyPath=@"position";

    //创建一条路径
    keyAnima.path=aPath.CGPath;

    //设置动画执行完毕后，不删除动画
    keyAnima.removedOnCompletion=NO;
    //设置保存动画的最新状态
    keyAnima.fillMode=kCAFillModeForwards;
    //设置动画执行的时间
    keyAnima.duration=_animationDuration;
    //设置动画的节奏
    keyAnima.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    keyAnima.keyTimes = @[ @1 ];
    
    //添加核心动画
    [self.rotateButton.layer addAnimation:keyAnima forKey:@"rotateAnimation"];
    
    
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
//{
//    NSLog(@"%@",_shapeLayer.presentationLayer);
//}

- (void)setLineColor:(UIColor *)lineColor {
    self.contentView.backgroundColor = lineColor;
}

- (void)setLineBackgroundImage:(UIImage *)lineBackgroundImage {
    self.contentView.layer.contents = (id)lineBackgroundImage.CGImage;
}

- (UIView *)rotateView {
    if (!_rotateView) {
        _rotateView = [UIView new];
    }
    return _rotateView;
}

- (UIButton *)rotateButton {
    if (!_rotateButton) {
        _rotateButton = [UIButton new];
        [_rotateButton.layer setMasksToBounds:YES];
        [_rotateButton.layer setCornerRadius:_lineWidth / 2.f];
    }
    return _rotateButton;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
    }
    return _contentView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
