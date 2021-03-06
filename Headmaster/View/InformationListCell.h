//
//  InformationListCell.h
//  Principal
//
//  Created by dawei on 15/11/26.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationDataModel.h"
#import "YBBaseTableCell.h"

@interface InformationListCell : YBBaseTableCell

@property (nonatomic, strong) NSString *detailsId;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void)refreshData:(InformationDataModel *)dataModel;

@end
