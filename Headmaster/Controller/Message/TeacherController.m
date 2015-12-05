//
//  TeacherController.m
//  Headmaster
//
//  Created by kequ on 15/12/1.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "TeacherController.h"
#import "RefreshTableView.h"
#import "TeacherCell.h"
#import "BaseModelMethod.h"
#import "ChatViewController.h"
#import "NetworkEntity.h"
#import "SearchBarView.h"

@interface TeacherController ()<UITableViewDelegate,UITableViewDataSource,TeacherCellDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
@property(nonatomic,strong)UIImageView * bgView;
@property(nonatomic,strong)RefreshTableView * tableView;
@property (strong, nonatomic) SearchBarView *searchBar;

@property(nonatomic,strong)NSMutableArray * dataSource;
@property(nonatomic,assign)BOOL isNeedRefresh;


@end

@implementation TeacherController

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
//    [[[self myNavController] navigationBar] setBarTintColor:[UIColor clearColor]];
    self.myNavigationItem.title = @"我的教练";
}

-(void)initUI
{
    self.bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.bgView.image = [UIImage imageNamed:@"teacher_bg"];
    [self.view addSubview:self.bgView];
    
    self.tableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.searchBar;
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
        
        [NetworkEntity getTeacherListWithSchoolId:[[UserInfoModel defaultUserInfo] schoolId] pageIndex:1 success:^(id responseObject) {
            
            NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
            if (type == 1) {
                ws.dataSource = [[BaseModelMethod getTeacherListArrayFormDicInfo:[responseObject objectArrayForKey:@"data"]] mutableCopy];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [ws.tableView.refreshHeader endRefreshing];
                    [ws.tableView reloadData];
                });
            }
        } failure:^(NSError *failure) {
            [ws netErrorWithTableView:ws.tableView];
        }];
    };
    
    self.tableView.refreshFooter.beginRefreshingBlock = ^(){
        [NetworkEntity getTeacherListWithSchoolId:@"56163c376816a9741248b7f9" pageIndex:ws.dataSource.count / RELOADDATACOUNT + 1 success:^(id responseObject) {
            NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
            
            if (type == 1) {
                NSArray * listArray = [[BaseModelMethod getTeacherListArrayFormDicInfo:[responseObject objectArrayForKey:@"data"]] mutableCopy];
                if (listArray.count) {
                    [ws.dataSource addObjectsFromArray:listArray];
                    [ws.tableView reloadData];
                }else{
                    [ws showTotasViewWithMes:@"已经加载所有数据"];
                }
                [ws.tableView.refreshFooter endRefreshing];
            }else{
                [ws dealErrorResponseWithTableView:ws.tableView info:responseObject];
            }
            
        }  failure:^(NSError *failure) {
            [ws netErrorWithTableView:ws.tableView];
        }];
        
    };
}

#pragma mark - SearchBar
- (SearchBarView *)searchBar
{
    if (_searchBar == nil) {
        _searchBar = [[SearchBarView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 38)];
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.searchBar.delegate = self;
    }
    return _searchBar;
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

#pragma mark - DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [TeacherCell cellHigth];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeacherCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[TeacherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
        cell.delegate = self;
    }
    TeacherModel * model = [self.dataSource objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - Action
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)teacherCell:(TeacherCell *)cell didClickMessageButton:(UIButton *)button
{
    ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:cell.model.userId conversationType:eConversationTypeChat];
    chatController.userName = cell.model.userName;
    [self.navigationController pushViewController:chatController animated:YES];
}

@end
