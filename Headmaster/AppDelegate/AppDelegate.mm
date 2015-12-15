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

@interface AppDelegate ()<LoginControllerDelegate>
@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self sysConfigWithApplication:application LaunchOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    LoginController * loginViewC = [[LoginController alloc] init];
    loginViewC.delegate = self;
    
    self.navController = [[HMNagationController alloc] initWithRootViewController:loginViewC];
    self.window.rootViewController = [self sideControllerWithContentController:self.navController];

    if ([UserInfoModel isLogin]) {
        [self loginControllerDidLoginSucess:nil];
    }
    
    if([self isReciveFromHunaxin:launchOptions]){
        [self.navController jumpToMessageList];
    }
    
    // 添加引导页
//    [YBWelcomeController removeSavedVersion]; // 测试引导页时打开注释
    if ([YBWelcomeController isShowWelcome]) {
//         当需要引导页时打开注释
        [YBWelcomeController show];
    }
    return YES;
}

#pragma mark - LoginDelegate
- (void)loginControllerDidLoginSucess:(LoginController *)controller
{
    [self.navController setNavigationBarHidden:NO];
    UIViewController * viewController = [self rootViewController];
    [self.navController pushViewController:viewController animated:controller ? YES : NO];
}

#pragma mark - 系统配置
- (void)sysConfigWithApplication:(UIApplication *)application LaunchOptions:(NSDictionary *)launchOptions
{
    //umeng统计
    [MobClick startWithAppkey:@"5667f8a467e58e8aca001142" reportPolicy:BATCH   channelId:nil];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick setLogEnabled:NO];
    
    //AFNet log显示
    AFNetworkReachabilityManager *  manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [[AFNetworkActivityLogger sharedLogger] startLogging];
    
    //环信
    NSString *apnsCertName = nil;
    
    
    
//    #if DEBUG
//        apnsCertName = @developXZPush";
//    #else
//        apnsCertName = @"pordXZPush";
//    #endif
    
    apnsCertName = @"dis_apns";
    [[EaseSDKHelper shareHelper] easemobApplication:application
                      didFinishLaunchingWithOptions:launchOptions
                                             appkey:@"black-cat#yibuxuechetest"
                                       apnsCertName:apnsCertName
                                        otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
    //极光推送
    [APService
     registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                         UIUserNotificationTypeSound |
                                         UIUserNotificationTypeAlert)
     categories:nil];
    
    [APService setupWithOption:launchOptions];
}


#pragma mark - Nofitication
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"%@",deviceToken);
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
        [self.navController jumpToMessageList];
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
