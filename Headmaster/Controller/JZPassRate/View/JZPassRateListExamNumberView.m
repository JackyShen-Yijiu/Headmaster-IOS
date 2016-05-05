//
//  JZPassRateListExamNumberView.m
//  Headmaster
//
//  Created by ytzhang on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZPassRateListExamNumberView.h"

#import "JZPassRateLabelView.h"

@interface JZPassRateListExamNumberView ()

@property (nonatomic, strong) UIView *topLineView;

@property (nonatomic, strong) UIView *bottonlineView;

@property (nonatomic, strong) UIView *leftlineView;

@property (nonatomic, strong) UIView *rightlineView;

@property (nonatomic, strong) JZPassRateLabelView *examLabel;

@property (nonatomic, strong) JZPassRateLabelView *noexamLabel;

@property (nonatomic, strong) JZPassRateLabelView *nopassLabel;



@end

@implementation JZPassRateListExamNumberView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.topLineView];
     [self addSubview:self.bottonlineView];
    
     [self addSubview:self.leftlineView];
    [self addSubview:self.rightlineView];
    
    [self addSubview:self.examLabel];
     [self addSubview:self.noexamLabel];
    [self addSubview:self.nopassLabel];
}
-(void)layoutSubviews{
    NSNumber *with = [NSNumber numberWithFloat:(self.width - 2) / 3];
    //
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(16);
         make.right.mas_equalTo(self.mas_right).offset(-16);
        make.height.mas_equalTo(@1);
        
    }];
    // 报考人数
    [self.examLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topLineView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
         make.width.mas_equalTo(with);
        make.height.mas_equalTo(44);
        
    }];
    [self.leftlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.examLabel.mas_right).offset(0);
        make.height.mas_equalTo(@24);
        make.width.mas_equalTo(@1);
        
    }];
    
    // 缺考人数
    [self.noexamLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.examLabel.mas_top);
        make.left.mas_equalTo(self.leftlineView.mas_right).offset(0);
        make.width.mas_equalTo(with);
        make.height.mas_equalTo(44);
        
    }];
    [self.rightlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.noexamLabel.mas_right).offset(0);
        make.height.mas_equalTo(@24);
        make.width.mas_equalTo(@1);
        
    // 未通过人数
    [self.nopassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.examLabel.mas_top);
        make.left.mas_equalTo(self.rightlineView.mas_right).offset(0);
        make.width.mas_equalTo(with);
        make.height.mas_equalTo(44);
        
    }];


    
    [self.bottonlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@1);
        
    }];
    
        
    }];



}
- (UIView *)topLineView{
    if (_topLineView == nil) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = HM_LINE_COLOR;
    }
    return _topLineView;
}
- (UIView *)bottonlineView{
    if (_bottonlineView == nil) {
        _bottonlineView = [[UIView alloc] init];
        _bottonlineView.backgroundColor = HM_LINE_COLOR;
    }
    return _bottonlineView;
}
- (UIView *)leftlineView{
    if (_leftlineView == nil) {
        _leftlineView = [[UIView alloc] init];
        _leftlineView.backgroundColor = HM_LINE_COLOR;
    }
    return _leftlineView;
}

- (UIView *)rightlineView{
    if (_rightlineView == nil) {
        _rightlineView = [[UIView alloc] init];
        _rightlineView.backgroundColor = HM_LINE_COLOR;
    }
    return _rightlineView;
}

- (JZPassRateLabelView *)examLabel{
    if (_examLabel == nil) {
        _examLabel = [[JZPassRateLabelView alloc] initWithFrame:CGRectMake(0, 0, (self.width - 2) / 3, 44)];
        _examLabel.titleStr = @"报考";
        _examLabel.resultStr = @"60 人";
    }
    return _examLabel;
}
- (JZPassRateLabelView *)noexamLabel{
    if (_noexamLabel == nil) {
        _noexamLabel = [[JZPassRateLabelView alloc] initWithFrame:CGRectMake(0, (self.width - 2) / 3 + 1, (self.width - 2) / 3, 44)];
        _noexamLabel.titleStr = @"缺考";
        _noexamLabel.resultStr = @"60 人";
    }
    return _noexamLabel;
}
- (JZPassRateLabelView *)nopassLabel{
    if (_nopassLabel == nil) {
        _nopassLabel = [[JZPassRateLabelView alloc] initWithFrame:CGRectMake(0, 0, ((self.width - 2) / 3) * 2 + 2, 44)];
        _nopassLabel.titleStr = @"未通过";
        _nopassLabel.resultStr = @"60 人";
    }
    return _nopassLabel;
}

@end
