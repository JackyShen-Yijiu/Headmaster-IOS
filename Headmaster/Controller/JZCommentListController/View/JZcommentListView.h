//
//  JZcommentListView.h
//  Headmaster
//
//  Created by ytzhang on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "TTRefreshFooter.h"

@protocol ShowNoDataBG <NSObject>

- (void)initWithDataSearchType:(kCommentDateSearchType)commentDateSearchType;

@end

@interface JZcommentListView : TTRefreshFooter


@property (nonatomic, strong) UIViewController *parementVC;

@property (nonatomic, assign) kCommentDateSearchType commentDateSearchType;

@property (nonatomic, strong) id<ShowNoDataBG> showNodataDelegate;


// 刷新数据的方法
- (void)refreshUI;

// 请求网络数据的方法
- (void)networkRequest;

// 加载更多
- (void)moreData;

@end
