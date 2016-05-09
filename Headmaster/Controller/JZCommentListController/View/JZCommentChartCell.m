//
//  JZCommentChartCell.m
//  Headmaster
//
//  Created by ytzhang on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZCommentChartCell.h"




@interface JZCommentChartCell ()



@end
@implementation JZCommentChartCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.userInteractionEnabled = YES;
    [self addSubview:self.pieChartView];
     [self addSubview:self.goodCommentView];
     [self addSubview:self.mightCommentView];
     [self addSubview:self.badCommentView];
    
    
}
- (void)layoutSubviews{
    [self.pieChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).offset(40);
        make.height.mas_equalTo(@110);
        make.width.mas_equalTo(@110);
    }];
    [self.goodCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pieChartView.mas_top).offset(10);
        make.left.mas_equalTo(self.pieChartView.mas_right).offset(50);
        make.height.mas_equalTo(@20);
       
    }];
    [self.mightCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodCommentView.mas_bottom).offset(16);
        make.left.mas_equalTo(self.goodCommentView.mas_left);
        make.height.mas_equalTo(@20);
        
    }];
    [self.badCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mightCommentView.mas_bottom).offset(16);
        make.left.mas_equalTo(self.goodCommentView.mas_left);
        make.height.mas_equalTo(@20);
        
    }];


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)didCommentView:(UITapGestureRecognizer *)tap{
    
    if ([self.delegate respondsToSelector:@selector(initWithCommentViewIndex:)]) {
        [self.delegate initWithCommentViewIndex:tap.view.tag];
    }
}
- (YBPieChartView *)pieChartView{
    
    if (_pieChartView == nil) {
        _pieChartView = [[YBPieChartView alloc] initWithFrame:CGRectMake(0, 100, 110, 110)];
        _pieChartView.percentageArray = @[ @"0.2", @"0.16", @"0.82" ];
        _pieChartView.colorArray = @[RGB_Color(123, 214, 92),RGB_Color(61, 139, 255),RGB_Color(232, 0, 49)];
        [_pieChartView reloadData];
    }
    return _pieChartView;
}
- (TTCommentView *)goodCommentView{
    if (_goodCommentView == nil) {
        _goodCommentView = [[TTCommentView alloc] init];
        _goodCommentView.viewColor = RGB_Color(123, 214, 92);
        _goodCommentView.titileColor = kJZLightTextColor;
        _goodCommentView.titieleStr = @"好评 2%";
        _goodCommentView.labelFont = [UIFont systemFontOfSize:14];
        _goodCommentView.tag = 500;
        _goodCommentView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didCommentView:)];
        [_goodCommentView addGestureRecognizer:tap];
        
        
    }
    return _goodCommentView;
}
- (TTCommentView *)mightCommentView{
    if (_mightCommentView == nil) {
        _mightCommentView = [[TTCommentView alloc] init];
        _mightCommentView.viewColor = RGB_Color(61, 139, 255);
        _mightCommentView.titileColor = kJZLightTextColor;
        _mightCommentView.titieleStr = @"中评 16%";
        _mightCommentView.labelFont = [UIFont systemFontOfSize:14];
        _mightCommentView.tag = 501;
        _mightCommentView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didCommentView:)];
        [_mightCommentView addGestureRecognizer:tap];
    }
    return _mightCommentView;
}
- (TTCommentView *)badCommentView{
    if (_badCommentView == nil) {
        _badCommentView = [[TTCommentView alloc] init];
        _badCommentView.viewColor = RGB_Color(232, 0, 49);
        _badCommentView.titileColor = kJZLightTextColor;
        _badCommentView.titieleStr = @"差评 82%";
        _badCommentView.labelFont = [UIFont systemFontOfSize:14];
        _badCommentView.tag = 502;
        _badCommentView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didCommentView:)];
        [_badCommentView addGestureRecognizer:tap];
        
    }
    return _badCommentView;
}

@end
