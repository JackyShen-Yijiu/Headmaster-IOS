//
//  ApplyStuentListModel.h
//  Headmaster
//
//  Created by ytzhang on 15/12/6.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplyStuentListModel : NSObject

/*
 "applystuentlist": [
 {
 "hour": "int,小时",
 "applystudentcount": "int,申请学生数量"
 }
 ],
 
*/

@property (nonatomic,strong) NSArray *applyStuentListArray;
@property (nonatomic,strong) NSString *hour;
@property (nonatomic,strong) NSString *applystudentcount;

@end
