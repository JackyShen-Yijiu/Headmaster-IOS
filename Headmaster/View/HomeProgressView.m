//
//  HomeProgressView.m
//  Headmaster
//
//  Created by 大威 on 15/12/8.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeProgressView.h"
#import "TTProgressView.h"
#import "JZPassRateController.h"

@interface HomeProgressView()

@property (nonatomic,strong) UILabel *topLabel;

@property (nonatomic,strong) NSMutableArray *progressViewArray;

@property (nonatomic,strong) NSMutableArray *cirmpArray;

@end

@implementation HomeProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.progressViewArray = [NSMutableArray array];
        self.cirmpArray = [NSMutableArray array];
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
    NSArray *ColorArray = [NSArray arrayWithObjects:@"7bd65c", @"3d8bff",@"e80031",@"3d8bff",nil];

    for (int i = 0; i < 4; i ++) {
    
        NSInteger col = i % maxColumns;
        NSInteger row = i / maxColumns;
        
        NSLog(@"col:%ld row:%ld",(long)col,(long)row);
        
        UIView *progressView = [[UIView alloc] init];
        CGFloat progressViewW = contentView.width/2;
        CGFloat progressViewH = contentView.height/2;
        CGFloat progressViewX = col * progressViewW;
        CGFloat progressViewY = 0;
        progressView.userInteractionEnabled = YES;
        progressView.tag = 500 + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didProgressView:)];
        [progressView addGestureRecognizer:tap];
        
        if (i > 1) {
            progressViewY = progressViewH;
        }
        progressView.frame = CGRectMake(progressViewX, progressViewY, progressViewW, progressViewH);
        [contentView addSubview:progressView];
        
        CGFloat progressY = 15;
        CGFloat ratio = 1;
        if (YBIphone6Plus) {
            ratio = YBSizeRatio;
        }
        TTProgressView  *progress = [[TTProgressView alloc] initWithFrame:CGRectMake(45 * ratio, progressY, progressViewW-90*ratio, progressViewW-90*ratio) bgColor:[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0f] resultColor:[UIColor colorWithHexString:ColorArray[i]]];
        progress.tag = i + 100;
        progress.lineWidth = 5;
        progress.percent = 0.5;
        [progressView addSubview:progress];
        [self.progressViewArray addObject:progress];
        
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
        CGFloat subjectLabelY = CGRectGetMaxY(progress.frame)+10*ratio;
        subjectLabel.text = [NSString stringWithFormat:@"%@",subjectArray[i]];
        subjectLabel.textAlignment = NSTextAlignmentCenter;
        subjectLabel.frame = CGRectMake(subjectLabelX, subjectLabelY, subjectLabelW, subjectLabelH);
        subjectLabel.font = [UIFont systemFontOfSize:13];
        if (YBIphone6Plus) {
            subjectLabel.font = [UIFont systemFontOfSize:13*YBRatio];
        }
        subjectLabel.textColor = [UIColor grayColor];
        [progressView addSubview:subjectLabel];

        // 积压
        UILabel *cirmpLabel = [[UILabel alloc] init];
        CGFloat cirmpLabelW = progressView.width;
        CGFloat cirmpLabelH = 15;
        CGFloat cirmpLabelX = 0;
        CGFloat cirmpLabelY = CGRectGetMaxY(subjectLabel.frame)+3*ratio;
        cirmpLabel.text = @"积压人数";
        cirmpLabel.textAlignment = NSTextAlignmentCenter;
        cirmpLabel.frame = CGRectMake(cirmpLabelX, cirmpLabelY, cirmpLabelW, cirmpLabelH);
        cirmpLabel.font = [UIFont systemFontOfSize:12];
        if (YBIphone6Plus) {
            cirmpLabel.font = [UIFont systemFontOfSize:12*YBRatio];
        }
        cirmpLabel.textColor = [UIColor blackColor];
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
    
    for (TTProgressView  *progressView  in self.progressViewArray) {
        
        NSLog(@"progressView:%@",progressView);
        
        if (progressView.tag != 0 && ![[passrate objectAtIndex:progressView.tag - 100] isKindOfClass:[NSNull class]]) {
            NSLog(@"[passrate[progressView.tag-100] integerValue] / 100:%f",[passrate[progressView.tag-100] floatValue] / 100);
            progressView.percent = [passrate[progressView.tag-100] floatValue] / 100;
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

// 手势点击事件
- (void)didProgressView:(UITapGestureRecognizer *)tap{
    
    NSInteger index = tap.view.tag - 500;
    
    JZPassRateController *passRateVC = [[JZPassRateController alloc] init];
    passRateVC.subjectID = index + 1;
    
    [self.parentVC.myNavController pushViewController:passRateVC animated:YES];
    
    
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
