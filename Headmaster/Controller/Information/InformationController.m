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
#import "YiRefreshHeader.h"
#import "YiRefreshFooter.h"

@interface InformationController ()

@property (nonatomic, strong) InformationViewModel *viewModel;

@end

@implementation InformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackgroundImage];
    
    self.tableView.rowHeight = 80;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self setRefresh];
    
    _viewModel = [InformationViewModel new];
    [_viewModel successRefreshBlock:^{
        NSLog(@"我被成功回调了哟！");
        [self.tableView reloadData];
    }];
    [_viewModel networkRequestRefresh];
}

- (void)setRefresh {

}

#pragma mark - tableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _viewModel.informationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    InformationListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[InformationListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
    }
    InformationDataModel *dataModel = _viewModel.informationArray[indexPath.row];
    [cell refreshData:dataModel];
    
    return cell;
}

#pragma mark tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    InformationDetailController *detailsVC = [InformationDetailController new];
//    [self.navigationController pushViewController:detailsVC animated:YES];
    
    // 取消cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
