//
//  JZMailBoxCell.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/10.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZMailBoxCell.h"

@interface JZMailBoxCell()
///  教练头像
@property (nonatomic, strong) UIImageView *coachIcon;
///  教练姓名
@property (nonatomic, strong) UILabel *coachNameLabel;
///  反馈内容
@property (nonatomic, strong) UILabel *contentLabel;
///  反馈时间
@property (nonatomic, strong) UILabel *dateLabel;
///“已回复”这个图片
@property (nonatomic, strong) UIImageView *replyImage;
///  小红点
@property (nonatomic, strong) UIView *badgeView;

@end
@implementation JZMailBoxCell

#pragma mark - 自动布局
-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.coachIcon mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.top.equalTo(self.contentView.mas_top).offset(12);
        
    }];
    
    
    
}






#pragma mark - 懒加载
-(UIImageView *)coachIcon {
    if (!_coachIcon) {
        
        _coachIcon = [[UIImageView alloc]init];

    }
    return _coachIcon;
}

-(UILabel *)coachNameLabel {
    
    if (!_coachNameLabel) {
        
        _coachNameLabel = [[UILabel alloc]init];
        _coachNameLabel.font = [UIFont systemFontOfSize:14];
        _coachNameLabel.textColor = kJZDarkTextColor;
    }
    
    return _contentLabel;
}
-(UILabel *)contentLabel {
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = kJZLightTextColor;
    }
    return _contentLabel;
}
-(UILabel *)dateLabel {
    
    if (!_dateLabel) {
        
        _dateLabel = [[UILabel alloc]init];
        
        _dateLabel.font = [UIFont systemFontOfSize:12];
        
        _dateLabel.textColor = kJZLightTextColor;
    }
    
    return _dateLabel;
}
-(UIImageView *)replyImage {
    if (!_replyImage) {
        
        _replyImage = [[UIImageView alloc]init];
        _replyImage.image = [UIImage imageNamed:@"replied"];
        
    }
    return _replyImage;
}
-(UIView *)badgeView {
    
    if (!_badgeView) {
        
        _badgeView = [[UIView alloc]init];
        _badgeView.backgroundColor = kJZRedColor;
        _badgeView.layer.cornerRadius = 6;
        _badgeView.layer.masksToBounds = YES;
    }
    
    return _badgeView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
