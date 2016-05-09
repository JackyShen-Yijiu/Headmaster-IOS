//
//  JZInformationListView.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/6.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZInformationListView.h"
#import "JZInformationListCell.h"
#import "JZInformationData.h"
#import <YYModel.h>

static NSString *JZInformationListCellID = @"JZInformationListCellID";

@interface JZInformationListView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *listDataArray;

@end
@implementation JZInformationListView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    if (self = [super initWithFrame:frame style:style]) {
        
            self.frame = frame;
            
            self.dataSource = self;
            
            self.delegate = self;
            
            self.rowHeight = 108;
            
            
            [self loadData];
            //        [self setRefresh];
            
    }
        
        return self;
    
    
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JZInformationListCell *listCell = [tableView dequeueReusableCellWithIdentifier:JZInformationListCellID];
    
    if (!listCell) {
        
        listCell = [[JZInformationListCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JZInformationListCellID];
    }
    
    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    JZInformationData *dataModel = self.listDataArray[indexPath.row];
    listCell.data = dataModel;
    
    
    return listCell;
    
}


-(void)loadData {
    
    [NetworkEntity informationListWithseqindex:0 count:10 success:^(id responseObject) {
        
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];

        if (type) {
            
            NSArray *data = [responseObject objectForKey:@"data"];
            
            if (data) {
                
            
                for (NSDictionary  *dict in data) {
                    JZInformationData *listModel = [JZInformationData yy_modelWithJSON:dict];
                    [self.listDataArray addObject:listModel];
                    
                }
                [self reloadData];
                
                
            }else {
                ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"暂无数据"];
                [alertView show];
                
            }
            
            
        }else {
            
            ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"网络出错啦"];
            [alertView show];
        }
        
        
        
        
    } failure:^(NSError *failure) {
        ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"网络出错啦"];
        [alertView show];
        
    }];
    
}
-(void)setRefresh {
    
}
-(NSMutableArray *)listDataArray {
    
    if (!_listDataArray) {
        
        _listDataArray = [[NSMutableArray alloc]init];
    }
    
    return _listDataArray;
}
@end
