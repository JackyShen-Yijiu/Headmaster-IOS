//
//  JZInformationListCell.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/6.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZInformationListCell.h"
#import "JZInformationData.h"

@interface JZInformationListCell()
///  新闻图片
@property (nonatomic, weak) UIImageView *newsImageView;
///  新闻标题
@property (nonatomic, weak) UILabel *newsTitleLabel;
///  新闻日期
@property (nonatomic, weak) UILabel *newsDateLabel;

@property (nonatomic, weak) UIView *lineView;

@end
@implementation JZInformationListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//                self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
//        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

-(void)setData:(JZInformationData *)data {
    
    _data = data;
    
    
    [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:_data.logimg]placeholderImage:[UIImage imageNamed:@"pic_load"]];
    
    self.newsTitleLabel.text = _data.title;
    
    self.newsDateLabel.text = [self getYearLocalDateFormateUTCDate:_data.createtime];
    
    
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.newsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(12);
        make.width.equalTo(@102);
        make.height.equalTo(@80);
 
    }];
    
    [self.newsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.newsImageView.mas_right).offset(12);
        make.right.equalTo(self.contentView.mas_right).offset(-12);
        make.top.equalTo(self.contentView.mas_top).offset(14);
 
    }];
    
    [self.newsDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView.mas_right).offset(-12);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-14);
        
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@0.5);
        
    }];
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
// Configure the view for the selected state
}

-(UIImageView *)newsImageView {
    
    if (!_newsImageView) {
        
        UIImageView *newsImageView = [[UIImageView alloc]init];
        self.newsImageView = newsImageView;
        [self.contentView addSubview:newsImageView];
        
    }
    return _newsImageView;
}

-(UILabel *)newsTitleLabel {
    if (!_newsTitleLabel) {
        
        UILabel *newsTitleLabel = [[UILabel alloc]init];
        if (YBIphone6Plus) {
            
            [newsTitleLabel setFont:[UIFont systemFontOfSize:14*YBRatio]];

        }else {
            [newsTitleLabel setFont:[UIFont systemFontOfSize:14]];

        }
        
        newsTitleLabel.textColor = kJZDarkTextColor;
        newsTitleLabel.numberOfLines = 0;
        self.newsTitleLabel = newsTitleLabel;
        [self.contentView addSubview:newsTitleLabel];
        
    }
    return _newsTitleLabel;

    
}

-(UILabel *)newsDateLabel {
    if (!_newsDateLabel) {
        
        UILabel *newsDateLabel = [[UILabel alloc]init];
        
        if (YBIphone6Plus) {
            [newsDateLabel setFont:[UIFont systemFontOfSize:12*YBRatio]];
 
            
        }else {
            [newsDateLabel setFont:[UIFont systemFontOfSize:12]];

        }
        
        newsDateLabel.textColor = kJZLightTextColor;
        self.newsDateLabel = newsDateLabel;
        [self.contentView addSubview:newsDateLabel];

    }
    return _newsDateLabel;
}

-(UIView *)lineView {
    if (!_lineView) {
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = JZ_MAIN_BACKGROUND_COLOR;
        
        self.lineView = lineView;
        
        [self.contentView addSubview:lineView];

    }
    
    return _lineView;
}

- (NSString *)getYearLocalDateFormateUTCDate:(NSString *)utcDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}



@end
