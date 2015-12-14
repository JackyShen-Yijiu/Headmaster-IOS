//
//  CoachOfCoureDetailCell.h
//  DataDatiel
//
//  Created by ytzhang on 15/12/2.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoachCoureDatilModel.h"
#import "CWStarRateView.h"

#import "YBBaseTableCell.h"

@class CoachOfCoureDetailCell;

@protocol CoachOfCoureDetailCellDelegate <NSObject>
- (void)coachOfCoureDetailCell:(CoachOfCoureDetailCell *)cell DidImessageButton:(UIButton *)button;

@end
@interface CoachOfCoureDetailCell : YBBaseTableCell
@property (nonatomic,weak) id<CoachOfCoureDetailCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *buttonIcon;
@property (weak, nonatomic) IBOutlet UILabel *courseHourLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodCommondLabel;
@property (weak, nonatomic) IBOutlet UILabel *mightCommondLabel;
@property (weak, nonatomic) IBOutlet UILabel *badCommondLabel;
@property (weak, nonatomic) IBOutlet UILabel *complainCommondLabel;
@property (nonatomic,strong)CoachCoureDatilModel * model;
@property (weak, nonatomic) IBOutlet UIImageView *starLevelImageView;
@property (nonatomic, strong) CWStarRateView *rateView;

- (void)refreshData:(CoachCoureDatilModel *)dataModel;
@end
