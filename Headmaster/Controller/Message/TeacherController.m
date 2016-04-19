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

@property(nonatomic,strong)NSString * searchKey;
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
    
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self.isNeedRefresh){
        [self.tableView.refreshHeader beginRefreshing];
    }
    self.isNeedRefresh = NO;
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

#pragma mark - initUI

- (void)initNavBar
{
    [self resetNavBar];
    self.myNavigationItem.title = @"我的教练";
    
    CGRect backframe= CGRectMake(0, 0, 16, 16);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pushBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.myNavigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)pushBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)initUI
{
    self.bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.bgView.image = [UIImage imageNamed:@"teacher_bg"];
    [self.view addSubview:self.bgView];
    
    self.tableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 38 - 2) style:UITableViewStylePlain];
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
        
        [NetworkEntity getTeacherListWithSchoolId:[[UserInfoModel defaultUserInfo] schoolId] searchName:ws.searchKey pageIndex:1 success:^(id responseObject) {
            ws.searchKey = nil;
            NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
            if (type == 1) {
                ws.dataSource = [[BaseModelMethod getTeacherListArrayFormDicInfo:[responseObject objectArrayForKey:@"data"]] mutableCopy];
                if (ws.dataSource.count == 0) {
                    ToastAlertView *tav = [[ToastAlertView alloc] initWithTitle:@"没有搜到您要找的教练"];
                    [tav show];
                    
                }
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
        [NetworkEntity getTeacherListWithSchoolId:[[UserInfoModel defaultUserInfo] schoolId] searchName:ws.searchKey pageIndex:ws.dataSource.count / RELOADDATACOUNT + 1 success:^(id responseObject) {
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
    searchBar.placeholder = @"";
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self.tableView.refreshHeader beginRefreshing];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    self.searchKey = [searchBar.text copy];
    
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    if ([searchBar.text isEqualToString:@""]) {
        searchBar.placeholder = @"搜索";
    }
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
    NSLog(@"button.tag = %lu",button.tag);
    if (button.tag == 601) {
        // 电话
        if (cell.model.mobile == nil ||[cell.model.mobile isEqualToString:@""]) {
            [self showTotasViewWithMes:@"该教练未录入电话!"];
            return;
        }
                        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",cell.model.mobile];
                        UIWebView * callWebview = [[UIWebView alloc] init];
                        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
                        [self.view addSubview:callWebview];
        
    }
    if (button.tag == 600) {
        // 聊天
        ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:cell.model.userId conversationType:eConversationTypeChat Name:cell.model.userName ava:cell.model.porInfo.originalpic mobile:nil];
        [self.navigationController pushViewController:chatController animated:YES];
    }
    
    
    
}

@end
