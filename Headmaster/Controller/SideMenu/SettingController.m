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
#import "EaseSDKHelper.h"

#import "APService.h"


@interface SettingController () <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate> {
    BOOL isFirstLoad;
}

@property (nonatomic, strong) UITableView      *tableView;
@property (nonatomic, copy) NSArray     *dataArr;
@property (nonatomic, weak) UIAlertView *alert;


@end

@implementation SettingController

- (void)pushBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    self.view.backgroundColor = JZ_MAIN_BACKGROUND_COLOR;
    UIView *lineTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 2)];
    lineTopView.backgroundColor = RGB_Color(41, 41, 41);
    [self.view addSubview:lineTopView];
    [self setNavBar];
    
    [self addBackgroundImage];
    [self isFirstLOad];
    [self createUI];
    
}

- (void)setNavBar {
    CGRect backframe= CGRectMake(0, 0, 16, 16);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pushBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.title = @"设置";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#fcfcfc"],NSForegroundColorAttributeName,nil]];
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
    self.dataArr = @[@[@"新消息提醒",@"投诉消息提醒",@"新学员报名提醒"],@[@"清除缓存",@"关于我们",@"去评分",@"意见反馈"]];
    self.tableView.tableFooterView = [self tableFootView];
    
    self.tableView.tableHeaderView = [self headerView];
}



#pragma mark ----lazy load 

- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSArray alloc] init];
    }
    return _dataArr;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 2, self.view.frame.size.width, self.view.frame.size.height -64-2)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = kJZLightTextColor;
        
    }
    return _tableView;
}


#pragma mark ----tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }else if (section == 1) {
        return 4;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.dataArr[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if (YBIphone6Plus) {
        cell.textLabel.font = [UIFont systemFontOfSize:14*YBRatio];
    }
    cell.textLabel.textColor = kJZDarkTextColor;
    cell.backgroundColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, self.view.width - 150 - 30, 44)];
            NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES)lastObject];
            CGFloat sizeF = [self folderSizeAtPath:path];
            NSString *message = [NSString stringWithFormat:@"%zdM",(int)sizeF];
            NSLog(@"cell-sizeF:%f",sizeF);
            
            cell.userInteractionEnabled = (int)sizeF;
            
            label.text = message;
            label.textColor = kJZDarkTextColor;
            label.font = [UIFont systemFontOfSize:12];
            if (YBIphone6Plus) {
                label.font = [UIFont systemFontOfSize:12*YBRatio];
            }
            label.textAlignment = NSTextAlignmentRight;
            [cell addSubview:label];
        }
        
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    if (indexPath.section == 0) {
        UISwitch *switchControl = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 34, 18)];
        switchControl.onTintColor = [UIColor colorWithHexString:@"3d8bff"];
        
        switchControl.tag = 100 + indexPath.row;
        
        if (indexPath.row == 0) {
            if ([UserInfoModel defaultUserInfo].newmessagereminder) {
                NSInteger num = [UserInfoModel defaultUserInfo].newmessagereminder.integerValue;
                switchControl.on = num;
               
            }else {
                switchControl.on = YES;
                
            }
        }else if (indexPath.row == 1) {
           
//            if ([UserInfoModel defaultUserInfo].complaintreminder) {
                //                BOOL setON = [UserInfoModel defaultUserInfo].complaintreminder.integerValue;
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                BOOL setON = [userDefaults boolForKey:@"setComplaint"];

                switchControl.on = setON;
                
//            }else {
//                switchControl.on = YES;
            
//            }
        }else if (indexPath.row == 2) {
            
            if ([UserInfoModel defaultUserInfo].applyreminder) {
                NSInteger num = [UserInfoModel defaultUserInfo].applyreminder.integerValue;
                NSLog(@"num:%zd",num);
                switchControl.on = num;
            }else {
                switchControl.on = YES;
                
            }
        }
        cell.accessoryView = switchControl;
        
        [switchControl addTarget:self action:@selector(switchBtnAction:) forControlEvents:UIControlEventValueChanged];
        

    
    }
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (1 == indexPath.section) {
        if (0 == indexPath.row) {
            // 清除缓存
            NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES)lastObject];
            CGFloat sizeF = [self folderSizeAtPath:path];
            NSLog(@"sizeF:%f",sizeF);
            
            if (sizeF == 0) {
                // 当缓存为0时,不让去在去清理
                [self showTotasViewWithMes:@"现在没有可清理的内存"];
                
                return;
                
            }
            NSString *message = [NSString stringWithFormat:@"缓存大小为%zdM.确定要清除缓存吗?",(int)sizeF];
            
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"清除缓存"
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定",nil];
            
            
            self.alert = alert;
            [alert show];
            
            
            
            
        }
        if (1 == indexPath.row) {
           [self.navigationController pushViewController:[AboutUsController new] animated:NO];
            
        }
        if (2 == indexPath.row) {
            // 去评分
            [self goToAppStore];
            
        }
        if (3 == indexPath.row) {
            // 意见反馈
            [self.navigationController pushViewController:[FeedbackController new] animated:NO];

          
        }
        
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}



- (void)switchBtnAction:(UISwitch *)sender {
    
    if (sender.tag - 100 == 0) {
        if (sender.on == YES) {
            [[UserInfoModel defaultUserInfo] setValue:@"1" forKey:@"newmessagereminder"];
        }else if (sender.on == NO) {
            [[UserInfoModel defaultUserInfo] setValue:@"0" forKey:@"newmessagereminder"];
        }
 
    }
    if (sender.tag - 100 == 1) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        
        if (sender.on == YES) {
//            [[UserInfoModel defaultUserInfo] setValue:@"1" forKey:@"complaintreminder"];
            [userDefaults setBool:YES forKey:@"setComplaint"];
        }else if (sender.on == NO) {
//            [[UserInfoModel defaultUserInfo] setValue:@"0" forKey:@"complaintreminder"];
            [userDefaults setBool:NO forKey:@"setComplaint"];

        }
        
        [userDefaults synchronize];
    }
    if (sender.tag - 100 == 2) {
        if (sender.on == YES) {
            [[UserInfoModel defaultUserInfo] setValue:@"1" forKey:@"applyreminder"];
        }else if (sender.on == NO) {
            [[UserInfoModel defaultUserInfo] setValue:@"0" forKey:@"applyreminder"];
        }
        
    }
    
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            NSString *newmessagereminder = [ud integerForKey:@"0"] == sender.isOn?@"1":@"0";
            NSString *complaintreminder  = [ud integerForKey:@"1"] == sender.isOn?@"1":@"0";
            NSString *applyreminder      = [ud integerForKey:@"2"] == sender.isOn?@"1":@"0";
    
    [NetworkEntity changeUserMessageWithUseInfoModel:[UserInfoModel defaultUserInfo] complaintReminder:complaintreminder applyreminder:applyreminder newmessagereminder:newmessagereminder success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        if ([[dataDic objectForKey:@"data"] isEqualToString:@"success"]) {
            
            if (sender.isOn == NO) {
                sender.on = sender.isOn;
                
                [ud removeObjectForKey:[NSString stringWithFormat:@"%zd",sender.tag]];
                [ud setInteger:sender.on forKey:[NSString stringWithFormat:@"%zd",sender.tag]];
                [ud synchronize];
                //环信消息开启免打扰模式
                if (sender.tag - 100 == 0) {
                    NSLog(@"环信消息开启免打扰模式");
                    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
                    options.noDisturbStatus = ePushNotificationNoDisturbStatusDay;
                    [[EaseMob sharedInstance].chatManager asyncUpdatePushOptions:options];
                }
            }else {
                
                sender.on = sender.isOn;
                [ud removeObjectForKey:[NSString stringWithFormat:@"%zd",sender.tag]];
                [ud setInteger:sender.on forKey:[NSString stringWithFormat:@"%zd",sender.tag]];
                [ud synchronize];
                //环信消息关闭免打扰模式
                if (sender.tag - 100 == 0) {
                    NSLog(@"环信消息关闭免打扰模式");

                    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
                    options.noDisturbStatus = ePushNotificationNoDisturbStatusClose;
                    [[EaseMob sharedInstance].chatManager asyncUpdatePushOptions:options];
                }
            
            }
            
            
        }else {
        ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"同步失败，请检查网络连接"];
        [alertView show];
        }

        
    } failure:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"同步失败，请检查网络连接"];
        [alertView show];
        
    }];


    
}

- (void)changeUseMessage:(NSUserDefaults *)ud switchBtn:(UISwitch *)btn{
    NSString *newmessagereminder = [ud integerForKey:@"0"] == btn.isOn?@"0":@"1";
    NSString *complaintreminder  = [ud integerForKey:@"1"] ==  btn.isOn?@"0":@"1";
    NSString *applyreminder      = [ud integerForKey:@"2"] ==  btn.isOn?@"0":@"1";
    if (btn.tag == 0) {
        newmessagereminder = [ud integerForKey:@"0"] == btn.isOn ? @"1":@"0";
    }else if (btn.tag == 1) {
        complaintreminder  = [ud integerForKey:@"1"] == btn.isOn ? @"1":@"0";
    }else {
        applyreminder      = [ud integerForKey:@"2"] == btn.isOn ? @"1":@"0";
    }

    
    [NetworkEntity changeUserMessageWithUseInfoModel:[UserInfoModel defaultUserInfo] complaintReminder:complaintreminder applyreminder:applyreminder newmessagereminder:newmessagereminder success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        if ([[dataDic objectForKey:@"data"] isEqualToString:@"success"]) {
//            NSInteger btnX = [ud integerForKey:[NSString stringWithFormat:@"%zd",btn.tag]];
            if (btn.isOn == NO) {
                btn.on = btn.isOn;

                [ud removeObjectForKey:[NSString stringWithFormat:@"%zd",btn.tag]];
                [ud setInteger:btn.on forKey:[NSString stringWithFormat:@"%zd",btn.tag]];
                [ud synchronize];
                //环信消息开启免打扰模式
                if (btn.tag == 0) {
                    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
                    options.noDisturbStatus = ePushNotificationNoDisturbStatusDay;
                    [[EaseMob sharedInstance].chatManager asyncUpdatePushOptions:options];
                }
            }else {

                btn.on = btn.isOn;
                [ud removeObjectForKey:[NSString stringWithFormat:@"%zd",btn.tag]];
                [ud setInteger:btn.on forKey:[NSString stringWithFormat:@"%zd",btn.tag]];
                [ud synchronize];
                //环信消息关闭免打扰模式
                if (btn.tag == 0) {
                    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
                    options.noDisturbStatus = ePushNotificationNoDisturbStatusClose;
                    [[EaseMob sharedInstance].chatManager asyncUpdatePushOptions:options];
                }
            }

        }else {
            ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"同步失败，请检查网络连接"];
            [alertView show];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, id responseObject) {
        ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"同步失败，请检查网络连接"];
        [alertView show];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIButton *)tableFootView {
    UIButton *quit = [UIButton buttonWithType:UIButtonTypeCustom];
    quit.backgroundColor = [UIColor whiteColor];
    [quit setTitle:@"退出登录" forState:UIControlStateNormal];
    quit.titleLabel.font = [UIFont systemFontOfSize:14];
    if (YBIphone6Plus) {
        quit.titleLabel.font = [UIFont systemFontOfSize:14*YBRatio];
    }
    [quit setTitleColor:kJZLightTextColor forState:UIControlStateNormal];
    quit.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    [quit addTarget:self action:@selector(UserWillLoginOut) forControlEvents:UIControlEventTouchUpInside];
    return quit;
    
}
-(UIView *)headerView {
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 2, [UIScreen mainScreen].bounds.size.width, 10)];
    
    
    headerView.backgroundColor = [UIColor clearColor];
    
    
    return headerView;
    
}
- (void)UserWillLoginOut {
    
    
    [[EaseMob sharedInstance].chatManager logoffWithUnbindDeviceToken:YES error:nil];
    
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES];
    
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
//        DYNSLog(@"asyncLogoffWithUnbindDeviceToken%@",error);
    } onQueue:nil];
    
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        
        UserInfoModel *uim = [UserInfoModel defaultUserInfo];
        [uim loginOut];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud removeObjectForKey:@"0"];
        [ud removeObjectForKey:@"1"];
        [ud removeObjectForKey:@"2"];
        [ud removeObjectForKey:@"USERIMAGE"];
        
        //极光推送设置alias
        [APService setAlias:[UserInfoModel defaultUserInfo].userID callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
        
        //友盟统计账号登出
        [MobClick profileSignOff];
        //    [self.navigationController pushViewController:lc animated:YES];
        
        [self dismissViewControllerAnimated:NO completion:^{
            [[self slideMenu] hideMenuViewController];
            [[(AppDelegate *)[[UIApplication sharedApplication] delegate] navController] popToRootViewControllerAnimated:NO];
            
        }];
        
    } onQueue:nil];
    
    }

-(void)tagsAliasCallback:(int)iResCode
                    tags:(NSSet*)tags
                   alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}



#pragma mark ------ 去评分和版本更新相关操作
- (void)goToAppStore{
    NSString *str = [NSString stringWithFormat:@"https://itunes.apple.com/us/app/ji-zhi-xiao-zhang/id1089884462?mt=8"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

#pragma mark ----- 清除缓存相关操作

// 计算单个文件大小
- (float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}
// 清除文件缓存
- (void)clearCache:(NSString *)path{
    NSLog(@"path = %@",path);
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager contentsOfDirectoryAtPath:path error:NULL];;
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}
// 计算目录大小
- (float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize = 0;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[self fileSizeAtPath:absolutePath];
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}

#pragma mark - alertView代理
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES)lastObject];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 开子线程进行清除内存
            [self clearCache:path];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self showTotasViewWithMes:@"清除成功"];
                
                NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:1];
                [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
                
                
            });
            
        });

        
        
        
    }
}


@end
