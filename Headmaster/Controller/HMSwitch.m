//
//  HMSwitch.m
//  
//
//  Created by kequ on 15/12/5.
//
//

#import "HMSwitch.h"

@interface HMSwitch()
@property(nonatomic,strong)UIImageView * backImageView;
@property(nonatomic,strong)UIImageView * knobView;
@end

@implementation HMSwitch


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backImageView.frame = CGRectMake(5, 0, self.width - 10, 8.f);
    self.backImageView.centerY = self.height/2.f;
    if (self.isOn) {
        self.knobView.frame = CGRectMake(0,
                                         0,
                                         21.f,
                                         self.height);
    } else {
        self.knobView.frame = CGRectMake(self.width - 21,
                                         0,
                                         21,
                                         self.height);
    }

}

- (void)commonInit
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handleTapTapGestureRecognizerEvent:)];
    [self addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handlePanGestureRecognizerEvent:)];
    [self addGestureRecognizer:panGesture];
}


- (void)handleTapTapGestureRecognizerEvent:(UITapGestureRecognizer *)recognizer
{
    if (!self.isOn) {
        return;
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self setOn:!self.isOn];
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)handlePanGestureRecognizerEvent:(UIPanGestureRecognizer *)recognizer
{
    if (!self.isOn) {
        return;
    }
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:{
            [self scaleKnodViewFrame:YES];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed: {
            [self scaleKnodViewFrame:NO];
            break;
        }
        case UIGestureRecognizerStateChanged:{
            break;
        }
        case UIGestureRecognizerStateEnded:
            [self setOn:!self.isOn];
            [self sendActionsForControlEvents:UIControlEventValueChanged];
            break;
        case UIGestureRecognizerStatePossible:
            break;
    }
}


- (void)scaleKnodViewFrame:(BOOL)scale
{
    CGRect preFrame = self.knobView.frame;
    
    if (self.isOn) {
        self.knobView.frame = CGRectMake(0,
                                         0,
                                         21.f,
                                         self.height);
    } else {
        self.knobView.frame = CGRectMake(self.width - 21,
                                         0,
                                         21,
                                         self.height);
    }
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"bounds"];
    [animation1 setFromValue:[NSValue valueWithCGRect:CGRectMake(0, 0, CGRectGetWidth(preFrame), CGRectGetHeight(preFrame))]];
    [animation1 setToValue:[NSValue valueWithCGRect:CGRectMake(0, 0, CGRectGetWidth(self.knobView.frame), CGRectGetHeight(self.knobView.frame))]];
    [animation1 setDuration:0.3];
    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.knobView.layer addAnimation:animation1 forKey:NULL];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation2 setFromValue:[NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(preFrame), CGRectGetMidY(preFrame))]];
    [animation2 setToValue:[NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.knobView.frame), CGRectGetMidY(self.knobView.frame))]];
    [animation2 setDuration:0.3];
    [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.knobView.layer addAnimation:animation2 forKey:NULL];
}

- (void)setOn:(BOOL)on
{
    _on = on;
    if (self.isOn) {
        self.knobView.frame = CGRectMake(0,
                                         0,
                                         21.f,
                                         self.height);
        self.knobView.image = [UIImage imageNamed:@"switch_on"];
    } else {
        self.knobView.frame = CGRectMake(self.width - 21,
                                         0,
                                         21,
                                         self.height);
        self.knobView.image = [UIImage imageNamed:@"swithc_off"];
    }
}

#pragma mark - GetMethod
- (UIImageView *)backImageView
{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [UIImage imageNamed:@"switch_bg"];
        [self addSubview:_backImageView];
    }
    return _backImageView;
}

- (UIImageView *)knobView
{
    if (!_knobView) {
        _knobView = [[UIImageView alloc] init];
        [self addSubview:_knobView];
        [self sendSubviewToBack:self.backImageView];
    }
    return _knobView;
}


@end
