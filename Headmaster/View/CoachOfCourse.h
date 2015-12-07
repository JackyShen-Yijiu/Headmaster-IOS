//
//  CoachOfCourse.h
//  SingerDataView
//
//  Created by ytzhang on 15/12/1.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBBarChartView.h"
typedef void(^didClick)(UIButton *btn);

@interface CoachOfCourse : UIView

@property (nonatomic,strong) didClick didClick;

/**
 *
 *  教练授课
 *
 */
@property (nonatomic,strong) UILabel *coachOfCourseLabel;
/**
 *
 *  详情
 *
 */
@property (nonatomic,strong) UIButton *coachOfCourseButton;

/**
 *
 * 教练授课图表
 *
 */
//@property (nonatomic,strong) UIView *coachOfCourseChart;
@property (nonatomic,strong) YBBarChartView *coachOfCourseChart;

@end
