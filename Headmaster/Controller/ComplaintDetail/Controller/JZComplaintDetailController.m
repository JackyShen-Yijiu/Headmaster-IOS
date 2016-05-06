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
#import "JZComplaintDetailTopView.h"
@interface JZComplaintDetailController ()
@property (nonatomic, weak) JZComplaintDetailView *detailView;
@property (nonatomic, weak) JZComplaintDetailTopView *detailTopView;
@end

@implementation JZComplaintDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myNavigationItem.title = @"投诉详情";
    
    self.view.backgroundColor = JZ_MAIN_BACKGROUND_COLOR;
    
    JZComplaintDetailTopView *detailTopView = [[JZComplaintDetailTopView alloc]initWithFrame:CGRectMake(0, 0, kJZWidth, 146)];

    detailTopView.data = self.dataModel;
    self.detailTopView = detailTopView;
    [self.view addSubview:detailTopView];
    
    CGFloat detailViewHeight = [JZComplaintDetailView complaintDetailViewH:self.dataModel];
    

//    NSLog(@"detailViewHeight = %f",detailViewHeight);
    JZComplaintDetailView *detailView = [[JZComplaintDetailView alloc]initWithFrame:CGRectMake(0, 0, kJZWidth,detailViewHeight)];
    detailView.data = self.dataModel;
    self.detailView = detailView;
    
    UIScrollView *contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,146,kJZWidth,detailViewHeight)];
    contentScrollView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:contentScrollView];
    
    contentScrollView.contentSize = detailView.frame.size;

    [contentScrollView addSubview:detailView];
    


    
    
    
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
