//
//  ChatViewController.h
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/26.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#define KNOTIFICATIONNAME_DELETEALLMESSAGE @"RemoveAllMessages"

#import "EaseMessageViewController.h"

@interface ChatViewController : EaseMessageViewController
- (instancetype)initWithConversationChatter:(NSString *)conversationChatter
                           conversationType:(EMConversationType)conversationType
                                       Name:(NSString *)name ava:(NSString *)ava mobile:(NSString *)mobile;

@end
