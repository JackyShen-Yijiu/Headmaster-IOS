//
//  InformationListCell.m
//  Principal
//
//  Created by dawei on 15/11/26.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import "InformationListCell.h"

@implementation InformationListCell

- (void)awakeFromNib {
    
    if (YBIphone6Plus) {
        
        self.contentLabel.font = [UIFont systemFontOfSize:14*YBRatio];
        
        self.timeLabel.font = [UIFont systemFontOfSize:14*YBRatio];
        
    }
    
    self.iconImageView.contentMode = UIViewContentModeScaleToFill;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"InformationListCell" owner:self options:nil];
        if (array.count) {
            self = array.lastObject;
        }
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)refreshData:(InformationDataModel *)dataModel {
    
    [self.iconImageView downloadImage:dataModel.logimg];
    
    self.contentLabel.text = dataModel.descriptionString;
    self.contentLabel.textColor = [UIColor colorWithHexString:@"#bfbfbf"];
    self.timeLabel.text = [[self class] getLocalDateFormateUTCDate:dataModel.createtime];
    self.timeLabel.textColor = [UIColor colorWithHexString:@"#666"];
    
}

+ (NSString *)currentDay {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}
+ (NSString *)currentTimeDay {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd/HHmmss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}

+ (NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate {
    //    NSLog(@"utc = %@",utcDate);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    
    NSString *currentTime = [[self class] currentDay];
    NSRange rang = NSMakeRange(0, 10);
    NSString *subString = [dateString substringWithRange:rang];
    if (![subString isEqualToString:currentTime]) {
        return subString;
    }else {
        //hhmmss
        NSString *nowTime = [[self class] currentTimeDay];
        NSInteger subHourTime = [[nowTime substringWithRange:NSMakeRange(10, 2)] integerValue];
        NSInteger subLastHourTime = [[dateString substringWithRange:NSMakeRange(12, 2)] integerValue];
        if (subHourTime == subLastHourTime) {
            NSInteger subMinuteTime = [[nowTime substringWithRange:NSMakeRange(10, 2)] integerValue];
            NSInteger subLastMinuteTime = [[dateString substringWithRange:NSMakeRange(12, 2)] integerValue];
            if (subMinuteTime -subLastMinuteTime == 0) {
                return @"刚刚";
            }else {
                return [NSString stringWithFormat:@"%zd分钟前",subMinuteTime-subLastMinuteTime];
            }
        }else {
            return [NSString stringWithFormat:@"%zd小时前",subHourTime - subLastHourTime];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
