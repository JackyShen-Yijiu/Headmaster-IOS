//
//  NSString+LKString.h
//  Headmaster
//
//  Created by 雷凯 on 16/5/19.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LKDateStyle){
    LKDateStyleDefault = 0,
    LKDateStyleNoHaveYear = 1,
    LKDateStyleNoHaveTime = 2
};

@interface NSString (LKString)
+ (NSString *)getYearLocalDateFormateUTCDate:(NSString *)utcDate style:(LKDateStyle)dataStyle;
@end
