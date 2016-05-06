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

//@property (nonatomic, strong) UIImageView *backgroundImage;

//@property (nonatomic, strong) DVVProgressView *outSide;
//@property (nonatomic, strong) DVVProgressView *inSide;

//@property (nonatomic, strong) DVVProgressView *outSideBgView;

//@property (nonatomic, strong) DVVProgressView *outSideFgView;

//@property (nonatomic, strong) DVVProgressView *inSideBgView;

//@property (nonatomic, strong) DVVProgressView *inSideFgView;

//@property (nonatomic, strong) UILabel *progressLabel;

//@property (nonatomic, strong) UILabel *firstMarkLabel;

//@property (nonatomic, strong) UILabel *secondMarkLabel;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) CGFloat maxValue;

@property (nonatomic, assign) CGFloat incremental;

@property (nonatomic, assign) CGFloat currentValue;

//@property (nonatomic, assign) CGFloat progress;

@property (nonatomic,strong) UILabel *topLabel;

@property (nonatomic,strong) NSMutableArray *progressViewArray;
@property (nonatomic,strong) NSMutableArray *labelArray;
@property (nonatomic,strong) NSMutableArray *cirmpArray;

@end

@implementation HomeProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.progressViewArray = [NSMutableArray array];
        self.labelArray = [NSMutableArray array];
        self.cirmpArray = [NSMutableArray array];

//        [self createObject];
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{

    self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kJZWidth, 20)];
    self.topLabel.textAlignment = 1;
    self.topLabel.textAlignment = NSTextAlignmentCenter;
    self.topLabel.text = @"当前合格率";
    self.topLabel.font = [UIFont boldSystemFontOfSize:13];
    if (YBIphone6Plus) {
        self.topLabel.font = [UIFont boldSystemFontOfSize:13*YBRatio];
    }
    self.topLabel.textColor = [UIColor blackColor];
    [self addSubview:self.topLabel];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.frame = CGRectMake(0, 30, kJZWidth, self.height-30);
    [self addSubview:contentView];
    
    NSInteger maxColumns = 2;
    
    NSArray *subjectArray = [NSArray arrayWithObjects:@"科目一", @"科目二",@"科目三",@"科目四",nil];
    
    for (int i = 0; i < 4; i ++) {
    
        NSInteger col = i % maxColumns;
        NSInteger row = i / maxColumns;
        
        NSLog(@"col:%ld row:%ld",(long)col,(long)row);
        
        UIView *progressView = [[UIView alloc] init];
        CGFloat progressViewW = contentView.width/2;
        CGFloat progressViewH = contentView.height/2;
        CGFloat progressViewX = col * progressViewW;
        CGFloat progressViewY = 0;
        if (i > 1) {
            progressViewY = progressViewH;
        }
        progressView.frame = CGRectMake(progressViewX, progressViewY, progressViewW, progressViewH);
//        progressView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0f];
        [contentView addSubview:progressView];
        
        DVVProgressView  *progress = [DVVProgressView new];
        progress.tag = i + 100;
        progress.lineBackgroundImage = [UIImage imageNamed:@"x3"];
        progress.lineWidth = 5;
        progress.animationDuration = 1.0;
        progress.lineColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0f];
//        progress.progress = 1.0;
        CGFloat progressY = 15;
        progress.frame = CGRectMake(45, progressY, progressViewW-90, progressViewW-90);
        [progressView addSubview:progress];
        [self.progressViewArray addObject:progress];
        
        UILabel *label = [[UILabel alloc] init];
        CGFloat labelW = progress.width;
        CGFloat labelH = 40;
        CGFloat labelX = 0;
        CGFloat labelY = progress.height/2-labelH/2;
        label.text = @"33";
        label.tag = i + 1000;
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        [progress addSubview:label];
        [self.labelArray addObject:label];

        UIView *delive = [[UIView alloc] init];
        delive.backgroundColor = [UIColor lightGrayColor];
        delive.alpha = 0.3;
        CGFloat deliveX = progressViewW;
        CGFloat deliveY = progressViewH;
        CGFloat deliveW = 0;
        CGFloat deliveH = 0;
        
        if (i == 0) {
            deliveY = 10;
            deliveW = 0.5;
            deliveH = progressViewH - 20;
        }
        if (i == 1) {
            deliveX = 10;
            deliveW = progressViewW - 20;
            deliveH = 0.5;
        }
        if (i == 2) {
            deliveX = progressViewW + 10;
            deliveW = progressViewW - 20;
            deliveH = 0.5;
        }
        if (i==3) {
            deliveY+=10;
            deliveW = 0.5;
            deliveH = progressViewH - 20;
        }
        
        delive.frame = CGRectMake(deliveX, deliveY, deliveW, deliveH);
        [contentView addSubview:delive];
        
        // 科目
        UILabel *subjectLabel = [[UILabel alloc] init];
        CGFloat subjectLabelW = progressView.width;
        CGFloat subjectLabelH = 20;
        CGFloat subjectLabelX = 0;
        CGFloat subjectLabelY = CGRectGetMaxY(progress.frame)+10;
        subjectLabel.text = [NSString stringWithFormat:@"%@",subjectArray[i]];
        subjectLabel.textAlignment = NSTextAlignmentCenter;
        subjectLabel.frame = CGRectMake(subjectLabelX, subjectLabelY, subjectLabelW, subjectLabelH);
        subjectLabel.font = [UIFont systemFontOfSize:13];
        subjectLabel.textColor = [UIColor grayColor];
        [progressView addSubview:subjectLabel];

        // 积压
        UILabel *cirmpLabel = [[UILabel alloc] init];
        CGFloat cirmpLabelW = progressView.width;
        CGFloat cirmpLabelH = 15;
        CGFloat cirmpLabelX = 0;
        CGFloat cirmpLabelY = CGRectGetMaxY(subjectLabel.frame);
        cirmpLabel.text = @"积压人数";
        cirmpLabel.textAlignment = NSTextAlignmentCenter;
        cirmpLabel.frame = CGRectMake(cirmpLabelX, cirmpLabelY, cirmpLabelW, cirmpLabelH);
        cirmpLabel.font = [UIFont systemFontOfSize:12];
        cirmpLabel.textColor = [UIColor grayColor];
        [progressView addSubview:cirmpLabel];
        cirmpLabel.tag = i + 10000;
        [self.cirmpArray addObject:cirmpLabel];

    }
    
    
    UIView *delive = [[UIView alloc] init];
    delive.backgroundColor = [UIColor lightGrayColor];
    delive.alpha = 0.3;
    delive.frame = CGRectMake(0, self.height-0.5, self.width, 0.5);
    [self addSubview:delive];
    
    NSLog(@"self.subviews:%@",self.subviews);
    
}

- (void)refreshpassrate:(NSArray *)passrate overstockstudent:(NSArray *)overstockstudent{

    NSLog(@"refreshData array:%@ overstockstudent:%@",passrate,overstockstudent);
    
    for (DVVProgressView  *progressView  in self.progressViewArray) {
        
        NSLog(@"progressView:%@",progressView);
        
        if (progressView.tag != 0 && ![[passrate objectAtIndex:progressView.tag - 100] isKindOfClass:[NSNull class]]) {
            NSLog(@"[passrate[progressView.tag-100] integerValue] / 100:%f",[passrate[progressView.tag-100] floatValue] / 100);
            progressView.progress = [passrate[progressView.tag-100] floatValue] / 100;
        }

    }
    
    // 百分比
    for (UILabel  *label  in self.labelArray) {
        
        NSLog(@"label:%@",label);
        
        if (label.tag != 0 && ![[passrate objectAtIndex:label.tag - 1000] isKindOfClass:[NSNull class]]) {
            label.text = [NSString stringWithFormat:@"%ld%@",(long)[passrate[label.tag-1000] integerValue],@"％"];
        }
        
    }
    
   // 积压
    for (UILabel  *cirmpLabel  in self.cirmpArray) {
        
        NSLog(@"cirmpLabel:%@",cirmpLabel);
        
        if (cirmpLabel.tag != 0 && ![[overstockstudent objectAtIndex:cirmpLabel.tag - 10000] isKindOfClass:[NSNull class]]) {
            cirmpLabel.text = [NSString stringWithFormat:@"积压:%ld人",(long)[overstockstudent[cirmpLabel.tag-10000] integerValue]];
        }
    }
    
   
}

- (void)loadShowTextWithProgress:(CGFloat)progress {
//    NSLog(@"%f,%f",progress,self.progress);
    _currentValue = 0;
//    _maxValue =  self.progress * 100;
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
//    self.progressLabel.attributedText = attributeStr;
}

- (void)layoutSubviews {
    
    //[self configUI];
}

- (void)configUI {
    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    
//    _backgroundImage.frame = CGRectMake(20, 20, viewWidth - 40, viewHeight - 40);
//
//    _outSideBgView.frame = CGRectMake(1, 1, viewWidth - 2, viewHeight - 2);
//    _outSideFgView.frame = _outSideBgView.frame;
//    _outSide.frame = _outSideBgView.frame;
//    
    CGFloat margin = 37;
    if (SCREEN_WIDTH > 320) {
        margin = 47;
    }
    
    CGFloat insideWidth = viewHeight - margin * 2;
//    _inSideBgView.frame = CGRectMake(margin, margin, insideWidth, insideWidth);
//    _inSideFgView.frame  =_inSideBgView.frame;
//    _inSide.frame = _inSideBgView.frame;
    
//    _progressLabel.frame = CGRectMake(0, 0, insideWidth, insideWidth);
//    _progressLabel.center = CGPointMake(viewWidth / 2.f, viewHeight / 2.f - 5);
    
//    if (SCREEN_WIDTH > 320) {
//        _firstMarkLabel.frame = CGRectMake(0, viewHeight - 30 - 60, viewWidth, 30);
//        //    _firstMarkLabel.center = CGPointMake(viewWidth / 2.f, viewHeight / 2.f + 50);
//        _secondMarkLabel.frame = CGRectMake(0, viewHeight - 60, viewWidth, 30);;
//        //    _secondMarkLabel.center = CGPointMake(_firstMarkLabel.center.x, viewHeight / 2.f + 80);
//    }else {
//        _firstMarkLabel.frame = CGRectMake(0, viewHeight - 30 - 50, viewWidth, 30);
//        _secondMarkLabel.frame = CGRectMake(0, viewHeight - 50, viewWidth, 30);;
//    }
    
//    _progressLabel.text = @"";
//    _firstMarkLabel.text = @"实时负荷";
//    _secondMarkLabel.text = @"当天累积负荷";
}

- (void)createObject {
    
//    _backgroundImage = [UIImageView new];
//    _backgroundImage.backgroundColor = [UIColor clearColor];
//    _backgroundImage.image = [UIImage imageNamed:@"home_progress_bg"];
//    [self addSubview:_backgroundImage];
    
//    _outSide = [DVVProgressView new];
//    _inSide = [DVVProgressView new];
//    [self addSubview:_outSide];
    //    [self addSubview:_inSide];
//    _outSide.animationDuration = 1;
//    _inSide.animationDuration = 1;
//    _outSide.lineColor = [UIColor blackColor];
//    _inSide.lineColor = [UIColor blackColor];
//    _outSide.progress = 1;
//    _inSide.progress = 1;
    
//    _outSideBgView = [DVVProgressView new];
//    _outSideFgView = [DVVProgressView new];
//    _inSideBgView = [DVVProgressView new];
//    _inSideFgView = [DVVProgressView new];
    
//    [self addSubview:_outSideBgView];
//    [self addSubview:_outSideFgView];
//    [self addSubview:_inSideBgView];
//    [self addSubview:_inSideFgView];
    
//    _outSideBgView.animationDuration = 2;
//    _outSideBgView.lineColor = [UIColor colorWithHexString:@"4E1741"];
//    _outSideBgView.progress = 0;
//    
//    _outSideFgView.animationDuration = 2;
//    _outSideFgView.lineColor = [UIColor colorWithHexString:@"F955D2" alpha:0.8];
//    _outSideFgView.progress = 0;
//    
//    _inSideBgView.animationDuration = 0.7;
//    _inSideBgView.lineColor = [UIColor colorWithHexString:@"284E4D"];
//    _inSideBgView.progress = 1;
//    
//    _inSideFgView.animationDuration = 2;
//    _inSideFgView.lineColor = [UIColor colorWithHexString:HIGHLIGHT_COLOR alpha:0.8];
//    _inSideFgView.progress = 0;
    
//    _progressLabel = [UILabel new];
//    _progressLabel.textAlignment = 1;
//    _progressLabel.textColor = [UIColor colorWithHexString:HIGHLIGHT_COLOR];
    
//    _firstMarkLabel = [UILabel new];
//    _firstMarkLabel.textAlignment = 1;
//    _firstMarkLabel.textColor = [UIColor colorWithHexString:HIGHLIGHT_COLOR];
//    
//    _secondMarkLabel = [UILabel new];
//    _secondMarkLabel.textAlignment = 1;
//    _secondMarkLabel.textColor = [UIColor colorWithHexString:@"F955D2"];
    
    if (SCREEN_WIDTH > 320) {
//        _progressLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:48];
        if (YBIphone6Plus) {
//            _progressLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:48*YBRatio];
        }
//        _firstMarkLabel.font = [UIFont systemFontOfSize:20];
        if (YBIphone6Plus) {
//            _firstMarkLabel.font = [UIFont systemFontOfSize:20*YBRatio];
        }
//        _secondMarkLabel.font = [UIFont systemFontOfSize:20];
        if (YBIphone6Plus) {
//            _secondMarkLabel.font = [UIFont systemFontOfSize:20*YBRatio];
        }
    }else {
//        _progressLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:42];
        if (YBIphone6Plus) {
//            _progressLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:42*YBRatio];
        }
//        _firstMarkLabel.font = [UIFont systemFontOfSize:17];
        if (YBIphone6Plus) {
//            _firstMarkLabel.font = [UIFont systemFontOfSize:17*YBRatio];
        }
//        _secondMarkLabel.font = [UIFont systemFontOfSize:17];
        if (YBIphone6Plus) {
//            _secondMarkLabel.font = [UIFont systemFontOfSize:17*YBRatio];
        }
    }
    
//    [self addSubview:_progressLabel];
//    [self addSubview:_firstMarkLabel];
//    [self addSubview:_secondMarkLabel];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
