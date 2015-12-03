//
//  SettingController.m
//  Headmaster
//
//  Created by 胡东苑 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "SettingController.h"

@interface SettingController () <UITableViewDataSource,UITableViewDelegate> {
    BOOL isFirstLoad;
}

@property (nonatomic, strong) UITableView      *tableView;
@property (nonatomic, copy) NSMutableArray     *dataArr;

@end

@implementation SettingController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIButton *pushBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [pushBtn setTitle:@"返回" forState:UIControlStateNormal];
    [pushBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pushBtn addTarget:self action:@selector(pushBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:pushBtn];
    
    self.navigationItem.title = @"设置";
}

- (void)pushBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self isFirstLOad];
    [self createUI];
}

- (void)isFirstLOad {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (![ud objectForKey:@"firstLoad"]) {
        NSString *str = @"firstLoad";
        [ud setObject:str forKey:@"firstLoad"];
        [ud synchronize];
    }
}

- (void)createUI {
    [self.view addSubview:self.tableView];
    self.dataArr = [NSMutableArray arrayWithObjects:@"聊天消息提醒",@"投诉消息提醒",@"新学员报名提醒",@""
                    ,@"关于我们",@"去评分",@"反馈", nil];
}

#pragma mark ----lazy load 

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -64)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = [UIColor clearColor];
    }
    return _tableView;
}

#pragma mark ----tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yy"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"yy"];
        if (indexPath.row <3) {
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            NSInteger btnX = [ud integerForKey:[NSString stringWithFormat:@"%zd",indexPath.row]];
            //            [ud removeObjectForKey:[NSString stringWithFormat:@"%zd",indexPath.row]];
            if (!btnX) {
                btnX = self.view.frame.size.width -80;
                [ud setInteger:btnX forKey:[NSString stringWithFormat:@"%zd",indexPath.row]];
                [ud synchronize];
            }
            UIButton *switchBtn = [[UIButton alloc] initWithFrame:CGRectMake((int)btnX, 12, 20, 20)];
            switchBtn.tag = indexPath.row;
            switchBtn.backgroundColor = [UIColor redColor];
            switchBtn.layer.cornerRadius = 10;
            [switchBtn addTarget:self action:@selector(switchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:switchBtn];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    if (indexPath.row == 3) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}

- (void)switchBtnAction:(UIButton *)sender {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSInteger btnX = [ud integerForKey:[NSString stringWithFormat:@"%zd",sender.tag]];
    CGRect btnFrame = sender.frame;
    if (btnX == self.view.frame.size.width -80) {
        btnX += 20;
        btnFrame.origin.x = btnX;
        sender.frame = btnFrame;
        [ud removeObjectForKey:[NSString stringWithFormat:@"%zd",sender.tag]];
        [ud setInteger:btnX forKey:[NSString stringWithFormat:@"%zd",sender.tag]];
        [ud synchronize];
    }else {
        btnX -= 20;
        btnFrame.origin.x = btnX;
        sender.frame = btnFrame;
        [ud removeObjectForKey:[NSString stringWithFormat:@"%zd",sender.tag]];
        [ud setInteger:btnX forKey:[NSString stringWithFormat:@"%zd",sender.tag]];
        [ud synchronize];
    }
    
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
