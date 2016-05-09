//
//  TTCommentView.h
//  Headmaster
//
//  Created by ytzhang on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCommentView : UIView

@property (nonatomic, strong) UIView *leftSmallView;

@property (nonatomic, strong) UIView *leftBigView;

@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) UIColor *viewColor; // 图例颜色

@property (nonatomic, strong) UIFont *labelFont; // 字体大小

@property (nonatomic, strong) UIColor *titileColor; // 字体颜色

@property (nonatomic, assign) BOOL isShowBigView; // 图例和字体是否变大

@property (nonatomic, strong) NSString *titieleStr; // 文字内容

@property (nonatomic, assign) NSInteger expandIndex; // 标记放大的下标

@end
