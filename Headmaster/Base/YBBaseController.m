//
//  YBBaseController.m
//  Headmaster
//
//  Created by 大威 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "YBBaseController.h"

@interface YBBaseController ()

@end

@implementation YBBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)addBackgroundImage {
    self.view.layer.backgroundColor = RGB_Color(247, 247, 247).CGColor;
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
