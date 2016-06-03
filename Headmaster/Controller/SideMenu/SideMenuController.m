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

@property (nonatomic, copy) NSArray                     *LeftIconArray;

@end

@implementation SideMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    SideMenuItem * item1 = [[SideMenuItem alloc] init];
    item1.title = @"发布公告";
    item1.target = @"JZPublishController";
    
    SideMenuItem * item2 = [[SideMenuItem alloc] init];
    item2.title = @"我的教练";
    item2.target = @"TeacherController";
    
    SideMenuItem * item3 = [[SideMenuItem alloc] init];
    item3.title = @"设置";
    item3.target = @"SettingController";
    
    self.LeftItemArray = @[ item1,item2,item3 ];
    
    self.LeftIconArray = @[ @"imessageButton",@"imessageButton",@"imessageButton" ];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
}

// 返回单元格数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.LeftItemArray.count;
}

// 返回单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

// 每行中的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellId];
        UIImageView *cellIconView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 20, 40, 40)];
        cellIconView.tag = 10 +indexPath.row;
        [cell.contentView addSubview:cellIconView];
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(90, 20, 100, 40)];
        lb.tag = 100 +indexPath.row;
        [cell.contentView addSubview:lb];
    }
    UIImageView *cellIconView = (id)[cell.contentView viewWithTag:10 +indexPath.row];
    cellIconView.image = [UIImage imageNamed:[self.LeftIconArray objectAtIndex:indexPath.row]];
    
    SideMenuItem *item = [self.LeftItemArray objectAtIndex:indexPath.row];
    UILabel *lb = (id)[cell.contentView viewWithTag:100 +indexPath.row];
    lb.text = [NSString stringWithFormat:@"%@",item.title];
    
    return cell;
}
// 每行的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SideMenuItem * item = self.LeftItemArray[indexPath.row];
    
//    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[NSClassFromString(item.target) alloc]init] ]animated:YES];
    UIViewController *vc = [[NSClassFromString(item.target) alloc]init];

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.sideMenuViewController.leftMenuViewController presentViewController:nav animated:YES completion:nil];
//    [[UIApplication sharedApplication].keyWindow.rootViewController.navigationController pushViewController:[UIViewController new] animated:YES];
    
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
        imgView.image = [UIImage imageNamed:@"imessageButton"];
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
    
}


@end
