//
//  RecomendCel.h
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMRecomendModel.h"
#import "HMComplainModel.h"

#import "YBBaseTableCell.h"

typedef NS_ENUM(NSInteger,KRecomendCellType) {
    KRecomendCellTypeDefoult,
    KRecomendCellTypeVaule1
};

@class RecomendCell;
@protocol RecomendCellDelegate <NSObject>
- (void)recomendCell:(RecomendCell *)cell DidCoaImessageButton:(UIButton *)button;
- (void)recomendCell:(RecomendCell *)cell DidStuImessageButton:(UIButton *)button;
- (void)complainCell:(RecomendCell *)cell DidSwithcButttonValueChanged:(UISwitch *)swithcButton;

@end
@interface RecomendCell : YBBaseTableCell
@property(nonatomic,strong)HMRecomendModel* model;
@property(nonatomic,weak)id<RecomendCellDelegate> delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(KRecomendCellType )type;

+ (CGFloat)cellHigthWithModel:(HMRecomendModel *)model;

@end
