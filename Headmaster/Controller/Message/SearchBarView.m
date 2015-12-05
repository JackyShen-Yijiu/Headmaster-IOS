//
//  SearchBarView.m
//  Headmaster
//
//  Created by kequ on 15/12/5.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "SearchBarView.h"

#define LINEHEIGTH  5
#define LINESPACING 15
#define LINECOLOR       RGB_Color(0, 0, 0)


@interface SearchBarView()
@property(nonatomic,strong)UIView * topLineView;
@property(nonatomic,strong)UIView * bottomView;

@end

@implementation SearchBarView

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.searchBar.frame = CGRectMake(0, LINEHEIGTH, self.width, self.height - 2 * LINEHEIGTH);
    self.topLineView.frame = CGRectMake(LINESPACING, 0, self.width - 2 * LINESPACING, LINEHEIGTH);
    self.bottomView.frame = CGRectMake(self.height - LINEHEIGTH, 0, self.width - 2 * LINESPACING, LINEHEIGTH);
}

#pragma mark - SearchBar
- (UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc] initWithFrame: CGRectMake(0, 0, self.width, 37)];
        _searchBar.backgroundColor = [UIColor clearColor];
        [_searchBar setContentMode:UIViewContentModeLeft];
        [self addSubview:_searchBar];
    }
    return _searchBar;

}


- (UIView *)topLineView
{
    if (!_topLineView) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = LINECOLOR;
        [self addSubview:_topLineView];
    }
    return _topLineView;
}


- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = LINECOLOR;
        [self addSubview:_bottomView];
    }
    return _bottomView;
}

@end
