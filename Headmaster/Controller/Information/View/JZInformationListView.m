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
#import "SDCycleScrollView.h"
#import "InformationDetailController.h"
#import "LKNoDataView.h"
static NSString *JZInformationListCellID = @"JZInformationListCellID";

@interface JZInformationListView ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *listDataArray;
@property (nonatomic, strong) NSMutableArray *imagesURLStrings;
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *topDataArr;
@property (nonatomic, strong) LKNoDataView *noDataView;


@end
@implementation JZInformationListView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.frame = frame;
        
        self.dataSource = self;
        
        self.delegate = self;
        
        self.rowHeight = 108;
        
        self.separatorStyle = NO;
        
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
    
    JZInformationListCell *listCell = [tableView dequeueReusableCellWithIdentifier:JZInformationListCellID];
    
    if (!listCell) {
        
        listCell = [[JZInformationListCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JZInformationListCellID];
    }
    
    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    JZInformationData *dataModel = self.listDataArray[indexPath.row];
    listCell.data = dataModel;
    
    
    return listCell;
    
}

#pragma mark - 代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InformationDetailController *detailsVC = [InformationDetailController new];
    JZInformationData *dataModel = self.listDataArray[indexPath.row];
    detailsVC.urlStr = dataModel.contenturl;
    detailsVC.navTitle = dataModel.title;
    [self.vc.navigationController pushViewController:detailsVC animated:YES];
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    InformationDetailController *detailsVC = [InformationDetailController new];
    JZInformationData *dataModel = self.topDataArr[index];
    detailsVC.urlStr = dataModel.contenturl;
    detailsVC.navTitle = dataModel.title;
    [self.vc.navigationController pushViewController:detailsVC animated:YES];
}

-(void)loadData {
    
    
    static NSInteger index = 0;
    
    [NetworkEntity informationListWithseqindex:0 count:10 success:^(id responseObject) {
        [self.noDataView removeFromSuperview];

        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        
        if (type) {
            
            NSArray *data = [responseObject objectForKey:@"data"];
            
            if (data) {
                
                for (NSDictionary  *dict in data) {
                    JZInformationData *listModel = [JZInformationData yy_modelWithJSON:dict];

                    if (index<3) {
                        [self.imagesURLStrings addObject:listModel.logimg];
                        [self.titles addObject:listModel.title];
                        [self.topDataArr addObject:listModel];
                        
                    }else {
                       [self.listDataArray addObject:listModel];
                    }
                    index ++;
                    
                }
                //创建带标题的图片轮播器
                SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, kJZWidth, 160) delegate:self placeholderImage:[UIImage imageNamed:@"pic_load"]];
                cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
                cycleScrollView.titleLabelTextFont = [UIFont systemFontOfSize:14];
                cycleScrollView.titlesGroup = self.titles;
                cycleScrollView.imageURLStringsGroup = self.imagesURLStrings;
                ///  图片填充方式
                cycleScrollView.bannerImageViewContentMode = 2;
                // 自定义分页控件小圆标颜色
                cycleScrollView.currentPageDotColor = [UIColor whiteColor];
               
                if (YBIphone6Plus) {
                    
                    cycleScrollView.frame = CGRectMake(0,0, kJZWidth, 160*YBRatio);
                    cycleScrollView.titleLabelTextFont = [UIFont systemFontOfSize:14*YBRatio];

                }
                
                self.tableHeaderView = cycleScrollView;
                [self reloadData];
                
                
            }else {
                [self.noDataView removeFromSuperview];

                ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"暂无资讯"];
                [alertView show];
                
            }
            
        }else {
            
            [self.noDataView removeFromSuperview];

            ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"网络出错啦"];
            [alertView show];
        }
        
        
        
        
    } failure:^(NSError *failure) {
        
        [self.noDataView removeFromSuperview];
        self.noDataView = [[LKNoDataView alloc]init];
   
        self.noDataView.frame =  CGRectMake(0,0, kJZWidth, kJZHeight-64);

        self.noDataView.backgroundColor = RGB_Color(239, 239, 244);
        
        self.noDataView.noDataLabel.text = @"网络开小差了";
        self.noDataView.noDataImageView.image = [UIImage imageNamed:@"net_null"];
        
        [self.vc.view addSubview: self.noDataView];
        
        [self.noDataView.noDataImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_centerY).offset(-60-28);
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
    
    JZInformationData *dataModel = self.listDataArray.lastObject;
    
    [NetworkEntity informationListWithseqindex:dataModel.seqindex count:10 success:^(id responseObject) {
        
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        
        if (type) {
            
            NSArray *data = [responseObject objectForKey:@"data"];
            
            if (data) {
                
                if (!data.count) {
                    
                    [self.refreshFooter endRefreshing];
                    self.refreshFooter.headerLabel.text = @"";
                    [self.refreshFooter.headerLabel removeFromSuperview];

                    self.refreshFooter.scrollView = nil;
                    [self.vc showTotasViewWithMes:@"已经加载所有数据"];
                    return;
                    
                }
                
                for (NSDictionary  *dict in data) {
                    JZInformationData *listModel = [JZInformationData yy_modelWithJSON:dict];
                    [self.listDataArray addObject:listModel];
                    
                }
                [self reloadData];
                [self.refreshFooter endRefreshing];
  
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

-(NSMutableArray *)listDataArray {
    
    if (!_listDataArray) {
        
        _listDataArray = [[NSMutableArray alloc]init];
    }
    
    return _listDataArray;
}
-(NSMutableArray *)imagesURLStrings {
    
    if (!_imagesURLStrings) {
        
        _imagesURLStrings = [[NSMutableArray alloc]init];
    }
    
    return _imagesURLStrings;
}
-(NSMutableArray *)titles {
    
    if (!_titles) {
        
        _titles = [[NSMutableArray alloc]init];
    }
    
    return _titles;
}
-(NSMutableArray *)topDataArr {
    if (!_topDataArr) {
        
        _topDataArr = [[NSMutableArray alloc]init];
    }
    
    return _topDataArr;
}

@end
