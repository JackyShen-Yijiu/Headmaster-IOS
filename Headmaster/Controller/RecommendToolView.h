//
//  RecommendToolView.h
//  Headmaster
//
//  Created by 大威 on 15/12/9.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RecommendToolViewItemClickBlock)(UIButton *btn);
@interface RecommendToolView : UIView

@property (nonatomic,strong) RecommendToolViewItemClickBlock itemClickBlock;
@property (nonatomic,assign) NSInteger selectButtonInteger; // 设置选中时的按钮

//模拟点击一项的方法
- (void)selectedItem:(NSInteger)tag;

- (void)selectOneButton:(NSInteger)tag;

@end
