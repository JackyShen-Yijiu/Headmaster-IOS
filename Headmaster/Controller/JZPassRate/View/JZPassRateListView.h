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

@interface JZPassRateListView : UITableView


@property (nonatomic, strong) UIViewController *parementVC;

@property (nonatomic, assign) kDateSearchSubjectID searchSubjectID;

@property (nonatomic, assign) NSInteger month;

@property (nonatomic, assign) NSInteger year;

@property (nonatomic, strong) id<ShowNoDataBG> showNodataDelegate;

@property (nonatomic, strong) NSMutableArray *timeDataArray;


// 刷新数据的方法
- (void)refreshUI;

// 请求网络数据的方法
- (void)networkRequest;

// 加载更多
- (void)moreData;

@end
