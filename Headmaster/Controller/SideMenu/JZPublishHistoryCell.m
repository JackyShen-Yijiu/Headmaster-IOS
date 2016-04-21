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




@end
@implementation JZPublishHistoryCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *bjView = [[UIView alloc]init];
        bjView.backgroundColor = [UIColor blackColor];
        bjView.alpha = 0.4;
        self.backgroundView = bjView;
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
    self.mainTitleLabel.textColor = RGB_Color(0, 248, 199);
    [self.mainTitleLabel setFont:[UIFont systemFontOfSize:14]];
   
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.textColor = RGB_Color(185, 185, 185);
    [self.timeLabel setFont:[UIFont systemFontOfSize:12]];
    
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel.textColor = [UIColor whiteColor];
    self.contentLabel.numberOfLines = 0;
    [self.contentLabel setFont:[UIFont systemFontOfSize:14]];
    
    self.linView = [[UIView alloc]init];
    self.linView.backgroundColor = [UIColor darkGrayColor];
    
    self.linView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.linView.layer.shadowOpacity = 0.5;
    
    
    [self.contentView addSubview:self.mainTitleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.linView];
    
    
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
        
        self.mainTitleLabel.text = @"无标题";
    }else {
        self.mainTitleLabel.text = _data.title;
    }
    
    
    self.contentLabel.text = _data.content;
    self.timeLabel.text = [self getYearLocalDateFormateUTCDate:_data.createtime];

    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.timeLabel.mas_bottom).offset(12);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        
    }];
    
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
