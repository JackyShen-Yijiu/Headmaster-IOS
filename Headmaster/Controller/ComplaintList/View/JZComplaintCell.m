//
//  JZComplaintCell.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZComplaintCell.h"
#import "JZComplaintComplaintlist.h"
static NSString *JZComplaintCellID = @"JZComplaintCell";
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
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)initUI {
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = JZ_MAIN_BACKGROUND_COLOR;
    
    self.studentNameLabel = [[UILabel alloc]init];
    self.studentNameLabel.textColor = kJZLightTextColor;
    [self.studentNameLabel setFont:[UIFont systemFontOfSize:14]];


    self.studentIcon = [[UIImageView alloc]init];
    self.studentIcon.layer.cornerRadius = 12;
    self.studentIcon.layer.masksToBounds = YES;

    self.complaintTime = [[UILabel alloc]init];
    self.complaintTime.textColor = kJZLightTextColor;
    self.complaintName.textAlignment = NSTextAlignmentRight;
    [self.complaintTime setFont:[UIFont systemFontOfSize:12]];
    self.complaintTime.numberOfLines = 0;

    self.complaintName = [[UILabel alloc]init];
    self.complaintName.textAlignment = NSTextAlignmentLeft;
    self.complaintName.textColor = kJZDarkTextColor;
    [self.complaintName setFont:[UIFont systemFontOfSize:14]];

    self.complaintDetail = [[UILabel alloc]init];
    self.complaintDetail.textColor = kJZDarkTextColor;
    self.complaintDetail.numberOfLines = 2;
    [self.complaintDetail setFont:[UIFont systemFontOfSize:14]];
    
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
    
    [self.studentIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).offset(16);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.width.equalTo(@24);
        make.height.equalTo(@24);
        
       
    }];
    
    
    [self.studentNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.studentIcon.mas_centerY);
        make.left.equalTo(self.studentIcon.mas_right).offset(14);
        
    }];
    
    
    [self.complaintName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.studentIcon.mas_bottom).offset(16);
        make.left.equalTo(self.contentView.mas_left).offset(16);
    }];
    [self.complaintTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.studentIcon.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.height.equalTo(@12);
    }];
    [self.complaintDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.complaintName.mas_bottom).offset(14);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
    }];
    
    [self.complaintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.complaintName.mas_left);
        make.top.mas_equalTo(self.complaintDetail.mas_bottom).offset(10);
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
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@0.5);
        
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

+ (CGFloat)cellHeightDmData:(JZComplaintComplaintlist *)dmData
{
    
    JZComplaintCell *cell = [[JZComplaintCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JZMyComplaintCell"];
    
    cell.data = dmData;
    
    [cell layoutIfNeeded];
    
    if (dmData.piclistr && dmData.piclistr.count!=0) {
        return cell.complaintName.height + cell.complaintDetail.height + cell.complaintImageView.height + cell.studentNameLabel.height + cell.studentIcon.height + 70;
    }
    return cell.complaintName.height + cell.complaintDetail.height + cell.studentNameLabel.height + cell.studentIcon.height + 58;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
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
