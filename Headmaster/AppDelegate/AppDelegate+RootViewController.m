//
//  AppDelegate+RootViewController.m
//  Headmaster
//
//  Created by 大威 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "AppDelegate+RootViewController.h"
#import "HMNagationController.h"
#import "RESideMenu.h"
#import "MenuController.h"
#import "DVVTabBarController.h"
#import "RecommendViewController.h"
#import "RecommendViewController.h"
#import "ConversationListController.h"

@implementation AppDelegate (RootViewController)

- (UIViewController *)rootViewController {

    NSArray *controllerArray = @[ @"HomeController",
                                  @"InformationController",
                                  @"ConversationListController"];
    
    NSArray *titleArray = @[ @"数据概览", @"资讯", @"消息" ];
    
    DVVTabBarController *tabBarVC = [DVVTabBarController new];
    
    // 循环创建Controller
    for (NSInteger i = 0; i < controllerArray.count; i++) {
        
        Class vcClass = NSClassFromString(controllerArray[i]);
        UIViewController *viewController = [vcClass new];
        viewController.title = titleArray[i];
//        HMNagationController *naviVC = [[HMNagationController alloc] initWithRootViewController:viewController];
        [tabBarVC addChildViewController:viewController];
    }
    
    
    return tabBarVC;
}

- (UIViewController *)sideControllerWithContentController:(UINavigationController *)naviController {
    
    //创建sideMenu
    MenuController * sideVC = [[MenuController alloc] init];
    
    //创建抽屉
    static RESideMenu *sideViewController = nil;
    sideViewController = [[RESideMenu alloc] initWithContentViewController:naviController leftMenuViewController:sideVC rightMenuViewController:nil];
    sideViewController.backgroundImage = [UIImage imageNamed:@""];
    sideViewController.menuPreferredStatusBarStyle = 1;
    
    //阴影颜色
    sideViewController.contentViewShadowColor = [UIColor blackColor];
    //阴影偏移量
    sideViewController.contentViewShadowOffset = CGSizeMake(-5, 0);
    //阴影不透明度
    sideViewController.contentViewShadowOpacity = 0.5;
    //阴影半径范围
    sideViewController.contentViewShadowRadius = 12;
    //是否启用阴影
    sideViewController.contentViewShadowEnabled = YES;
    //缩放比例 2.2～0.0
    sideViewController.contentViewScaleValue = 0.8;
    //是否启用缩放
    sideViewController.scaleBackgroundImageView = NO;
    //设置动画时间
    sideViewController.animationDuration = 0.3;
    
    sideViewController.menuPrefersStatusBarHidden = NO;
    
    //RESideMenu默认设置的状态栏颜色总是黑色的，修改其中的preferredStatusBarStyle方法，使其返回白色状态栏
    return sideViewController;

}

@end
