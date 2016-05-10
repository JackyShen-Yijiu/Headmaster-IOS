//
//  JZPassRateListModel.h
//  Headmaster
//
//  Created by ytzhang on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZPassRateListModel : NSObject
/*
 
 {
 "type": 1,
 "msg": "",
 "data": [
 {
 "examdate": "2016-5-16",
 "subject": "2",
 "studentcount": 3,
 "passstudent": 3,
 "nopassstudent": 0,
 "missexamstudent": 0,
 "passrate": 1
 }
 ]
 }
 */
@property (nonatomic, strong) NSString *examdate;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, assign) NSInteger studentcount;
@property (nonatomic, assign) NSInteger passstudent;
@property (nonatomic, assign) NSInteger nopassstudent;
@property (nonatomic, assign) NSInteger missexamstudent;
@property (nonatomic, assign) NSInteger passrate;




@end
