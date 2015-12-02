//
//  InformationListCell.h
//  Principal
//
//  Created by dawei on 15/11/26.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationListCell : UITableViewCell

@property (nonatomic, strong) NSString *detailsId;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *seeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *seeIconImageView;

@end
