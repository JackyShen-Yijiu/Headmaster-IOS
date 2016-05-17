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
@property (nonatomic, strong) UIBarButtonItem *pushBtn;



@end

@implementation JZComplaintListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myNavigationItem.title = [NSString stringWithFormat:@"投诉(%zd)",self.count];
    
    if (_isFormSideMenu) {
        self.navigationItem.leftBarButtonItem = self.pushBtn;
    }
    
    
    JZComplaintListView *listView = [[JZComplaintListView alloc]initWithFrame:CGRectMake(0, 0, kJZWidth, kJZHeight-64)];
    
    listView.vc = self;
    self.listView = listView;
    
    self.listView.vc = self;
    
    [self.view addSubview:listView];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pushBtnClick {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (UIBarButtonItem *)pushBtn {
    if (!_pushBtn) {
        CGRect backframe= CGRectMake(0, 0, 16, 16);
        UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = backframe;
        [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(pushBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _pushBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    return _pushBtn;
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
