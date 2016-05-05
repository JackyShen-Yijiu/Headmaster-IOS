//
//  SearchBarView.m
//  Headmaster
//
//  Created by kequ on 15/12/5.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "SearchBarView.h"

#define LINEHEIGTH  2
#define LINESPACING 0
#define LINECOLOR       RGB_Color(42, 42, 42)


@interface HMSearchbar : UISearchBar

@end

@implementation HMSearchbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView *subview in [[self.subviews lastObject] subviews]) {
        subview.backgroundColor = [UIColor clearColor];
        
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
        }
        
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
            UITextField *textField = (UITextField *)subview;
            [textField setBorderStyle:UITextBorderStyleNone];
            textField.background = nil;
            textField.font = [UIFont systemFontOfSize:14.f];
            if (YBIphone6Plus) {
                textField.font = [UIFont systemFontOfSize:14.f*YBRatio];
            }
            textField.textColor = [UIColor whiteColor];
            textField.clearButtonMode = UITextFieldViewModeNever;
            textField.clipsToBounds = YES;
        }
        
        if ([subview isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            UIButton * cancelButton = (UIButton *)subview;
            [cancelButton setImage:[UIImage imageNamed:@"searchBar_cancel"] forState:UIControlStateNormal];
            [cancelButton setTitle:@"" forState:UIControlStateNormal];
            cancelButton.tintColor = RGB_Color(42, 42, 42);
           
        }
    }
    
}
@end

@interface SearchBarView()
@property(nonatomic,strong)UIView * topLineView;
@property(nonatomic,strong)UIView * bottomView;

@property (nonatomic, strong) UIView *bgView;

@end

@implementation SearchBarView

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.searchBar.frame = CGRectMake(0, LINEHEIGTH, self.width, self.height - 2 * LINEHEIGTH);
    self.topLineView.frame = CGRectMake(LINESPACING, 0, self.width - 2 * LINESPACING, LINEHEIGTH);
    self.bottomView.frame = CGRectMake(LINESPACING, self.height - LINEHEIGTH , self.width - 2 * LINESPACING, LINEHEIGTH);
}

#pragma mark - SearchBar
- (UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        _searchBar = [[HMSearchbar alloc] initWithFrame: CGRectMake(0, 0, self.width, 37)];
        [_searchBar setBackgroundColor:[UIColor clearColor]];
        [_searchBar setBarTintColor:[UIColor clearColor]];
        _searchBar.placeholder = @"搜索";
//        [_searchBar setInputAccessoryView:self.bgView];// 提供一个遮盖视图
        [self addSubview:_searchBar];
    }
    return _searchBar;

}

//- (UIView *)bgView{
//    if (_bgView == nil) {
//        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame) + 64 + 40, self.frame.size.width, 300)];
//        _bgView.backgroundColor = [UIColor cyanColor];
//    }
//    return _bgView;
//}
- (UIView *)topLineView
{
    if (!_topLineView) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = RGB_Color(52, 54, 53);
        _topLineView.layer.shadowColor = [UIColor whiteColor].CGColor;
        _topLineView.layer.shadowOffset = CGSizeMake(0, 2);
        _topLineView.layer.shadowOpacity = 0.048;
        _topLineView.layer.shadowRadius = 2;

        [self addSubview:_topLineView];
    }
    return _topLineView;
}


- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = RGB_Color(52, 54, 53);
        _bottomView.layer.shadowColor = [UIColor whiteColor].CGColor;
        _bottomView.layer.shadowOffset = CGSizeMake(0, 2);
        _bottomView.layer.shadowOpacity = 0.048;
        _bottomView.layer.shadowRadius = 2;

        [self addSubview:_bottomView];
    }
    return _bottomView;
}

@end
