//
//  MenuController.m
//  Headmaster
//
//  Created by 胡东苑 on 15/12/7.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "MenuController.h"
#import "SideMenuItem.h"
#import "UserCenterController.h"

@interface MenuController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView                    *headView;
@property (nonatomic, copy) NSArray                     *LeftItemArray;
@property (nonatomic, copy) NSArray                     *LeftIconArray;

@end

@implementation MenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *image = [UIImage imageNamed:@"sbg"];
    self.view.layer.contents = (id)image.CGImage;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.scrollEnabled = NO;
    
    SideMenuItem * item1 = [[SideMenuItem alloc] init];
    item1.title = @"发布公告";
    item1.target = @"PublishController";
    
    SideMenuItem * item2 = [[SideMenuItem alloc] init];
    item2.title = @"我的教练";
    item2.target = @"TeacherController";
    
    SideMenuItem * item3 = [[SideMenuItem alloc] init];
    item3.title = @"设置";
    item3.target = @"SettingController";
    
    self.LeftItemArray = @[ item1,item2,item3 ];
    
    self.LeftIconArray = @[ @"1",@"2",@"3" ];
    self.tableView.tableHeaderView = self.headView;
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
        _headView.backgroundColor = [UIColor clearColor];
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(97, 82, 78, 78)];
        imgView.userInteractionEnabled = YES;
        imgView.image = [UIImage imageNamed:@"tou"];
        imgView.layer.masksToBounds = YES;
        imgView.layer.cornerRadius = 39;
        [_headView addSubview:imgView];
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconViewIsClick)];
        [imgView addGestureRecognizer:tapGR];
    }
    return _headView;
}

- (void)iconViewIsClick {
//    [self.sideMenuViewController hideMenuViewController];
    UserCenterController *ucc = [[UserCenterController alloc] init];
    ucc.hideMenu = ^ {
        [self.sideMenuViewController hideMenuViewController];
    };
    HMNagationController *nav = [[HMNagationController alloc] initWithRootViewController:ucc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _LeftIconArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        UIImageView *cellIconView = [[UIImageView alloc] initWithFrame:CGRectMake(37, 15, 16, 16)];
        cellIconView.tag = 10 +indexPath.row;
        [cell.contentView addSubview:cellIconView];
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(67, 15, 100, 16)];
        lb.textColor = [UIColor colorWithHexString:@"#fcfcfc"];
        lb.tag = 100 +indexPath.row;
        lb.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:lb];
    }
    UIImageView *cellIconView = (id)[cell.contentView viewWithTag:10 +indexPath.row];
    cellIconView.image = [UIImage imageNamed:[self.LeftIconArray objectAtIndex:indexPath.row]];
    SideMenuItem *item = [self.LeftItemArray objectAtIndex:indexPath.row];
    UILabel *lb = (id)[cell.contentView viewWithTag:100 +indexPath.row];
    lb.text = [NSString stringWithFormat:@"%@",item.title];
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SideMenuItem * item = self.LeftItemArray[indexPath.row];
    UIViewController *vc = [[NSClassFromString(item.target) alloc]init];
    HMNagationController *nav = [[HMNagationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
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