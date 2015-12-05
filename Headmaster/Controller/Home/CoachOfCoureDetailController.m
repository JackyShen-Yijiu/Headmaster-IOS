//
//  CoachOfCoureDetailController.m
//  DataDatiel
//
//  Created by ytzhang on 15/12/2.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "CoachOfCoureDetailController.h"


@interface CoachOfCoureDetailController ()

@property (nonatomic,retain) UITableView *tableView;

@end

@implementation CoachOfCoureDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"今天教练详情";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UIImage *image = [UIImage imageNamed:@"controllerBackground"];
    self.tableView.layer.contents = (id)image.CGImage;

    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *strCell = @"myCell";
    CoachOfCoureDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (!cell) {
        NSArray *xib = [[NSBundle mainBundle] loadNibNamed:@"CoachOfCoureDetailCell" owner:nil options:nil];
        cell = [xib lastObject];
        cell.BottomLineLabel.backgroundColor = [UIColor blackColor];
        
        cell.BottomLineLabel.layer.shadowColor = [UIColor whiteColor].CGColor;
        cell.BottomLineLabel.layer.shadowOffset = CGSizeMake(0, 1);
        cell.BottomLineLabel.layer.shadowOpacity = 0.3;
        cell.BottomLineLabel.layer.shadowRadius = 1;
        cell.backgroundColor = [UIColor clearColor];
        
//               UIImage*img =[UIImage imageNamed:@"bgg.png"];
//        [cell setBackgroundColor:[UIColor colorWithPatternImage:img]];

        
    
    }
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 109;
}

@end
