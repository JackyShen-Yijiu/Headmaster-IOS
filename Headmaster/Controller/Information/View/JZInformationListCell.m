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
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
// Configure the view for the selected state
}

-(UIImageView *)newsImageView {
    
    if (!_newsImageView) {
        
        UIImageView *newsImageView = [[UIImageView alloc]init];
        self.newsImageView = newsImageView;
        [self.contentView addSubview:newsImageView];
        
    }
    return _newsImageView;
}

-(UILabel *)newsTitleLabel {
    if (!_newsTitleLabel) {
        
        UILabel *newsTitleLabel = [[UILabel alloc]init];
        
        [newsTitleLabel setFont:[UIFont systemFontOfSize:14]];
        newsTitleLabel.textColor = [UIColor blackColor];
        self.newsTitleLabel = newsTitleLabel;
        [self.contentView addSubview:newsTitleLabel];
        
    }
    return _newsTitleLabel;

    
}

-(UILabel *)newsDateLabel {
    if (!_newsDateLabel) {
        
        UILabel *newsDateLabel = [[UILabel alloc]init];
        
        [newsDateLabel setFont:[UIFont systemFontOfSize:14]];
        newsDateLabel.textColor = [UIColor blackColor];
        self.newsDateLabel = newsDateLabel;
        [self.contentView addSubview:newsDateLabel];

    }
    return _newsDateLabel;
}

@end
