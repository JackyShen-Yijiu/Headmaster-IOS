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

        
        [self addBackgroundImage];
        [self loadData];
        

        
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
        listCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        listCell.backgroundColor = [UIColor clearColor];

    }

    JZPublishHistoryData *dataModel = self.listDataArray[indexPath.row];
    listCell.data = dataModel;
    
    return listCell;
    
}
#pragma mark - 代理
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JZPublishHistoryData *dataModel = self.listDataArray[indexPath.row];
    return [JZPublishHistoryCell cellHeightDmData:dataModel];
    
}

-(void)loadData {
    

    [NetworkEntity getPublishListWithUseInfoModel:[UserInfoModel defaultUserInfo]  seqindex:[NSString stringWithFormat:@"0"] count:[NSString stringWithFormat:@"10"] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSArray *resultData = dataDic[@"data"];
        
        
        if ([[dataDic objectForKey:@"type"] integerValue]) {
          NSArray *array = resultData;
            for (NSDictionary *dict in array) {
                
                JZPublishHistoryData *listModel = [JZPublishHistoryData yy_modelWithDictionary:dict];
                
                [self.listDataArray addObject:listModel];
            }
            
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

#pragma mark - 背景图片
- (void)addBackgroundImage {
    
    UIImage *image = [UIImage imageNamed:@"controllerBackground"];
    self.layer.contents = (id)image.CGImage;
}


@end