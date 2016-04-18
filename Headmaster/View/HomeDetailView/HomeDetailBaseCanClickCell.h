//
//  HomeDetailBaseCanClickCell.h
//  Headmaster
//
//  Created by 大威 on 15/12/8.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "YBBaseTableCell.h"

typedef void(^ClickBlock)(NSInteger tag);

@interface HomeDetailBaseCanClickCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *markLabel;

@property (nonatomic, strong) UIImageView *markImageView;

@property (nonatomic, assign) CGFloat titleDefaultHeight;

- (void)setClickBlock:(ClickBlock)handle;

@end
