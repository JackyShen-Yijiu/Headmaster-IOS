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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        UIView *bjView = [[UIView alloc]init];
//        bjView.backgroundColor = [UIColor blackColor];
//        bjView.alpha = 0.4;
//        self.backgroundView = bjView;
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)initUI {
    self.mainTitleLabel = [[UILabel alloc]init];
    self.mainTitleLabel.textAlignment = NSTextAlignmentLeft;
    self.mainTitleLabel.textColor = kJZDarkTextColor;
    [self.mainTitleLabel setFont:[UIFont systemFontOfSize:14]];
    
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.textAlignment = NSTextAlignmentRight;
    self.nameLabel.textColor = kJZLightTextColor;
    [self.nameLabel setFont:[UIFont systemFontOfSize:12]];
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.textColor = kJZLightTextColor;
    [self.timeLabel setFont:[UIFont systemFontOfSize:12]];
    
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel.textColor = kJZDarkTextColor;
    self.contentLabel.numberOfLines = 0;
    [self.contentLabel setFont:[UIFont systemFontOfSize:14]];
    
    self.linView = [[UIView alloc]init];
    self.linView.backgroundColor = kJZLightTextColor;
    
//    self.linView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
//    self.linView.layer.shadowOpacity = 0.5;
    
    
    [self.contentView addSubview:self.mainTitleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.linView];
    [self.contentView addSubview:self.nameLabel];
    
    
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.mainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView.mas_top).offset(14);//
        make.left.equalTo(self.contentView.mas_left).offset(16);
        
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.mainTitleLabel.mas_bottom).offset(10);//
        make.left.equalTo(self.contentView.mas_left).offset(16);
        
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mainTitleLabel.mas_bottom).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-16);

    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.timeLabel.mas_bottom).offset(12);//
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);

    }];
    
    [self.linView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(14);
        make.height.equalTo(@0.5);
        
    }];

    
}

-(void)setData:(JZPublishHistoryData *)data {
    
    _data = data;
    
    
    
    if ([_data.title isEqualToString:@""]) {
        
        NSString *str1 = @"无标题";
        UIFont *boldFont = [UIFont boldSystemFontOfSize:16];
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"无标题"];
        [attrString addAttribute:NSFontAttributeName value:boldFont range:NSMakeRange(0, str1.length)];
        [self.mainTitleLabel setAttributedText:attrString];
        
    }else {
        NSString *str2 = _data.title;
        UIFont *boldFont = [UIFont boldSystemFontOfSize:16];
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:str2];
        [attrString addAttribute:NSFontAttributeName value:boldFont range:NSMakeRange(0, str2.length)];
        [self.mainTitleLabel setAttributedText:attrString];
    }
    
    
    self.contentLabel.text = _data.content;
    self.timeLabel.text = [self getYearLocalDateFormateUTCDate:_data.createtime];

    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.timeLabel.mas_bottom).offset(12);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        
    }];
    
   
    self.nameLabel.text = [NSString stringWithFormat:@"发布者: %@",_data.name];
    
}

+ (CGFloat)cellHeightDmData:(JZPublishHistoryData *)dmData
{
    
    JZPublishHistoryCell *cell = [[JZPublishHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JZPublishHistoryCellID"];
    
    cell.data = dmData;
    
    [cell layoutIfNeeded];

    return cell.timeLabel.height + cell.mainTitleLabel.height + cell.contentLabel.height  + 0.5 + 50;
    
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
