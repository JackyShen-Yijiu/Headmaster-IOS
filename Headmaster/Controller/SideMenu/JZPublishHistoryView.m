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
static NSString *JZPublishHistoryCellID = @"JZPublishHistoryCellID";
@interface JZPublishHistoryView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *listDataArray;

@end

@implementation JZPublishHistoryView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        
        self.dataSource = self;
        
        self.delegate = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;

        
//        [self addBackgroundImage];
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
    
   listCell.selectionStyle = UITableViewCellSelectionStyleGray;

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
            
            UIView *noDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kJZWidth, kJZHeight-64)];
            
            noDataView.backgroundColor =  RGB_Color(239, 239, 244);
            [self.vc.view addSubview:noDataView];
            self.userInteractionEnabled = NO;
            
            UIImageView *noDataImg = [[UIImageView alloc]init];
            noDataImg.image = [UIImage imageNamed:@"announcement_null"];
            [noDataView addSubview:noDataImg];
            
            [noDataImg mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerX.equalTo(noDataView.mas_centerX);
                make.centerY.equalTo(noDataView.mas_centerY).offset(-24-44);
                
            }];
            UILabel *noDataLabel = [[UILabel alloc]init];
            noDataLabel.text = @"暂时还没有驾校公告";
            noDataLabel.font = [UIFont systemFontOfSize:14];
            noDataLabel.textColor = kJZLightTextColor;
            [noDataView addSubview:noDataLabel];
            
            [noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(noDataImg.mas_bottom).offset(24);
                make.centerX.equalTo(noDataView.mas_centerX);
                
            }];
  
  
        }
        
        if ([[dataDic objectForKey:@"type"] integerValue]) {
          NSArray *array = resultData;
            for (NSDictionary *dict in array) {
                
                JZPublishHistoryData *listModel = [JZPublishHistoryData yy_modelWithDictionary:dict];
                
                [self.listDataArray addObject:listModel];
            }
            
            [self reloadData];
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
        
        
    }];

    
}


-(NSMutableArray *)listDataArray {
    
    if (!_listDataArray) {
        
        _listDataArray = [[NSMutableArray alloc]init];
    }
    
    return _listDataArray;
}

//#pragma mark - 背景图片
//- (void)addBackgroundImage {
//    
//    UIImage *image = [UIImage imageNamed:@"controllerBackground"];
//    self.layer.contents = (id)image.CGImage;
//}


@end