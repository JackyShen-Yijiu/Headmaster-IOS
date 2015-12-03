//
//  ChatViewController.h
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/26.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#define KNOTIFICATIONNAME_DELETEALLMESSAGE @"RemoveAllMessages"

#import "EaseMessageViewController.h"
#import "TeacherModel.h"

@interface ChatViewController : EaseMessageViewController
@property(nonatomic,strong)TeacherModel * model;
@end
