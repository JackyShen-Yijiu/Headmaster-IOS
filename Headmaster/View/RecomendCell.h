//
//  RecomendCel.h
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMRecomendModel.h"
#import "YBBaseTableCell.h"

typedef NS_ENUM(NSInteger,KRecomendCellType) {
    KRecomendCellTypeDefoult,
    KRecomendCellTypeVaule1
};

@class RecomendCell;
@protocol RecomendCellDelegate <NSObject>
- (void)recomendCell:(RecomendCell *)cell DidCoaImessageButton:(UIButton *)button;
- (void)recomendCell:(RecomendCell *)cell DidStuImessageButton:(UIButton *)button;
@end
@interface RecomendCell : YBBaseTableCell
@property(nonatomic,strong)HMRecomendModel * model;
@property(nonatomic,weak)id<RecomendCellDelegate> delegate;

+ (CGFloat)cellHigthWithModel:(HMRecomendModel *)model;

@end
