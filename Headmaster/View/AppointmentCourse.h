//
//  AppointmentCourse.h
//  SingerDataView
//
//  Created by ytzhang on 15/11/30.
//  Copyright © 2015年 ytzhang. All rights reserved.
//   约课图表

#import <UIKit/UIKit.h>
#import "YBLineChartView.h"

@interface AppointmentCourse : UITableViewCell
@property (nonatomic,assign) CGFloat resuleW;
/**
 *
 * 约课
 *
 */
@property(nonatomic,strong) UILabel *appintmentCoureLabel;
/**
 *
 * 预课总人数
 *
 */
@property (nonatomic,strong) UILabel *allPeopelNumberLabel;
/**
 *
 *  约课的表格视图
 *
 */
//@property (nonatomic,strong) UIView *appintmentChartView;
@property (nonatomic,strong) YBLineChartView *appintmentChartView;


@end
