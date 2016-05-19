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
#import "JZPublishHistoryController.h"
#import "JZCoachFeedbackController.h"
#import "LKNoDataView.h"

static NSString *JZMailBoxCellID = @"JZMailBoxCellID";

@interface JZMailBoxView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) JZMailBoxHeaderView *headerView;

@property (nonatomic, strong) LKNoDataView *noDataView;

@property (nonatomic, assign) NSInteger index;



@end
@implementation JZMailBoxView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.frame = frame;
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = NO;
//        self.backgroundColor = [UIColor orangeColor];
        
//        self.sectionHeaderHeight = 10;

//        self.headerView = [[JZMailBoxHeaderView alloc]initWithFrame:CGRectMake(0, 0, kJZWidth, 48)];
        
//        UITapGestureRecognizer *tapGestureTel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerViewClick:)];
//        self.headerView.userInteractionEnabled = YES;
//        [self.headerView addGestureRecognizer:tapGestureTel];
//        self.tableHeaderView = self.headerView;

        
        
        [self reloadData];
        
        [self loadData];
        [self setRefresh];
        
    }
    return self;
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    [self.headerView setBadge:10];
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
    
    
    
    NSString *key = [NSString stringWithFormat:@"%@",dataModel._id];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL isExit = [user boolForKey:key];
    listCell.badgeView.hidden = isExit;
    
    if (dataModel.replyflag) {
        
        listCell.badgeView.hidden = YES;
        
    }
    
   
    return listCell;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JZMailboxData *dataModel = self.dataArr[indexPath.row];
    
    return [JZMailBoxCell cellHeightDmData:dataModel];
    

}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"教练反馈";

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32;
}


#pragma mark - 代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    JZMailboxData *dataModel = self.dataArr[indexPath.row];
    
    NSString *key = [NSString stringWithFormat:@"%@",dataModel._id];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:YES forKey:key];
    [user synchronize];
    
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

    
    JZCoachFeedbackController *feedbackVC = [JZCoachFeedbackController new];
    
    feedbackVC.dataModel = dataModel;
    
    feedbackVC.index = indexPath.row;
    
    [self.vc.navigationController pushViewController:feedbackVC animated:YES];
    
}
//#pragma mark - headerView点击事件
//-(void)headerViewClick:(UITapGestureRecognizer *)recognizer {
//    
//    JZPublishHistoryController *publishVC = [[JZPublishHistoryController alloc]init];
//    
//    [self.vc.myNavController pushViewController:publishVC animated:YES];
//    
//    
//}


-(void)loadData {
    
    [NetworkEntity getCoachFeedbackWithUserid:[UserInfoModel defaultUserInfo].userID SchoolId:[UserInfoModel defaultUserInfo].schoolId count:10 index:1 success:^(id responseObject) {
        
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        if (type == 1) {
            NSArray *resultData = responseObject[@"data"];
            
            //暂无数据空白图
            if (!resultData.count) {

                [self.noDataView removeFromSuperview];
                self.noDataView = [[LKNoDataView alloc]initWithFrame:CGRectMake(0,44+32, kJZWidth, kJZHeight-64) andNoDataLabelText:@"暂时没有反馈消息" andNoDataImgName:@"message_null"];
                if (YBIphone6Plus) {
                   self.noDataView.frame =  CGRectMake(0,(44+32)*YBRatio, kJZWidth, kJZHeight-64);
                }
                
                self.noDataView.backgroundColor = RGB_Color(239, 239, 244);
                
                [self.vc.view addSubview: self.noDataView];
                
                [self.noDataView.noDataImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(self.mas_centerY).offset(-60-28-44*YBRatio);
                    make.centerX.equalTo(self.mas_centerX);
                    
                }];

            }else {
                [self.noDataView removeFromSuperview];
                self.index = 2;
                for (NSDictionary *dict in resultData) {
                    
                    JZMailboxData *dataModel = [JZMailboxData yy_modelWithJSON:dict];
                    [self.dataArr addObject:dataModel];
                    
                }
                
                [self reloadData];

            }
            
            
            
            
        }else{
            
            
            [self.noDataView removeFromSuperview];
            self.noDataView = [[LKNoDataView alloc]initWithFrame:CGRectMake(0,44+32, kJZWidth, kJZHeight-64) andNoDataLabelText:@"网络开小差了" andNoDataImgName:@"net_null"];
            if (YBIphone6Plus) {
                self.noDataView.frame =  CGRectMake(0,(44+32)*YBRatio, kJZWidth, kJZHeight-64);
            }
            self.noDataView.backgroundColor = RGB_Color(239, 239, 244);
            
            [self.vc.view addSubview: self.noDataView];
            
            [self.noDataView.noDataImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(self.mas_centerY).offset(-60-28-44*YBRatio);
                make.centerX.equalTo(self.mas_centerX);
                
            }];
            
            
        }

    } failure:^(NSError *failure) {
        
        
        [self.noDataView removeFromSuperview];
        self.noDataView = [[LKNoDataView alloc]init];
        if (YBIphone6Plus) {
            self.noDataView.frame =  CGRectMake(0,(44+32)*YBRatio, kJZWidth, kJZHeight-64);
            
            
        }else {
            self.noDataView.frame =  CGRectMake(0,44+32, kJZWidth, kJZHeight-64);
            
        }

        [self.noDataView removeFromSuperview];
        self.noDataView = [[LKNoDataView alloc]initWithFrame:CGRectMake(0,44+32, kJZWidth, kJZHeight-64) andNoDataLabelText:@"网络开小差了" andNoDataImgName:@"net_null"];
        if (YBIphone6Plus) {
            self.noDataView.frame =  CGRectMake(0,(44+32)*YBRatio, kJZWidth, kJZHeight-64);
        }
        self.noDataView.backgroundColor = RGB_Color(239, 239, 244);
        
        [self.vc.view addSubview: self.noDataView];
        
        [self.noDataView.noDataImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_centerY).offset(-60-28-44*YBRatio);
            make.centerX.equalTo(self.mas_centerX);
            
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
-(void)loadMoreData {
    

    [NetworkEntity getCoachFeedbackWithUserid:[UserInfoModel defaultUserInfo].userID SchoolId:[UserInfoModel defaultUserInfo].schoolId count:10 index:self.index success:^(id responseObject) {
        
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        if (type == 1) {
            NSArray *resultData = responseObject[@"data"];
           
            if (!resultData.count) {
                
                [self.refreshFooter endRefreshing];
                self.refreshFooter.scrollView = nil;
                self.refreshFooter.headerLabel.text = @"";
                [self.refreshFooter.headerLabel removeFromSuperview];

                [self.vc showTotasViewWithMes:@"已经加载所有数据"];
                return;
                
            }
            self.index ++;
            for (NSDictionary *dict in resultData) {
                
                JZMailboxData *dataModel = [JZMailboxData yy_modelWithJSON:dict];
                [self.dataArr addObject:dataModel];
                
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
        
    }];}


#pragma mark - 懒加载
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
}



@end
