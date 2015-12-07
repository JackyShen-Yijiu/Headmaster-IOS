//
//  InviteStudentView.h
//  SingerDataView
//
//  Created by ytzhang on 15/11/30.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBLineChartView.h"

@interface InviteStudentView : UITableViewCell

@property (nonatomic,assign) CGFloat resuleW;
/**
 *
 * 招生
 *
 */
@property (nonatomic,strong) UILabel *inviteStudentLabel;
/**
 *
 * 招生总数
 *
 */

@property (nonatomic,strong) UILabel *inviteStudentNumberLabel;
/**
 *
 * 表格视图
 *
 */

//@property (nonatomic,strong) UIView *chartView;

@property (nonatomic,strong) YBLineChartView *chartView;

//@property (nonatomic,strong) YBLineChartView *lineChartView;

@end
