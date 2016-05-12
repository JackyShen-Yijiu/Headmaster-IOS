//
//  JZCoachFeedbackView.h
//  Headmaster
//
//  Created by 雷凯 on 16/5/11.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JZMailboxData;
@interface JZCoachFeedbackView : UIView
@property (nonatomic, strong) JZMailboxData *data;
@property (nonatomic, assign) NSInteger index;

+ (CGFloat)coachFeedbackViewH:(JZMailboxData *)data;
@end
