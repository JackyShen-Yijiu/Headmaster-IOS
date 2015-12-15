//
//  AppDelegate+RootViewController.h
//  Headmaster
//
//  Created by 大威 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (RootViewController)<RESideMenuDelegate>

- (UIViewController *)rootViewController;

- (UIViewController *)sideControllerWithContentController:(UINavigationController *)naviController;

@end
