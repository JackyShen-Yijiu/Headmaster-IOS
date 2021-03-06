//
//  UserCenterController.m
//  Headmaster
//
//  Created by 胡东苑 on 15/12/5.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "UserCenterController.h"
#import "LoginController.h"
#import "APService.h"
#import "AppDelegate.h"
#import "UIImage+Helper.h"

@interface UserCenterController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation UserCenterController

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
    UIView *lineTopView = [[UIView alloc] initWithFrame:CGRectMake(7.5, 0, self.view.bounds.size.width - 15, 2)];
    lineTopView.backgroundColor = [UIColor colorWithHexString:@"2a2a2a"];
    [self.view addSubview:lineTopView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setNavBar];
    [self addBackgroundImage];
    [self.view addSubview:self.tableView];
}

- (void)setNavBar {
    self.navigationItem.title = @"个人信息";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#fcfcfc"],NSForegroundColorAttributeName,nil]];
    CGRect backframe= CGRectMake(0, 0, 16, 16);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pushBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)pushBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)UserWillLoginOut {
    UserInfoModel *uim = [UserInfoModel defaultUserInfo];
    [uim loginOut];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:@"0"];
    [ud removeObjectForKey:@"1"];
    [ud removeObjectForKey:@"2"];
    [ud removeObjectForKey:@"USERIMAGE"];
//    LoginController *lc = [LoginController new];
//    lc.dismissController = ^ {
//        [self dismissViewControllerAnimated:YES completion:nil];
//        if (_hideMenu) {
//            _hideMenu();
//        }
//    };

    //极光推送设置alias
    [APService setAlias:[UserInfoModel defaultUserInfo].userID callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
    //友盟统计账号登出
    [MobClick profileSignOff];
//    [self.navigationController pushViewController:lc animated:YES];
    
    [self dismissViewControllerAnimated:NO completion:^{
        [[self slideMenu] hideMenuViewController];
        [[(AppDelegate *)[[UIApplication sharedApplication] delegate] navController] popToRootViewControllerAnimated:NO];
        
    }];
}

-(void)tagsAliasCallback:(int)iResCode
                    tags:(NSSet*)tags
                   alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

#pragma mark - lazy load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, self.view.frame.size.width, self.view.frame.size.height-69)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

#pragma mark - tableViewDelegate 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.view.frame.size.height -69-44;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -69-44)];
    view.userInteractionEnabled = YES;
    view.backgroundColor = [UIColor clearColor];
    UIButton *loginOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height -69-44-100, self.view.frame.size.width, 40)];
    [loginOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [loginOutBtn setTitleColor:[UIColor colorWithHexString:@"#bfbfbf"] forState:UIControlStateNormal];
    loginOutBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    if (YBIphone6Plus) {
        loginOutBtn.titleLabel.font = [UIFont systemFontOfSize:16*YBRatio];
    }
    loginOutBtn.backgroundColor = [UIColor darkGrayColor];
    [loginOutBtn addTarget:self action:@selector(UserWillLoginOut) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:loginOutBtn];
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yy"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"yy"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 50, 50)];
    iv.image = [UIImage resizeImage:_iconImage newSize:CGSizeMake(50, 50)];
    iv.layer.cornerRadius = 25;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 100, 50)];
    label.text = [UserInfoModel defaultUserInfo].name;
    label.textColor = [UIColor colorWithHexString:@"#BFBFBF"];
    [cell.contentView addSubview:iv];
    [cell.contentView addSubview:label];
    return cell;
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
