//
//  YearDataView.m
//  DataDatiel
//
//  Created by ytzhang on 15/12/1.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "YearDataView.h"
# define ksystemH [UIScreen mainScreen].bounds.size.height
# define ksystemW [UIScreen mainScreen].bounds.size.width
@implementation YearDataView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
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
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell addSubview:self.inviteStudentView];
        return cell;
    }else if (indexPath.row == 1)
    {static  NSString *strCell = @"myCell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell addSubview:self.appintmentCoure];
        return cell;
        
    }else if (indexPath.row == 2)
    {static  NSString *strCell = @"myCell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell addSubview:self.coacOfCourse];
        return cell;
        
    }else if (indexPath.row == 3)
        
    {static  NSString *strCell = @"myCell3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell addSubview:self.judgeView];
        return cell;
        
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 270;
}
- (InviteStudentView *)inviteStudentView{
    
    
    if (_inviteStudentView == nil) {
        _inviteStudentView = [[InviteStudentView alloc] init];
        _inviteStudentView.frame = CGRectMake(0, 0,ksystemW , 200);
    }
    return _inviteStudentView;
}
- (AppointmentCourse *)appintmentCoure{
    
    
    if (_appintmentCoure == nil) {
        _appintmentCoure = [[AppointmentCourse alloc] init];
        _appintmentCoure.frame = CGRectMake(0, 0,ksystemW , 200);
    }
    return _appintmentCoure;
}
- (CoachOfCourse *)coacOfCourse{
    
    
    if (_coacOfCourse == nil) {
        _coacOfCourse = [[CoachOfCourse alloc] init];
        _coacOfCourse.frame = CGRectMake(0, 0,400 , 400);
    }
    return _coacOfCourse;
}
- (JudgeView *)judgeView{
    
    
    if (_judgeView == nil) {
        _judgeView = [[JudgeView alloc] init];
        _judgeView.frame = CGRectMake(0, 0,ksystemW , 200);
    }
    return _judgeView;
}

@end
