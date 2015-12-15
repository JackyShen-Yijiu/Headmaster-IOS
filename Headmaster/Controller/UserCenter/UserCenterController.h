//
//  UserCenterController.h
//  Headmaster
//
//  Created by 胡东苑 on 15/12/5.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "YBBaseController.h"

@interface UserCenterController : YBBaseController

@property (nonatomic, copy) void (^hideMenu)(void);

@property (nonatomic, copy) UIImage *iconImage;

@end
