//
//  JZComplaintCell.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZComplaintCell.h"

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

@end
@implementation JZComplaintCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)initUI {

    self.studentIcon = [[UIImageView alloc]init];
    self.studentIcon.layer.cornerRadius = 18;
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
    self.complaintDetail.numberOfLines = 0;
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

}
-(void)layoutSubviews {
    [super layoutSubviews];
    
    [self.studentIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(16);
       
    }];
    
    
    [self.studentNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.studentIcon.mas_centerY);
        make.left.equalTo(self.studentNameLabel.mas_right).offset(8);
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
        make.top.equalTo(self.complaintName.mas_bottom).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
    }];
    
    [self.complaintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.complaintName.mas_left);
        make.top.mas_equalTo(self.complaintDetail.mas_bottom).offset(10);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(75);
    }];
    [self.complaintFirstImg mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.mas_equalTo(75);
    }];
    [self.complaintSecondImg mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(@0);
        make.left.equalTo(self.complaintFirstImg.mas_right).offset(10);
        make.bottom.equalTo(@0);
        make.width.mas_equalTo(75);
    }];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
