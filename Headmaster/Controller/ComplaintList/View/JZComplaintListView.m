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
#import "JZComplaintListController.h"
#import "MJRefresh.h"
#import "LKNoDataView.h"
static NSString *JZComplaintCellID = @"JZComplaintCellID";

@interface JZComplaintListView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *listDataArray;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic, strong) LKNoDataView *noDataView;

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
    
    NSString *key = [NSString stringWithFormat:@"%@",dataModel.complaintid];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL isExit = [user boolForKey:key];
    listCell.badgeView.hidden = isExit;
    
    return listCell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JZComplaintComplaintlist *dataModel = self.listDataArray[indexPath.row];
    
    return [JZComplaintCell cellHeightDmData:dataModel];
}
#pragma mark - 代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    JZComplaintComplaintlist *dataModel = self.listDataArray[indexPath.row];

    NSString *key = [NSString stringWithFormat:@"%@",dataModel.complaintid];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:YES forKey:key];
    [user synchronize];

    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

    JZComplaintDetailController *complaintDetailVC = [[JZComplaintDetailController alloc]init];
    
    JZComplaintListController *JZComplaintVC  = (JZComplaintListController * )self.vc;

    complaintDetailVC.isFormSideMenu =   JZComplaintVC.isFormSideMenu;


    complaintDetailVC.dataModel = dataModel;
    
    [self.vc.myNavController pushViewController:complaintDetailVC animated:YES];
    
}
#pragma mark - 首次加载数据
-(void)loadData {
    
    [NetworkEntity getComplainListWithUserid:[UserInfoModel defaultUserInfo].userID SchoolId:[UserInfoModel defaultUserInfo].schoolId Index:1 Count:10 success:^(id responseObject) {
        
       
        
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        if (type == 1) {
            NSDictionary *resultData = responseObject[@"data"];
            self.vc.myNavigationItem.title = [NSString stringWithFormat:@"投诉(%@)",resultData[@"count"]];
            NSArray *complaintlist = resultData[@"complaintlist"];
            
            NSString *messageCount = resultData[@"count"];
            if (!messageCount.integerValue) {

                [self.noDataView removeFromSuperview];
                self.noDataView = [[LKNoDataView alloc]initWithFrame:CGRectMake(0,0, kJZWidth, kJZHeight-64)];
                self.noDataView.noDataLabel.text = @"暂时还没有收到学员投诉";
                self.noDataView.noDataImageView.image = [UIImage imageNamed:@"complaint_null"];
                [self.vc.view addSubview: self.noDataView];
  
            }else {
                [self.noDataView removeFromSuperview];

                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                // 写入
                [userDefaults setInteger:messageCount.integerValue forKey:@"JZComplainCount"];
                // 强制写入
                [userDefaults synchronize];
                
                self.index = 2;
                
                for (NSDictionary *dict in complaintlist) {
                    
                    JZComplaintComplaintlist *listModel = [JZComplaintComplaintlist yy_modelWithJSON:dict];
                    [self.listDataArray addObject:listModel];
                    
                }
                [self reloadData];
            }
            
           

            
            ///  网络出错空白图
        }else{
        
            [self.noDataView removeFromSuperview];
            self.noDataView = [[LKNoDataView alloc]initWithFrame:CGRectMake(0,0, kJZWidth, kJZHeight-64)];
            self.noDataView.noDataLabel.text = @"网络开小差了";
            self.noDataView.noDataImageView.image = [UIImage imageNamed:@"net_null"];
            [self.vc.view addSubview: self.noDataView];
    
            
        }
        ///  网络出错空白图
    } failure:^(NSError *failure) {
        [self.noDataView removeFromSuperview];
        self.noDataView = [[LKNoDataView alloc]initWithFrame:CGRectMake(0,0, kJZWidth, kJZHeight-64)];
        self.noDataView.noDataLabel.text = @"网络开小差了";
        self.noDataView.noDataImageView.image = [UIImage imageNamed:@"net_null"];
        [self.vc.view addSubview: self.noDataView];
        
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
    
    [NetworkEntity getComplainListWithUserid:[UserInfoModel defaultUserInfo].userID SchoolId:[UserInfoModel defaultUserInfo].schoolId Index:self.index Count:10 success:^(id responseObject) {

        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        if (type == 1) {
            NSDictionary *resultData = responseObject[@"data"];
            
            NSArray *complaintlist = resultData[@"complaintlist"];
            
            self.index ++;
            if (!complaintlist.count) {
                
                [self.refreshFooter endRefreshing];
                self.refreshFooter.scrollView = nil;
                self.refreshFooter.headerLabel.text = @"";
                [self.refreshFooter.headerLabel removeFromSuperview];

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


