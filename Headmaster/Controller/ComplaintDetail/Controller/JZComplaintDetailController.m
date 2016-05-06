//
//  JZComplaintDetailController.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZComplaintDetailController.h"
#import "JZComplaintDetailView.h"
#import "JZComplaintComplaintlist.h"
@interface JZComplaintDetailController ()
@property (nonatomic, weak) JZComplaintDetailView *detailView;

@end

@implementation JZComplaintDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myNavigationItem.title = @"投诉详情";
    
    self.view.backgroundColor = JZ_MAIN_BACKGROUND_COLOR;
    
//    CGFloat height = [JZComplaintDetailView viewHeightDmData:self.dataModel];
    CGFloat height = 500;
    JZComplaintDetailView *detailView = [[JZComplaintDetailView alloc]initWithFrame:CGRectMake(0, 0, kJZWidth, height)];
    detailView.data = self.dataModel;
    
    self.detailView = detailView;
    
    [self.view addSubview:detailView];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
