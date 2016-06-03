//
//  AppDelegate.m
//  Headmaster
//
//  Created by kequ on 15/11/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "AppDelegate.h"
#import "EaseSDKHelper.h"
#import "AFNetworkActivityLogger.h"
#import "APService.h"
#import "HMNagationController.h"
#import "LoginController.h"
#import "TeacherController.h"
#import "YBWelcomeController.h"
#import "AppDelegate+RootViewController.h"
#import "LoginController.h"
#import "ProjectGuideView.h"
#import "AppDelegate+YJPush.h"
#import "ViewController.h"
#import "WMCommon.h"
#import "JZUserLoginManager.h"

@interface AppDelegate ()<LoginControllerDelegate,IChatManagerDelegate>
{
    BOOL isReceiveMessage;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucess) name:longinSuccess object:nil];
    // 系统基本信息配置
    
   [self sysConfigWithApplication:application LaunchOptions:launchOptions];
//
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    WMCommon *common = [WMCommon getInstance];
    common.screenW = [[UIScreen mainScreen] bounds].size.width;
    common.screenH = [[UIScreen mainScreen] bounds].size.height;
    
    // 引导页
    if ([YBWelcomeController isShowWelcome]) {
        self.window.rootViewController = [[YBWelcomeController alloc] init];
    }else{
        if ([UserInfoModel isLogin]) {
            [self loginControllerDidLoginSucess:nil];
        }else{
            LoginController *loginVC = (LoginController *)[JZUserLoginManager loginController];
            loginVC.delegate = self;
            self.window.rootViewController = loginVC;
            
        }
    }

    [self.window makeKeyAndVisible];
    
    if([self isReciveFromHunaxin:launchOptions]){
        [self.navController jumpToMessageList];
    }
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    return YES;
    
}

#pragma mark - LoginDelegate
- (void)loginControllerDidLoginSucess:(LoginController *)controller
{
    
//    //设置是否自动登录
//    [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
//    
//    // 旧数据转换 (如果您的sdk是由2.1.2版本升级过来的，需要家这句话)
//    [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
//    //获取数据库中数据
//    [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
    
    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
    NSLog(@"[UserInfoModel defaultUserInfo].name:%@",[UserInfoModel defaultUserInfo].name);
    options.nickname = [UserInfoModel defaultUserInfo].name;
    options.displayStyle = ePushNotificationDisplayStyle_messageSummary;
    
    [self.navController setNavigationBarHidden:NO];
    
    ViewController *viewVC = [[ViewController alloc] init];
   self.window.rootViewController = viewVC;
    
}
- (void)loginSucess{
    //    //设置是否自动登录
    //    [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
    //
    //    // 旧数据转换 (如果您的sdk是由2.1.2版本升级过来的，需要家这句话)
    //    [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
    //    //获取数据库中数据
    //    [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
    
    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
    NSLog(@"[UserInfoModel defaultUserInfo].name:%@",[UserInfoModel defaultUserInfo].name);
    options.nickname = [UserInfoModel defaultUserInfo].name;
    options.displayStyle = ePushNotificationDisplayStyle_messageSummary;
    
    [self.navController setNavigationBarHidden:NO];
    
    ViewController *viewVC = [[ViewController alloc] init];
    self.window.rootViewController = viewVC;
}
#pragma mark - 系统配置
- (void)sysConfigWithApplication:(UIApplication *)application LaunchOptions:(NSDictionary *)launchOptions
{
    //umeng统计
    [MobClick startWithAppkey:umengAppkey reportPolicy:BATCH   channelId:nil];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick setLogEnabled:NO];
    
    //AFNet log显示
    AFNetworkReachabilityManager *  manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [[AFNetworkActivityLogger sharedLogger] startLogging];
    
    //环信
    [[EaseSDKHelper shareHelper] easemobApplication:application
                      didFinishLaunchingWithOptions:launchOptions
                                             appkey:easeMobAPPkey
                                       apnsCertName:easeMobPushName
                                        otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
    // 注册环信
    [self registerEaseMobNotification];
    
    // Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound |UIUserNotificationTypeAlert) categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert) categories:nil];
    }
    // Required
    [APService setupWithOption:launchOptions];
    
    if ([UserInfoModel defaultUserInfo].userID) {
        //        NSString *coachID = [NSString stringWithFormat:@"%@",[UserInfoModel defaultUserInfo].driveschoolinfo[@"id"]];
        //        NSSet *set = [NSSet setWithObjects:JPushTag,coachID, nil];
        [APService setTags:nil alias:[UserInfoModel defaultUserInfo].userID callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
    }
    
}

- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    NSString *callbackString =
    [NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,
     tags, alias];
    NSLog(@"TagsAlias回调:%@", callbackString);
}

#pragma mark - registerEase]MobNotification
- (void)registerEaseMobNotification{
    [self unRegisterEaseMobNotification];
    // 将self 添加到SDK回调中，以便本类可以收到SDK回调
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

- (void)unRegisterEaseMobNotification{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

#pragma mark - Nofitication
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"注册token：%@",deviceToken);
    [APService registerDeviceToken:deviceToken];
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"注册失败");
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

//接受通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    if ([self isReciveFromHunaxin:userInfo]) {
        [self.navController jumpToMessageList];
    }else{
        [APService handleRemoteNotification:userInfo];
        [self handleJPushNotification:userInfo];
    }
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler
{
    
#warning 当App在后台接受到消息推送,点击消息提醒,调用此方法
#warning 当App在前台接受到消息推送,直接调用此方法
    
    NSLog(@"%s userInfo:%@",__func__,userInfo);
    /*
     // 自定义消息
     {
     "_j_msgid" = 4122902527;
     aps =     {
     alert = "\U6d4b\U8bd5\U6559\U7ec3\U7aef\U63a8\U9001";
     badge = 1;
     sound = default;
     };
     type = 1;
     }
     // 接受到后台消息
     
     {
     "_j_msgid" = 1488777374;
     aps =     {
     alert = babababbaba;
     badge = 1;
     sound = default;
     };
     data = {
     reservationid = 11111
     userid = 554154544
     }
     type = "dasdsa"
     
     }
     
     */
    
    completionHandler(UIBackgroundFetchResultNewData);
    
    
    // ????????????????????????????????????   区分消息来自环信和JPush
    
    if ([self isReciveFromHunaxin:userInfo]) {
        [self.navController jumpToMessageList];
    }else{
        [APService handleRemoteNotification:userInfo];
        [self handleJPushNotification:userInfo];
    }
}

- (BOOL)isReciveFromHunaxin:(NSDictionary *)dic
{
    return  [dic objectStringForKey:@"f"] &&
    [dic objectStringForKey:@"m"] &&
    [dic objectStringForKey:@"t"];
}

- (void)didReceiveMessage:(EMMessage *)message
{
    
    NSLog(@"didReceiveMessage message.messageBodies:%@",message.messageBodies);
    
    if (([UIApplication sharedApplication].applicationState == UIApplicationStateActive)&&([[NSUserDefaults standardUserDefaults] boolForKey:@"isInChatVc"])) {
        return;
    }
    
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    notification.alertBody = [NSString stringWithFormat:@"%@",@"你有一条新消息,快点击查看吧"];
    notification.alertAction = NSLocalizedString(@"确定", @"确定");
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
        
    });
    
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = unreadCount;
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"接收到环信推送通知UILocalNotification = %@",notification);
    if (isReceiveMessage==NO) {
        isReceiveMessage=YES;
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"你有一条新消息,快点击查看吧" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    isReceiveMessage = NO;
    
    // 统计未读消息
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
