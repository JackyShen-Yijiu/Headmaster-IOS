//
//  DVVTabBarController.h
//  DVVTabBarController
//
//  Created by 大威 on 15/12/4.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeController.h"
#import "JZInformationController.h"
#import "JZMailBoxController.h"

@protocol IWTabBarViewControllerDelegate <NSObject>

- (void)IWTabBarViewControllerWithLeftBarDidClick;

@end

@interface DVVTabBarController : UITabBarController

@property (assign, nonatomic) kControllerType   vcType;// 控制器类型

@property (strong, nonatomic) HomeController   *homeVC;
@property (strong, nonatomic) JZInformationController   *informationVC;
@property (strong, nonatomic) JZMailBoxController   *mailBoxVC;


@property (nonatomic,weak)id<IWTabBarViewControllerDelegate>delegate;

@end
