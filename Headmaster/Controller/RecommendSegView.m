//
//  RecommendSegView.m
//  Headmaster
//
//  Created by kequ on 15/12/5.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "RecommendSegView.h"

#define KSEGLINEHEIGTH  2
#define KSEGLINESPACING 15
#define KSEGLINECOLOR       RGB_Color(42, 42, 42)

@interface  RecommendSegView()

@property(nonatomic,strong)UIView * topLineView;
@property(nonatomic,strong)UIView * bottomView;

@end

@implementation RecommendSegView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.control.frame = CGRectMake(0, KSEGLINEHEIGTH, self.width, self.height - 2 * KSEGLINEHEIGTH);
    self.topLineView.frame = CGRectMake(KSEGLINESPACING, 0, self.width - 2 * KSEGLINESPACING, KSEGLINEHEIGTH);
    self.bottomView.frame = CGRectMake(KSEGLINESPACING, self.height - KSEGLINEHEIGTH , self.width - 2 * KSEGLINESPACING, KSEGLINEHEIGTH);
}

#pragma mark - SearchBar
- (DZNSegmentedControl *)control
{
    if (_control == nil) {
        
        [[DZNSegmentedControl appearance] setBackgroundColor:RGB_Color(0x54, 0x54, 0x54)];
        [[DZNSegmentedControl appearance] setTintColor:RGB_Color(0x01, 0xe2, 0xb6)];
        [[DZNSegmentedControl appearance] setHairlineColor:[UIColor clearColor]];
        
        [[DZNSegmentedControl appearance] setFont:[UIFont systemFontOfSize:15.f]];
        [[DZNSegmentedControl appearance] setSelectionIndicatorHeight:1];
        [[DZNSegmentedControl appearance] setAnimationDuration:0.125];
        
        _control = [[DZNSegmentedControl alloc] initWithItems:self.menuItems];
        _control.selectedSegmentIndex = 0;
        _control.backgroundColor = [UIColor clearColor];
        _control.bouncySelectionIndicator = NO;
        _control.showsCount = NO;
        [self addSubview:_control];
    }
    return _control;
}


- (NSArray *)menuItems
{
    return       @[
                   @"  好评       ",
                   @"  中评       ",
                   @"  差评       ",
                   @"  投诉       "
                   ];
    
}

#pragma mark - Line
- (UIView *)topLineView
{
    if (!_topLineView) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = KSEGLINECOLOR;
        [self addSubview:_topLineView];
    }
    return _topLineView;
}


- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = KSEGLINECOLOR;
        [self addSubview:_bottomView];
    }
    return _bottomView;
}

@end

