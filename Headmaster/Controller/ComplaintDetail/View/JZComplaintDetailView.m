//
//  JZComplaintDetailView.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZComplaintDetailView.h"

@interface JZComplaintDetailView ()

@end
@implementation JZComplaintDetailView

-(instancetype)initWithFrame:(CGRect)frame {
    
    
    if (self = [super initWithFrame:frame]) {
        
     
        
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
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.topView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        
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

-(UIView *)bottomView {
    if (!_bottomView) {
        
        UIView *bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor whiteColor];
        self.bottomView = bottomView;
        [self addSubview:bottomView];
    }
    return _bottomView;

    
}
-(UILabel *)complaintContent {
    if (!_complaintContent) {
        
        UILabel *complaintContent = [[UILabel alloc]init];
        
        complaintContent.text = @"投诉内容";
        [complaintContent setFont:[UIFont systemFontOfSize:14]];
        complaintContent.textColor = kJZLightTextColor;
        
        self.complaintContent = complaintContent;
        
        [self.bottomView addSubview:complaintContent];
        
    }
    
    return _complaintContent;
}


-(UILabel *)complaintTime {
    if (!_complaintTime) {
        
        UILabel *complaintTime = [[UILabel alloc]init];
        
        [complaintTime setFont:[UIFont systemFontOfSize:14]];
        complaintTime.textColor = kJZLightTextColor;
        
        self.complaintTime = complaintTime;
        
        [self.bottomView addSubview:complaintTime];
        
    }
    
    return _complaintTime;

    
}

-(UILabel *)complaintDetail {
    
    if (!_complaintDetail) {
        
        UILabel *complaintDetail = [[UILabel alloc]init];
        
        [complaintDetail setFont:[UIFont systemFontOfSize:14]];
        complaintDetail.textColor = kJZDarkTextColor;
        
        self.complaintDetail = complaintDetail;
        
        [self.bottomView addSubview:complaintDetail];
        
    }
    
    return _complaintDetail;
}
-(UIView *)complaintImageView {
    
    if (!_complaintImageView) {
        
        UIView *complaintImageView = [[UIView alloc]init];
        self.complaintImageView = complaintImageView;
        
        [self.bottomView addSubview:complaintImageView];
        
    }
    return _complaintImageView;
}
-(UIImageView *)complaintFirstImg {
    
    if (_complaintFirstImg) {
        
        UIImageView *complaintFirstImg = [[UIImageView alloc]init];
        self.complaintFirstImg = complaintFirstImg;
        [self.complaintImageView addSubview:complaintFirstImg];
    }
    return _complaintFirstImg;
    
}

-(UIImageView *)complaintSecondImg {
    if (!_complaintSecondImg) {
        
        UIImageView *complaintSecondImg = [[UIImageView alloc]init];
        self.complaintSecondImg = complaintSecondImg;
        [self.complaintImageView addSubview:complaintSecondImg];
        
    }
    return _complaintSecondImg;
}




@end
