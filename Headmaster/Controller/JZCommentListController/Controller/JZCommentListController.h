//
//  JZCommentListController.h
//  Headmaster
//
//  Created by ytzhang on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZCommentListController : UIViewController

@property (nonatomic, assign) KCommnetLevel commentLevel; // 评价等级

@property (nonatomic, assign) kCommentDateSearchType commnentDateSearchType; // 评论时间段

- (void)loadNetworkData; // 数据刷新

@end
