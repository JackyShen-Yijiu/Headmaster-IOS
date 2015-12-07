//
//  JudgeView.h
//  SingerDataView
//
//  Created by ytzhang on 15/12/1.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBLineChartView.h"
#import "ZTJudgeBottonSign.h"
typedef void(^didClick)(UIButton *btn);

@interface JudgeView : UITableViewCell
@property (nonatomic,strong) didClick didClick;
/**
 *
 *  评价
 *
 */
@property (nonatomic,strong) UILabel *judgeLabel;
/**
 *
 *  详情
 *
 */
@property (nonatomic,strong) UIButton *judgeButton;

/**
 *
 * 评价图表
 *
 */
@property (nonatomic,strong) YBLineChartView *judgeChart;
//@property (nonatomic,strong) UIView *judgeChart;
/**
 *
 *  底部标示图
 *
 */
@property (nonatomic,strong) ZTJudgeBottonSign *signView;
@end
