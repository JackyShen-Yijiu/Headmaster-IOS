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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initUI {
    
    
//    ///  学员头像
//    @property (nonatomic, strong) UIImageView *studentIcon;
//    ///  学员姓名
//    @property (nonatomic, strong) UILabel *studentNameLabel;
//    /// 投诉的时间
//    @property (strong, nonatomic)  UILabel *complaintTime;
//    //// 投诉的名称
//    @property (strong, nonatomic)  UILabel *complaintName;
    
    self.complaintName = [[UILabel alloc]init];
    self.complaintName.textAlignment = NSTextAlignmentLeft;
    //    self.complaintName.textColor = ;
    [self.complaintName setFont:[UIFont systemFontOfSize:14]];
//    /// 投诉详情
//    @property (strong, nonatomic)  UILabel *complaintDetail;
//    /// 投诉的第一张图片
//    @property (strong, nonatomic)  UIImageView *complaintFirstImg;
//    /// 投诉的第二张图片
//    @property (strong, nonatomic)  UIImageView *complaintSecondImg;
//    
//    @property (nonatomic,strong) UIView *complaintImageView;
    
    
    
    
    
    
    self.complaintName = [[UILabel alloc]init];
    self.complaintName.textAlignment = NSTextAlignmentLeft;
//    self.complaintName.textColor = ;
    [self.complaintName setFont:[UIFont systemFontOfSize:14]];
    
    self.complaintTime = [[UILabel alloc]init];
//    self.complaintTime.textColor =  ;
    self.complaintName.textAlignment = NSTextAlignmentRight;
    [self.complaintTime setFont:[UIFont systemFontOfSize:12]];
    self.complaintTime.numberOfLines = 0;
    
    self.complaintDetail = [[UILabel alloc]init];
//    self.complaintDetail.textColor = ;
    self.complaintDetail.numberOfLines = 0;
    [self.complaintDetail setFont:[UIFont systemFontOfSize:14]];
    
    self.complaintImageView = [[UIView alloc] init];
    [self.contentView addSubview:self.complaintImageView];
    
    self.complaintFirstImg = [[UIImageView alloc]init];
    [self.complaintImageView addSubview:self.complaintFirstImg];
    
    self.complaintSecondImg = [[UIImageView alloc]init];
    [self.complaintImageView addSubview:self.complaintSecondImg];
    
    [self.contentView addSubview:self.complaintName];
    [self.contentView addSubview:self.complaintTime];
    [self.contentView addSubview:self.complaintDetail];
    

}
@end
