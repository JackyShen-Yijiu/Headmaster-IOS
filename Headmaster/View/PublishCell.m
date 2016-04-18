//
//  PublishCell.m
//  hudongyuan
//
//  Created by 胡东苑 on 15/11/28.
//  Copyright © 2015年 胡东苑. All rights reserved.
//

#import "PublishCell.h"

#define h_size [UIScreen mainScreen].bounds.size

@implementation PublishCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)buttonClick:(UIButton *)sender {
    ToastAlertView *tav = [[ToastAlertView alloc] initWithTitle:@"暂未开放此功能"];
    [tav show];
//    if (_deleteCell) {
//        _deleteCell();
//    }
}

- (void)adaptHeightWithString:(NSString *)str {
    CGSize size = [str boundingRectWithSize:CGSizeMake(h_size.width - 16 -1 , CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:_contentLabel.font forKey:NSFontAttributeName] context:nil].size;
    
    _lableHeightConstraint.constant = size.height+1;
}

- (void)refreshData:(PublishDataModel *)dataModel {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentLabel.text = dataModel.content;
    self.contentLabel.textColor = [UIColor colorWithHexString:TEXT_HIGHLIGHT_COLOR];
    [self adaptHeightWithString:dataModel.content];
    self.whichPersonLabel.textColor = [UIColor colorWithHexString:DARK_COLOR];
    if ([dataModel.bulletobject isEqualToString:@"1"]) {
        self.whichPersonLabel.text = @"学员";
    }else {
        self.whichPersonLabel.text = @"教练";
    }
    NSRange rangeTime = NSMakeRange(0, 10);
    NSRange rangeData = NSMakeRange(11, 5);
    self.dateLabel.text = [dataModel.createtime substringWithRange:rangeTime];
    self.timeLabel.text = [dataModel.createtime substringWithRange:rangeData];
    self.timeLabel.textColor = [UIColor colorWithHexString:TEXT_NORMAL_COLOR];
    self.dateLabel.textColor = [UIColor colorWithHexString:TEXT_NORMAL_COLOR];
}

- (void)amOrpm:(NSString *)str {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
