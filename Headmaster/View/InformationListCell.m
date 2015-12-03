//
//  InformationListCell.m
//  Principal
//
//  Created by dawei on 15/11/26.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import "InformationListCell.h"

@implementation InformationListCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"InformationListCell" owner:self options:nil];
        if (array.count) {
            self = array.lastObject;
        }
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
