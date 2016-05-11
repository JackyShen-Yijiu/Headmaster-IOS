//
//  HomeDetailTableView.m
//  Headmaster
//
//  Created by 大威 on 15/12/9.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeDetailTableView.h"
#import "YBLineChartView.h"
#import "HomeDetailNormalLineChartCell.h"
#import "HomeDetailCanClickLineChartCell.h"
#import "HomeDetailEvaluationCell.h"
#import "HomeDataDetailViewModel.h"
#import "HomeTopView.h"
#import "HomeViewModel.h"
#import "DVVDoubleRowToolBarView.h"

@interface HomeDetailTableView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) ClickBlock coachTeacherBlock;

@property (nonatomic, copy) ClickBlock evaluationBlock;

@property (nonatomic, strong) HomeDataDetailViewModel *viewModel;

@property (nonatomic, assign) BOOL successRequest;

@property (nonatomic,strong) HomeTopView *topView;

@end

@implementation HomeDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        self.viewModel = [HomeDataDetailViewModel new];
        [self.viewModel successRefreshBlock:^{
            [self refreshUI];
            self.successRequest = 1;
        }];
        
    }
    return self;
}

- (void)setCoachTeacherClickBlock:(void (^)(NSInteger))handle {
    _coachTeacherBlock = handle;
}

- (void)setEvaluationClickBlock:(void (^)(NSInteger))handle {
    _evaluationBlock = handle;
}

#pragma mark - 刷新数据
- (void)refreshUI {
    [self reloadData];
}

#pragma mark - 刷新数据
- (void)networkRequest {
    if (self.successRequest) {
        [self refreshUI];
        return;
    }
    [self.viewModel networkRequestRefresh];
}

- (void)setSearchType:(kDateSearchType)searchType {
    _searchType = searchType;
    self.viewModel.searchType = searchType;
}

#pragma mark - tableView data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        
        static NSString *kNormalLineChartCellId = @"lineCell";
        HomeDetailNormalLineChartCell *normalLineChartCell = [tableView dequeueReusableCellWithIdentifier:kNormalLineChartCellId];
        if (!normalLineChartCell) {
            normalLineChartCell = [[HomeDetailNormalLineChartCell alloc] initWithWidth:self.bounds.size.width - 20 Style:UITableViewCellStyleDefault reuseIdentifier:kNormalLineChartCellId];
        }
       
        normalLineChartCell.searchType = self.searchType;
       
//        //获取当前时间
//        NSDate *now = [NSDate date];
//        NSLog(@"now date is: %@", now);
//        
//        NSCalendar *calendar = [NSCalendar currentCalendar];
//        NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
//        
//        NSInteger year = [dateComponent year];
//        NSInteger month = [dateComponent month];
//        NSInteger day = [dateComponent day];
//        NSInteger hour = [dateComponent hour];
//        NSInteger minute = [dateComponent minute];
//        NSInteger second = [dateComponent second];
//        NSInteger zhou = [dateComponent weekdayOrdinal];
//
//        NSLog(@"year is: %ld", (long)year);
//        NSLog(@"month is: %ld", (long)month);
//        NSLog(@"day is: %ld", (long)day);
//        NSLog(@"hour is: %ld", (long)hour);
//        NSLog(@"minute is: %ld", (long)minute);
//        NSLog(@"second is: %ld", (long)second);
//        NSLog(@"zhou is: %ld", (long)zhou);

        NSDate*date = [NSDate date];
        
        
        NSCalendar*calendar = [NSCalendar currentCalendar];
        
        
        NSDateComponents*comps;
        
        
        // 年月日获得
        comps =[calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit)
                
                
                           fromDate:date];
        
        
        NSInteger year = [comps year];
        
        
        NSInteger month = [comps month];
        
        
        NSInteger day = [comps day];
        
        
        NSLog(@"year:%d month: %d, day: %d", year, month, day);
        
        //当前的时分秒获得
        comps =[calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit)
                
                
                           fromDate:date];
        
        
        NSInteger hour = [comps hour];
        
        
        NSInteger minute = [comps minute];
        
        
        NSInteger second = [comps second];
        
        
        NSLog(@"hour:%d minute: %d second: %d", hour, minute, second);
        
        
        
        
        
        // 周几和星期几获得
        
        
        comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
                
                
                           fromDate:date];
        
        
        NSInteger week = [comps week]; // 今年的第几周
        
        
        NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
        
        
        NSInteger weekdayOrdinal = [comps weekdayOrdinal]; // 这个月的第几周
        
        
        NSLog(@"week:%ld weekday: %d weekday ordinal: %d", (long)week, weekday, weekdayOrdinal);

        switch (self.searchType) {
            
            case kDateSearchTypeWeek:
                normalLineChartCell.titleLabel.text = [NSString stringWithFormat:@"%ld年%ld月 第%ld周",(long)year,(long)month,weekdayOrdinal];
                break;
                
            case kDateSearchTypeMonth:
                normalLineChartCell.titleLabel.text = [NSString stringWithFormat:@"%ld年%ld月",(long)year,(long)month];
                break;
                
            case kDateSearchTypeYear:
                normalLineChartCell.titleLabel.text = [NSString stringWithFormat:@"%ld年",(long)year];
                break;
                
            default:
                break;
        }
        
        //    normalLineChartCell.xTitleMarkWordString = @"时";
        //    normalLineChartCell.yTitleMarkWordString = @"人";
        
        NSLog(@"self.viewModel.dataModel.reservationXTitleArray:%@",self.viewModel.dataModel.reservationXTitleArray);
        NSLog(@"self.viewModel.dataModel.reservationValueArray:%@",self.viewModel.dataModel.reservationValueArray);
        
        for (NSString *str in self.viewModel.dataModel.reservationXTitleArray) {
            NSLog(@"self.viewModel.dataModel.reservationXTitleArray-str:%@",str);
        }
        for (NSString *str in self.viewModel.dataModel.reservationValueArray) {
            NSLog(@"self.viewModel.dataModel.reservationValueArray-str:%@",str);
        }
        
        if (self.viewModel.dataModel.reservationXTitleArray.count) {
            normalLineChartCell.markLabel.text = [NSString stringWithFormat:@"共%li人",self.viewModel.dataModel.reservationStudentCount];
            normalLineChartCell.xTitleArray = self.viewModel.dataModel.reservationXTitleArray;
            normalLineChartCell.valueArray = @[self.viewModel.dataModel.reservationValueArray];
        }
        [normalLineChartCell refreshUI];
        
        return normalLineChartCell;
        
    }
    
    static NSString *footerCellID = @"footerCellID";
    
    UITableViewCell *footerCell = [tableView dequeueReusableCellWithIdentifier:footerCellID];
    if (!footerCell) {
        footerCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:footerCellID];
    }
    
    [self.topView removeFromSuperview];
    self.topView = [[HomeTopView alloc] initWithFrame:CGRectMake(0, 0, footerCell.width, 105) withIsHomeDetailsVc:YES];
    [footerCell.contentView addSubview:self.topView];
    [self.topView refreshSubjectData:_homeViewModel.subjectArray sameDay:_homeViewModel.applyCount];
   
    return footerCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        return [HomeDetailNormalLineChartCell new].defaultHeight + 20;
    }else{
        return 105;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
