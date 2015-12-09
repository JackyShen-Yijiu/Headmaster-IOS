//
//  HomeDetailCanClickBarChartCell.m
//  Headmaster
//
//  Created by 大威 on 15/12/8.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeDetailCanClickBarChartCell.h"
#import "YBBarChartView.h"

@interface HomeDetailCanClickBarChartCell()

@property (nonatomic, strong) YBBarChartView *barChartView;

@end

@implementation HomeDetailCanClickBarChartCell

- (instancetype)initWithWidth:(CGFloat)width Style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect rect = self.frame;
        rect.size.width = width;
        [self.contentView addSubview:self.barChartView];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.barChartView.frame = CGRectMake(15, self.titleDefaultHeight, width, self.barChartView.defaultHeight);
    }
    return self;
}

- (void)refreshUI {
    
    self.barChartView.xTitleArray = self.xTitleArray;
    self.barChartView.valueArray = self.valueArray;
    self.barChartView.xTitleMarkWordString = self.xTitleMarkWordString;
    self.barChartView.yTitleMarkWordString = self.yTitleMarkWordString;
    
    [self.barChartView refreshUI];
}

- (YBBarChartView *)barChartView {
    if (!_barChartView) {
        _barChartView = [YBBarChartView new];
    }
    return _barChartView;
}

- (CGFloat)defaultHeight {
    return self.barChartView.defaultHeight + self.titleDefaultHeight;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
