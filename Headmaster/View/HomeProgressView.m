//
//  HomeProgressView.m
//  Headmaster
//
//  Created by 大威 on 15/12/8.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeProgressView.h"
#import "DVVProgressView.h"

@interface HomeProgressView()

@property (nonatomic, strong) UIImageView *backgroundImage;

@property (nonatomic, strong) DVVProgressView *outSide;
@property (nonatomic, strong) DVVProgressView *inSide;

@property (nonatomic, strong) DVVProgressView *outSideBgView;

@property (nonatomic, strong) DVVProgressView *outSideFgView;

@property (nonatomic, strong) DVVProgressView *inSideBgView;

@property (nonatomic, strong) DVVProgressView *inSideFgView;

@property (nonatomic, strong) UILabel *progressLabel;

@property (nonatomic, strong) UILabel *firstMarkLabel;

@property (nonatomic, strong) UILabel *secondMarkLabel;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) CGFloat maxValue;

@property (nonatomic, assign) CGFloat incremental;

@property (nonatomic, assign) CGFloat currentValue;

@property (nonatomic, assign) CGFloat progress;

@end

@implementation HomeProgressView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createObject];
    }
    return self;
}

- (void)refreshData:(NSArray *)array {
    
    if (array.count < 4) {
        return;
    }
    self.outSideBgView.progress = [array[0] floatValue];
    self.outSideFgView.progress = [array[1] floatValue];
    self.inSideBgView.progress = [array[2] floatValue];
    self.inSideFgView.progress = [array[3] floatValue];
    self.progress = [array[3] floatValue];
    // 加载显示的数字进度
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [_outSideBgView setNeedsDisplay];
    [_outSideFgView setNeedsDisplay];
//    [_inSideBgView setNeedsDisplay];
    [_inSideFgView setNeedsDisplay];
    
    [self loadShowTextWithProgress:self.inSideFgView.progress];
}

- (void)loadShowTextWithProgress:(CGFloat)progress {
//    NSLog(@"%f,%f",progress,self.progress);
    _currentValue = 0;
    _maxValue =  self.progress * 100;
    _incremental = _maxValue / 500;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
}

- (void)timerAction {
    
    _currentValue += _incremental;
    if (_currentValue > _maxValue) {
        [_timer invalidate];
        return;
    }
    [self setProgressText:_currentValue];
}

- (void)setProgressText:(CGFloat)value {
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.f%%",value]];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:36] range:(NSRange){ attributeStr.length -    1, 1 }];
    self.progressLabel.attributedText = attributeStr;
}

- (void)layoutSubviews {
    
    [self configUI];
}

- (void)configUI {
    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    
    _backgroundImage.frame = CGRectMake(20, 20, viewWidth - 40, viewHeight - 40);
    
    _outSideBgView.frame = CGRectMake(1, 1, viewWidth - 2, viewHeight - 2);
    _outSideFgView.frame = _outSideBgView.frame;
    _outSide.frame = _outSideBgView.frame;
    
    CGFloat margin = 37;
    if (SCREEN_WIDTH > 320) {
        margin = 47;
    }
    
    CGFloat insideWidth = viewHeight - margin * 2;
    _inSideBgView.frame = CGRectMake(margin, margin, insideWidth, insideWidth);
    _inSideFgView.frame  =_inSideBgView.frame;
    _inSide.frame = _inSideBgView.frame;
    
    _progressLabel.frame = CGRectMake(0, 0, insideWidth, insideWidth);
    _progressLabel.center = CGPointMake(viewWidth / 2.f, viewHeight / 2.f - 5);
    
    if (SCREEN_WIDTH > 320) {
        _firstMarkLabel.frame = CGRectMake(0, viewHeight - 30 - 60, viewWidth, 30);
        //    _firstMarkLabel.center = CGPointMake(viewWidth / 2.f, viewHeight / 2.f + 50);
        _secondMarkLabel.frame = CGRectMake(0, viewHeight - 60, viewWidth, 30);;
        //    _secondMarkLabel.center = CGPointMake(_firstMarkLabel.center.x, viewHeight / 2.f + 80);
    }else {
        _firstMarkLabel.frame = CGRectMake(0, viewHeight - 30 - 50, viewWidth, 30);
        _secondMarkLabel.frame = CGRectMake(0, viewHeight - 50, viewWidth, 30);;
    }
    
    _progressLabel.text = @"";
    _firstMarkLabel.text = @"实时负荷";
    _secondMarkLabel.text = @"当天累积负荷";
}

- (void)createObject {
    
    _backgroundImage = [UIImageView new];
    _backgroundImage.backgroundColor = [UIColor clearColor];
    _backgroundImage.image = [UIImage imageNamed:@"home_progress_bg"];
    [self addSubview:_backgroundImage];
    
    _outSide = [DVVProgressView new];
    _inSide = [DVVProgressView new];
    [self addSubview:_outSide];
    //    [self addSubview:_inSide];
    _outSide.animationDuration = 1;
    _inSide.animationDuration = 1;
    _outSide.lineColor = [UIColor blackColor];
    _inSide.lineColor = [UIColor blackColor];
    _outSide.progress = 1;
    _inSide.progress = 1;
    
    _outSideBgView = [DVVProgressView new];
    _outSideFgView = [DVVProgressView new];
    _inSideBgView = [DVVProgressView new];
    _inSideFgView = [DVVProgressView new];
    
    [self addSubview:_outSideBgView];
    [self addSubview:_outSideFgView];
    [self addSubview:_inSideBgView];
    [self addSubview:_inSideFgView];
    
    _outSideBgView.animationDuration = 2;
    _outSideBgView.lineColor = [UIColor colorWithHexString:@"4E1741"];
    _outSideBgView.progress = 0;
    
    _outSideFgView.animationDuration = 2;
    _outSideFgView.lineColor = [UIColor colorWithHexString:@"F955D2" alpha:0.8];
    _outSideFgView.progress = 0;
    
    _inSideBgView.animationDuration = 0.7;
    _inSideBgView.lineColor = [UIColor colorWithHexString:@"284E4D"];
    _inSideBgView.progress = 1;
    
    _inSideFgView.animationDuration = 2;
    _inSideFgView.lineColor = [UIColor colorWithHexString:HIGHLIGHT_COLOR alpha:0.8];
    _inSideFgView.progress = 0;
    
    _progressLabel = [UILabel new];
    _progressLabel.textAlignment = 1;
    _progressLabel.textColor = [UIColor colorWithHexString:HIGHLIGHT_COLOR];
    
    _firstMarkLabel = [UILabel new];
    _firstMarkLabel.textAlignment = 1;
    _firstMarkLabel.textColor = [UIColor colorWithHexString:HIGHLIGHT_COLOR];
    
    _secondMarkLabel = [UILabel new];
    _secondMarkLabel.textAlignment = 1;
    _secondMarkLabel.textColor = [UIColor colorWithHexString:@"F955D2"];
    
    if (SCREEN_WIDTH > 320) {
        _progressLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:48];
        if (YBIphone6Plus) {
            _progressLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:48*YBRatio];
        }
        _firstMarkLabel.font = [UIFont systemFontOfSize:20];
        if (YBIphone6Plus) {
            _firstMarkLabel.font = [UIFont systemFontOfSize:20*YBRatio];
        }
        _secondMarkLabel.font = [UIFont systemFontOfSize:20];
        if (YBIphone6Plus) {
            _secondMarkLabel.font = [UIFont systemFontOfSize:20*YBRatio];
        }
    }else {
        _progressLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:42];
        if (YBIphone6Plus) {
            _progressLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:42*YBRatio];
        }
        _firstMarkLabel.font = [UIFont systemFontOfSize:17];
        if (YBIphone6Plus) {
            _firstMarkLabel.font = [UIFont systemFontOfSize:17*YBRatio];
        }
        _secondMarkLabel.font = [UIFont systemFontOfSize:17];
        if (YBIphone6Plus) {
            _secondMarkLabel.font = [UIFont systemFontOfSize:17*YBRatio];
        }
    }
    
    [self addSubview:_progressLabel];
    [self addSubview:_firstMarkLabel];
    [self addSubview:_secondMarkLabel];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
