//
//  TopButtonView.h
//  DataDatiel
//
//  Created by ytzhang on 15/11/29.
//  Copyright © 2015年 ytzhang. All rights reserved.

//   数据详情头部的按钮

#import <UIKit/UIKit.h>

typedef void(^didClick)(UIButton *btn);
@interface TopButtonView : UIView
@property (nonatomic,strong) didClick didClick;
@property (nonatomic,assign) NSInteger selectButtonInteger; // 设置选中时的按钮


//模拟点击一项的方法
- (void)selectedItem:(NSInteger)tag;
@end
