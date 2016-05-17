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
                
                UIView *noDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 55.2+32, kJZWidth, kJZHeight-55.2-32)];
                
                noDataView.backgroundColor =  RGB_Color(239, 239, 244);
                [self.vc.view addSubview:noDataView];
                self.userInteractionEnabled = NO;
                
                UIImageView *noDataImg = [[UIImageView alloc]init];
                noDataImg.image = [UIImage imageNamed:@"message_null"];
                [noDataView addSubview:noDataImg];
                
                [noDataImg mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.centerX.equalTo(noDataView.mas_centerX);
                    make.centerY.equalTo(noDataView.mas_centerY).offset(-44-44-24);
                    
                }];
                UILabel *noDataLabel = [[UILabel alloc]init];
                noDataLabel.text = @"暂时没有反馈消息";
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
            
            for (NSDictionary *dict in resultData) {
                
            JZMailboxData *dataModel = [JZMailboxData yy_modelWithJSON:dict];
            [self.dataArr addObject:dataModel];
                
            }
            
            [self reloadData];
            
            
            
        }else{
            
            UIView *noDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 55.2+32, kJZWidth, kJZHeight-55.2-32)];
            
            noDataView.backgroundColor =  RGB_Color(239, 239, 244);
            [self.vc.view addSubview:noDataView];
            self.userInteractionEnabled = NO;
            
            UIImageView *noDataImg = [[UIImageView alloc]init];
            noDataImg.image = [UIImage imageNamed:@"net_null"];
            [noDataView addSubview:noDataImg];
            
            [noDataImg mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerX.equalTo(noDataView.mas_centerX);
                make.centerY.equalTo(noDataView.mas_centerY).offset(-44-44-24);
                
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

    } failure:^(NSError *failure) {
        UIView *noDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 55.2+32, kJZWidth, kJZHeight-55.2-32)];
        
        noDataView.backgroundColor =  RGB_Color(239, 239, 244);
        [self.vc.view addSubview:noDataView];
        self.userInteractionEnabled = NO;
        
        UIImageView *noDataImg = [[UIImageView alloc]init];
        noDataImg.image = [UIImage imageNamed:@"net_null"];
        [noDataView addSubview:noDataImg];
        
        [noDataImg mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(noDataView.mas_centerX);
            make.centerY.equalTo(noDataView.mas_centerY).offset(-44-44-24);
            
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
-(void)loadMoreData {
    static NSInteger index = 2;

    [NetworkEntity getCoachFeedbackWithUserid:[UserInfoModel defaultUserInfo].userID SchoolId:[UserInfoModel defaultUserInfo].schoolId count:10 index:index success:^(id responseObject) {
        
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        if (type == 1) {
            NSArray *resultData = responseObject[@"data"];
            index ++;
            if (!resultData.count) {
                
                [self.refreshFooter endRefreshing];
                self.refreshFooter.scrollView = nil;
                self.refreshFooter.headerLabel.text = @"";
                [self.refreshFooter.headerLabel removeFromSuperview];

                [self.vc showTotasViewWithMes:@"已经加载所有数据"];
                return;
                
            }
            
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
