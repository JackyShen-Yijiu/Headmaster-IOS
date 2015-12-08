//
//  YearDataView.m
//  DataDatiel
//
//  Created by ytzhang on 15/12/1.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "YearDataView.h"
#import "CoachOfCoureDetailController.h"
# define ksystemH [UIScreen mainScreen].bounds.size.height
# define ksystemW [UIScreen mainScreen].bounds.size.width
@implementation YearDataView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
//        self.tableHeaderView = [[UIView alloc] init];
//        self.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
        static  NSString *strCell = @"myCell";
        InviteStudentView *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
        if (!cell) {
            cell = [[InviteStudentView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            // 招生人数
            cell.chartView.xTitleArray = @[ @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日" ];
            cell.chartView.valueArray =@[@[@"23",@"42",@"25",@"15",@"30",@"42",@"32",@"40",@"42",@"25",@"33"]];
            cell.chartView.frame = CGRectMake(0, 16, self.frame.size.width - 32, 200);
            [cell.chartView refreshUI];
            
        }
        return cell;
        
    }else if (indexPath.row == 1)
    {static  NSString *strCell = @"myCell1";
        AppointmentCourse *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
        if (!cell) {
            cell = [[AppointmentCourse alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            // 约课人数赋值
            cell.appintmentChartView.xTitleArray = @[ @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日" ];
            ;
        cell.appintmentChartView.valueArray = @[@[@"23",@"42",@"25",@"15",@"30",@"42",@"32",@"40",@"42",@"25",@"33"]];
            cell.appintmentChartView.frame = CGRectMake(0, 16, self.frame.size.width - 32, 200);
            

            [cell.appintmentChartView refreshUI];
        }
        
//        [cell addSubview:self.appintmentCoure];
        return cell;
        // 教练授课情况
        
    }else if (indexPath.row == 2)
    {static  NSString *strCell = @"myCell2";
        CoachOfCourse *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
        if (!cell) {
            cell = [[CoachOfCourse alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.coachOfCourseChart.xTitleArray = @[ @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日" ];
            cell.coachOfCourseChart.valueArray = @[@[@"23",@"42",@"25",@"15",@"30",@"42",@"32",@"40",@"42",@"25",@"33"]];
            
            cell.coachOfCourseChart.frame = CGRectMake(0, 16, self.frame.size.width - 32, 200);
            [cell.coachOfCourseChart refreshUI];
            cell.userInteractionEnabled = YES;
        }
        
//        [cell addSubview:self.coacOfCourse];
        return cell;
        
    }else if (indexPath.row == 3)
        
    {static  NSString *strCell = @"myCell3";
        JudgeView *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
        if (!cell) {
            cell = [[JudgeView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            // 评价情况
            cell.judgeChart.xTitleArray = @[ @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日" ];
            
            cell.judgeChart.valueArray = @[@[@"23",@"42",@"25",@"15",@"30",@"42",@"32",@"40",@"42",@"25",@"33"]];
            cell.judgeChart.frame = CGRectMake(0, 16, self.frame.size.width - 32, 200);
            [cell.judgeChart refreshUI];

            

        }
    
        return cell;
        
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
}
//- (InviteStudentView *)inviteStudentView{
//    
//    
//    if (_inviteStudentView == nil) {
//        _inviteStudentView = [[InviteStudentView alloc] init];
//        _inviteStudentView.frame = CGRectMake(0, 0,ksystemW , 200);
//    }
//    return _inviteStudentView;
//}
//- (AppointmentCourse *)appintmentCoure{
//    
//    
//    if (_appintmentCoure == nil) {
//        _appintmentCoure = [[AppointmentCourse alloc] init];
//        _appintmentCoure.frame = CGRectMake(0, 0,ksystemW , 200);
//    }
//    return _appintmentCoure;
//}
//- (CoachOfCourse *)coacOfCourse{
//    
//    
//    if (_coacOfCourse == nil) {
//        _coacOfCourse = [[CoachOfCourse alloc] init];
//        _coacOfCourse.frame = CGRectMake(0, 0,ksystemW , 200);
//    }
//    return _coacOfCourse;
//}
//- (JudgeView *)judgeView{
//    
//    
//    if (_judgeView == nil) {
//        _judgeView = [[JudgeView alloc] init];
//        _judgeView.frame = CGRectMake(0, 0,ksystemW , 200);
//    }
//    return _judgeView;
//}

@end
