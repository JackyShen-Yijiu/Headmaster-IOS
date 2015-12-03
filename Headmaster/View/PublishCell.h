//
//  PublishCell.h
//  hudongyuan
//
//  Created by 胡东苑 on 15/11/28.
//  Copyright © 2015年 胡东苑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lableHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic, copy) void(^deleteCell)();

- (void)adaptHeightWithString:(NSString *)str;

@end
