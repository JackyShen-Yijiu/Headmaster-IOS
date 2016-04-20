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
#import "HomeDetailController.h"
#import "RecommendViewController.h"

#define LiftMargain 36

@interface MenuController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView                    *headView;
@property (nonatomic, copy) NSArray                     *LeftItemArray;
@property (nonatomic, copy) NSArray                     *LeftIconArray;

@end

@implementation MenuController

+ (UIImageView *)defaultImageView {
    
    static UIImageView *imgview = nil;
    @synchronized (self)
    {
        if (!imgview) {
            imgview = [[UIImageView alloc] init];
            [imgview sd_setImageWithURL:[NSURL URLWithString:[UserInfoModel defaultUserInfo].portrait]];
        }
    }
    return imgview;
}

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
    // Do any additional setup after loading the view.
    
    UIImage *image = [UIImage imageNamed:@"sbg"];
    self.view.layer.contents = (id)image.CGImage;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.scrollEnabled = NO;
    
    // 发布公告
    SideMenuItem * item1 = [[SideMenuItem alloc] init];
    item1.title = @"发布公告";
    item1.target = @"JZPublishController";
    
    // 我校教练
    SideMenuItem * item2 = [[SideMenuItem alloc] init];
    item2.title = @"我校教练";
    item2.target = @"TeacherController";
    
    // 运营数据
    SideMenuItem * item3 = [[SideMenuItem alloc] init];
    item3.title = @"数据概览";
    item3.target = @"HomeDetailController";
    
    
    // 投诉评论
    SideMenuItem * item4 = [[SideMenuItem alloc] init];
    item4.title = @"评论投诉";
    item4.target = @"RecommendViewController";
    
    
    // 设置
    SideMenuItem * item5 = [[SideMenuItem alloc] init];
    item5.title = @"设置";
    item5.target = @"SettingController";
    
   
    
    
    
    self.LeftItemArray = @[ item1,item2,item3,item4,item5 ];
    self.LeftIconArray = @[ @"announcement",@"coach",@"data",@"complaint",@"set" ];
    self.tableView.tableHeaderView = self.headView;
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
        _headView.backgroundColor = [UIColor clearColor];
        // 头像
        UIImageView * imgView = [[self class] defaultImageView];
        imgView.frame = CGRectMake(LiftMargain, 84, 58, 58);
        imgView.userInteractionEnabled = YES;
        imgView.layer.masksToBounds = YES;
        imgView.layer.cornerRadius = 29;
        
        // 校长姓名
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.frame = CGRectMake(0, CGRectGetMaxY(imgView.frame) + 14, 100, 16);
        nameLabel.centerX = imgView.centerX;
        nameLabel.text = [UserInfoModel defaultUserInfo].name;
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font = [UIFont systemFontOfSize:16];
    
        [_headView addSubview:imgView];
        [_headView addSubview:nameLabel];
        
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconViewIsClick)];
        [imgView addGestureRecognizer:tapGR];
    }
    return _headView;
}

- (void)iconViewIsClick {
//    [self.sideMenuViewController hideMenuViewController];
    UserCenterController *ucc = [[UserCenterController alloc] init];
    ucc.iconImage = [[self class] defaultImageView].image;
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
    return 45;
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
//        lb.backgroundColor = [UIColor cyanColor];
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
    
    // 数据概述 控制器的跳转
    if (2 == indexPath.row ) {
        HomeDetailController *vc = [[HomeDetailController alloc] init];
        vc.searchType = kDateSearchTypeToday;
        vc.isFormSideMenu = YES;
        HMNagationController *nav = [[HMNagationController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        return;

    }
    
    // 评论投诉
    if (3 == indexPath.row ) {
        RecommendViewController *vc = [[RecommendViewController alloc] init];
        vc.isFormSideMenu = YES;
        HMNagationController *nav = [[HMNagationController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        return;
        
    }

    
    // 侧边栏其他控制器的跳转
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
