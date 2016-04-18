//
//  HomeDetailNormalLineChartCell.m
//  Headmaster
//
//  Created by 大威 on 15/12/8.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeDetailNormalLineChartCell.h"
#import "YBLineChartView.h"

@interface HomeDetailNormalLineChartCell()

@property (nonatomic, strong) YBLineChartView *lineChartView;

@end

@implementation HomeDetailNormalLineChartCell

- (instancetype)initWithWidth:(CGFloat)width Style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.lineChartView];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _lineChartView.frame = CGRectMake(13, self.titleDefaultHeight, width, _lineChartView.defaultHeight);
    }
    return self;
}

- (void)refreshUI {
    
    self.lineChartView.xTitleArray = self.xTitleArray;
    self.lineChartView.valueArray = self.valueArray;
    self.lineChartView.xTitleMarkWordString = self.xTitleMarkWordString;
    self.lineChartView.yTitleMarkWordString = self.yTitleMarkWordString;
    
    [self.lineChartView refreshUI];
}

- (YBLineChartView *)lineChartView {
    if (!_lineChartView) {
        _lineChartView = [YBLineChartView new];
    }
    return _lineChartView;
}

- (CGFloat)defaultHeight {
    return self.titleDefaultHeight + self.lineChartView.defaultHeight;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
