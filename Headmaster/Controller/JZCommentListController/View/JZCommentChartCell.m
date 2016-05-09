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

     [self.contentView addSubview:self.pieChartView];
     [self.contentView addSubview:self.goodCommentView];
     [self.contentView addSubview:self.mightCommentView];
     [self.contentView addSubview:self.badCommentView];
    
    
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.pieChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).offset(40);
        make.height.mas_equalTo(@110);
        make.width.mas_equalTo(@110);
    }];
    [self.goodCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pieChartView.mas_top).offset(10);
        make.left.mas_equalTo(self.pieChartView.mas_right).offset(50);
        make.right.mas_equalTo(self.contentView).offset(-16);
        make.height.mas_equalTo(@20);
    }];
    [self.mightCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodCommentView.mas_bottom).offset(16);
        make.left.mas_equalTo(self.goodCommentView.mas_left);
        make.right.mas_equalTo(self.contentView).offset(-16);
        make.height.mas_equalTo(@20);
    }];
    [self.badCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mightCommentView.mas_bottom).offset(16);
        make.left.mas_equalTo(self.goodCommentView.mas_left);
        make.right.mas_equalTo(self.contentView).offset(-16);
        make.height.mas_equalTo(@20);
    }];


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    }
    return _badCommentView;
}
- (void)setModel:(JZCommentData *)model{

    
    
    // 评论列表赋值
    

}
- (void)setCommentDataNumberDic:(NSDictionary *)commentDataNumberDic{
    
    // 计算百分比
    NSInteger goodComment = [[commentDataNumberDic objectForKey:@"goodcommnent"] integerValue];
    NSInteger mightComment = [[commentDataNumberDic objectForKey:@"generalcomment"] integerValue];
    NSInteger badComment = [[commentDataNumberDic objectForKey:@"badcomment"] integerValue];;
    
    NSInteger totalComnet = goodComment + mightComment + badComment;
    NSLog(@"goodComment = %lu,mightComment = %lu, badComment = %lu totalComnet = %lu",goodComment,mightComment,badComment,totalComnet);
    
    
    
    if (totalComnet != 0) {
        CGFloat goodRate = goodComment / totalComnet;
        CGFloat mightRate = mightComment / totalComnet;
        CGFloat badRate = badComment / totalComnet;
        
        NSArray *array = @[@(goodRate),@(mightRate),@(badRate)];
        self.pieChartView.percentageArray = array;
        [self.pieChartView reloadData];
        
        // 图例赋值
        self.goodCommentView.titieleStr = [NSString stringWithFormat:@"好评 %f",goodRate];
        self.mightCommentView.titieleStr = [NSString stringWithFormat:@"中评 %f",mightRate];
        self.badCommentView.titieleStr = [NSString stringWithFormat:@"差评 %f",badRate];

    }
    
    
}
@end
