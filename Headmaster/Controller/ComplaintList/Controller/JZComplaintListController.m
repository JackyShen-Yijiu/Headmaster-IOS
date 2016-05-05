//
//  JZComplaintListController.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZComplaintListController.h"
#import "JZComplaintListView.h"

@interface JZComplaintListController ()
@property (nonatomic, weak) JZComplaintListView *listView;

@property (nonatomic, assign) NSInteger count;

@end

@implementation JZComplaintListController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.myNavigationItem.title = [NSString stringWithFormat:@"投诉%zd",self.count];

    self.view.backgroundColor = [UIColor cyanColor];
    JZComplaintListView *listView = [[JZComplaintListView alloc]initWithFrame:CGRectMake(0, 0, kJZWidth, kJZHeight-64)];
    
    listView.vc = self;
    self.listView = listView;
    
    [self.view addSubview:listView];

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
