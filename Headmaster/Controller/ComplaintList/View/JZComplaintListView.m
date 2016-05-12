//
//  JZComplaintListView.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZComplaintListView.h"
#import "JZComplaintCell.h"
#import "JZComplaintComplaintlist.h"
#import <YYModel.h>
#import "RefreshTableView.h"
#import "JZComplaintDetailController.h"

static NSString *JZComplaintCellID = @"JZComplaintCell";

@interface JZComplaintListView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *listDataArray;

@end

@implementation JZComplaintListView
-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        
        self.dataSource = self;
        
        self.delegate = self;
        
        
        [self loadData];
        [self setRefresh];

        
    }
    return self;
    
}
#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JZComplaintCell *listCell = [tableView dequeueReusableCellWithIdentifier:JZComplaintCellID];
    
    if (!listCell) {
        
        listCell = [[JZComplaintCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JZComplaintCellID];
    }
    
    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
     JZComplaintComplaintlist *dataModel = self.listDataArray[indexPath.row];
    
    
        listCell.data = dataModel;

    
    return listCell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JZComplaintComplaintlist *dataModel = self.listDataArray[indexPath.row];
    
    return [JZComplaintCell cellHeightDmData:dataModel];
}
#pragma mark - 代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JZComplaintDetailController *complaintDetailVC = [[JZComplaintDetailController alloc]init];
   
    JZComplaintComplaintlist *dataModel = self.listDataArray[indexPath.row];

    complaintDetailVC.dataModel = dataModel;
    
    [self.vc.myNavController pushViewController:complaintDetailVC animated:YES];
    
}
#pragma mark - 首次加载数据
-(void)loadData {
    
    [NetworkEntity getComplainListWithUserid:[UserInfoModel defaultUserInfo].userID SchoolId:[UserInfoModel defaultUserInfo].schoolId Index:1 Count:10 success:^(id responseObject) {
        
        
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        if (type == 1) {
            NSDictionary *resultData = responseObject[@"data"];
            
            NSArray *complaintlist = resultData[@"complaintlist"];
            
            NSString *messageCount = resultData[@"count"];
            
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                // 写入
            [userDefaults setInteger:messageCount.integerValue forKey:@"JZComplainCount"];
                // 强制写入
            [userDefaults synchronize];

            
            for (NSDictionary *dict in complaintlist) {
                
                JZComplaintComplaintlist *listModel = [JZComplaintComplaintlist yy_modelWithJSON:dict];
                [self.listDataArray addObject:listModel];

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
#pragma mark - 下拉刷新
-(void)setRefresh {
    
    WS(ws);
    
    self.refreshFooter.beginRefreshingBlock = ^{
        [ws loadMoreData];
    };
    
    self.refreshHeader = nil;
    
    
}
#pragma mark - 下拉加载的数据
-(void)loadMoreData {
    
    static NSInteger index = 2;

    
    [NetworkEntity getComplainListWithUserid:[UserInfoModel defaultUserInfo].userID SchoolId:[UserInfoModel defaultUserInfo].schoolId Index:index Count:10 success:^(id responseObject) {
        


        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        if (type == 1) {
            NSDictionary *resultData = responseObject[@"data"];
            
            NSArray *complaintlist = resultData[@"complaintlist"];
            
            index ++;
            if (!complaintlist.count) {
                
                [self.refreshFooter endRefreshing];
                self.refreshFooter.scrollView = nil;
                [self.vc showTotasViewWithMes:@"已经加载所有数据"];
                return;
                
            }
            
            for (NSDictionary *dict in complaintlist) {
                
                JZComplaintComplaintlist *listModel = [JZComplaintComplaintlist yy_modelWithJSON:dict];
                [self.listDataArray addObject:listModel];
                
            }
            [self reloadData];
            [self.refreshFooter endRefreshing];

            
            
            
        }else{
            
            ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"网络出错啦"];
            [alertView show];
            
        }
        
    } failure:^(NSError *failure) {
        ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"网络出错啦"];
        [alertView show];
        
    }];

    
}



-(NSMutableArray *)listDataArray {
    
    if (!_listDataArray) {
        
        _listDataArray = [[NSMutableArray alloc]init];
    }
    
    return _listDataArray;
}

@end


