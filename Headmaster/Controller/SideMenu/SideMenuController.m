//
//  InformationController.h
//  Headmaster
//
//  Created by 大威 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "SideMenuController.h"
#import "RESideMenu.h"
#import "SideMenuItem.h"

@interface SideMenuController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView                    *headView;

@property (nonatomic, strong) UITableView               *tableView;

@property (nonatomic, copy) NSArray                     *LeftItemArray;

@end

@implementation SideMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    SideMenuItem * item1 = [[SideMenuItem alloc] init];
    item1.title = @"第一页";
    item1.target = @"HomeController";
    
    SideMenuItem * item2 = [[SideMenuItem alloc] init];
    item2.title = @"第一页";
    item2.target = @"InformationController";
    
    self.LeftItemArray = @[ item1,item2 ];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
}

// 返回单元格数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.LeftItemArray.count;
}
// 每行中的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellId];
        cell.backgroundColor = [UIColor redColor];
        cell.contentView.backgroundColor = [UIColor orangeColor];
    }
    
    cell.backgroundColor = [UIColor blackColor];
    
    SideMenuItem *item = [self.LeftItemArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",item.title];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}
// 每行的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SideMenuItem * item = self.LeftItemArray[indexPath.row];
    
//    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[NSClassFromString(item.target) alloc]init] ]animated:YES];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController.navigationController pushViewController:[UIViewController new] animated:YES];
    
    // 隐藏侧滑菜单
    [self.sideMenuViewController hideMenuViewController];
}

#pragma mark - lazy load
// 顶部视图
- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
        _headView.backgroundColor = [UIColor lightGrayColor];
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
        imgView.image = [UIImage imageNamed:@"ic_sex_male"];
        imgView.layer.masksToBounds = YES;
        imgView.layer.cornerRadius = 40;
        [_headView addSubview:imgView];
        UILabel * lbl = [[UILabel alloc] initWithFrame:CGRectMake(120, 25, 150, 50)];
        lbl.text = @"测试名字";
        lbl.textColor = [UIColor whiteColor];
        [_headView addSubview:lbl];
        
    }
    return _headView;
}

// 表格
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor lightGrayColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
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
