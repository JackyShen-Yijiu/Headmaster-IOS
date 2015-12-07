 //
//  InformationController.m
//  Headmaster
//
//  Created by 大威 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "InformationController.h"
#import "InformationViewModel.h"
#import "InformationListCell.h"
#import "RefreshTableView.h"
#import "InformationDetailController.h"

@interface InformationController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) InformationViewModel   *viewModel;

@property (nonatomic, strong) RefreshTableView       *tableView;

@property (nonatomic, assign) int                seqindex;

@end

@implementation InformationController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackgroundImage];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    _viewModel = [InformationViewModel new];
    WS(ws);
    _viewModel.tableViewNeedReLoad = ^ {
        [ws.tableView reloadData];
        [ws.tableView.refreshHeader endRefreshing];
        [ws.tableView.refreshFooter endRefreshing];
    };
    _viewModel.showToast = ^ {
        ToastAlertView *tav = [[ToastAlertView alloc] initWithTitle:@"网络连接失败，请检查网络连接"];
        [tav show];
    };
    [_viewModel successRefreshBlock:^{
        NSLog(@"我被成功回调了哟！");
        InformationDataModel *dataModel = [_viewModel.informationArray lastObject];
        self.seqindex = [dataModel.seqindex intValue];
        [self.tableView reloadData];
    }];
    [_viewModel networkRequestRefresh];
    [self setRefresh];
}

- (void)setRefresh {
    WS(ws);
    __weak typeof(_viewModel) viewModel = _viewModel;
    self.tableView.refreshHeader.beginRefreshingBlock = ^(){
        [viewModel networkRequestRefresh];
    };
    self.tableView.refreshFooter.beginRefreshingBlock = ^(){
        if (ws.seqindex) {
            [viewModel networkRequestNeedUpRefreshWithSeqindex:(NSInteger)ws.seqindex];
        }else {
            ToastAlertView *tav = [[ToastAlertView alloc] initWithTitle:@"已经加载所有数据"];
            [tav show];
            [ws.tableView.refreshFooter endRefreshing];
        }
    };


}

#pragma mark - lazy load

- (RefreshTableView *)tableView {
    if (!_tableView) {
        _tableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64 -49) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"InformationListCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    }
    return _tableView;
}

#pragma mark - tableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.informationArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    InformationListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[InformationListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.backgroundColor = [UIColor clearColor];
    InformationDataModel *dataModel = _viewModel.informationArray[indexPath.row];
    [cell refreshData:dataModel];
    
    return cell;
}

#pragma mark tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InformationDetailController *detailsVC = [InformationDetailController new];
    InformationDataModel *informationDataModel = _viewModel.informationArray[indexPath.row];
    detailsVC.urlStr = informationDataModel.contenturl;
    [self.navigationController pushViewController:detailsVC animated:YES];
    
    // 取消cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [NetworkTool cancelAllRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
