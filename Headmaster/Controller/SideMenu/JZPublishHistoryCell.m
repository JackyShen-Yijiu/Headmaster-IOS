//
//  JZPublishHistoryCell.m
//  Headmaster
//
//  Created by 雷凯 on 16/4/19.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZPublishHistoryCell.h"
#import "JZPublishHistoryData.h"
#define kLKSize [UIScreen mainScreen].bounds.size
@interface JZPublishHistoryCell ()
/// 标题
@property (nonatomic, strong) UILabel *mainTitleLabel;
///  时间
@property (nonatomic, strong) UILabel *timeLabel;
///  内容
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIView *linView;

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation JZPublishHistoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

-(void)initUI {
    
    self.mainTitleLabel = [[UILabel alloc]init];
    self.mainTitleLabel.textAlignment = NSTextAlignmentLeft;
    self.mainTitleLabel.textColor = kJZDarkTextColor;
    
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.textAlignment = NSTextAlignmentRight;
    self.nameLabel.textColor = kJZLightTextColor;
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.textColor = kJZLightTextColor;
  
    
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel.textColor = kJZDarkTextColor;
    self.contentLabel.numberOfLines = 0;
    
    self.linView = [[UIView alloc]init];
    self.linView.backgroundColor = JZ_MAIN_BACKGROUND_COLOR;
    
    if (YBIphone6Plus) {
        
        [self.mainTitleLabel setFont:[UIFont boldSystemFontOfSize:16*YBRatio]];
        
        [self.nameLabel setFont:[UIFont systemFontOfSize:12*YBRatio]];
        
        [self.timeLabel setFont:[UIFont systemFontOfSize:12*YBRatio]];
       
        [self.contentLabel setFont:[UIFont systemFontOfSize:14*YBRatio]];

    }else {
    
        [self.mainTitleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        
        [self.nameLabel setFont:[UIFont systemFontOfSize:12]];
        
        [self.timeLabel setFont:[UIFont systemFontOfSize:12]];
      
        [self.contentLabel setFont:[UIFont systemFontOfSize:14]];

    }
    
    
    [self.contentView addSubview:self.mainTitleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.linView];
    [self.contentView addSubview:self.nameLabel];
    
}

-(void)setData:(JZPublishHistoryData *)data {
    
    _data = data;
    
    NSString *str1 = @"无标题";

    if (_data.title && [_data.title length]!=0) {
        str1 = _data.title;
    }
    
    self.mainTitleLabel.text = str1;
    
    NSLog(@"_data.content:(%@)",_data.content);
          
    self.timeLabel.text = [self getYearLocalDateFormateUTCDate:_data.createtime];

    self.contentLabel.text = _data.content;
    
    if (_data.name && _data.name.length) {
      self.nameLabel.text = [NSString stringWithFormat:@"发布者: %@",_data.name];
    }else {
        self.nameLabel.text = @"发布者: 未知";
    }
    
    
    [self.mainTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).offset(24);// 24
        make.left.equalTo(self.contentView.mas_left).offset(16);
        
    }];
    
    [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mainTitleLabel.mas_bottom).offset(12);// 12
        make.left.equalTo(self.contentView.mas_left).offset(16);
        
    }];
    
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mainTitleLabel.mas_bottom).offset(12);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        
    }];
    
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.timeLabel.mas_bottom).offset(14);// 14
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        
    }];
    
    [self.linView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(24);// 24
        make.height.equalTo(@0.5);
    }];

}

+ (CGFloat)cellHeightDmData:(JZPublishHistoryData *)dmData
{
    
    JZPublishHistoryCell *cell = [[JZPublishHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JZPublishHistoryCellID"];
    
    cell.data = dmData;
    
    [cell layoutIfNeeded];

//    CGFloat height = [dmData.content sizeWithFont:[UIFont boldSystemFontOfSize:14*YBRatio] constrainedToSize:CGSizeMake(cell.contentView.width - 16 - 16, MAXFLOAT)].height;
//    NSLog(@"---height:%f",height);
    
    return cell.timeLabel.height + cell.mainTitleLabel.height + cell.contentLabel.height + 0.5 + 74;
    
}

- (NSString *)getYearLocalDateFormateUTCDate:(NSString *)utcDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

//- (CGSize)getLabelWidthWithString:(NSString *)string {
//    CGRect bounds = [string boundingRectWithSize:
//                     CGSizeMake([[UIScreen mainScreen] bounds].size.width - 30, 10000) options:
//                     NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} context:nil];
//    return bounds.size.height;
//}


@end
