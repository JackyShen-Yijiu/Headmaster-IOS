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
static NSString *JZComplaintCellID = @"JZComplaintCellID";

@interface JZComplaintListView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *listDataArray;
@property (nonatomic,assign) NSInteger index;
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
    complaintDetailVC.dataModel = dataModel;
    
    [self.vc.navigationController pushViewController:complaintDetailVC animated:YES];
    
}
#pragma mark - 首次加载数据
-(void)loadData {
    
    [NetworkEntity getComplainListWithUserid:[UserInfoModel defaultUserInfo].userID SchoolId:[UserInfoModel defaultUserInfo].schoolId Index:1 Count:10 success:^(id responseObject) {
        
       
        
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        if (type == 1) {
            NSDictionary *resultData = responseObject[@"data"];
            self.vc.title = [NSString stringWithFormat:@"投诉(%@)",resultData[@"count"]];
            NSArray *complaintlist = resultData[@"complaintlist"];
            
            NSString *messageCount = resultData[@"count"];
            if (!messageCount.integerValue) {
                
                UIView *noDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kJZWidth, kJZHeight-64)];
                
                noDataView.backgroundColor =  RGB_Color(239, 239, 244);
                [self.vc.view addSubview:noDataView];
                self.userInteractionEnabled = NO;
                
                UIImageView *noDataImg = [[UIImageView alloc]init];
                noDataImg.image = [UIImage imageNamed:@"complaint_null"];
                [noDataView addSubview:noDataImg];
                
                [noDataImg mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.centerX.equalTo(noDataView.mas_centerX);
                    make.centerY.equalTo(noDataView.mas_centerY).offset(-24-44);
                    
                }];
                UILabel *noDataLabel = [[UILabel alloc]init];
                noDataLabel.text = @"暂时还没有收到学员投诉";
                if (YBIphone6Plus) {
                    noDataLabel.font = [UIFont systemFontOfSize:14*YBRatio];
                    
                }else {
                    noDataLabel.font = [UIFont systemFontOfSize:14];
                    
                }
                noDataLabel.textColor = kJZLightTextColor;
                [noDataView addSubview:noDataLabel];
                
                [noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(noDataImg.mas_bottom).offset(24);
                    make.centerX.equalTo(noDataView.mas_centerX);
                    
                }];


                
            }
            
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

            
            ///  网络出错空白图
        }else{
        
            UIView *noDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kJZWidth, kJZHeight-64)];
            
            noDataView.backgroundColor =  RGB_Color(239, 239, 244);
            [self.vc.view addSubview:noDataView];
            self.userInteractionEnabled = NO;
            
            UIImageView *noDataImg = [[UIImageView alloc]init];
            noDataImg.image = [UIImage imageNamed:@"net_null"];
            [noDataView addSubview:noDataImg];
            
            [noDataImg mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerX.equalTo(noDataView.mas_centerX);
                make.centerY.equalTo(noDataView.mas_centerY).offset(-24-44);
                
            }];
            UILabel *noDataLabel = [[UILabel alloc]init];
            noDataLabel.text = @"网络开小差了";
            if (YBIphone6Plus) {
                noDataLabel.font = [UIFont systemFontOfSize:14*YBRatio];
                
            }else {
                noDataLabel.font = [UIFont systemFontOfSize:14];
                
            }
            noDataLabel.textColor = kJZLightTextColor;
            [noDataView addSubview:noDataLabel];
            
            [noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(noDataImg.mas_bottom).offset(24);
                make.centerX.equalTo(noDataView.mas_centerX);
                
            }];

            
        }
        ///  网络出错空白图
    } failure:^(NSError *failure) {
        UIView *noDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kJZWidth, kJZHeight-64)];
        
        noDataView.backgroundColor =  RGB_Color(239, 239, 244);
        [self.vc.view addSubview:noDataView];
        self.userInteractionEnabled = NO;
        
        UIImageView *noDataImg = [[UIImageView alloc]init];
        noDataImg.image = [UIImage imageNamed:@"net_null"];
        [noDataView addSubview:noDataImg];
        
        [noDataImg mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(noDataView.mas_centerX);
            make.centerY.equalTo(noDataView.mas_centerY).offset(-24-44);
            
        }];
        UILabel *noDataLabel = [[UILabel alloc]init];
        noDataLabel.text = @"网络开小差了";
        if (YBIphone6Plus) {
            noDataLabel.font = [UIFont systemFontOfSize:14*YBRatio];
            
        }else {
            noDataLabel.font = [UIFont systemFontOfSize:14];
            
        }
        noDataLabel.textColor = kJZLightTextColor;
        [noDataView addSubview:noDataLabel];
        
        [noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(noDataImg.mas_bottom).offset(24);
            make.centerX.equalTo(noDataView.mas_centerX);
            
        }];
        
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


