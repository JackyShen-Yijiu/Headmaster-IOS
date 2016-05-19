//
//  NSString+LKString.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/19.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "NSString+LKString.h"


@implementation NSString (LKString)
+ (NSString *)getYearLocalDateFormateUTCDate:(NSString *)utcDate style:(LKDateStyle)dataStyle{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    switch (dataStyle) {
        case 0:
            [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
            break;
        case 1:
            [dateFormatter setDateFormat:@"MM/dd HH:mm"];
            break;
        case 2:
            [dateFormatter setDateFormat:@"yyyy/MM/dd"];

            break;
            
        default:
            break;
    }
    //输出格式
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}
@end
