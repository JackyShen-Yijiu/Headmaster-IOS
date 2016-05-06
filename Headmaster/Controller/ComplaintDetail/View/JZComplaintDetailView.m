//
//  JZComplaintDetailView.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZComplaintDetailView.h"
#import "JZComplaintComplaintlist.h"

@interface JZComplaintDetailView ()
///  顶部View
@property (nonatomic, weak) UIView *topView;
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

///"投诉内容"这四个文字
@property (nonatomic, weak) UILabel *complaintContent;
/// 投诉的时间
@property (strong, nonatomic)  UILabel *complaintTime;

/// 投诉详情
@property (strong, nonatomic)  UILabel *complaintDetail;
/// 投诉的第一张图片
@property (strong, nonatomic)  UIImageView *complaintFirstImg;
/// 投诉的第二张图片
@property (strong, nonatomic)  UIImageView *complaintSecondImg;
/// 放置两张图片的View
@property (nonatomic,strong) UIView *complaintImageView;
@end
@implementation JZComplaintDetailView

-(instancetype)initWithFrame:(CGRect)frame {
    
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    
    return self;
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@146);
        
    }];
    
    [self.studentIcon mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.mas_left).offset(kJZWidth*0.25-24);
        make.top.equalTo(self.mas_top).offset(36);
        make.width.equalTo(@48);
        make.height.equalTo(@48);
        
    }];

    [self.studentNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.studentIcon.mas_centerX);
        make.top.equalTo(self.studentIcon.mas_bottom).offset(12);
        
        
    }];

    [self.complainIcon mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.mas_left).offset(kJZWidth*0.75+24);
        make.centerY.equalTo(self.studentIcon.mas_centerY);
        make.width.equalTo(@48);
        make.height.equalTo(@48);
    }];

    [self.complaintNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.complainIcon.mas_centerX);
        make.top.equalTo(self.complainIcon.mas_bottom).offset(12);
    }];

    [self.talkComplaintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.studentIcon.mas_top);
        make.left.equalTo(self.studentIcon.mas_right).offset(2);
        make.width.equalTo(@28);
        make.height.equalTo(@28);
    }];

    [self.directionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.studentIcon.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@36);
        make.height.equalTo(@24);
        
    }];



    [self.complaintContent mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.topView.mas_bottom).offset(16);
        make.left.equalTo(self.mas_left).offset(16);
    }];

    [self.complaintTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.topView.mas_bottom).offset(16);
        make.right.equalTo(self.mas_right).offset(-16);
    }];
    [self.complaintDetail mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.complaintTime.mas_bottom).offset(12);
        make.left.equalTo(self.mas_left).offset(16);
        make.right.equalTo(self.mas_right).offset(-16);
    }];
    [self.complaintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(16);
        make.top.mas_equalTo(self.complaintDetail.mas_bottom).offset(12);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(73);
    }];

    [self.complaintFirstImg mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.mas_equalTo(73);
    }];

    [self.complaintSecondImg mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(@0);
        make.left.equalTo(self.complaintFirstImg.mas_right).offset(10);
        make.bottom.equalTo(@0);
        make.width.mas_equalTo(73);
    }];
    
    
}


#pragma mark - 懒加载
-(UIView *)topView {
    if (!_topView) {
        
        UIView *topView = [[UIView alloc]init];
        topView.backgroundColor = kJZNavBackgroundColor;
        self.topView = topView;
        [self addSubview:topView];
    }
    return _topView;
}

-(UIImageView *)studentIcon {
    
    if (!_studentIcon) {

        UIImageView *studentIcon = [[UIImageView alloc]init];
        studentIcon.layer.cornerRadius = 24;
        studentIcon.layer.masksToBounds = YES;
        self.studentIcon = studentIcon;
        [self.topView addSubview:studentIcon];
    }
    
    return _studentIcon;
}
-(UILabel *)studentNameLabel {
    
    if (!_studentNameLabel) {
        UILabel *studentNameLabel = [[UILabel alloc]init];
        [studentNameLabel setFont:[UIFont systemFontOfSize:14]];
        studentNameLabel.textColor = [UIColor whiteColor];

        self.studentNameLabel = studentNameLabel;
        
        [self.topView addSubview:studentNameLabel];
    }
    
    return _studentNameLabel;
}

-(UIImageView *)complainIcon {
    if (!_complainIcon) {
        UIImageView *complainIcon = [[UIImageView alloc]init];
        complainIcon.layer.cornerRadius = 24;
        complainIcon.layer.masksToBounds = YES;
        self.complainIcon = complainIcon;
        [self.topView addSubview:complainIcon];

    }
    return _complainIcon;
}
-(UILabel *)complaintNameLabel {
    if (!_complaintNameLabel) {
        
        UILabel *complaintNameLabel = [[UILabel alloc]init];
        [complaintNameLabel setFont:[UIFont systemFontOfSize:14]];
        complaintNameLabel.textColor = [UIColor whiteColor];

        self.complaintNameLabel = complaintNameLabel;
        
        [self.topView addSubview:complaintNameLabel];

    }
    return _complaintNameLabel;
}
-(UIImageView *)talkComplaintImageView {
    if (!_talkComplaintImageView) {
        
        UIImageView *talkComplaintImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"talk_complaint"]];
        self.talkComplaintImageView = talkComplaintImageView;
        [self.topView addSubview:talkComplaintImageView];

    }
    return _talkComplaintImageView;
}

-(UIImageView *)directionImageView {
    
    if (!_directionImageView) {
        
        UIImageView *directionImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"direction"]];
        self.directionImageView = directionImageView;
        [self.topView addSubview:directionImageView];
    
    }
    return _directionImageView;
}


-(UILabel *)complaintContent {
    if (!_complaintContent) {
        
        UILabel *complaintContent = [[UILabel alloc]init];
        
        complaintContent.text = @"投诉内容";
        [complaintContent setFont:[UIFont systemFontOfSize:14]];
        complaintContent.textColor = kJZLightTextColor;
        
        self.complaintContent = complaintContent;
        
        [self addSubview:complaintContent];
        
    }
    
    return _complaintContent;
}


-(UILabel *)complaintTime {
    if (!_complaintTime) {
        
        UILabel *complaintTime = [[UILabel alloc]init];
        
        [complaintTime setFont:[UIFont systemFontOfSize:14]];
        complaintTime.textColor = kJZLightTextColor;
        
        self.complaintTime = complaintTime;
        
        [self addSubview:complaintTime];
        
    }
    
    return _complaintTime;

    
}

-(UILabel *)complaintDetail {
    
    if (!_complaintDetail) {
        
        UILabel *complaintDetail = [[UILabel alloc]init];
        
        [complaintDetail setFont:[UIFont systemFontOfSize:14]];
        complaintDetail.textColor = kJZDarkTextColor;
        
        self.complaintDetail = complaintDetail;
        
        [self addSubview:complaintDetail];
        
    }
    
    return _complaintDetail;
}
-(UIView *)complaintImageView {
    
    if (!_complaintImageView) {
        
        UIView *complaintImageView = [[UIView alloc]init];
        
        complaintImageView.backgroundColor = [UIColor cyanColor];
        self.complaintImageView = complaintImageView;
        
        [self addSubview:complaintImageView];
        
    }
    return _complaintImageView;
}
-(UIImageView *)complaintFirstImg {
    
    if (_complaintFirstImg) {
        
        UIImageView *complaintFirstImg = [[UIImageView alloc]init];
        self.complaintFirstImg = complaintFirstImg;
//        [self.complaintImageView addSubview:complaintFirstImg];
    }
    return _complaintFirstImg;
    
}

-(UIImageView *)complaintSecondImg {
    if (!_complaintSecondImg) {
        
        UIImageView *complaintSecondImg = [[UIImageView alloc]init];
        self.complaintSecondImg = complaintSecondImg;
//        [self.complaintImageView addSubview:complaintSecondImg];
        
    }
    return _complaintSecondImg;
}
-(void)setData:(JZComplaintComplaintlist *)data {
    
    _data = data;
    
    
    [self.studentIcon sd_setImageWithURL:[NSURL URLWithString:_data.studentinfo.headportrait.originalpic] placeholderImage:[UIImage imageNamed:@"head_null"]];
    self.studentNameLabel.text = _data.studentinfo.name;
    
    self.complaintDetail.text = _data.complaintcontent;
    
    if (_data.feedbacktype == 1) {
        
        [self.complainIcon sd_setImageWithURL:[NSURL URLWithString:_data.coachinfo.headportrait.originalpic] placeholderImage:[UIImage imageNamed:@"head_null"]];
        self.complaintNameLabel.text = [NSString stringWithFormat:@"教练：%@",_data.coachinfo.name];
        
    }else if (_data.feedbacktype == 2){
        [self.complainIcon sd_setImageWithURL:[NSURL URLWithString:[UserInfoModel defaultUserInfo].portrait] placeholderImage:[UIImage imageNamed:@"head_null"]];
        self.complaintNameLabel.text = [NSString stringWithFormat:@"驾校：%@",[UserInfoModel defaultUserInfo].schoolName];
    }
    
    self.complaintTime.text = [self getYearLocalDateFormateUTCDate:_data.complaintDateTime];
    
    if (_data.piclistr && _data.piclistr.count!=0) {
        
        self.complaintImageView.hidden = NO;
        
        if (_data.piclistr[0] && [_data.piclistr[0] length]!=0) {
            self.complaintFirstImg.hidden = NO;
            [self.complaintFirstImg sd_setImageWithURL:[NSURL URLWithString:_data.piclistr[0]]];
        }else{
            self.complaintFirstImg.hidden = YES;
        }
        
        if (_data.piclistr && _data.piclistr.count>1) {
            
            if (_data.piclistr[1] && [_data.piclistr[1] length]!=0) {
                self.complaintSecondImg.hidden = NO;
                [self.complaintSecondImg sd_setImageWithURL:[NSURL URLWithString:_data.piclistr[1]]];
            }else{
                self.complaintSecondImg.hidden = YES;
            }
            
        }
        
    }else{
        
        self.complaintImageView.hidden = YES;
        
    }
    
    
}

+ (CGFloat)viewHeightDmData:(JZComplaintComplaintlist *)dmData
{
    
    JZComplaintDetailView *detailView = [[JZComplaintDetailView alloc]init];
    
    detailView.data = dmData;
    
    [detailView layoutIfNeeded];
    
    if (dmData.piclistr && dmData.piclistr.count!=0) {
        return detailView.studentIcon.height + detailView.studentNameLabel.height + detailView.complaintContent.height + detailView.complaintDetail.height + detailView.complaintImageView.height + 128;
    }
    return detailView.studentIcon.height + detailView.studentNameLabel.height + detailView.complaintContent.height + detailView.complaintDetail.height + 112;
    
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
