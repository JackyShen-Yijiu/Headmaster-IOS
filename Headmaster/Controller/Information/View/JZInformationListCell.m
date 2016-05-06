//
//  JZInformationListCell.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/6.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZInformationListCell.h"

@interface JZInformationListCell()
///  新闻图片
@property (nonatomic, weak) UIImageView *newsImageView;
///  新闻标题
@property (nonatomic, weak) UILabel *newsTitleLabel;
///  新闻日期
@property (nonatomic, weak) UILabel *newsDateLabel;

@end
@implementation JZInformationListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
