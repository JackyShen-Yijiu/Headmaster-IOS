//
//  GoodCommentListModel.h
//  Headmaster
//
//  Created by ytzhang on 15/12/6.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodCommentListModel : NSObject
/*
 "goodcommentlist": [
 {
 "hour": "int,小时",
 "commnetcount": "int,好评数量"
 }
 ],
 */
@property (nonatomic,strong) NSArray *goodCommentListArray;
@property (nonatomic,strong) NSString *hour;
@property (nonatomic,strong) NSString *commnetcount;

@end
