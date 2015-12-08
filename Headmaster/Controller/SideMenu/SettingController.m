//
//  SettingController.m
//  Headmaster
//
//  Created by 胡东苑 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "SettingController.h"
#import "AboutUsController.h"
#import "FeedbackController.h"

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
    [pushBtn setTitleColor:[UIColor colorWithHexString:TEXT_NORMAL_COLOR] forState:UIControlStateNormal];
    [pushBtn addTarget:self action:@selector(pushBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:pushBtn];
    self.navigationItem.title = @"设置";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:TEXT_NORMAL_COLOR],NSForegroundColorAttributeName,nil]];
    
}

- (void)pushBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackgroundImage];
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
        _tableView.backgroundColor = [UIColor clearColor];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yy"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"yy"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(29, 42, 200, 15)];
        label.textColor = [UIColor colorWithHexString:TEXT_NORMAL_COLOR];
        [cell.contentView addSubview:label];
        if (indexPath.row <3) {
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//            [ud removeObjectForKey:[NSString stringWithFormat:@"%zd",indexPath.row]];
            NSInteger btnX = [ud integerForKey:[NSString stringWithFormat:@"%zd",indexPath.row]];
            if (!btnX) {
                btnX = self.view.frame.size.width -70;
                if (indexPath.row == 0 && [[UserInfoModel defaultUserInfo].newmessagereminder isEqualToString:@"0"]) {
                    btnX += 20;
                }
                if (indexPath.row == 1 && [[UserInfoModel defaultUserInfo].complaintreminder isEqualToString:@"0"]) {
                    btnX += 20;
                }
                if (indexPath.row == 2 && [[UserInfoModel defaultUserInfo].applyreminder isEqualToString:@"0"]) {
                    btnX += 20;
                }
                [ud setInteger:btnX forKey:[NSString stringWithFormat:@"%zd",indexPath.row]];
                [ud synchronize];
            }
            UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width -67, 45, 40, 9)];
            bgView.image = [UIImage imageNamed:@"hd69x16"];
            bgView.layer.cornerRadius = 10;
            [cell.contentView addSubview:bgView];
            
            UIButton *switchBtn = [[UIButton alloc] initWithFrame:CGRectMake((int)btnX, 37, 25, 25)];
            if ((int)btnX == self.view.frame.size.width -70) {
                [switchBtn setImage:[UIImage imageNamed:@"an42x44"] forState:UIControlStateNormal];
            }else {
                [switchBtn setImage:[UIImage imageNamed:@"hm"] forState:UIControlStateNormal];
            }
            switchBtn.tag = indexPath.row;
            switchBtn.layer.cornerRadius = 10;
            [switchBtn addTarget:self action:@selector(switchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:switchBtn];
        }
    }
    if (indexPath.row == 3) {
        cell.backgroundColor = [UIColor clearColor];
    }
    for (UILabel *subView in cell.contentView.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            subView.text = _dataArr[indexPath.row];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        NSLog(@"444");
        [self.navigationController pushViewController:[AboutUsController new] animated:NO];
    }else if (indexPath.row == 5) {
        NSLog(@"555");
        NSString *appid = @"";
        NSString* url = [NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", appid];
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
    }else if (indexPath.row == 6) {
        NSLog(@"666");
        [self.navigationController pushViewController:[FeedbackController new] animated:NO];
    }
    
}


- (void)switchBtnAction:(UIButton *)sender {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSInteger btnX = [ud integerForKey:[NSString stringWithFormat:@"%zd",sender.tag]];
    CGRect btnFrame = sender.frame;
    if (btnX == self.view.frame.size.width -70) {
        btnX += 20;
        btnFrame.origin.x = btnX;
        sender.frame = btnFrame;
        [sender setImage:[UIImage imageNamed:@"hm"] forState:UIControlStateNormal];
        [ud removeObjectForKey:[NSString stringWithFormat:@"%zd",sender.tag]];
        [ud setInteger:btnX forKey:[NSString stringWithFormat:@"%zd",sender.tag]];
        [ud synchronize];
        [self changeUseMessage:ud button:sender goRight:YES];
    }else {
        btnX -= 20;
        btnFrame.origin.x = btnX;
        sender.frame = btnFrame;
        [sender setImage:[UIImage imageNamed:@"an42x44"] forState:UIControlStateNormal];
        [ud removeObjectForKey:[NSString stringWithFormat:@"%zd",sender.tag]];
        [ud setInteger:btnX forKey:[NSString stringWithFormat:@"%zd",sender.tag]];
        [ud synchronize];
        [self changeUseMessage:ud button:sender goRight:NO];
    }
    
}

- (void)changeUseMessage:(NSUserDefaults *)ud button:(UIButton *)btn goRight:(BOOL)goright {
    NSString *complaintreminder =  [ud integerForKey:@"1"] == self.view.frame.size.width -70?@"1":@"0";
    NSString *applyreminder =      [ud integerForKey:@"2"] == self.view.frame.size.width -70?@"1":@"0";
    NSString *newmessagereminder = [ud integerForKey:@"0"] == self.view.frame.size.width -70?@"1":@"0";
    [NetworkEntity changeUserMessageWithUseInfoModel:[UserInfoModel defaultUserInfo] complaintReminder:complaintreminder applyreminder:applyreminder newmessagereminder:newmessagereminder success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        if ([[dataDic objectForKey:@"data"] isEqualToString:@"success"]) {

        }else {
            ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"同步失败，请检查网络连接"];
            [alertView show];
            if (goright) {
                CGRect frame = btn.frame;
                frame.origin.x -= 20 ;
                btn.frame = frame;
            }else {
                CGRect frame = btn.frame;
                frame.origin.x += 20 ;
                btn.frame = frame;
            }
            
        }
            } failure:^(AFHTTPRequestOperation *operation, id responseObject) {
                ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"同步失败，请检查网络连接"];
                [alertView show];
        if (goright) {
            CGRect frame = btn.frame;
            frame.origin.x -= 20 ;
            btn.frame = frame;
        }else {
            CGRect frame = btn.frame;
            frame.origin.x += 20 ;
            btn.frame = frame;
        }
    }];
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
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
