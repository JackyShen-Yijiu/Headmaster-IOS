//
//  JZCoachFeedbackView.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/11.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZCoachFeedbackView.h"
#import "JZMailboxData.h"

@interface JZCoachFeedbackView ()
///  教练头像
@property (nonatomic, strong) UIImageView *coachIcon;
///  教练名称
@property (nonatomic, strong) UILabel *coachNameLabel;
///  反馈内容
@property (nonatomic, strong) UILabel *contentLabel;
///  反馈日期
@property (nonatomic, strong) UILabel *dateLabel;
///  分割线
@property (nonatomic, strong) UIView *lineView;
///驾校头像
@property (nonatomic, strong) UIImageView *schoolIcon;
///  校长名称
@property (nonatomic, strong) UILabel *headmasterNameLabel;
///  回复时间
@property (nonatomic, strong) UILabel *replyDateLabel;
///  回复内容
@property (nonatomic, strong) UILabel *replyCotentLabel;

///  “回复”这两个字
@property (nonatomic, strong) UILabel *replyLabel;



@end

@implementation JZCoachFeedbackView
-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
       [self.coachIcon mas_makeConstraints:^(MASConstraintMaker *make) {
          
           make.top.equalTo(self.mas_top).offset(16);
           make.left.equalTo(self.mas_left).offset(16);
           make.width.equalTo(@24);
           make.height.equalTo(@24);
           
       }];
        
        [self.coachNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.coachIcon.mas_right).offset(12);
            make.centerY.equalTo(self.coachIcon.mas_centerY);
            
        }];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.coachNameLabel.mas_left);
            make.right.equalTo(self.mas_right).offset(-16);
            make.top.equalTo(self.coachNameLabel.mas_bottom).offset(12);
        }];

        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.contentLabel.mas_bottom).offset(8);
            make.right.equalTo(self.mas_right).offset(-16);
            
        }];
//
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.coachIcon.mas_left);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.dateLabel.mas_bottom).offset(48);
            make.height.equalTo(@0.5);
        }];
//
        [self.schoolIcon mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.lineView.mas_top).offset(32);
            make.left.equalTo(self.mas_left).offset(16);
            make.width.equalTo(@24);
            make.height.equalTo(@24);
        }];
//
        [self.headmasterNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.schoolIcon.mas_right).offset(12);
            make.centerY.equalTo(self.schoolIcon.mas_centerY);
        }];
        
        [self.replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.headmasterNameLabel.mas_right).offset(4);
            make.centerY.equalTo(self.schoolIcon.mas_centerY);
            
        }];
//
        [self.replyDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(self.schoolIcon.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-16);
        }];
//
        [self.replyCotentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.headmasterNameLabel.mas_left);
            make.right.equalTo(self.mas_right).offset(-16);
            make.top.equalTo(self.headmasterNameLabel.mas_bottom).offset(12);

        }];
//
//        
        
        
    }
    
    return self;
}

-(void)setData:(JZMailboxData *)data {
    
    _data = data;
    
    [self.coachIcon sd_setImageWithURL:[NSURL URLWithString:_data.coachid.headportrait.originalpic] placeholderImage:[UIImage imageNamed:@"head_null"]];
    
    self.coachNameLabel.text = _data.coachid.name;
    self.contentLabel.text = _data.content;
    self.dateLabel.text = [self getYearLocalDateFormateUTCDate:_data.createtime];

   
    
    if (data.replyflag) {
        [self.schoolIcon sd_setImageWithURL:[NSURL URLWithString:[UserInfoModel defaultUserInfo].portrait] placeholderImage:[UIImage imageNamed:@"head_null"]];
        //
        self.headmasterNameLabel.text = _data.replyid.name;
        
        self.replyLabel.text = @"回复";
        //
        self.replyDateLabel.text = [self getYearLocalDateFormateUTCDate:_data.replytime];
        //
        self.replyCotentLabel.text = _data.replycontent;
        
    }
    
}

+ (CGFloat)coachFeedbackViewH:(JZMailboxData *)data{
    
    JZCoachFeedbackView *feedbackView = [[JZCoachFeedbackView alloc]init];
    
    feedbackView.data = data;
    
    [feedbackView layoutIfNeeded];
    
    if (data.replyflag) {
       
        return 16+14+12+ feedbackView.contentLabel.height +8+12+48+0.5+ 32+14+feedbackView.replyCotentLabel.height +32;
       
    }else{
        
         return 16+14+12+ feedbackView.contentLabel.height +8+12+48+0.5;
    }
    
}


#pragma mark - 懒加载
-(UIImageView *)coachIcon {
    if (!_coachIcon) {
        
        _coachIcon = [[UIImageView alloc]init];
        
        _coachIcon.layer.cornerRadius = 12;
        
        _coachIcon.layer.masksToBounds = YES;
        
        [self addSubview:_coachIcon];
        
    }
    return _coachIcon;
}

-(UILabel *)coachNameLabel {
    
    if (!_coachNameLabel) {
        
        _coachNameLabel = [[UILabel alloc]init];
        _coachNameLabel.font = [UIFont systemFontOfSize:14];
        _coachNameLabel.textColor = kJZDarkTextColor;
        [self addSubview:_coachNameLabel];
        
    }
    
    return _coachNameLabel;
}
-(UILabel *)contentLabel {
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = kJZLightTextColor;
        _contentLabel.numberOfLines = 0;
        [self addSubview:_contentLabel];
        
    }
    
    return _contentLabel;
}
-(UILabel *)dateLabel {
    
    if (!_dateLabel) {
        
        _dateLabel = [[UILabel alloc]init];
        
        _dateLabel.font = [UIFont systemFontOfSize:12];
        
        _dateLabel.textColor = kJZLightTextColor;
        [self addSubview:_dateLabel];
        
    }
    
    return _dateLabel;
}
-(UIView *)lineView {
    
    if (!_lineView) {
        
        
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = JZ_MAIN_BACKGROUND_COLOR;
        [self addSubview:_lineView];
        
    }
    
    return _lineView;
}


-(UIImageView *)schoolIcon {
    if (!_schoolIcon) {
        
        _schoolIcon = [[UIImageView alloc]init];
        
        _schoolIcon.layer.cornerRadius = 12;
        
        _schoolIcon.layer.masksToBounds = YES;
        
        [self addSubview:_schoolIcon];
        
    }
    return _schoolIcon;
}
//
-(UILabel *)headmasterNameLabel {
    
    if (!_headmasterNameLabel) {
        
        _headmasterNameLabel = [[UILabel alloc]init];
        _headmasterNameLabel.font = [UIFont systemFontOfSize:14];
        _headmasterNameLabel.textColor = kJZDarkTextColor;
        [self addSubview:_headmasterNameLabel];
        
    }
    
    return _headmasterNameLabel;
}

-(UILabel *)replyLabel {
    
    if (!_replyLabel) {
     
        _replyLabel = [[UILabel alloc]init];
        _replyLabel.font = [UIFont systemFontOfSize:14];
        _replyLabel.textColor = kJZLightTextColor;
        [self addSubview:_replyLabel];
        
    }
    return _replyLabel;
}
-(UILabel *)replyCotentLabel {
    
    if (!_replyCotentLabel) {
        
        _replyCotentLabel = [[UILabel alloc]init];
        _replyCotentLabel.font = [UIFont systemFontOfSize:14];
        _replyCotentLabel.textColor = kJZLightTextColor;
        _replyCotentLabel.numberOfLines = 0;
        [self addSubview:_replyCotentLabel];
        
    }
    
    return _replyCotentLabel;
}
-(UILabel *)replyDateLabel{
    
    if (!_replyDateLabel) {
        
        _replyDateLabel = [[UILabel alloc]init];
        
        _replyDateLabel.font = [UIFont systemFontOfSize:12];
        
        _replyDateLabel.textColor = kJZLightTextColor;
        [self addSubview:_replyDateLabel];
        
    }
    
    return _replyDateLabel;
}

- (NSString *)getYearLocalDateFormateUTCDate:(NSString *)utcDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}


@end
