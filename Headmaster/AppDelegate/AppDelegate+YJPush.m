//
//  AppDelegate+YJPush.m
//  HeiMao_B
//
//  Created by 大威 on 16/1/21.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "AppDelegate+YJPush.h"

@implementation AppDelegate (YJPush)

- (void)handleJPushNotification:(NSDictionary *)userInfo {
    
    if (![userInfo isKindOfClass:[NSDictionary class]]) {
        return ;
    }
    NSString *type = [userInfo objectForKey:@"type"];
    if (!type) {
        return ;
    }
    
    // 获取提示信息
    NSDictionary *aps = userInfo[@"aps"];
    
    if (aps&&aps.count!=0) {
        
        NSString *message = aps[@"alert"];
        
        NSDictionary *data = [userInfo objectForKey:@"data"];
        if (data&&data.count!=0) {
#warning 从data中去除字段进行定向界面跳转处理
        }
        
        // jpush后台推送
        if ([type isEqualToString:@"1"]) {
#warning 从userInfo中取得其他字段，进行界面跳转，跳转web
            [self showAlertWithMessage:message];
        }
        
        /*
         
         ApplySuccess:"有新的学员报名你的驾校,请查看",
         Complaint:"收到新的投诉消息，请查看",
         NewVersion:config.appname+"有版本更新啦！"
         
         */
        
        // 有新的学员报名你的驾校,请查看
        if ([type isEqualToString:@"ApplySuccess"]) {
            
            [self showAlertWithMessage:message];
        }
        
        // 收到新的投诉消息，请查看
        if ([type isEqualToString:@"Complaint"]) {
            [self showAlertWithMessage:message];
        }
        
        // 有版本更新啦！
        if ([type isEqualToString:@"NewVersion"]) {
            [self showAlertWithMessage:message];
        }
        
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 显示弹窗提示
- (void)showAlertWithMessage:(NSString *)message {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}

@end
