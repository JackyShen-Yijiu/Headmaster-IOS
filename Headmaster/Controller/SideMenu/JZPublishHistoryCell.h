//
//  JZPublishHistoryCell.h
//  Headmaster
//
//  Created by 雷凯 on 16/4/19.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JZPublishHistoryData;
@interface JZPublishHistoryCell : UITableViewCell
@property (nonatomic, strong) JZPublishHistoryData *data;

+ (CGFloat)cellHeightDmData:(JZPublishHistoryData *)dmData;


@end
