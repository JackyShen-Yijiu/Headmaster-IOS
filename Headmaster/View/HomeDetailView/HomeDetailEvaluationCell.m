//
//  HomeDetailEvaluationCell.m
//  Headmaster
//
//  Created by 大威 on 15/12/9.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeDetailEvaluationCell.h"
#import "ZTJudgeBottonSign.h"

@interface HomeDetailEvaluationCell()

@property (nonatomic, strong) ZTJudgeBottonSign *bottomView;

@end

@implementation HomeDetailEvaluationCell

- (instancetype)initWithWidth:(CGFloat)width Style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithWidth:width Style:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.bottomView];
        self.bottomView.frame = CGRectMake(15, [super defaultHeight], width, 40);
    }
    return self;
}

- (CGFloat)defaultHeight {
    return [super defaultHeight] + 40;
}

- (ZTJudgeBottonSign *)bottomView {
    if (!_bottomView) {
        _bottomView = [ZTJudgeBottonSign new];
    }
    return _bottomView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
