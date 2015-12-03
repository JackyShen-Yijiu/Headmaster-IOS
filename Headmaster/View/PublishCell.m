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
    sender.tag = 1;
    if (_deleteCell) {
        _deleteCell();
    }
}

- (void)adaptHeightWithString:(NSString *)str {
    
    /*
     //计算一个字符串完整展示出来，所需要的size
     //第一个参数是计算结果的限制，一般都只限制宽度
     //第二个参数固定写法
     //第三个参数是字符串在计算占用size时，所采用的属性，比如：字体大小
     CGSize size = [tm.body boundingRectWithSize:CGSizeMake(k_width - 90 -1 , CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:cell.bodyLabel.font forKey:NSFontAttributeName] context:nil].size;
     */
    CGSize size = [str boundingRectWithSize:CGSizeMake(h_size.width - 16 -1 , CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:_contentLabel.font forKey:NSFontAttributeName] context:nil].size;
    
    _lableHeightConstraint.constant = size.height+5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
