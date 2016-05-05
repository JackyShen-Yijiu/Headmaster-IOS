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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JZComplaintCell *listCell = [tableView dequeueReusableCellWithIdentifier:JZComplaintCellID];
    
    if (!listCell) {
        
        listCell = [[JZComplaintCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JZComplaintCellID];
    }
    
//    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
     JZComplaintComplaintlist *dataModel = self.listDataArray[indexPath.row];
        listCell.data = dataModel;

    
    return listCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JZComplaintComplaintlist *dataModel = self.listDataArray[indexPath.row];
    
    return [JZComplaintCell cellHeightDmData:dataModel];
}

-(void)loadData {
    
    [NetworkEntity getComplainListWithUserid:[UserInfoModel defaultUserInfo].userID SchoolId:[UserInfoModel defaultUserInfo].schoolId Index:1 Count:10 success:^(id responseObject) {
        
        
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        if (type == 1) {
            NSDictionary *resultData = responseObject[@"data"];
            
            NSArray *complaintlist = resultData[@"complaintlist"];
            
            
            
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

-(void)setRefresh {
    
    WS(ws);
    
    self.refreshFooter.beginRefreshingBlock = ^{
        [ws loadMoreData];
    };
    
    self.refreshHeader = nil;
    
    
}
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


