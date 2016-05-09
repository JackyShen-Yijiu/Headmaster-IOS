//
//  JZCommentListCell.m
//  Headmaster
//
//  Created by ytzhang on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZCommentListCell.h"
#import "PortraitView.h"
#import "CWStarRateView.h"

@interface JZCommentListCell ()

@property(nonatomic,strong) UIImageView * iconView;

@property(nonatomic,strong)UILabel * nameLabel;

@property (nonatomic, strong) UILabel *teachNameLabel;

@property (nonatomic, strong) UILabel *commentContentLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property(nonatomic,strong)CWStarRateView * rateView;

@property(nonatomic,strong)UIView * bottonLineView;


@end

@implementation JZCommentListCell

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
    [self addSubview:self.iconView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.teachNameLabel];
    [self addSubview:self.commentContentLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.rateView];
    [self addSubview:self.bottonLineView];
    
    
}
- (void)layoutSubviews{
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(16);
        make.left.mas_equalTo(self.mas_left).offset(16);
        make.height.mas_equalTo(@24);
        make.width.mas_equalTo(@24);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.left.mas_equalTo(self.iconView.mas_right).offset(8);
        make.height.mas_equalTo(@14);
    }];
    [self.teachNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconView.mas_bottom).offset(16);
        make.left.mas_equalTo(self.iconView.mas_left);
        make.height.mas_equalTo(@14);
    }];
    [self.commentContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.teachNameLabel.mas_bottom).offset(16);
        make.left.mas_equalTo(self.iconView.mas_left);
        make.height.mas_equalTo(@14);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_top);
        make.right.mas_equalTo(self.mas_right).offset(-16);
        make.height.mas_equalTo(@12);
    }];
    [self.rateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(22);
        make.right.mas_equalTo(self.mas_right).offset(-16);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@94);
    }];
    [self.bottonLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.height.mas_equalTo(@1);
        
    }];



}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.backgroundColor = [UIColor cyanColor];
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.cornerRadius = 12;
    }
    return _iconView;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = kJZLightTextColor;
        _nameLabel.text = @"小楠";
    }
    return _nameLabel;
}
- (UILabel *)teachNameLabel{
    if (_teachNameLabel == nil) {
        _teachNameLabel = [[UILabel alloc] init];
        _teachNameLabel.font = [UIFont systemFontOfSize:14];
        _teachNameLabel.textColor = kJZDarkTextColor;
        _teachNameLabel.text = @"教练: 六爻";
    }
    return _teachNameLabel;
}

- (UILabel *)commentContentLabel{
    if (_commentContentLabel == nil) {
        _commentContentLabel = [[UILabel alloc] init];
        _commentContentLabel.font = [UIFont systemFontOfSize:14];
        _commentContentLabel.textColor = kJZDarkTextColor;
        _commentContentLabel.text = @"jjjj积极急急急";
    }
    return _commentContentLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = kJZLightTextColor;
        _timeLabel.text = @"2016/04/26 12:32";
    }
    return _timeLabel;
}
- (CWStarRateView *)rateView{
    if (_rateView == nil) {
        _rateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(0, 0, 90, 14.f) numberOfStars:5];
        [_rateView setUserInteractionEnabled:NO];
        _rateView.scorePercent = (2.5 / 5.f);
    }
    return _rateView;
}
- (UIView *)bottonLineView{
    if (_bottonLineView == nil) {
        _bottonLineView = [[UIView alloc] init];
        _bottonLineView.backgroundColor = HM_LINE_COLOR;
    }
    return _bottonLineView;
}
- (void)setModel:(JZCommentCommentlist *)model{
    /*
     
     "studentinfo": {
     "userid": "5707a3037e1c28b744297d54",
     "mobile": "156708536",
     "name": "雷凯",
     "headportrait": {
     "originalpic": "http://7xnjg0.com1.z0.glb.clouddn.com/20160412/104926-5707a3037e1c28b744297d54.png",
     "thumbnailpic": "",
     "width": "",
     "height": ""
     },
     */
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.studentinfo.headportrait.originalpic] placeholderImage:nil];
    self.nameLabel.text = model.studentinfo.name;
    
    self.teachNameLabel.text = [NSString stringWithFormat:@"教练: %@",model.coachinfo.name];
    self.commentContentLabel.text = model.commentcontent;
    self.timeLabel.text = model.commenttime;
    [self.rateView setScorePercent:(model.commentstarlevel / 5)];
    
    
    
}
@end
