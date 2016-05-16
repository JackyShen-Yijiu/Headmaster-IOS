//
//  JZComplaintDetailTopView.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/6.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZComplaintDetailTopView.h"
#import "JZComplaintComplaintlist.h"

@interface JZComplaintDetailTopView ()
///  学员头像
@property (nonatomic, weak) UIImageView *studentIcon;
///  学员姓名
@property (nonatomic, weak) UILabel *studentNameLabel;
///  投诉的对象头像
@property (nonatomic, weak) UIImageView *complainIcon;
//// 投诉的名称
@property (weak, nonatomic)  UILabel *complaintNameLabel;
///  投诉的小图标
@property (nonatomic, weak) UIImageView *talkComplaintImageView;
///  箭头图片
@property (nonatomic, weak) UIImageView *directionImageView;
@end
@implementation JZComplaintDetailTopView
-(instancetype)initWithFrame:(CGRect)frame {
    
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = RGB_Color(0, 0, 0);
        
//        self.backgroundColor = [UIColor redColor];
        
    }
    
    return self;
}
-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.studentIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(kJZWidth*0.25-24);
        make.top.equalTo(self.mas_top).offset(36);
        if (YBIphone6Plus) {
            make.width.equalTo(@(48*YBRatio));
            make.height.equalTo(@(48*YBRatio));
            
        }else {
            make.width.equalTo(@48);
            make.height.equalTo(@48);
        }
    }];
    
    [self.studentNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.studentIcon.mas_centerX);
        make.top.equalTo(self.studentIcon.mas_bottom).offset(12);
        
        
    }];
    
    [self.complainIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_left).offset(kJZWidth*0.75+24);
        make.centerY.equalTo(self.studentIcon.mas_centerY);
        if (YBIphone6Plus) {
            make.width.equalTo(@(48*YBRatio));
            make.height.equalTo(@(48*YBRatio));
            
        }else {
            make.width.equalTo(@48);
            make.height.equalTo(@48);
        }
       
    }];
    
    [self.complaintNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.complainIcon.mas_centerX);
        make.top.equalTo(self.complainIcon.mas_bottom).offset(12);
    }];
    
    [self.talkComplaintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.studentIcon.mas_top);
        make.left.equalTo(self.studentIcon.mas_right).offset(2);
        if (YBIphone6Plus) {
            make.width.equalTo(@(28*YBRatio));
            make.height.equalTo(@(28*YBRatio));

        }else{
            make.width.equalTo(@28);
            make.height.equalTo(@28);

        }
           }];
    
    [self.directionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.studentIcon.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
        if (YBIphone6Plus) {
            
            make.width.equalTo(@(36*YBRatio));
            make.height.equalTo(@(24*YBRatio));
        }else {
            make.width.equalTo(@36);
            make.height.equalTo(@24);
        }
       
        
    }];
}
-(UIImageView *)studentIcon {
    
    if (!_studentIcon) {
        
        UIImageView *studentIcon = [[UIImageView alloc]init];
        if (YBIphone6Plus) {
            studentIcon.layer.cornerRadius = 24*YBRatio;

            
        }else {
            studentIcon.layer.cornerRadius = 24;

        }
        studentIcon.layer.masksToBounds = YES;
        self.studentIcon = studentIcon;
        [self addSubview:studentIcon];
    }
    
    return _studentIcon;
}
-(UILabel *)studentNameLabel {
    
    if (!_studentNameLabel) {
        UILabel *studentNameLabel = [[UILabel alloc]init];
        if (YBIphone6Plus) {
            [studentNameLabel setFont:[UIFont systemFontOfSize:14*YBRatio]];

            
        }else {
            [studentNameLabel setFont:[UIFont systemFontOfSize:14]];

        }
        studentNameLabel.textColor = [UIColor whiteColor];
        
        self.studentNameLabel = studentNameLabel;
        
        [self addSubview:studentNameLabel];
    }
    
    return _studentNameLabel;
}

-(UIImageView *)complainIcon {
    if (!_complainIcon) {
        UIImageView *complainIcon = [[UIImageView alloc]init];
        if (YBIphone6Plus) {
            complainIcon.layer.cornerRadius = 24*YBRatio;
 
            
        }else {
            complainIcon.layer.cornerRadius = 24;

        }
        complainIcon.layer.masksToBounds = YES;
        self.complainIcon = complainIcon;
        [self addSubview:complainIcon];
        
    }
    return _complainIcon;
}
-(UILabel *)complaintNameLabel {
    if (!_complaintNameLabel) {
        
        UILabel *complaintNameLabel = [[UILabel alloc]init];
        if (YBIphone6Plus) {
            [complaintNameLabel setFont:[UIFont systemFontOfSize:14*YBRatio]];

            
        }else {
            [complaintNameLabel setFont:[UIFont systemFontOfSize:14]];

        }
        complaintNameLabel.textColor = [UIColor whiteColor];
        
        self.complaintNameLabel = complaintNameLabel;
        
        [self addSubview:complaintNameLabel];
        
    }
    return _complaintNameLabel;
}
-(UIImageView *)talkComplaintImageView {
    if (!_talkComplaintImageView) {
        
        UIImageView *talkComplaintImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"talk_complaint"]];
        self.talkComplaintImageView = talkComplaintImageView;
        [self addSubview:talkComplaintImageView];
        
    }
    return _talkComplaintImageView;
}

-(UIImageView *)directionImageView {
    
    if (!_directionImageView) {
        
        UIImageView *directionImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"direction"]];
        self.directionImageView = directionImageView;
        [self addSubview:directionImageView];
        
    }
    return _directionImageView;
}
-(void)setData:(JZComplaintComplaintlist *)data {
    
    _data = data;
    
    
    [self.studentIcon sd_setImageWithURL:[NSURL URLWithString:_data.studentinfo.headportrait.originalpic] placeholderImage:[UIImage imageNamed:@"head_null"]];
    self.studentNameLabel.text = _data.studentinfo.name;
    
    if (_data.feedbacktype == 1) {
        
        [self.complainIcon sd_setImageWithURL:[NSURL URLWithString:_data.coachinfo.headportrait.originalpic] placeholderImage:[UIImage imageNamed:@"head_null"]];
        self.complaintNameLabel.text = [NSString stringWithFormat:@"教练：%@",_data.coachinfo.name];
        
    }else if (_data.feedbacktype == 2){
        [self.complainIcon sd_setImageWithURL:[NSURL URLWithString:[UserInfoModel defaultUserInfo].portrait] placeholderImage:[UIImage imageNamed:@"head_null"]];
        self.complaintNameLabel.text = [NSString stringWithFormat:@"驾校：%@",[UserInfoModel defaultUserInfo].schoolName];
    }
    
    
       
}




@end
