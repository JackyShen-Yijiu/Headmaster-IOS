//
//  JZMailBoxView.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/10.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZMailBoxView.h"
#import "JZMailBoxHeaderView.h"
#import "JZMailboxData.h"
#import "JZMailBoxCell.h"
#import <YYModel.h>

static NSString *JZMailBoxCellID = @"JZMailBoxCellID";

@interface JZMailBoxView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) JZMailBoxHeaderView *headerView;

@end
@implementation JZMailBoxView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.frame = frame;
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = NO;
        self.backgroundColor = [UIColor orangeColor];
        
        self.sectionHeaderHeight = 10;

        self.headerView = [[JZMailBoxHeaderView alloc]initWithFrame:CGRectMake(0, 0, kJZWidth, 48)];
        self.tableHeaderView = self.headerView;

        
        [self reloadData];
        
        [self loadData];
//        [self setRefresh];
        
    }
    return self;
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [self.headerView setBadge:10];
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JZMailBoxCell *listCell = [tableView dequeueReusableCellWithIdentifier:JZMailBoxCellID];
    
    if (!listCell) {
        
        listCell = [[JZMailBoxCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JZMailBoxCellID];
        
    }
        
    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    JZMailboxData *dataModel = self.dataArr[indexPath.row];
    listCell.data = dataModel;
    
    
    return listCell;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JZMailboxData *dataModel = self.dataArr[indexPath.row];
    
    return [JZMailBoxCell cellHeightDmData:dataModel];
}
-(void)loadData {
    
    [NetworkEntity getCoachFeedbackWithUserid:[UserInfoModel defaultUserInfo].userID SchoolId:[UserInfoModel defaultUserInfo].schoolId count:10 index:1 success:^(id responseObject) {
        
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        if (type == 1) {
            NSArray *resultData = responseObject[@"data"];
            
            
            for (NSDictionary *dict in resultData) {
                
            JZMailboxData *dataModel = [JZMailboxData yy_modelWithJSON:dict];
            [self.dataArr addObject:dataModel];
                
            }
            
            [self reloadData];
            
            
            
        }else{
            
            ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"网络出错啦"];
            [alertView show];
            
        }

    } failure:^(NSError *failure) {
        ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"网络出错啦"];
        [alertView show];
        
    }];
    
   }





#pragma mark - 懒加载
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
}


@end
