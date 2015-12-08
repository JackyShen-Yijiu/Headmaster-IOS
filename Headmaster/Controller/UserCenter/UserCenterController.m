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
    self.navigationItem.title = @"个人信息";
    [self addBackgroundImage];
    [self initUI];
}

- (void)initUI {
    [self.view addSubview:_tableView];
    
    UIButton *loginOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    [loginOutBtn setTitle:@"退出登入" forState:UIControlStateNormal];
    [loginOutBtn addTarget:self action:@selector(UserWillLoginOut) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = loginOutBtn;
}

- (void)UserWillLoginOut {
    UserInfoModel *uim = [UserInfoModel defaultUserInfo];
    [uim loginOut];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:@"0"];
    [ud removeObjectForKey:@"1"];
    [ud removeObjectForKey:@"2"];
    [self presentViewController:[LoginController new] animated:YES completion:nil];
    
}

#pragma mark - lazy load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yy"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"yy"];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [UserInfoModel defaultUserInfo].name;
//    cell.imageView.image = [UIImage imageNamed:@""];
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
