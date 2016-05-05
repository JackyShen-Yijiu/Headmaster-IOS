//
//  JZPassRateListView.h
//  Headmaster
//
//  Created by ytzhang on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "RefreshTableView.h"
#import "TTRefreshFooter.h"

@protocol ShowNoDataBG <NSObject>

- (void)initWithDataSearchType:(kDateSearchSubjectID)dataSearchSubjectID;

@end

@interface JZPassRateListView : TTRefreshFooter


@property (nonatomic, strong) UIViewController *parementVC;

@property (nonatomic, assign) kDateSearchSubjectID searchSubjectID;

@property (nonatomic, strong) id<ShowNoDataBG> showNodataDelegate;


// 刷新数据的方法
- (void)refreshUI;

// 请求网络数据的方法
- (void)networkRequest;

// 加载更多
- (void)moreData;

@end
