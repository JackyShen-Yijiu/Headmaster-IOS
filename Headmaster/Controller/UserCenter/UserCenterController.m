//
//  UserCenterController.m
//  Headmaster
//
//  Created by 胡东苑 on 15/12/5.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "UserCenterController.h"
#import "LoginController.h"

@interface UserCenterController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation UserCenterController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setNavBar];
    [self addBackgroundImage];
    [self initUI];
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

- (void)initUI {
    [self.view addSubview:self.tableView];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    view.backgroundColor = [UIColor clearColor];
    UIButton *loginOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 40)];
    [loginOutBtn setTitle:@"退出登入" forState:UIControlStateNormal];
    [loginOutBtn setTitleColor:[UIColor colorWithHexString:@"#bfbfbf"] forState:UIControlStateNormal];
    loginOutBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    loginOutBtn.backgroundColor = [UIColor darkGrayColor];
    [loginOutBtn addTarget:self action:@selector(UserWillLoginOut) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:loginOutBtn];
    
    self.tableView.tableFooterView = view;
}

- (void)UserWillLoginOut {
    UserInfoModel *uim = [UserInfoModel defaultUserInfo];
    [uim loginOut];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:@"0"];
    [ud removeObjectForKey:@"1"];
    [ud removeObjectForKey:@"2"];
    LoginController *lc = [LoginController new];
    lc.dismissController = ^ {
        [self dismissViewControllerAnimated:YES completion:nil];
        if (_hideMenu) {
            _hideMenu();
        }
    };
    [self.navigationController pushViewController:lc animated:YES];
}

#pragma mark - lazy load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yy"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"yy"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [UserInfoModel defaultUserInfo].name;
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#BFBFBF"];
    cell.imageView.image = [UIImage imageNamed:@"tou"];
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