//
//  HomeSeeTimeView.h
//  Principal
//
//  Created by dawei on 15/11/27.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClickBlock)(UIButton *button);

@interface HomeSeeTimeView : UIView

// 按钮点击事件
- (void)itemClick:(ButtonClickBlock)handle;

@end
