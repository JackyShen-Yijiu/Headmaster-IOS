//
//  CoachOfCoureDetailCell.m
//  DataDatiel
//
//  Created by ytzhang on 15/12/2.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "CoachOfCoureDetailCell.h"

@implementation CoachOfCoureDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.iconImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconTap:)];
    [self.iconImageView addGestureRecognizer:ges];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"CoachOfCoureDetailCell" owner:self options:nil];
        if (array.count) {
            self = array.lastObject;
        }
        self.backgroundColor = [UIColor clearColor];

    }
    return self;
}

- (void)refreshData:(CoachCoureDatilModel *)dataModel
{
    self.model = dataModel;
    [self.iconImageView downloadImage:dataModel.originalpic];
    self.courseHourLabel.text =  [NSString stringWithFormat:@"%lu",dataModel.coursecount];
    self.goodCommondLabel.text = [NSString stringWithFormat:@"好评%lu",dataModel.goodcommentcount];
    self.badCommondLabel.text = [NSString stringWithFormat:@"差评%lu",dataModel.badcommentcount];
    self.mightCommondLabel.text = [NSString stringWithFormat:@"中评%lu",dataModel.generalcommentcount];
    self.complainCommondLabel.text = [NSString stringWithFormat:@"投诉%lu",dataModel.complaintcount];
    self.starLevelImageView.image = [UIImage imageNamed:@"starBlack"];
//    [self.starLevelImageView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"starBlack"]]];
    

}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
}

#pragma mark - Action
- (void)iconTap:(UITapGestureRecognizer *)ges
{
    if ([_delegate respondsToSelector:@selector(coachOfCoureDetailCell:DidImessageButton:)]) {
        [_delegate coachOfCoureDetailCell:self DidImessageButton:nil];
    }
}
@end
