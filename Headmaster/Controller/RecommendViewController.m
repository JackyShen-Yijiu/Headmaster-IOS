//
//  RecommendViewController.m
//  Headmaster
//
//  Created by kequ on 15/12/3.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "RecommendViewController.h"
#import "NetworkEntity.h"
#import "RefreshTableView.h"
#import "RecomendPieChartView.h"
#import "RecomendCell.h"
#import "ChatViewController.h"
#import "BaseModelMethod.h"
//#import "RecommendSegView.h"
#import "RecommendToolView.h"

@interface RecommendViewController ()<UITableViewDelegate,UITableViewDataSource,RecomendCellDelegate>

@property (nonatomic, strong) UIImageView * bgView;
//@property (nonatomic, strong) RecommendSegView *controlView;
@property (nonatomic, strong) RecommendToolView *toolView;

@property (nonatomic, strong) RecomendPieChartView * pieView;
//@property (nonatomic, strong) RecomendPieChartViewModel * pieModel;

@property (nonatomic, strong)RefreshTableView * tableView;
//@property (nonatomic, strong) RecomendPieChartView * pieView;

@property (nonatomic, strong)NSMutableArray * recomendData;
@property (nonatomic, strong)NSMutableArray * complainData;

@property (nonatomic, assign)BOOL isNeedRefresh;

@end

@implementation RecommendViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.isNeedRefresh = YES;
    [self initUI];
}

#pragma mark Life Sycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initNavBar];
    if(self.isNeedRefresh){
        [self.tableView.refreshHeader beginRefreshing];
    }
    self.isNeedRefresh = NO;
    
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self.isNeedRefresh){
        [self.tableView.refreshHeader beginRefreshing];
    }
    self.isNeedRefresh = NO;
}

#pragma mark - initUI

- (void)initNavBar
{
    [self resetNavBar];
    if (_commentTag == 0) {
        self.myNavigationItem.title = [NSString stringWithFormat:@"%@好评详情",[self searchTypeString]];
    }else if (_commentTag == 1)
    {
        self.myNavigationItem.title = [NSString stringWithFormat:@"%@中评详情",[self searchTypeString]];
    }else if (_commentTag == 2)
    {
        self.myNavigationItem.title = [NSString stringWithFormat:@"%@差评详情",[self searchTypeString]];
    }else if (_commentTag == 3)
    {
        self.myNavigationItem.title = [NSString stringWithFormat:@"%@投诉详情",[self searchTypeString]];
    }
    
    }

- (NSString *)searchTypeString
{
    NSString * str =  @"今日";
    switch (self.searchType) {
        case kDateSearchTypeToday:
            str = @"今日";
            break;
        case kDateSearchTypeYesterday:
            str = @"昨日";
            break;
        case kDateSearchTypeWeek:
            str = @"本周";
            break;
        case kDateSearchTypeMonth:
            str = @"本月";
            break;
        case kDateSearchTypeYear:
            str = @"本年";
            break;
    }
    return str;
}
// 返回评论类别字符串
- (NSString *)evaluateTypeString:(NSInteger)flage {
    NSString *evaluate = @"";
    switch (flage) {
        case 1:
            evaluate = @"好评";
            break;
        case 2:
            evaluate = @"中评";
            break;
        case 3:
            evaluate = @"差评";
            break;
        case 4:
            evaluate = @"投诉";
            break;
        default:
            break;
    }
    return evaluate;
}

-(void)initUI
{
    self.bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.bgView.image = [UIImage imageNamed:@"teacher_bg"];
    [self.view addSubview:self.bgView];
    
//    self.controlView.frame = CGRectMake(0, 0, self.view.width, 38);
//    self.controlView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:self.controlView];
    // 添加button下面一条线
    UIView *lineDownView = [[UIView alloc] initWithFrame:CGRectMake(7.5, 35, self.view.frame.size.width - 15, 2)];
    lineDownView.backgroundColor = [UIColor colorWithHexString:@"2a2a2a"];
    [self.view addSubview:lineDownView];
    
    self.toolView.frame = CGRectMake(25, 0, self.view.bounds.size.width -50, 36);
    self.toolView.backgroundColor = [UIColor clearColor];
    [_toolView selectedItem:_commentTag + 101];
    [self.view addSubview:self.toolView];
    
    // 添加button上面一条线
    UIView *lineTopView = [[UIView alloc] initWithFrame:CGRectMake(7.5,0, self.view.frame.size.width - 15, 2)];
    lineTopView.backgroundColor = [UIColor colorWithHexString:@"2a2a2a"];
    [self.view addSubview:lineTopView];
    
    self.tableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, self.toolView.bottom, self.view.width, self.view.height - self.toolView.bottom - 65) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = nil;
    [self.view addSubview:self.tableView];
    [self initRefreshView];
}

#pragma mark Load Data
- (void)dealErrorResponseWithTableView:(RefreshTableView *)tableview info:(NSDictionary *)dic
{
    [self showTotasViewWithMes:[dic objectForKey:@"msg"]];
    [tableview.refreshHeader endRefreshing];
    [tableview.refreshFooter endRefreshing];
}

- (void)netErrorWithTableView:(RefreshTableView*)tableView
{
    [self showTotasViewWithMes:@"网络异常，稍后重试"];
    [tableView.refreshHeader endRefreshing];
    [tableView.refreshFooter endRefreshing];
}

- (void)initRefreshView
{
    WS(ws);
    self.tableView.refreshHeader.beginRefreshingBlock = ^(){
        
        if (![ws isShowRecomend]) {
            //投诉
            ws.tableView.tableHeaderView = nil;
            
            [NetworkEntity getComplainListWithUserid:[[UserInfoModel defaultUserInfo] userID]
                                            SchoolId:[[UserInfoModel defaultUserInfo] schoolId]
                                           pageIndex:1
                                             success:^(id responseObject) {
                                                 
//                                                 NSLog(@"==%@",responseObject);
                                                 NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
                                                 if (type == 1) {
                                                     ws.complainData = [[BaseModelMethod getComplainListArrayFormDicInfo:[responseObject objectArrayForKey:@"data"]] mutableCopy];
                                                     [ws.tableView.refreshHeader endRefreshing];
                                                     [ws.tableView reloadData];
                                                 }

                                                 
                                             } failure:^(NSError *failure) {
                                                 [ws netErrorWithTableView:ws.tableView];
                                             }];
            
        }else{
            //评论
            ws.tableView.tableHeaderView = ws.pieView;
            [NetworkEntity getRecommendListWithUserid:[[UserInfoModel defaultUserInfo] userID]
                                             SchoolId:[[UserInfoModel defaultUserInfo] schoolId]
                                            pageIndex:1
                                           searchType:ws.searchType
                                         commentLevle:ws.toolView.selectButtonInteger - 100
                                              success:^(id responseObject) {
                                                
                                                  
                                                  NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
                                                  if (type == 1) {
                                                      NSDictionary * data = [responseObject objectInfoForKey:@"data"];
                                                      ws.recomendData = [[BaseModelMethod getRecomendListArrayFormDicInfo:[data objectArrayForKey:@"commentlist"]] mutableCopy];
                                                      [ws.pieView updateUIWithCountInfo:[data objectInfoForKey:@"commentcount"]];
                                                      
                                                      [ws.tableView.refreshHeader endRefreshing];
                                                      [ws.tableView reloadData];
                                                  } 
                                                  
                                                  
                                              } failure:^(NSError *failure) {
                                                  [ws netErrorWithTableView:ws.tableView];
                                              }];
        }
        
    };
    
    self.tableView.refreshFooter.beginRefreshingBlock = ^(){
        
        if (![ws isShowRecomend]) {
            //投诉
            ws.tableView.tableHeaderView = nil;
            ws.tableView.tableHeaderView = nil;
            
            NSInteger recomendDataCount = 0;
            if (ws.recomendData.count) {
                if (ws.recomendData.count <= 10) {
                    recomendDataCount = 10;
                }else {
                    NSInteger temp = ws.recomendData.count % 10;
                    if (temp) {
                        temp += RELOADDATACOUNT - temp;
                    }
                    recomendDataCount = ws.recomendData.count + temp;
                }
            }
            
            [NetworkEntity getComplainListWithUserid:[[UserInfoModel defaultUserInfo] userID]
                                            SchoolId:[[UserInfoModel defaultUserInfo] schoolId]
                                           pageIndex:recomendDataCount / RELOADDATACOUNT + 1
                                             success:^(id responseObject) {
                                                 
                                                 NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
                                                 
                                                 if (type == 1) {
                                                     NSArray * listArray = [[BaseModelMethod getComplainListArrayFormDicInfo:[responseObject objectArrayForKey:@"data"]] mutableCopy];
                                                     if (listArray.count) {
                                                         [ws.complainData addObjectsFromArray:listArray];
                                                         [ws.tableView reloadData];
                                                     }else{
                                                         [ws showTotasViewWithMes:@"已经加载所有数据"];
                                                     }
                                                     [ws.tableView.refreshFooter endRefreshing];
                                                 }else{
                                                     [ws dealErrorResponseWithTableView:ws.tableView info:responseObject];
                                                 }

                                             } failure:^(NSError *failure) {
                                                 
                                             }];
        }else{
            //评论
            ws.tableView.tableHeaderView = ws.pieView;
            
            NSInteger recomendDataCount = 0;
            if (ws.recomendData.count) {
                if (ws.recomendData.count <= 10) {
                    recomendDataCount = 10;
                }else {
                    NSInteger temp = ws.recomendData.count % 10;
                    if (temp) {
                        temp += RELOADDATACOUNT - temp;
                    }
                    recomendDataCount = ws.recomendData.count + temp;
                }
            }
            [NetworkEntity getRecommendListWithUserid:[[UserInfoModel defaultUserInfo] userID]
                                             SchoolId:[[UserInfoModel defaultUserInfo] schoolId]
                                            pageIndex:recomendDataCount / RELOADDATACOUNT + 1
                                           searchType:ws.searchType
                                         commentLevle:ws.toolView.selectButtonInteger - 100
                                              success:^(id responseObject) {
//                                                  NSLog(@"%li==%@",ws.toolView.selectButtonInteger,responseObject);
                                                  NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
                                                  
                                                  if (type == 1) {
                                                      NSDictionary * data = [responseObject objectInfoForKey:@"data"];
                                                      NSArray * listArray = [[BaseModelMethod getRecomendListArrayFormDicInfo:[data objectArrayForKey:@"commentlist"]] mutableCopy];
                                                      if (listArray.count) {
                                                          [ws.recomendData addObjectsFromArray:listArray];
                                                          [ws.tableView reloadData];
                                                      }else{
                                                          [ws showTotasViewWithMes:@"已经加载所有数据"];
                                                      }
                                                      [ws.tableView.refreshFooter endRefreshing];
                                                  }else{
                                                      [ws dealErrorResponseWithTableView:ws.tableView info:responseObject];
                                                  }
                                                  
                                              } failure:^(NSError *failure) {
                                                  [ws netErrorWithTableView:ws.tableView];
                                              }];
            
        }

    };
}

#pragma mark - PieChatView
- (RecomendPieChartView *)pieView
{
    if (!_pieView) {
        _pieView = [[RecomendPieChartView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 210)];
    }
    return _pieView;
}

#pragma mark -  DZNSegmentedControl
//- (RecommendSegView *)controlView
//{
//    if (!_controlView)
//    {
//        _controlView = [[RecommendSegView alloc] init];
//        [_controlView.control addTarget:self action:@selector(selectedSegment:) forControlEvents:UIControlEventValueChanged];
//    }
//    return _controlView;
//}
- (RecommendToolView *)toolView {
    if (!_toolView) {
        _toolView = [RecommendToolView new];
        WS(ws)
        _toolView.itemClickBlock = ^(UIButton *btn) {
            
            ws.title = [NSString stringWithFormat:@"%@%@详情",[ws searchTypeString],[ws evaluateTypeString:btn.tag - 100]];
            
            [ws.tableView.refreshHeader beginRefreshing];
        };
    }
    return _toolView;
}


//- (void)selectedSegment:(DZNSegmentedControl *)control
//{
//    [self.tableView.refreshHeader beginRefreshing];
//}

- (BOOL)isShowRecomend
{
    return (self.toolView.selectButtonInteger - 101) != 3;
}
#pragma mark - DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self isShowRecomend] ?  self.recomendData.count : self.complainData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMRecomendModel * model  =   [self isShowRecomend] ? self.recomendData[indexPath.row] : self.complainData[indexPath.row];
    return [RecomendCell cellHigthWithModel:model];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identify = [self isShowRecomend] ? @"Recomend" : @"Complain";
    RecomendCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[RecomendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify cellType:[self isShowRecomend] ? KRecomendCellTypeDefoult : KRecomendCellTypeVaule1];
        cell.delegate = self;
    }
    
    HMRecomendModel * model  =   [self isShowRecomend] ?  self.recomendData[indexPath.row] : self.complainData[indexPath.row];
    cell.model = model;
    
    return cell;
}

#pragma mark - Action
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (void)recomendCell:(RecomendCell *)cell DidCoaImessageButton:(UIButton *)button
{
    ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:cell.model.coaId conversationType:eConversationTypeChat Name:cell.model.coaName ava:cell.model.coaPortrait.originalpic mobile:cell.model.coaMobile];
    [self.navigationController pushViewController:chatController animated:YES];
}

- (void)recomendCell:(RecomendCell *)cell DidStuImessageButton:(UIButton *)button
{
    ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:cell.model.studentid conversationType:eConversationTypeChat Name:cell.model.studendName ava:cell.model.stuPortrait.originalpic mobile:cell.model.stuMobile];
    [self.navigationController pushViewController:chatController animated:YES];
}

#pragma mark - 投诉
- (void)complainCell:(RecomendCell *)cell DidSwithcButttonValueChanged:(UISwitch *)swithcButton
{
    WS(ws);
    HMComplainModel * model  = (HMComplainModel *)cell.model;
    if (model.isDealDone == NO) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [NetworkEntity markDealComplainWithComplainId:model.recomendId
                                                useID:[[UserInfoModel defaultUserInfo] userID]
                                              Success:^(id responseObject) {
            NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
            if(type == 1){
                [ws showTotasViewWithMes: @"成功处理"];
                model.isDealDone = YES;
            }else{
                model.isDealDone = NO;
                [ws showTotasViewWithMes:[responseObject objectForKey:@"msg"]];
            }
            cell.model = (HMRecomendModel *)model;
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        } failure:^(NSError *failure) {
            model.isDealDone = NO;
            cell.model = (HMRecomendModel *)model;
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [ws showTotasViewWithMes: @"网络异常，稍后重试"];
        }];
    }
}
@end
