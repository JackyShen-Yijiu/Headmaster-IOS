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
    [self.buttonIcon setUserInteractionEnabled:YES];
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconTap:)];
    [self.buttonIcon addGestureRecognizer:ges];
    self.rateView = [[CWStarRateView alloc]initWithFrame:CGRectMake(0, 0, 146, 23) numberOfStars:5];
    [_starLevelImageView addSubview:_rateView];

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
    [self.iconImageView downloadImage:dataModel.originalpic place:[UIImage imageNamed:@"defoult_por"]];
    self.nameLabel.text = dataModel.name;
    self.mobileStr = dataModel.mobile;
    self.courseHourLabel.text =  [NSString stringWithFormat:@"%lu",dataModel.coursecount];
    self.goodCommondLabel.text = [NSString stringWithFormat:@"好评%lu",dataModel.goodcommentcount];
    self.badCommondLabel.text = [NSString stringWithFormat:@"差评%lu",dataModel.badcommentcount];
    self.mightCommondLabel.text = [NSString stringWithFormat:@"中评%lu",dataModel.generalcommentcount];
    self.complainCommondLabel.text = [NSString stringWithFormat:@"投诉%lu",dataModel.complaintcount];
    self.starLevelImageView.image = [UIImage imageNamed:@"starBlack"];
    _rateView.scorePercent = (dataModel.starlevel / 5.f);
    
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
