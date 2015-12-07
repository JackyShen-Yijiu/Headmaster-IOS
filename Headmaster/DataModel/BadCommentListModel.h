//
//  BadCommentListModel.h
//  Headmaster
//
//  Created by ytzhang on 15/12/6.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BadCommentListModel : NSObject
/*
 "badcommentlist": [
 {
 "hour": "int,小时",
 "commnetcount": "int,差评数量"
 }
 ],
 */
@property (nonatomic,strong) NSArray *badCommentListArray;
@property (nonatomic,strong) NSString *hour;
@property (nonatomic,strong) NSString *commnetcount;

@end
