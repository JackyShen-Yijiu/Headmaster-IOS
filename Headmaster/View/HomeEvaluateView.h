//
//  HomeEvaluateView.h
//  Principal
//
//  Created by dawei on 15/11/27.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClickBlock)(UIButton *button);

@interface HomeEvaluateView : UIView

- (void)refreshData:(NSArray *)array;

@property (nonatomic, strong) ButtonClickBlock abcBlock;

// 按钮点击事件
- (void)itemClick:(ButtonClickBlock)handle;

@end
