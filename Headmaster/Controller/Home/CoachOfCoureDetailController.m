//
//  CoachOfCoureDetailController.m
//  DataDatiel
//
//  Created by ytzhang on 15/12/2.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "CoachOfCoureDetailController.h"
#import "CoachCourseDatailViewModel.h"
#import "RefreshTableView.h"
#import "CoachCoureDatilModel.h"
#import "ChatViewController.h"

@interface CoachOfCoureDetailController () <UITableViewDataSource,UITableViewDelegate,CoachOfCoureDetailCellDelegate>
@property (nonatomic, strong) RefreshTableView       *tableView;
@property (nonatomic, strong) CoachCourseDatailViewModel *coachCoureDatailViewModel;

@property (nonatomic, strong) UIBarButtonItem *pushBtn;

@end

@implementation CoachOfCoureDetailController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_isFormMenu) {
        self.navigationItem.leftBarButtonItem = self.pushBtn;
    }

    
    UIView *lineTopView = [[UIView alloc] initWithFrame:CGRectMake(7.5, 0, self.view.bounds.size.width - 15, 2)];
    lineTopView.backgroundColor = [UIColor colorWithHexString:@"2a2a2a"];
    [self.view addSubview:lineTopView];
    [self addBackgroundImage];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    
    self.tableView.refreshFooter = nil;
    
    switch (_searchType) {
        case 1:
            self.title = @"今天教练详情";
            break;
            case 2:
            self.title = @"昨天教练详情";
            break;
            case 3:
            self.title = @"本周教练详情";
            break;
            case 4:
            self.title = @"本月教练详情";
            break;
            case 5:
            self.title = @"本年教练详情";
            break;
            
        default:
            break;
    }
    // 数据请求
    _coachCoureDatailViewModel = [[CoachCourseDatailViewModel alloc] init];
    WS(ws);
    _coachCoureDatailViewModel.tableViewNeedReLoad = ^ {
        [ws.tableView reloadData];
        [ws.tableView.refreshHeader endRefreshing];
        [ws.tableView.refreshFooter endRefreshing];
    };
    _coachCoureDatailViewModel.showToast = ^ {
        ToastAlertView *tav = [[ToastAlertView alloc] initWithTitle:@"网络连接失败，请检查网络连接"];
        [tav show];
    };
    [_coachCoureDatailViewModel successRefreshBlock:^{
        NSLog(@"我被成功回调了哟！");
//        InformationDataModel *dataModel = [_viewModel.informationArray lastObject];
//        self.seqindex = [dataModel.seqindex intValue];
        
        [ws.tableView.refreshHeader endRefreshing];
        [ws.tableView.refreshFooter endRefreshing];
        [self.tableView reloadData];
    }];
    [_coachCoureDatailViewModel networkRequestNeedUpRefreshWithCoachCourseListWithuserid:[[UserInfoModel defaultUserInfo] userID] searchtype:_searchType schoolid:[[UserInfoModel defaultUserInfo] schoolId] count:10];
    [self setRefresh];
}

- (void)setRefresh {
    WS(ws);
    __weak typeof(_coachCoureDatailViewModel) viewModel = _coachCoureDatailViewModel;
    self.tableView.refreshHeader.beginRefreshingBlock = ^(){
        [viewModel networkRequestNeedUpRefreshWithCoachCourseListWithuserid:[[UserInfoModel defaultUserInfo] userID] searchtype:ws.searchType schoolid:[[UserInfoModel defaultUserInfo] schoolId] count:10];    };

}
- (void)pushBtnClick {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (UIBarButtonItem *)pushBtn {
    if (!_pushBtn) {
        CGRect backframe= CGRectMake(0, 0, 16, 16);
        UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = backframe;
        [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(pushBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _pushBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    return _pushBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_coachCoureDatailViewModel.coachArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"cellID";
    CoachOfCoureDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CoachOfCoureDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.delegate = self;
    cell.backgroundColor = [UIColor clearColor];
    CoachCoureDatilModel *dataModel = _coachCoureDatailViewModel.coachArray[indexPath.row];
    [cell refreshData:dataModel];
    return cell;
}

- (void)coachOfCoureDetailCell:(CoachOfCoureDetailCell *)cell DidImessageButton:(UIButton *)button
{
    ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:cell.model.coachid conversationType:eConversationTypeChat Name:cell.model.name ava:cell.model.originalpic mobile:cell.model.mobile];
    [self.navigationController pushViewController:chatController animated:YES];

}

#pragma mark - lazy load

- (RefreshTableView *)tableView {
    if (!_tableView) {
        _tableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 2, self.view.width, self.view.height - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"CoachOfCoureDetailCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    }
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 109;
}



@end
