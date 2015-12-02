//
//  TeacherCell.h
//  Headmaster
//
//  Created by kequ on 15/12/1.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PortraitView.h"
#import "TeacherModel.h"

@class TeacherCell;
@protocol TeacherCellDelegate <NSObject>
- (void)teacherCell:(TeacherCell *)cell didClickMessageButton:(UIButton *)button;
@end
@interface TeacherCell : UITableViewCell
@property(nonatomic,strong)TeacherModel * model;
@property(nonatomic,weak)id<TeacherCellDelegate>delegate;
+ (CGFloat)cellHigth;

@end
