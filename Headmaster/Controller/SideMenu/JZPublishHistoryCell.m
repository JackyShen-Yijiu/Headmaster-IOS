//
//  JZPublishHistoryCell.m
//  Headmaster
//
//  Created by 雷凯 on 16/4/19.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZPublishHistoryCell.h"
#import "JZPublishHistoryData.h"
#import "NSString+LKString.h"
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

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.mainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).offset(24);// 24
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.height.equalTo(@16);
        
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mainTitleLabel.mas_bottom).offset(12);// 12
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.height.equalTo(@12);
        
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mainTitleLabel.mas_bottom).offset(12);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.height.equalTo(@12);
        
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.timeLabel.mas_bottom).offset(10);// 10
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        
    }];
    
    [self.linView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    

}

-(void)setData:(JZPublishHistoryData *)data {
    
    _data = data;
    
    NSString *titleStr = @"无标题";

    if (_data.title && [_data.title length]!=0) {
        titleStr = _data.title;
    }
    
    self.mainTitleLabel.text = titleStr;
    
    NSLog(@"_data.content:(%@)",_data.content);
          
    self.timeLabel.text = [NSString getYearLocalDateFormateUTCDate:_data.createtime style:LKDateStyleNoHaveTime];
    
 
    self.contentLabel.text = _data.content;
    
    if (_data.name && _data.name.length) {
      self.nameLabel.text = [NSString stringWithFormat:@"发布者: %@",_data.name];
    }else {
        self.nameLabel.text = @"发布者: 未知";
    }
    

}

+ (CGFloat)cellHeightDmData:(JZPublishHistoryData *)dmData
{
    
    JZPublishHistoryCell *cell = [[JZPublishHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JZPublishHistoryCellID"];
    
    cell.data = dmData;
    
    [cell layoutIfNeeded];

    
    return cell.timeLabel.height + cell.mainTitleLabel.height + cell.contentLabel.height + 0.5 + 70;
    
}




@end
