//
//  JZMailBoxCell.h
//  Headmaster
//
//  Created by 雷凯 on 16/5/10.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JZMailboxData;
@interface JZMailBoxCell : UITableViewCell

@property (nonatomic, strong) JZMailboxData *data;
+ (CGFloat)cellHeightDmData:(JZMailboxData *)dmData;
@end
