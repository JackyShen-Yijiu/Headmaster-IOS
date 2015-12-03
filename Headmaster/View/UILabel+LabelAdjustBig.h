//
//  UILabel+LabelAdjustBig.h
//  DataDatiel
//
//  Created by ytzhang on 15/12/2.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LabelAdjustBig)
/**
 *
 * UILabel的自适应宽高
 *
 */

+ (CGRect)initWithUILabel:(NSString *)text font:(CGFloat)font;
@end
