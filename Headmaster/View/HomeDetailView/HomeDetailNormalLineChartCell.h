//
//  HomeDetailNormalLineChartCell.h
//  Headmaster
//
//  Created by 大威 on 15/12/8.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeDetailBaseNormalCell.h"

@interface HomeDetailNormalLineChartCell : HomeDetailBaseNormalCell

@property (nonatomic, assign) kDateSearchType searchType;

@property (nonatomic, strong) NSArray *xTitleArray;

@property (nonatomic, strong) NSArray *valueArray;

@property (nonatomic, copy) NSString *xTitleMarkWordString;

@property (nonatomic, copy) NSString *yTitleMarkWordString;

@property (nonatomic, assign) CGFloat defaultHeight;

- (instancetype)initWithWidth:(CGFloat)width Style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)refreshUI;


@end
