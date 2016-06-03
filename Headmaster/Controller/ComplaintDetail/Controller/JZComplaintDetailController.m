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
@property (nonatomic, strong) UIBarButtonItem *pushBtn;

@end

@implementation JZComplaintDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"投诉详情";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = self.pushBtn;

    
    JZComplaintDetailTopView *detailTopView = [[JZComplaintDetailTopView alloc]init];

    
    if (YBIphone6Plus) {
        

        detailTopView.frame = CGRectMake(0, 0, kJZWidth, 146*YBRatio);

    }else {
        detailTopView.frame = CGRectMake(0, 0, kJZWidth, 146);

    }
    
    detailTopView.data = self.dataModel;
    

    
    self.detailTopView = detailTopView;

    
    
    [self.view addSubview:detailTopView];
    
    CGFloat detailViewHeight = [JZComplaintDetailView complaintDetailViewH:self.dataModel];
    
    JZComplaintDetailView *detailView = [[JZComplaintDetailView alloc]initWithFrame:CGRectMake(0, 0, kJZWidth,detailViewHeight)];
    detailView.data = self.dataModel;
    self.detailView = detailView;
    self.detailView.vc = self;
    
    UIScrollView *contentScrollView = [[UIScrollView alloc]init];
    
    if (YBIphone6Plus) {

       contentScrollView.frame = CGRectMake(0,146*YBRatio,kJZWidth,detailViewHeight);
        
    }else {
        
       contentScrollView.frame = CGRectMake(0,146,kJZWidth,detailViewHeight);
    }
    
    contentScrollView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:contentScrollView];
    
    contentScrollView.contentSize = detailView.frame.size;
    
    [contentScrollView addSubview:detailView];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)pushBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
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


@end
