//
//  JZUserLoginManager.m
//  Headmaster
//
//  Created by ytzhang on 16/5/25.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZUserLoginManager.h"
#import "LoginController.h"

@implementation JZUserLoginManager
// 获得登录窗体
+ (UIViewController *)loginController {
    
    static LoginController *loginVC = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        loginVC = [LoginController new];
    });
    return loginVC;
}

@end
