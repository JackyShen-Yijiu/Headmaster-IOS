//
//  JZComplaintCell.h
//  Headmaster
//
//  Created by 雷凯 on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JZComplaintComplaintlist;
@interface JZComplaintCell : UITableViewCell

@property (nonatomic, strong) JZComplaintComplaintlist *data;
+ (CGFloat)cellHeightDmData:(JZComplaintComplaintlist *)dmData;
@end
