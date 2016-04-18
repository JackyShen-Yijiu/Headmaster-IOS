//
//  GeneralCommentListModel.h
//  Headmaster
//
//  Created by ytzhang on 15/12/6.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeneralCommentListModel : NSObject
/*
 "generalcommentlist": [
 {
 "hour": "int,小时",
 "commnetcount": "int,中评数量"
 }
 ],
 */
@property (nonatomic,strong) NSArray *generalCommentListArray;
@property (nonatomic,strong) NSString *hour;
@property (nonatomic,strong) NSString *commnetcount;

@end
