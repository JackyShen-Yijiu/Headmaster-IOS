//
//  ReservationStudentListModel.h
//  Headmaster
//
//  Created by ytzhang on 15/12/6.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReservationStudentListModel : NSObject


/*
 "reservationstudentlist": [
 {
 "hour": "int,小时",
 "studentcount": "int,预约学生数量"
 }
 ],
 */
 
@property (nonatomic,strong) NSArray *ReservationStudentlistArray;
@property (nonatomic,strong) NSString *hour;
@property (nonatomic,strong) NSString *studentcount;
@end
