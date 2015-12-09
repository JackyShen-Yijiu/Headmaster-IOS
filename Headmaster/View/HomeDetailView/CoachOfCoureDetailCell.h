//
//  CoachOfCoureDetailCell.h
//  DataDatiel
//
//  Created by ytzhang on 15/12/2.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoachCoureDatilModel.h"

#import "YBBaseTableCell.h"

@class CoachOfCoureDetailCell;

@protocol CoachOfCoureDetailCellDelegate <NSObject>
- (void)coachOfCoureDetailCell:(CoachOfCoureDetailCell *)cell DidImessageButton:(UIButton *)button;

@end
@interface CoachOfCoureDetailCell : YBBaseTableCell
@property (nonatomic,weak) id<CoachOfCoureDetailCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *courseHourLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodCommondLabel;
@property (weak, nonatomic) IBOutlet UILabel *mightCommondLabel;
@property (weak, nonatomic) IBOutlet UILabel *badCommondLabel;
@property (weak, nonatomic) IBOutlet UILabel *complainCommondLabel;
@property (nonatomic,strong)CoachCoureDatilModel * model;
@property (weak, nonatomic) IBOutlet UILabel *BottomLineLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starLevelImageView;

- (void)refreshData:(CoachCoureDatilModel *)dataModel;
@end
