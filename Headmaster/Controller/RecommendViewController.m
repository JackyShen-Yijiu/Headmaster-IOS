//
//  RecommendViewController.m
//  Headmaster
//
//  Created by kequ on 15/12/3.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "RecommendViewController.h"
#import "DZNSegmentedControl.h"
#import "NetworkEntity.h"
#import "RefreshTableView.h"
#import "RecomendPieChartView.h"
#import "RecomendCell.h"
#import "ChatViewController.h"

@interface RecommendViewController ()<UITableViewDelegate,UITableViewDataSource,RecomendCellDelegate>

@property (nonatomic, strong) UIImageView * bgView;
@property (nonatomic, strong) DZNSegmentedControl *control;
@property (nonatomic, strong) NSArray *menuItems;

@property (nonatomic, strong) RecomendPieChartView * pieView;
@property (nonatomic, strong) RecomendPieChartViewModel * pieModel;

@property (nonatomic, strong)RefreshTableView * tableView;
@property (nonatomic, strong)NSMutableArray * dataModel;
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
    self.myNavigationItem.title = @"评价详情";
}

-(void)initUI
{
    self.bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.bgView.image = [UIImage imageNamed:@"teacher_bg"];
    [self.view addSubview:self.bgView];
    
    [[DZNSegmentedControl appearance] setBackgroundColor:RGB_Color(0x54, 0x54, 0x54)];
    [[DZNSegmentedControl appearance] setTintColor:RGB_Color(0x01, 0xe2, 0xb6)];
    [[DZNSegmentedControl appearance] setHairlineColor:[UIColor clearColor]];
    
    [[DZNSegmentedControl appearance] setFont:[UIFont systemFontOfSize:15.f]];
    [[DZNSegmentedControl appearance] setSelectionIndicatorHeight:1];
    [[DZNSegmentedControl appearance] setAnimationDuration:0.125];

    self.control.frame = CGRectMake(0, 0, self.view.width, 60);
    self.control.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.control];
    
    self.tableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, self.control.bottom, self.view.width, self.view.height - self.control.bottom) style:UITableViewStylePlain];
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
        
        ws.dataModel = [NSMutableArray arrayWithCapacity:0];
        for (int i =0; i < 20; i++) {
            [ws.dataModel addObject:[HMRecomendModel converJsonDicToModel:nil]];
        }
        [ws.tableView.refreshHeader endRefreshing];
        [ws.tableView reloadData];
        
//        [NetworkEntity getTeacherListWithSchoolId:@"56163c376816a9741248b7f9" pageIndex:1 success:^(id responseObject) {
//            
//            NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
//            if (type == 1) {
////                ws.dataModel = [[BaseModelMethod getTeacherListArrayFormDicInfo:[responseObject objectArrayForKey:@"data"]] mutableCopy];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [ws.tableView.refreshHeader endRefreshing];
//                    [ws.tableView reloadData];
//                });
//            }
//        } failure:^(NSError *failure) {
//            [ws netErrorWithTableView:ws.tableView];
//        }];
    };
    
    self.tableView.refreshFooter.beginRefreshingBlock = ^(){
//        [NetworkEntity getTeacherListWithSchoolId:@"56163c376816a9741248b7f9" pageIndex:ws.tableViewData.count / RELOADDATACOUNT + 1 success:^(id responseObject) {
//            NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
//            
//            if (type == 1) {
//                NSArray * listArray = [[BaseModelMethod getTeacherListArrayFormDicInfo:[responseObject objectArrayForKey:@"data"]] mutableCopy];
//                if (listArray.count) {
//                    [ws.tableViewData addObjectsFromArray:listArray];
//                    [ws.tableView reloadData];
//                }else{
//                    [ws showTotasViewWithMes:@"已经加载所有数据"];
//                }
//                [ws.tableView.refreshFooter endRefreshing];
//            }else{
//                [ws dealErrorResponseWithTableView:ws.tableView info:responseObject];
//            }
//            
//        }  failure:^(NSError *failure) {
//            [ws netErrorWithTableView:ws.tableView];
//        }];
    };
}

#pragma mark -  DZNSegmentedControl
- (DZNSegmentedControl *)control
{
    if (!_control)
    {
        _control = [[DZNSegmentedControl alloc] initWithItems:self.menuItems];
        _control.selectedSegmentIndex = 0;
        _control.bouncySelectionIndicator = NO;
        _control.showsCount = NO;
        [_control addTarget:self action:@selector(selectedSegment:) forControlEvents:UIControlEventValueChanged];
    }
    return _control;
}

- (NSArray *)menuItems
{
    if (!_menuItems) {
        _menuItems = @[
                       @"  好评       ",
                       @"  中评       ",
                       @"  差评       ",
                       @"  投诉       "
                       ];
    }
    return _menuItems;
}

- (void)selectedSegment:(DZNSegmentedControl *)control
{
    [self.tableView reloadData];
}


#pragma mark - DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataModel.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMRecomendModel * model  =  self.dataModel[indexPath.row];
    return [RecomendCell cellHigthWithModel:model];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecomendCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[RecomendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
        cell.delegate = self;
    }
    HMRecomendModel * model  =  self.dataModel[indexPath.row];
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
    ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:cell.model.coaId conversationType:eConversationTypeChat];
    chatController.userName = cell.model.coaName;
    [self.navigationController pushViewController:chatController animated:YES];
}

- (void)recomendCell:(RecomendCell *)cell DidStuImessageButton:(UIButton *)button
{
    ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:cell.model.studentid conversationType:eConversationTypeChat];
    chatController.userName = cell.model.studendName;
    [self.navigationController pushViewController:chatController animated:YES];

}
@end
