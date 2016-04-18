//
//  LoginController.h
//  Headmaster
//
//  Created by 大威 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "YBBaseController.h"

@class LoginController;
@protocol LoginControllerDelegate <NSObject>
- (void)loginControllerDidLoginSucess:(LoginController *)controller;
@end

@interface LoginController : YBBaseController
@property(nonatomic,weak)id<LoginControllerDelegate>delegate;
@property (nonatomic, copy) void (^dismissController)(void);
@end
