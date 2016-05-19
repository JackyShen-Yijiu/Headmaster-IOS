//
//  JZMailBoxCell.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/10.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZMailBoxCell.h"
#import "JZMailboxData.h"
#import "NSString+LKString.h"
static NSString *JZMailBoxCellID = @"JZMailBoxCellID";

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
//@property (nonatomic, strong) UIView *badgeView;
///  分割线
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSMutableDictionary *dict;


@end

@implementation JZMailBoxCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        //        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


-(void)setData:(JZMailboxData *)data {
    
    _data = data;
    
//    _data.isRead = @"0";

    
     [self.coachIcon sd_setImageWithURL:[NSURL URLWithString:_data.coachid.headportrait.originalpic] placeholderImage:[UIImage imageNamed:@"head_null"]];
    
    self.coachNameLabel.text = _data.coachid.name;
    self.contentLabel.text = _data.content;
    self.dateLabel.text = [NSString getYearLocalDateFormateUTCDate:_data.createtime style:LKDateStyleDefault];
    self.replyImage.hidden = !_data.replyflag;
    

    
    
       
    
    
    
}


#pragma mark - 自动布局
-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.coachIcon mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.top.equalTo(self.contentView.mas_top).offset(12);
        if (YBIphone6Plus) {
            make.width.equalTo(@(24*YBRatio));
            make.height.equalTo(@(24*YBRatio));
            
            
        }else {
            make.width.equalTo(@24);
            make.height.equalTo(@24);
        }
       
        
    }];
    
    [self.coachNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.coachIcon.mas_centerY);
        make.left.equalTo(self.coachIcon.mas_right).offset(16);
    }];
    
    
    
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.coachNameLabel.mas_bottom).offset(12);
        make.left.equalTo(self.coachNameLabel.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(8);
        
        
    }];

    
    [self.replyImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        if (YBIphone6Plus) {
            
            make.width.equalTo(@(38*YBRatio));
            make.height.equalTo(@(14*YBRatio));
            
        }else {
            make.width.equalTo(@38);
            make.height.equalTo(@14);
        }
       
        
    }];
    
    [self.badgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.coachIcon.mas_top);
        make.right.equalTo(self.coachIcon.mas_right);
        if (YBIphone6Plus) {
            
            make.width.equalTo(@(6*YBRatio));
            make.height.equalTo(@(6*YBRatio));
        }else {
            make.width.equalTo(@6);
            make.height.equalTo(@6);
        }
        
        
    }];
    
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@0.5);
        
    }];
    
}
+ (CGFloat)cellHeightDmData:(JZMailboxData *)dmData
{
    
    JZMailBoxCell *cell = [[JZMailBoxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JZMailBoxCellID];
    
    cell.data = dmData;
    
    [cell layoutIfNeeded];
    
    if (YBIphone6Plus) {
        
        return (17+14+12+8+12+12 + cell.contentLabel.height)*YBRatio;

    }else {
        
        return 17+14+12+8+12+12 + cell.contentLabel.height;

    }
    
    return 0;
}



#pragma mark - 懒加载
-(UIImageView *)coachIcon {
    if (!_coachIcon) {
        
        _coachIcon = [[UIImageView alloc]init];
        
        if (YBIphone6Plus) {
            
            _coachIcon.layer.cornerRadius = 12*YBRatio;

        }else {
            _coachIcon.layer.cornerRadius = 12;

        }
        
        
        _coachIcon.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_coachIcon];

    }
    return _coachIcon;
}

-(UILabel *)coachNameLabel {
    
    if (!_coachNameLabel) {
        
        _coachNameLabel = [[UILabel alloc]init];
        if (YBIphone6Plus) {
            _coachNameLabel.font = [UIFont systemFontOfSize:14*YBRatio];

            
        }else {
            _coachNameLabel.font = [UIFont systemFontOfSize:14];

        }
        _coachNameLabel.textColor = kJZDarkTextColor;
        [self.contentView addSubview:_coachNameLabel];

    }
    
    return _coachNameLabel;
}
-(UILabel *)contentLabel {
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc]init];
        if (YBIphone6Plus) {
            
            _contentLabel.font = [UIFont systemFontOfSize:14*YBRatio];

        }else {
            _contentLabel.font = [UIFont systemFontOfSize:14];

        }
        _contentLabel.textColor = kJZLightTextColor;
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];

    }
    
    return _contentLabel;
}
-(UILabel *)dateLabel {
    
    if (!_dateLabel) {
        
        _dateLabel = [[UILabel alloc]init];
        if (YBIphone6Plus) {
            
            _dateLabel.font = [UIFont systemFontOfSize:12*YBRatio];

        }else {
            _dateLabel.font = [UIFont systemFontOfSize:12];

        }
        
        _dateLabel.textColor = kJZLightTextColor;
        [self.contentView addSubview:_dateLabel];

    }
    
    return _dateLabel;
}
-(UIImageView *)replyImage {
    if (!_replyImage) {
        
        _replyImage = [[UIImageView alloc]init];
        _replyImage.image = [UIImage imageNamed:@"replied"];
        [self.contentView addSubview:_replyImage];

    }
    return _replyImage;
}
-(UIView *)badgeView {
    
    if (!_badgeView) {
        
        _badgeView = [[UIView alloc]init];
        _badgeView.backgroundColor = kJZRedColor;
        if (YBIphone6Plus) {
            _badgeView.layer.cornerRadius = 3*YBRatio;
  
            
        }else {
            _badgeView.layer.cornerRadius = 3;

        }
        _badgeView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_badgeView];

    }
    
    return _badgeView;
}

-(UIView *)lineView {
    
    if (!_lineView) {
        
        
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = JZ_MAIN_BACKGROUND_COLOR;
        [self.contentView addSubview:_lineView];

    }
    
    return _lineView;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end
