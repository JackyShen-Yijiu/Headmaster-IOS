//
//  JZComplaintCell.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZComplaintCell.h"
#import "JZComplaintComplaintlist.h"
#import "NSString+LKString.h"


static NSString *JZComplaintCellID = @"JZComplaintCellID";

@interface JZComplaintCell()

///  学员头像
@property (nonatomic, strong) UIImageView *studentIcon;
///  学员姓名
@property (nonatomic, strong) UILabel *studentNameLabel;
/// 投诉的时间
@property (strong, nonatomic)  UILabel *complaintTime;
//// 投诉的名称
@property (strong, nonatomic)  UILabel *complaintName;
/// 投诉详情
@property (strong, nonatomic)  UILabel *complaintDetail;
/// 投诉的第一张图片
@property (strong, nonatomic)  UIImageView *complaintFirstImg;
/// 投诉的第二张图片
@property (strong, nonatomic)  UIImageView *complaintSecondImg;
/// 放置两张图片的View
@property (nonatomic,strong) UIView *complaintImageView;

@property (nonatomic, strong) UIView *lineView;


@end
@implementation JZComplaintCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
-(void)initUI {
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = JZ_MAIN_BACKGROUND_COLOR;
    
    self.studentNameLabel = [[UILabel alloc]init];
    self.studentNameLabel.textColor = kJZDarkTextColor;
    [self.studentNameLabel setFont:[UIFont systemFontOfSize:14]];
    if (YBIphone6Plus) {
        [self.studentNameLabel setFont:[UIFont systemFontOfSize:14*YBRatio]];
    }


    self.studentIcon = [[UIImageView alloc]init];
    self.studentIcon.layer.cornerRadius = 12;
    if (YBIphone6Plus) {
        self.studentIcon.layer.cornerRadius = 12*YBRatio;
    }
    self.studentIcon.layer.masksToBounds = YES;

    
    self.complaintTime = [[UILabel alloc]init];
    self.complaintTime.textColor = kJZLightTextColor;
    self.complaintTime.textAlignment = NSTextAlignmentRight;
    [self.complaintTime setFont:[UIFont systemFontOfSize:12]];
    if (YBIphone6Plus) {
        [self.complaintTime setFont:[UIFont systemFontOfSize:12*YBRatio]];
    }
    
    self.complaintName = [[UILabel alloc]init];
    self.complaintName.textAlignment = NSTextAlignmentLeft;
    self.complaintName.textColor = kJZLightTextColor;
    [self.complaintName setFont:[UIFont systemFontOfSize:14]];
    if (YBIphone6Plus) {
        [self.complaintName setFont:[UIFont systemFontOfSize:14*YBRatio]];
    }

    self.complaintDetail = [[UILabel alloc]init];
    self.complaintDetail.textColor = kJZDarkTextColor;
    self.complaintDetail.numberOfLines = 2;
    [self.complaintDetail setFont:[UIFont systemFontOfSize:14]];
    if (YBIphone6Plus) {
        [self.complaintDetail setFont:[UIFont systemFontOfSize:14*YBRatio]];
    }
    
    self.complaintImageView = [[UIView alloc] init];

    self.complaintFirstImg = [[UIImageView alloc]init];

    self.complaintSecondImg = [[UIImageView alloc]init];

    

    [self.contentView addSubview:self.studentIcon];
    [self.contentView addSubview:self.studentNameLabel];
    [self.contentView addSubview:self.complaintName];
    [self.contentView addSubview:self.complaintTime];
    [self.contentView addSubview:self.complaintDetail];
    [self.contentView addSubview:self.complaintImageView];
    [self.complaintImageView addSubview:self.complaintFirstImg];
    [self.complaintImageView addSubview:self.complaintSecondImg];
    [self.contentView addSubview:self.lineView];

}
-(void)layoutSubviews {
    [super layoutSubviews];

    NSInteger studentIconW  = 24;
    if (YBIphone6Plus) {
        studentIconW = 24 * YBRatio;
    }
    [self.studentIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).offset(16);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.width.mas_equalTo(studentIconW);
        make.height.mas_equalTo(studentIconW);


    }];
    
    
    [self.studentNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.studentIcon.mas_centerY);
        make.left.equalTo(self.studentIcon.mas_right).offset(14);
    }];
    
    
    [self.complaintName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.studentIcon.mas_bottom).offset(14);
        make.left.equalTo(self.contentView.mas_left).offset(16);
    }];
    
    [self.complaintTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.studentIcon.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
    }];
    
    [self.complaintDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.complaintName.mas_bottom).offset(14);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
    }];
    NSInteger complaintImgW  = 73;
    NSInteger complaintImageViewW = 160;
    if (YBIphone6Plus) {
        complaintImgW = 73 * YBRatio;
        complaintImageViewW = 160*YBRatio;
    }
    [self.complaintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.complaintName.mas_left);
        make.top.mas_equalTo(self.complaintDetail.mas_bottom).offset(12);
        make.width.mas_equalTo(complaintImageViewW);
        make.height.mas_equalTo(complaintImgW);
    }];
    
    [self.complaintFirstImg mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.mas_equalTo(complaintImgW);

    }];
    
    [self.complaintSecondImg mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(@0);
        make.left.equalTo(self.complaintFirstImg.mas_right).offset(10);
        make.bottom.equalTo(@0);
        make.width.mas_equalTo(complaintImgW);
            
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@0.5);
        
    }];
    NSInteger badgeViewW  = 6;
    if (YBIphone6Plus) {
        badgeViewW = 6 * YBRatio;
    }
    [self.badgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.studentIcon.mas_top);
        make.right.equalTo(self.studentIcon.mas_right);
        make.width.equalTo(@(badgeViewW));
        make.height.equalTo(@(badgeViewW));

        
        
    }];


}
-(void)setData:(JZComplaintComplaintlist *)data {
    
    _data = data;
    
    [self.studentIcon sd_setImageWithURL:[NSURL URLWithString:_data.studentinfo.headportrait.originalpic] placeholderImage:[UIImage imageNamed:@"head_null"]];
    self.studentNameLabel.text = _data.studentinfo.name;
    
    self.complaintDetail.text = _data.complaintcontent;
    
    if (_data.feedbacktype == 1) {

        self.complaintName.text = [NSString stringWithFormat:@"投诉教练：%@",_data.coachinfo.name];
        
    }else if (_data.feedbacktype == 2){
        
        self.complaintName.text = [NSString stringWithFormat:@"投诉驾校：%@",[UserInfoModel defaultUserInfo].schoolName];
   
    }
    
    self.complaintTime.text = [NSString getYearLocalDateFormateUTCDate:_data.complaintDateTime style:LKDateStyleDefault];
    
//    NSLog(@"_data.piclistr:%@",_data.piclistr);
    
    NSString *str = @"""";
    
    if (_data.piclistr && _data.piclistr.count!=0 && ![_data.piclistr containsObject:str]) {
        
        self.complaintImageView.hidden = NO;
        
        if ((_data.piclistr[0] && [_data.piclistr[0] length]!=0)) {
            self.complaintFirstImg.hidden = NO;
            self.complaintSecondImg.hidden = YES;
            [self.complaintFirstImg sd_setImageWithURL:[NSURL URLWithString:_data.piclistr[0]]placeholderImage:[UIImage imageNamed:@"pic_load"]];
        }
        
        if (_data.piclistr.count>1 && _data.piclistr[1] && [_data.piclistr[1] length]!=0) {
            self.complaintFirstImg.hidden = NO;
            self.complaintSecondImg.hidden = NO;
            [self.complaintSecondImg sd_setImageWithURL:[NSURL URLWithString:_data.piclistr[1]]placeholderImage:[UIImage imageNamed:@"pic_load"]];

        }
       
    }else{
        
        self.complaintImageView.hidden = YES;
        
    }
    

}

+ (CGFloat)cellHeightDmData:(JZComplaintComplaintlist *)dmData
{
    
    JZComplaintCell *cell = [[JZComplaintCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JZComplaintCellID];
    
    cell.data = dmData;
    
    [cell layoutIfNeeded];
    
    NSString *str = @"""";
    
    if (dmData.piclistr && dmData.piclistr.count!=0 && ![dmData.piclistr containsObject:str]) {
        return cell.complaintName.height + cell.complaintDetail.height + cell.complaintImageView.height + cell.studentIcon.height + 70.5;
    }
    return cell.complaintName.height + cell.complaintDetail.height + cell.studentIcon.height + 58.5;
    
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
