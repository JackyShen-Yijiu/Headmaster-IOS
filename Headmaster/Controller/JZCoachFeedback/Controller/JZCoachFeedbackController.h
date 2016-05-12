//
//  JZCoachFeedbackController.h
//  Headmaster
//
//  Created by 雷凯 on 16/5/11.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZCoachFeedbackView.h"

@class JZMailboxData;
//@class JZCoachFeedbackView;

@interface JZCoachFeedbackController : UIViewController
@property (nonatomic, strong) JZMailboxData *dataModel;
@property (nonatomic, assign) NSInteger  index;

@end
