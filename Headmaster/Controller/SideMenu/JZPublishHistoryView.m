//
//  JZPublishHistoryView.m
//  Headmaster
//
//  Created by 雷凯 on 16/4/19.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZPublishHistoryView.h"
#import "JZPublishHistoryCell.h"
#import "BaseModelMethod.h"
#import <YYModel.h>
#import "JZPublishHistoryData.h"
#import "LKNoDataView.h"
static NSString *JZPublishHistoryCellID = @"JZPublishHistoryCellID";
@interface JZPublishHistoryView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *listDataArray;
@property (nonatomic, strong) LKNoDataView *noDataView;

@end

@implementation JZPublishHistoryView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        
        self.dataSource = self;
        
        self.delegate = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;

        
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
    
    JZPublishHistoryCell *listCell = [tableView dequeueReusableCellWithIdentifier:JZPublishHistoryCellID];
    
    if (!listCell) {
        
        listCell = [[JZPublishHistoryCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JZPublishHistoryCellID];
        
    }

   listCell.selectionStyle = UITableViewCellSelectionStyleNone;

//    listCell.backgroundColor = [UIColor redColor];

    JZPublishHistoryData *dataModel = self.listDataArray[indexPath.row];
    
    if (indexPath.row == 0) {
        
        JZPublishHistoryData *dataModel = self.listDataArray.firstObject;
        
        self.messageCount = dataModel.seqindex;
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        // 写入
        [userDefaults setInteger:self.messageCount forKey:@"JZPublishHistoryMessageCount"];
        // 强制写入
        [userDefaults synchronize];

    }
    
    listCell.data = dataModel;
    
    return listCell;
    
}
#pragma mark - 代理
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JZPublishHistoryData *dataModel = self.listDataArray[indexPath.row];
    return [JZPublishHistoryCell cellHeightDmData:dataModel];
    
}

-(void)loadData {
    

    [NetworkEntity getPublishListWithUseInfoModel:[UserInfoModel defaultUserInfo]  seqindex:0 count:10 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSArray *resultData = dataDic[@"data"];
        if (!resultData.count) {
            
            [self.noDataView removeFromSuperview];
            self.noDataView = [[LKNoDataView alloc]initWithFrame:CGRectMake(0, 0, kJZWidth, kJZHeight-64)];
            self.noDataView.noDataLabel.text = @"暂时还没有驾校公告";
            self.noDataView.noDataImageView.image = [UIImage imageNamed:@"announcement_null"];
            [self.vc.view addSubview: self.noDataView];

        }else {
            
            [self.noDataView removeFromSuperview];

            if ([[dataDic objectForKey:@"type"] integerValue]) {
                NSArray *array = resultData;
                for (NSDictionary *dict in array) {
                    
                    JZPublishHistoryData *listModel = [JZPublishHistoryData yy_modelWithDictionary:dict];
                    
                    [self.listDataArray addObject:listModel];
                }
                
                [self reloadData];
                
                
            }

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.noDataView removeFromSuperview];
        self.noDataView = [[LKNoDataView alloc]initWithFrame:CGRectMake(0, 0, kJZWidth, kJZHeight-64)];
        self.noDataView.noDataLabel.text = @"网络开小差了";
        self.noDataView.noDataImageView.image = [UIImage imageNamed:@"net_null"];
        [self.vc.view addSubview: self.noDataView];

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
    
    
    JZPublishHistoryData *dataModel = self.listDataArray.lastObject;
    
    NSLog(@"%zd",dataModel.seqindex);
    
    [NetworkEntity getPublishListWithUseInfoModel:[UserInfoModel defaultUserInfo]  seqindex:dataModel.seqindex count:10 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSArray *resultData = dataDic[@"data"];
        if (!resultData.count) {
            
            [self.refreshFooter endRefreshing];
            self.refreshFooter.scrollView = nil;
            self.refreshFooter.headerLabel.text = @"";
            [self.refreshFooter.headerLabel removeFromSuperview];
            [self.vc showTotasViewWithMes:@"已经加载所有数据"];
            return;
            
        }

        if ([[dataDic objectForKey:@"type"] integerValue]) {
            NSArray *array = resultData;
            for (NSDictionary *dict in array) {
                
                JZPublishHistoryData *listModel = [JZPublishHistoryData yy_modelWithDictionary:dict];
                
                [self.listDataArray addObject:listModel];
            }
            
             [self.refreshFooter endRefreshing];
            [self reloadData];
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       [self.vc showTotasViewWithMes:@"网络开小差了"];
    }];

    
}


-(NSMutableArray *)listDataArray {
    
    if (!_listDataArray) {
        
        _listDataArray = [[NSMutableArray alloc]init];
    }
    
    return _listDataArray;
}




@end