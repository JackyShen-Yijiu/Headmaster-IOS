//
//  ComplaintListModel.h
//  Headmaster
//
//  Created by ytzhang on 15/12/6.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComplaintListModel : NSObject
/*
 "complaintlist": [
 {
 "hour": "int,小时",
 "complaintcount": "int,投诉数量"
 }
 */
@property (nonatomic,strong) NSArray *complaintlistListArray;
@property (nonatomic,strong) NSString *hour;
@property (nonatomic,strong) NSString *commnetcount;
@end
