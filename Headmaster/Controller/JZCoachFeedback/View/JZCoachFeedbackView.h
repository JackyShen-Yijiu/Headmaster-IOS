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
///驾校头像
@property (nonatomic, strong) UIImageView *schoolIcon;
///  校长名称
@property (nonatomic, strong) UILabel *headmasterNameLabel;
///  回复时间
@property (nonatomic, strong) UILabel *replyDateLabel;
///  回复内容
@property (nonatomic, strong) UILabel *replyCotentLabel;

///  “回复”这两个字
@property (nonatomic, strong) UILabel *replyLabel;
+ (CGFloat)coachFeedbackViewH:(JZMailboxData *)data;
@end
