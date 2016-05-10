//
//  HomeProgressView.h
//  Headmaster
//
//  Created by 大威 on 15/12/8.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeProgressView : UIView

- (void)refreshpassrate:(NSArray *)passrate overstockstudent:(NSArray *)overstockstudent;

@property (nonatomic, strong) UIViewController *parentVC;

@end
