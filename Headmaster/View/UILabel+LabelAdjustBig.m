//
//  UILabel+LabelAdjustBig.m
//  DataDatiel
//
//  Created by ytzhang on 15/12/2.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "UILabel+LabelAdjustBig.h"

@implementation UILabel (LabelAdjustBig)
+ (CGRect)initWithUILabel:(NSString *)text font:(CGFloat)textFont
{
    
    // iOS7.0以后计算文本高度要使用的方法,它返回的是一个矩形区域
    // 限定宽高(基本上没用)
    CGSize size = CGSizeMake(200, 19999); // 200与lable相同,19999基本没用
    
    // 将字体和字体大小存放到字典
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:textFont]};
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |  NSStringDrawingUsesFontLeading attributes:dic context:nil]; // 3参数,是字体大小 4参数,是辅助信息
    return rect;
    
}
@end
