//
//  JZCommentChartCell.h
//  Headmaster
//
//  Created by ytzhang on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBPieChartView.h"
#import "TTCommentView.h"

@protocol TTCommnentViewDeleage <NSObject>

- (void)initWithCommentViewIndex:(NSInteger)index;

@end

@interface JZCommentChartCell : UITableViewCell

@property (nonatomic,strong) YBPieChartView *pieChartView;

@property (nonatomic, strong) TTCommentView *goodCommentView;

@property (nonatomic, strong) TTCommentView *mightCommentView;

@property (nonatomic, strong) TTCommentView *badCommentView;

@property (nonatomic, weak) id <TTCommnentViewDeleage> delegate;

@end
