//
//  MonthViewData.h
//  DataDatiel
//
//  Created by ytzhang on 15/12/1.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InviteStudentView.h"
#import "AppointmentCourse.h"
#import "CoachOfCourse.h"
#import "JudgeView.h"
typedef void(^didClickBlock)(UIButton *btn);
typedef void(^didJudgeBlock)(UIButton *btn);
@interface MonthViewData : UITableView <UITableViewDelegate,UITableViewDataSource>

/**
 *
 * 招生图表视图
 *
 */
@property (nonatomic,strong) InviteStudentView *inviteStudentView;
/**
 *
 * 约课图表视图
 *
 */
@property (nonatomic,strong) AppointmentCourse  *appintmentCoure;
/**
 *
 *  教练授课图表视图
 *
 */
@property (nonatomic,strong) CoachOfCourse *coacOfCourse;
/**
 *
 *  评价图表视图
 *
 */
@property (nonatomic,strong) JudgeView *judgeView;

@property (nonatomic,strong) didClickBlock didClickdid;
@property (nonatomic,strong) didJudgeBlock  didJugeBlock;
@end
