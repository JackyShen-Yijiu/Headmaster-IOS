//
//  AppDelegate.m
//  Headmaster
//
//  Created by kequ on 15/11/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "AppDelegate.h"
#import "MobClick.h"
#import "EaseSDKHelper.h"
#import "AFNetworkActivityLogger.h"
#import "APService.h"
#import "HMNagationController.h"
#import "LoginController.h"
#import "TeacherController.h"
#import "YBWelcomeController.h"
#import "AppDelegate+RootViewController.h"
#import "LoginController.h"
#import "InformationController.h"

@interface AppDelegate ()

//@property(nonatomic,strong)HMNagationController * navController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self sysConfigWithApplication:application LaunchOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
//    LoginController * loginViewC = [[LoginController alloc] init];
//    self.navController = [[HMNagationController alloc] initWithRootViewController:loginViewC];
//    self.window.rootViewController =  self.navController;
//    [self.window makeKeyAndVisible];
//    if ([UserInfoModel isLogin]) {
//        [self loginViewControllerdidLoginSucess:nil];
//    }
//    if([self isReciveFromHunaxin:launchOptions]){
//        [self.navController jumpToMessageList];
//    }
//    [self.navController pushViewController:[self rootViewController] animated:YES];
    
    
//    self.window.rootViewController = [self rootViewController];
//    self.window.rootViewController = [LoginController new];
    self.window.rootViewController = [InformationController new];
    [self.window makeKeyAndVisible];
    
    [self sysConfigWithApplication:application LaunchOptions:launchOptions];
    
    // 添加引导页
//    [YBWelcomeController removeSavedVersion]; // 测试引导页时使用打开注释
    if ([YBWelcomeController isShowWelcome]) {
        [YBWelcomeController show];
    }
    
    return YES;
}

#pragma mark - 系统配置
- (void)sysConfigWithApplication:(UIApplication *)application LaunchOptions:(NSDictionary *)launchOptions
{
    //umeng统计
    [MobClick startWithAppkey:@"564dc12967e58ee280001457" reportPolicy:BATCH   channelId:nil];
    
    //AFNet log显示
    AFNetworkReachabilityManager *  manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [[AFNetworkActivityLogger sharedLogger] startLogging];
    
    //环信
    NSString *apnsCertName = nil;
    //#if DEBUG
    //    apnsCertName = @"modoujiaxiaoPushDev";
    //#else
    //    apnsCertName = @"modoujiaxiaoPushDis";
    //#endif
    apnsCertName = @"dis_apns";
    [[EaseSDKHelper shareHelper] easemobApplication:application
                      didFinishLaunchingWithOptions:launchOptions
                                             appkey:@"black-cat#yibuxuecheprod"
                                       apnsCertName:apnsCertName
                                        otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
    //极光推送
    [APService
     registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                         UIUserNotificationTypeSound |
                                         UIUserNotificationTypeAlert)
     categories:nil];
    
    [APService setupWithOption:launchOptions];
}

#pragma mark - Nofitication
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [APService registerDeviceToken:deviceToken];
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

//接受通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    if ([self isReciveFromHunaxin:userInfo]) {
//        [self.navController jumpToMessageList];
    }else{
        [APService handleRemoteNotification:userInfo];
    }
}

- (BOOL)isReciveFromHunaxin:(NSDictionary *)dic
{
    return  [dic objectStringForKey:@"f"] &&
    [dic objectStringForKey:@"m"] &&
    [dic objectStringForKey:@"t"];
}

@end
