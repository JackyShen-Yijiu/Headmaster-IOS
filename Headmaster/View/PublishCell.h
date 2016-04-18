//
//  PublishCell.h
//  hudongyuan
//
//  Created by 胡东苑 on 15/11/28.
//  Copyright © 2015年 胡东苑. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublishDataModel.h"
#import "YBBaseTableCell.h"

@interface PublishCell : YBBaseTableCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lableHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic, copy) void(^deleteCell)();
@property (weak, nonatomic) IBOutlet UILabel *whichPersonLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

- (void)adaptHeightWithString:(NSString *)str;

- (void)refreshData:(PublishDataModel *)dataModel;

@end
